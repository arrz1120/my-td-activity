using Dapper; 
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.Payment;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Model.Enums;
using System.Data;
using TuanDai.SMS.Client;

namespace TuanDai.WXApiWeb.PaymentPlatform.EB
{
    public partial class PayCallback : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TuanDai.Payment.Log.Info(this.GetType().ToString(), "开始易宝回调");
            string callback_result = "";
            try
            {
                if (Request["data"] == null || Request["encryptkey"] == null)
                {
                    TuanDai.Payment.Log.Info(this.GetType().ToString(), "参数不正确");
                    Response.Write("参数不正确！");
                    Response.End();
                }

                TuanDai.Payment.Log.Info(this.GetType().ToString(), "易宝回调加密参数:" + Request["data"] + ",密钥:" + Request["encryptkey"]);
                //商户注意：接收到易宝的回调信息后一定要回写success用以保证握手成功！

                string data = Request["data"]; //回调中的参数data
                string encryptkey = Request["encryptkey"];//回调中的参数encryptkey
                callback_result = YJPayUtil.checkYbCallbackResult(data, encryptkey);
                var resultData = JsonConvert.DeserializeObject<SortedDictionary<string, string>>(callback_result);
                TuanDai.Payment.Log.Info(this.GetType().ToString(), "The Pay result is Values  : " + callback_result);

                if (resultData == null || resultData.ContainsKey("error_msg"))
                {
                    Response.Write("参数不正确！");
                    Response.End();
                }

                var status = resultData["status"].ToString();
                var rechargeMoney = resultData["amount"].ToString();
                var out_trade_no = resultData["orderid"].ToString();
                var transaction_id = resultData["yborderid"].ToString();

                string strSQL = "p_OnLineRechargeHandler";
                DynamicParameters dyParams = new DynamicParameters(); 
                dyParams.Add("@orderno", out_trade_no);
                dyParams.Add("@MediumMoney", decimal.Parse(rechargeMoney) / 100);
                dyParams.Add("@MediumOrderNo", transaction_id);
                dyParams.Add("@outStatus",0,DbType.Int32,ParameterDirection.Output,20); 
                if (status == "1")
                {
                    dyParams.Add("@handlerStatus", 2); 
                }
                else
                {
                    dyParams.Add("@handlerStatus", 1); 
                }
                PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref dyParams, CommandType.StoredProcedure);

                int result = dyParams.Get<int>("@outStatus");
                if (result == 1)
                {
                    AccountRechareInfo accountRechare = getAccountRechare(out_trade_no); 
                    if (accountRechare != null)
                    {
                        //List<int> typeList = new List<int>() { 2, 3, 4, 6, 8,9,11, 12 };
                        //if (db.AccountRechare.Count(p => p.UserId == accountRechare.UserId && p.Status == 2 && typeList.Contains(p.type)) == 1)
                        //{
                        //    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(accountRechare.UserId, (int)ConstString.UserGrowthType.FirstReCharge, null, 0);
                        //} 

                        TuanDai.PortalSystem.BLL.UserBLL bll = new TuanDai.PortalSystem.BLL.UserBLL();
                        UserBasicInfoInfo userBasicInfo = bll.GetUserBasicInfoModelById(accountRechare.UserId); 
                        if (userBasicInfo != null)
                        {
                            var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                            if (isNewSmsRequest == "0")
                            {
                                var parameters = new Dictionary<string, object>();
                                parameters.Add("User", userBasicInfo);
                                parameters.Add("CurrentDate", DateTime.Now);
                                parameters.Add("RechargeMoney", rechargeMoney);
                                parameters.Add("Host", GlobalUtils.WebURL);

                                var messageSender = new BusinessDll.MessageSend();
                                messageSender.SendMessage2(eventCode: MessageTemplates.RechargeSuccess, parameters: parameters,
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
                                rechargeSuccessSmsRequest.Parameters.Add("RechargeMoney", rechargeMoney);

                                string errorMessage = string.Empty;
                                SmsClient.SendMessage(rechargeSuccessSmsRequest, ref errorMessage);
                            }
                        }
                    }
                }

                //NetLog.WriteBatchwithdrawHandler("交易成功", string.Concat("签名:", sPara["sign"].ToString(), "签名方式:", sPara["sign_type"].ToString(), "我方处理状态:", result.ToString().Trim(), "连连处理状态:", sPara["result_pay"].ToString()));
                Response.Write(@"SUCCESS");
                Response.End();

                //SoftLog.LogStr("支付成功回调信息:" + callback_result, "yeepay/CallbackLog");
            }
            catch (Exception err)
            {
                TuanDai.Payment.Log.Info(this.GetType().ToString(), "支付失败:" + err.ToString() + "," + Request["data"] + Environment.NewLine + Request["encryptkey"] + "处理结果:" + callback_result);
                //SoftLog.LogStr("支付失败:" + err.ToString() + "," + Request["data"] + Environment.NewLine + Request["encryptkey"] + "处理结果:" + callback_result, "yeepay/CallbackLog");
                Response.Write("支付失败！");
                Response.End();
            }
            finally
            {
                //SoftLog.LogStr("支付回调信息" + Request["data"] + Environment.NewLine + Request["encryptkey"] + "处理结果:" + callback_result, "yeepay/CallbackLog");
            }
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
        protected class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
            public decimal Amount { get; set; }
            public Guid UserId { get; set; }
        }
    }
}