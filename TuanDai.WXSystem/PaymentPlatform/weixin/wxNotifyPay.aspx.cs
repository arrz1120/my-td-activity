using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Model.Enums;
using TuanDai.SMS.Client;

namespace TuanDai.WXApiWeb.PaymentPlatform.weixin
{
    public partial class wxNotifyPay : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                TuanDai.Payment.PaymentBLL paybll = new TuanDai.Payment.PaymentBLL();//此处实例化是为了给微信支付那些参数赋值

                TuanDai.Payment.ResultNotify resultNotify = new TuanDai.Payment.ResultNotify(this);
                resultNotify.AfterPayProcess = DoAfterPay;
                resultNotify.ProcessNotify();
            }
            catch (Exception ex)
            {
                string errormessage = "内部错误:" + ex.InnerException + "\r\n堆栈:" + ex.StackTrace + "\r\n信息:" + ex.Message + "\r\n来源:" + ex.Source;
               
                 SysLogHelper.WriteErrorLog("微信支付回调报错", errormessage);
            }
        }

        protected void DoAfterPay(TuanDai.Payment.ResultNotify resultNotify)
        {
            if (resultNotify.IsSuccess)
            {
                AccountRechareInfo accountRechare = getAccountRechare(resultNotify.OutTradeNo);
                if (accountRechare != null)
                {
                    //调用第三方渠道
                    try
                    {
                        TuanDai.PortalSystem.BLL.ThirdPartyChannel.RechargeCallBack(accountRechare.Id, accountRechare.UserId);
                    }
                    catch (Exception ex)
                    {
                        new TuanDai.LogSystem.LogClient.LogClients().WriteErrorLog(
                            "TuanDai.PortalSystem.BLL.ThirdPartyChannel.RechargeCallBack",
                            "", "", ex.Message);
                    }

                    UserBasicInfoInfo userBasicInfo = new UserBLL().GetUserBasicInfoModelById(accountRechare.UserId);
                    if (userBasicInfo != null)
                    {
                        var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                        if (isNewSmsRequest == "0")
                        {
                            var parameters = new Dictionary<string, object>();
                            parameters.Add("CurrentDate", DateTime.Now);
                            parameters.Add("RechargeMoney", resultNotify.TradeMoney);
                            parameters.Add("User", userBasicInfo);
                            parameters.Add("Host", GlobalUtils.WebURL);

                            var msgSender = new BusinessDll.MessageSend();
                            msgSender.SendMessage2(eventCode: MessageTemplates.RechargeSuccess, parameters: parameters,
                                mobile: userBasicInfo.TelNo, email: userBasicInfo.Email, userId: userBasicInfo.Id);
                        }
                        else
                        {
                            SmsRequest rechargeSuccessSmsRequest = new SmsRequest();
                            rechargeSuccessSmsRequest.EventCode = MsgTemplatesType.RechargeSuccess;
                            rechargeSuccessSmsRequest.PlatformSource = PlatformSource.Pc;
                            rechargeSuccessSmsRequest.UserId = userBasicInfo.Id;
                            rechargeSuccessSmsRequest.EmailAddress = userBasicInfo.Email;
                            rechargeSuccessSmsRequest.Mobile = userBasicInfo.TelNo;
                            rechargeSuccessSmsRequest.Parameters = new Dictionary<string, object>();
                            rechargeSuccessSmsRequest.Parameters.Add("RechargeMoney", resultNotify.TradeMoney);

                            string errorMessage = string.Empty;
                            SmsClient.SendMessage(rechargeSuccessSmsRequest, ref errorMessage);
                        }
                    }
                }
            }
        }

        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            AccountRechareInfo model = null;

            string strSQL = " select Id,TranOrder,UserId from AccountRechare WHERE TranOrder=@TranOrder";
            DynamicParameters paramData = new DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            model = PublicConn.QuerySingle<AccountRechareInfo>(strSQL, ref paramData);
            return model;
        }

        protected class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
            public decimal Amount { get; set; }
            public Guid UserId { get; set; }

            public Guid Id { get; set; }
        }
    }
}