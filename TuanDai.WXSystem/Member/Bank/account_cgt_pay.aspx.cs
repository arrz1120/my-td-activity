﻿using System;
using System.Data;
using BusinessDll;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core;
using Tool;
using TuanDai.WXSystem.Core.Common;
using TuanDai.WXSystem.Core.models;


namespace TuanDai.WXApiWeb.Member.Bank
{
    public partial class account_cgt_pay : UserPage
    {
        //JunTeEntities db = new JunTeEntities();
        private static object lockstatus = new object();

        protected void Page_Load(object sender, EventArgs e)
        {
            Guid userid = WebUserAuth.UserId.Value;
            //if (GetBankInfo(userid, 2) == 1)
            //{
            //    //if (bankmodel.Status==2)
            //    //{
            //    //Response.Write("您好，银行卡在审核中不允许充值！");
            //    ClientScript.RegisterStartupScript(this.GetType(), "ss",
            //        "<script>ShowMsg('您好，银行卡在审核中不允许充值！','1','确定');</script>");
            //    return;
            //    //}
            //}
            decimal Amount = Tool.SafeConvert.ToDecimal(Request.Params["Amount"], 0);
            decimal tmpAmount = Math.Floor(Amount * 100) / 100;
            if (tmpAmount != Amount)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('充值金额最多只能2位小数，如106.32！','1','确定');</script>");
                return;
            }
            TuanDai.PortalSystem.Model.WebSettingInfo rechargeSet =
                new TuanDai.PortalSystem.DAL.WebSettingDAL().GetWebSettingInfo("9A89CBAE-6550-4EA1-8224-EB645F38F8FA");
            decimal minRecharge = decimal.Parse(rechargeSet.Param1Value);
            if (Amount < minRecharge)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('单次充值最少" + minRecharge.ToString("N2") + "元！','1','确定');</script>");
                return;
            }
            if (Amount > 500000)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('单次充值不能超过50万！','1','确定');</script>");
                return;
            }

            var cgtMode = new QueryClient().GetUserByPlatformUserNo(userid);
            if (cgtMode == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('存管通未开通，不能进行充值！','1','确定');</script>");
                return;
            }
            if (!cgtMode.isActivate)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('存管通未激活，不能进行充值！','1','确定');</script>");
                return;
            }

            NoHandler noHandler = new NoHandler();
            string orderNo = noHandler.OnLineRechare();
            if (orderNo == "0")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('您好，您的提交失败请重试！','1','确定');</script>");
                return;
            }

            string err = string.Empty;
            bool isRecharge = new CgtCheckBLL().GetUserCgtIsOper(userid, "recharge", ref err);
            if (!isRecharge)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ss",
                    "<script>ShowMsg('" + err + "','1','确定');</script>");
                return;
            }
            //获取银行卡号
            string bankNo = Request["bankno"];
            string outCode = string.Empty;
            if (!string.IsNullOrEmpty(bankNo))
            {
                try
                {
                    bankNo = Tool.DESC.Decrypt(bankNo);
                }
                catch (Exception)
                {
                    bankNo = null;
                }
            }

            BankFromJavaService bankJavaService = new BankFromJavaService();
            if (GlobalUtils.IsBankService)
            {
                var bankInfoFromJava = bankJavaService.GetBankInfo(userid, ServiceType.NotTuomin);
                if (bankInfoFromJava != null && bankInfoFromJava.respData != null)
                {
                    bankNo = bankInfoFromJava.respData.bankNo;
                    outCode = bankInfoFromJava.respData.bankCode;
                }
            }
            else
            {
                var userInfo = new PortalSystem.BLL.UserBLL().GetUserBasicInfoModelById(userid);
                if (userInfo == null || string.IsNullOrEmpty(userInfo.BankAccountNo))
                {
                    var bankInfo = GlobalUtils.GetBankInfo(userid);
                    bankNo = bankInfo.BankNo;
                }
                else
                {
                    bankNo = userInfo.BankAccountNo;
                }
            }

            string userIP = Tool.WebFormHandler.GetIP();
            if (!GlobalUtils.IsBankService)
            {
                var sss = TuanDai.Payment.Client.BankInfo.GetPayBankInfo(userid);

                TuanDai.Payment.Models.PayRoute.RouteInfo bank = new TuanDai.Payment.Client.Recharge().GetCgtRechargeInfo(userid, sss.BankNo);
                int Sel = bank.Sel;

                int outStatus = 0;
                string bankcode = "";
                if (Request.Params["bankcode"] != null)
                {
                    bankcode = Request.Params["bankcode"];
                }


                var paramData = new Dapper.DynamicParameters();
                paramData.Add("@userid", userid);
                paramData.Add("@type", Sel);
                paramData.Add("@amount", Amount);
                paramData.Add("@orderNo", orderNo);
                paramData.Add("@backcode", bankcode);
                paramData.Add("@clientIp", userIP);
                paramData.Add("@from", "5");
                if (bank.RouteId.IsEmpty())
                    paramData.Add("@RouteId", null);
                else
                    paramData.Add("@RouteId", bank.RouteId);
                paramData.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                paramData.Add("@cmorderNo", "");
                PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, "p_cgt_AccountRechargeInit", ref paramData, CommandType.StoredProcedure);
                outStatus = paramData.Get<int>("@outStatus");

                int result = outStatus;
                if (result > 0)
                {
                    lock (lockstatus)
                    {


                        var isCallBackPayment =
                            System.Configuration.ConfigurationManager.AppSettings["IsCallBackPayment"];
                        var paymentUrl = System.Configuration.ConfigurationManager.AppSettings["PaymentUrl"];
                        string callBackUrl = paymentUrl + "/PaymentPlatform/H5/commonCallBack.aspx";
                        if (isCallBackPayment == "0")
                        {
                            callBackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.Recharge);
                        }
                        var recharInfo = new Payment.Client.Recharge().GetCgtRechargeInfo(userid, bankNo);
                        var url = CunGuanTong.Client.FundClient.RECHARGE_Req(new CunGuanTong.Model.RECHARGE_Request
                        {
                            rechargeWay = rechargeWay.SWIFT,
                            requestNo = orderNo,
                            amount = Amount,
                            bankcode = recharInfo.OutCode,
                            callbackMode = "DIRECT_CALLBACK",
                            platformUserNo = userid.ToString(),
                            expectPayCompany = recharInfo.CgtPayCompany,
                            //callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(CgtCallBackConfig.CgtCallBackType.Recharge),
                            callbackUrl = callBackUrl,
                            userDevice = CunGuanTong.Model.userDevice.MOBILE
                        });

                        if (string.IsNullOrEmpty(url))
                        {
                            if (Request.UrlReferrer != null)
                                url = Request.UrlReferrer.ToString();
                            else
                                url = GlobalUtils.WebURL;
                        }
                        Response.Redirect(url);
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ss", "<script>ShowMsg('您好，充值提交失败请重试！','1','确定');</script>");
                }
            }
            else
            {  //走Java银行卡服务
                string retUrl = bankJavaService.GetCgtRechargeUrl(userid, bankNo, Amount, userIP, outCode);
                if (!string.IsNullOrEmpty(retUrl))
                    Response.Redirect(retUrl);
            }
        }

        public class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
        }

        //private int GetBankInfo(Guid userId, byte? Status)
        //{
        //    int flag = 0;

        //    string strSQL = " select count(0) from BankInfo WITH(NOLOCK) WHERE UserId=@UserId and [Status]=@Status";
        //    var paramData = new Dapper.DynamicParameters();
        //    paramData.Add("@UserId", userId);
        //    paramData.Add("@Status", Status);
        //    flag = PublicConn.QuerySingle<int>(strSQL, ref paramData);

        //    return flag;
        //}

        private int UpdateAccountRechare(byte? From, string TranOrder)
        {
            int result = 0;

            string strSQL = " Update AccountRechare Set" +
                            " [From]=@From WHERE TranOrder=@TranOrder";
            var paramData = new Dapper.DynamicParameters();
            paramData.Add("@From", From);
            paramData.Add("@TranOrder", TranOrder);
            result = PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref paramData);
            return result;
        }
    }
}