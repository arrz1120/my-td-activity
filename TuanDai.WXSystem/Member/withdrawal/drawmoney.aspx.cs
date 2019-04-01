﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Objects;
using Tool;
using BusinessDll;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Dapper;
using TuanDai.WXSystem.Core.Common;
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.Member.withdrawal
{
    public partial class drawmoney : UserPage
    {
        protected UserBasicInfoInfo basicinfo;
        protected FundAccountInfoInfo accountInfo;
        protected string exsitbank = "1";
        protected int? vailStatus = 0;
        protected string sexname = "先生";
        protected decimal topwithdrawamount = 0;
        protected int count = 0;
        protected decimal cadAviMoney = 0;//银行卡最大可提现余额
        protected decimal FreezeAmount = 0;
        protected int bankStatus = 1;
        protected Guid userId;
        protected UserBLL bll = new UserBLL();
        protected List<WithdrawVoucherInfo1> VoucherInfoList = null;//提现卷
        protected int DefPayType = 2; //默认支付方式
        protected BankNoInfo bankModel = new BankNoInfo();
        protected Guid prizeId = Guid.Empty;
        protected string bankName = string.Empty;
        protected string bankNo = string.Empty;
        protected bool IsNoCanDraw = false;//是否不可以提现
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            if (!IsPostBack)
            {
                prizeId = Tool.WEBRequest.GetGuid("id");
                userId = WebUserAuth.UserId.Value;
                OnInitData();
            }
        }

        private void OnInitData()
        {
            basicinfo = bll.GetUserBasicInfoModelById(userId);

            //从Java接口获取银行卡信息
            var bankJavaService = new BankFromJavaService();
            if (GlobalUtils.IsBankService)
            {
                WXResponsePublicInfo<WXResponseSelectBankInfoChild> bankInfo = bankJavaService.GetBankInfo(userId, ServiceType.TuoMin);
                if (bankInfo != null && bankInfo.respData != null)
                {
                    bankName = bankInfo.respData.bankName;
                    bankNo = bankInfo.respData.bankNo;
                }
            }
            if (string.IsNullOrEmpty(bankNo))
            {
                GlobalUtils.GetBankImg(basicinfo.Id, out bankName);
                var bankinfo = GlobalUtils.GetBankInfo(basicinfo.Id);
                if (bankinfo != null)
                    bankNo = bankinfo.BankNo;
            }

            if (basicinfo.sex == 2)
            {
                sexname = "小姐";
            }
            vailStatus = getVailStatusByUserModel(basicinfo);
            accountInfo = new FundAccountBLL().GetFundAccountInfoById(userId);
            if (GlobalUtils.IsBankService)
            {
                cadAviMoney = bankJavaService.GetAviMoney(userId);
            }
            else
            {
                cadAviMoney = bll.GetDrawAviAmount(userId);
            }

            WebSettingInfo setmodel = new WebSettingBLL().GetWebSettingInfo("1F9F7CF7-267E-4F88-B3A4-F2775401CA0F");
            topwithdrawamount = (basicinfo.Level ?? 1) == (int)ConstString.UserType.VipUser ? decimal.Parse(setmodel.Param5Value) : decimal.Parse(setmodel.Param4Value);

            //UserPrizeBll prizebll = new UserPrizeBll();
            //VoucherInfoList = prizebll.GetWithdrawVoucher(userId);
            string err = "";
            //从接口获取未使用提现券
            List<TuanDai.UserPrizeNew.ServiceClient.Models.UserPrizeInfo> ulist =
                new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName).GetWithdrawVoucher(userId, out err);
            if (!string.IsNullOrEmpty(err))
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "TuanDai.UserPrizeNew.Client.UserPrizeQueryClient.GetUserPrizeListByUserId", userId.ToString(), err);
            }
            WithdrawVoucherInfo1 wvi = null;
            if (VoucherInfoList == null)
            {
                VoucherInfoList = new List<WithdrawVoucherInfo1>();
            }
            if (ulist != null && ulist.Count > 0)
            {   //循坏写入VoucherInfoList
                foreach (var u in ulist)
                {
                    wvi = new WithdrawVoucherInfo1();
                    wvi.Amount = u.PrizeValue;
                    wvi.ExpirationDate = u.ExpirationDate;
                    wvi.Id = u.Id;
                    wvi.SubTypeId = u.SubTypeId;
                    if (wvi.ExpirationDate.HasValue)
                    {
                        wvi.DateDeadline = (int)MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                            wvi.ExpirationDate.Value);
                    }
                    VoucherInfoList.Add(wvi);
                }
            }
            count = VoucherInfoList.Count;
            //获取默认支付方式
            DefPayType = 2;

            IsNoCanDraw = (DateTime.Now > DateTime.Parse(DateTime.Now.ToString("d") + " 22:59:59") &&
                         DateTime.Now <= DateTime.Parse(DateTime.Now.ToString("d") + " 23:59:59")) || (DateTime.Now >= DateTime.Parse(DateTime.Now.ToString("d") + " 00:00:00") &&
                         DateTime.Now < DateTime.Parse(DateTime.Now.ToString("d") + " 00:10:00"));
        }

        #region 根据用户实体类得到用户验证状态
        /// <summary>
        /// 根据用户实体类得到用户验证状态
        /// </summary>
        /// <param name="model"></param>
        /// <returns>返回用户状态 小于4：未通过实名认证 4：已通过实名认证 11：未修改昵称 12：未修改交易密码</returns>
        public int getVailStatusByUserModel(UserBasicInfoInfo userModel)
        {
            int vailStatus = 0;
            if (userModel != null)
            {
                //未绑定银行卡
                //if (string.IsNullOrEmpty(userModel.BankAccountNo))
                //{
                //    vailStatus = 5;
                //}
                //else if (string.IsNullOrEmpty(userModel.OpenBankName) || string.IsNullOrEmpty(userModel.BankProvice) || string.IsNullOrEmpty(userModel.BankCity))
                //{
                //    vailStatus = 6;
                //}
                //else 
                WXResponsePublicInfo<WXResponseSelectBankInfoChild> bankInfo =
                    new BankFromJavaService().GetBankInfo(userModel.Id, ServiceType.TuoMin);
                if (bankInfo == null || (bankInfo != null && string.IsNullOrEmpty(bankInfo.respData.bankNo)))
                {
                    vailStatus = 5;
                }

                if ((!userModel.IsValidateIdentity || !userModel.IsValidateMobile) && (string.IsNullOrEmpty(userModel.PayPwd) || userModel.PayPwd.ToLower() == userModel.Pwd.ToLower()))//既没有身份认证又没有修改交易密码
                {
                    vailStatus = 0;
                }
                else if (!userModel.IsValidateIdentity)
                {//没有身份认证
                    vailStatus = 1;
                }
                else if (!userModel.IsValidateMobile)//没有手机认证
                    vailStatus = 3;
                else if (string.IsNullOrEmpty(userModel.PayPwd) ||
                          userModel.PayPwd.ToLower() == userModel.Pwd.ToLower()) //没有修改交易密码
                {
                    vailStatus = 2;
                }
                else
                { //验证通过
                    vailStatus = 4;
                }
            }
            return vailStatus;
        }
        #endregion
        protected string GetBankName()
        {
            if (GlobalUtils.IsOpenCGT)
            {
                return bankName;
            }
            else
            {
                return Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.BankType), basicinfo.BankType);
            }
        }

    }
    public class BankNoInfo
    {
        public string BankAccountNo { get; set; }
        public int BankType { get; set; }
        public int ValType { get; set; }
    }
    public class UserBankInfo
    {
        public string BankNo { get; set; }

        public int? BankType { get; set; }
    }
    public class WithdrawVoucherInfo1
    {
        public decimal Amount { get; set; }
        public int Count { get; set; }

        public DateTime? ExpirationDate { get; set; }

        public int DateDeadline { get; set; }

        public Guid Id { get; set; }
        public int? SubTypeId { get; set; }
    }
}