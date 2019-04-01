using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using System.Security.Cryptography;
using System.Data.Objects;
using BusinessDll;
using System.Data.SqlClient;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.PortalSystem.Model.Enums;
using Dapper;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Data;
using TuanDai.SMS.Client;


namespace TuanDai.WXApiWeb.PaymentPlatform.Baofu
{
    public partial class PaymentPlatform_Baofu_Return_Url : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e)
        {
            InitData();
        }

        private void InitData()
        {
            try
            {
               
                WebSettingInfo webSetting = new WebSettingBLL().GetWebSettingInfo("fe5e5a30-b12c-4888-9858-12cbe80e1018"); 

                string MemberID = Request.Params["MemberID"];//商户号
                string TerminalID = Request.Params["TerminalID"];//商户终端号
                string TransID = Request.Params["TransID"];//商户流水号
                string Result = Request.Params["Result"];//支付结果(1:成功,0:失败)
                string ResultDesc = Request.Params["ResultDesc"];//支付结果描述
                string FactMoney = Request.Params["FactMoney"];//实际成交金额
                string AdditionalInfo = Request.Params["AdditionalInfo"];//订单附加消息
                string SuccTime = Request.Params["SuccTime"];//交易成功时间
                string Md5Sign = Request.Params["Md5Sign"].ToLower();//md5签名
                string Md5Key = "abcdefg";//webSetting.Param2Value;//ConfigurationManager.AppSettings["Md5key"];//密钥 双方约定
                String mark = "~|~";//分隔符

                //string _Md5Key = "100000178";//测试商户号//webSetting.Param1Value;//WebConfigurationManager.AppSettings["Md5key"];

                string _WaitSign = "MemberID=" + MemberID + mark + "TerminalID=" + TerminalID + mark + "TransID=" + TransID + mark + "Result=" + Result + mark + "ResultDesc=" + ResultDesc + mark
                     + "FactMoney=" + FactMoney + mark + "AdditionalInfo=" + AdditionalInfo + mark + "SuccTime=" + SuccTime
                     + mark + "Md5Sign=" + Md5Key;

               SysLogHelper.WriteTraceLog("等待验签参数", _WaitSign);
                //验证签名成功
                if (Md5Sign.ToLower() == Md5Encrypt(_WaitSign).ToLower())
                { 

                    ///支付结果(1:成功,0:失败)
                    DynamicParameters dyParams = new DynamicParameters();
                    string strSQL = "";
                    if (Result == "1")
                    {
                        strSQL = "p_OnLineRechargeHandler";
                        dyParams = new DynamicParameters();
                        dyParams.Add("@handlerStatus",2);
                        dyParams.Add("@MediumMoney", decimal.Divide(decimal.Parse(FactMoney), 100));
                        dyParams.Add("@MediumOrderNo", (TransID + SuccTime).Trim());
                        dyParams.Add("@outStatus",0,DbType.Int32,ParameterDirection.Output,20);

                        PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref dyParams, CommandType.StoredProcedure);

                        int presult = dyParams.Get<int>("@outStatus");

                        SysLogHelper.WriteTraceLog("宝付支付交易成功", string.Concat("签名:", Md5Sign.ToLower(), "签名方式:", "MD5", "我方处理状态:", presult.ToString().Trim(), "宝付处理状态:", Result, "支付单号:", TransID));

                        AccountRechareInfo accountRechare = getAccountRechare(TransID);
                        if (accountRechare != null)
                        {
                             strSQL = "select count(1) from AccountRechare where UserId=@userId and Status=2 and  [type] in(2, 3, 4, 6, 8, 12)";
                             dyParams = new DynamicParameters();
                             dyParams.Add("@userId", accountRechare.UserId);
                             int iCount = PublicConn.QuerySingleWrite<int>(strSQL, ref dyParams);
                             if (iCount > 0)
                             {
                                 TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(accountRechare.UserId, (int)ConstString.UserGrowthType.FirstReCharge, null, 0);
                             }
                            UserBasicInfoInfo userBasicInfo = new UserBLL().GetUserBasicInfoModelById(accountRechare.UserId); 
                            if (userBasicInfo != null)
                            {
                                var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                                if (isNewSmsRequest == "0")
                                {
                                    var parameters = new Dictionary<string, object>();
                                    parameters.Add("CurrentDate", DateTime.Now);
                                    //parameters.Add("RechargeMoney", FactMoney);
                                    parameters.Add("RechargeMoney", decimal.Divide(decimal.Parse(FactMoney), 100));//宝付充值以分为单位
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
                                    rechargeSuccessSmsRequest.Parameters.Add("RechargeMoney", FactMoney);

                                    string errorMessage = string.Empty;
                                    SmsClient.SendMessage(rechargeSuccessSmsRequest, ref errorMessage);
                                }
                            }
                        }
                        Response.Write("OK");
                        Response.End();
                    }

                    //if (Result == "0")
                    //{
                    //    db.p_OnLineRechargeHandler(1, TransID.Trim(), decimal.Divide(decimal.Parse(FactMoney), 100), (TransID + SuccTime).Trim(), outStatus);
                    //    int presult = int.Parse(outStatus.Value.ToString());
                    //    NetLog.WriteLoginHandler("宝付支付交易失败", string.Concat("签名:", Md5Sign.ToLower(), "签名方式:", "MD5", "我方处理状态:", presult.ToString().Trim(), "宝付处理状态:", Result, "支付单号:", TransID));

                    //    Response.Write("Fail");
                    //}
                }
                else
                {
                    SysLogHelper.WriteTraceLog("宝付验签失败", string.Concat("宝付返回签名:", Md5Sign.ToLower(), "等待验签", Md5Encrypt(_WaitSign).ToLower(), "签名方式:", "MD5", "宝付处理状态:", Result));
                    Response.Write("校验失败");
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("宝付支付失败", "错误详细信息：" + ex.Message + "|" + ex.StackTrace);
                Response.Write("Fail");
                Response.End();
            }  
        }

        //将字符串经过md5加密，返回加密后的字符串的小写表示

        private string Md5Encrypt(string strToBeEncrypt)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            Byte[] FromData = System.Text.Encoding.GetEncoding("utf-8").GetBytes(strToBeEncrypt);
            Byte[] TargetData = md5.ComputeHash(FromData);
            string Byte2String = "";
            for (int i = 0; i < TargetData.Length; i++)
            {
                Byte2String += TargetData[i].ToString("x2");
            }
            return Byte2String.ToLower();
        }

        public class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
            public decimal Amount { get; set; }
            public Guid UserId { get; set; }
        }

        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            AccountRechareInfo model = null;

            string strSQL = " select TranOrder,UserId from AccountRechare WHERE TranOrder=@TranOrder";
            DynamicParameters paramData = new DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            model = PublicConn.QuerySingle<AccountRechareInfo>(strSQL, ref  paramData);
            return model; 
        }
    }
}