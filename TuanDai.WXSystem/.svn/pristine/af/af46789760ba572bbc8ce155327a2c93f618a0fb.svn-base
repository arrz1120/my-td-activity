using BusinessDll;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.Payment;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.PaymentPlatform.EB
{
    public partial class ebPlainPay : BasePage
    {
      
       private string EBNotifyUrl = GlobalUtils.WebURL + "/PaymentPlatform/EB/PayCallback.aspx";

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = WEBRequest.GetQueryString("action");
            if (action == "getebpaycheck") {
                GetEBPayCheck();
            }
            else if (action == "confirmpay") {
                ConfirmPay();
            }
        }

        #region 易宝充值
        private void GetEBPayCheck() {
            Guid userid;
            if (WebUserAuth.UserId != null)
            {
                userid = WebUserAuth.UserId.Value;
            }
            else
            {
                PrintJson("0","您还未登录！"); 
                return;
            }

            decimal Amount = Tool.SafeConvert.ToDecimal(Request.QueryString["Amount"], 0);
            WebSettingInfo rechargeSet = new TuanDai.PortalSystem.DAL.WebSettingDAL().GetWebSettingInfo("9A89CBAE-6550-4EA1-8224-EB645F38F8FA");
            decimal MinRechargeAmount = decimal.Parse(rechargeSet.Param1Value);

            if (Amount < MinRechargeAmount)
            {
                PrintJson("0", "您好，充值金额必须大于或者等于" + MinRechargeAmount.ToString("N2") + "！"); 
                return;
            }

            if (Amount > 5000000)
            {
                PrintJson("0", "单次充值不能超过500万！");  
                return;
            }
            NoHandler noHandler = new NoHandler();
            string orderNo = noHandler.OnLineRechare();
            if (orderNo == "0")
            { 
                PrintJson("0", "您好，您的提交失败请重试！");  
                return;
            }
          
            int Sel = 11;
            Guid rechargeId = Guid.NewGuid();
            string bankcode = "";

            string userIP = Tool.WebFormHandler.GetIP();
            int outStatus = 0; 
            DynamicParameters paras = new DynamicParameters();
            paras.Add("@userid", userid);
            paras.Add("@type", Sel);
            paras.Add("@amount", Amount);
            paras.Add("@orderNo", orderNo);
            paras.Add("@backcode", bankcode);
            paras.Add("@clientIp", userIP);
            paras.Add("@from", "5");
            paras.Add("@outStatus", 0, DbType.Int32, ParameterDirection.Output);
            PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, "AccountRechargeInit", ref paras, CommandType.StoredProcedure);
            outStatus = paras.Get<int>("@outStatus"); 

            int result = outStatus;
            if (result <= 0) {
                PrintJson("0", "您好，您的提交失败请重试！");    
            }

            UserBLL bll = new UserBLL();
            UserBasicInfoInfo userInfo = bll.GetUserBasicInfoModelById(userid);
            //获取个人信息 
            if (null == userInfo)
            {
                PrintJson("0", "获取用户信息错误！");
                return;
            }

            //如果查询没有身份或者真实姓名
            if (string.IsNullOrEmpty(userInfo.IdentityCard) || string.IsNullOrEmpty(userInfo.RealName) || !userInfo.IsValidateIdentity)
            {
                PrintJson("0", "没有获取到用户实名信息(身份证和真实姓名)");
                return;
            }
            GetBankCardNo(userInfo, userid);
            //是否绑定银行卡
            if (string.IsNullOrEmpty(userInfo.BankAccountNo))
            {
                PrintJson("0", "银行卡未绑定");
                return;
            }
            //是否绑定手机
            if (string.IsNullOrEmpty(userInfo.TelNo) || !userInfo.IsValidateMobile)
            {
                PrintJson("0", "未完成手机或实名认证");
                return;
            }
           
            EBRechargeInfo orderInfo = new EBRechargeInfo();
            orderInfo.IsBindCard = 0;
            orderInfo.OrderId = orderNo;
            //申请充值
            try
            {
                var bankAccountNo = userInfo.BankAccountNo.Trim();
                var identityId = userInfo.Id.ToString().Replace("-", string.Empty).ToUpper();
                var bindCardModel = BindBankCardList.GetBindCardList(identityId, bankAccountNo);
                var rechargeAmount = (int)(Amount * 100);
                if (bindCardModel == null)
                {
                    var model = new BindCardRequestModel
                    {
                        CardNo = bankAccountNo,
                        IdCardNo = userInfo.IdentityCard,
                        IdentityId = identityId,
                        Phone = userInfo.TelNo,
                        RegisterPhone = userInfo.TelNo,
                        UserName = userInfo.RealName,
                    };

                    model.RequestId = string.Concat("D", identityId);
                    orderInfo.RequestId = model.RequestId;
                    BindBankCard.BindCard(model);
                }
                else
                {
                    orderInfo.RequestId = string.Concat("D", identityId);
                    orderInfo.IsBindCard = 1; 
                    BankCardPay.BindPay(new BankCardPayRequestModel
                    {
                        Amount = rechargeAmount,
                        CallBackUrl = EBNotifyUrl,
                        CardLast = bindCardModel.Card_Last,
                        CardTop = bindCardModel.Card_Top,
                        IdentityId = identityId,
                        OrderId = orderNo
                    });
                }
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("易宝充值出错:GetEBPayCheck", Tool.ExceptionHelper.GetExceptionMessage(ex));
                 PrintJson("0", "发生错误："+ex.Message);
                 return;
            }
            var ResponseData = new { result = "1", msg = JsonHelper.ToJson(orderInfo) };
            PrintJson(ResponseData); 
        }
        #endregion

        #region 确认支付
        private void ConfirmPay() {
            Guid userid;
            if (WebUserAuth.UserId != null)
            {
                userid = WebUserAuth.UserId.Value;
            }
            else
            {
                PrintJson("0", "您还未登录！");
                return;
            }
            string orderId = WEBRequest.GetFormString("OrderId");
            string valCode = WEBRequest.GetFormString("SMSCode");
            string isBindCard = WEBRequest.GetFormString("IsBindCard");
            try
            {
                if (isBindCard == "1")
                {
                    AccountRechareInfo ar=getAccountRechare(orderId); 
                    if (null == ar)
                    {
                        PrintJson("0", "充值交易未成功！");
                        return;
                    }

                    BankCardPay.ConfirmBindBankCard(orderId, valCode);
                }
                else {
                    //获取个人信息
                    UserBLL userbll = new UserBLL();
                    UserBasicInfoInfo userInfo = userbll.GetUserBasicInfoModelById(userid); 
                    if (null == userInfo)
                    {
                        PrintJson("0", "获取用户信息错误！");
                        return;
                    }
                    GetBankCardNo(userInfo, userid);
                    //是否绑定银行卡
                    if (string.IsNullOrEmpty(userInfo.BankAccountNo))
                    {
                        PrintJson("0", "银行卡未绑定！");
                        return;
                    }
                    string requestId = WEBRequest.GetFormString("RequestId").ToUpper();
                    //确认绑卡
                    BindBankCard.ConfirmBindBankCard(requestId, valCode);

                    //无短信充值
                    AccountRechareInfo ar = getAccountRechare(orderId);  
                    if (null == ar)
                    {
                        PrintJson("0", "充值交易未成功！");
                        return;
                    }

                    var identityId = userInfo.Id.ToString().Replace("-", string.Empty).ToUpper();
                    var bindCardModel = BindBankCardList.GetBindCardList(identityId, userInfo.BankAccountNo.Trim());
                    var rechargeAmount = (int)(ar.Amount * 100);
                    BindBankCardPay.BindPay(new BankCardPayRequestModel
                    {
                        Amount = rechargeAmount,
                        CallBackUrl = EBNotifyUrl,
                        CardLast = bindCardModel.Card_Last,
                        CardTop = bindCardModel.Card_Top,
                        IdentityId = identityId,
                        OrderId = orderId
                    });
                }
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("易宝充值出错:ConfirmPay", Tool.ExceptionHelper.GetExceptionMessage(ex));
                PrintJson("0", "发生错误：" + ex.Message);
                return;
            }
            PrintJson("1",""); 
        }
        #endregion

        protected void GetBankCardNo(UserBasicInfoInfo userInfo, Guid userid)
        {
            if (string.IsNullOrEmpty(userInfo.BankAccountNo))
            {
                UserBankInfo ubi = new UserBankInfo();
                string sql = @"SELECT BankAccountNo AS BankNo,BankType FROM UserBasicInfo WITH(NOLOCK) WHERE Id = @UserId "; 
                DynamicParameters para = new DynamicParameters();
                para.Add("@UserId", userid);
                ubi = PublicConn.QuerySingle<UserBankInfo>(sql, ref para);
                if (ubi != null)
                {
                    userInfo.BankAccountNo = ubi.BankNo;
                    userInfo.BankType = ubi.BankType;
                }
            }
        }

        protected void PrintJson(object data)
        {
            Response.ContentType = "application/json";
            var jsonString = JsonHelper.ToJson(data);
            this.Context.Response.Write(jsonString);
            this.Context.Response.End();
        }
        protected void PrintJson(string strstate, string strmsg)
        {
            Response.ContentType = "application/json";
            var objData = new ResponseData() { result = strstate, msg = strmsg };
            var jsonStr = TuanDai.WXSystem.Core.JsonHelper.ToJson(objData);
            this.Context.Response.Write(jsonStr);
            this.Context.Response.End();
        }
        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            AccountRechareInfo model = null; 
            string strSQL = " select TranOrder,UserId from AccountRechare WHERE TranOrder=@TranOrder";
            DynamicParameters paramData = new DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            model = PublicConn.QuerySingleWrite<AccountRechareInfo>(strSQL, ref paramData);
            return model; 
        }

       
        #region 内部Model
        protected class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
            public decimal Amount { get; set; }
            public Guid UserId { get; set; }
        }
        internal class ResponseData
        {
            public string result { get; set; }
            public string msg { get; set; }
        }
        public class EBRechargeInfo {
            public string OrderId { get; set; }
            public string RequestId { get; set; }
            public int IsBindCard { get; set; }
        }
        public class UserBankInfo
        {
            public string BankNo { get; set; }

            public int? BankType { get; set; }
        }
        #endregion 

    }
}