using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Newtonsoft.Json;
using BusinessDll;
using System.Data.Objects; 
using System.Linq;
using LLPay;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.SMS.Client;
using TuanDai.WXSystem.Core;
using System.Data.SqlClient; 
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model.Enums;
using TuanDai.WXApiWeb;
using Dapper;

/// <summary>
/// 功能：服务器异步通知页面
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// ///////////////////页面功能说明///////////////////
/// 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
/// 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。

/// </summary>
public partial class PaymentPlatform_lianlian_notify_url : System.Web.UI.Page
{
   
    protected PartnerConfig partnerConfig = null;
    protected void Page_Load(object sender, EventArgs e)
    {

        WebSettingInfo webSetting = new WebSettingBLL().GetWebSettingInfo("E27798C9-9301-4176-AC0B-6F3916F389EA"); 
        partnerConfig = new PartnerConfig(webSetting.Param1Value, webSetting.Param2Value, webSetting.Param3Value, webSetting.Param5Value);
        SortedDictionary<string, string> sPara = GetRequestPost();
        if (null == sPara)
        {
            Response.End();
        }

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            NetLog.WriteBatchwithdrawHandler("接收连连支付异步通知数据", string.Concat("【", "签名:", sPara["sign"].ToString(), "签名方式:", sPara["sign_type"].ToString(), "我方订单号:", sPara["no_order"].ToString(), "充值金额:", sPara["money_order"].ToString(), "连连订单号:", sPara["oid_paybill"].ToString(), "】"));

            if (!PaymentUtil.CheckSign(sPara, partnerConfig.YTPublicKey, //验证失败
                partnerConfig.MD5Key))
            {
                var out_trade_no = sPara["no_order"].ToString();
                var rechargeMoney = sPara["money_order"].ToString();
                var transaction_id = sPara["oid_paybill"].ToString();

                //ObjectParameter outStatus = new ObjectParameter("outStatus", "0");
                //db.p_OnLineRechargeHandler(1, out_trade_no, decimal.Parse(rechargeMoney), transaction_id, outStatus);
                //int result = int.Parse(outStatus.Value.ToString());

                NetLog.WriteBatchwithdrawHandler("连连验签失败", string.Concat("签名:", sPara["sign"].ToString(), "签名方式:", sPara["sign_type"].ToString(), "连连处理状态:9999"));

                Response.Write(@"{""ret_code"":""9999"",""ret_msg"":""验签失败""}");
                Response.End();
            }
            else
            {
                var out_trade_no = sPara["no_order"].ToString();
                var rechargeMoney = sPara["money_order"].ToString();
                var transaction_id = sPara["oid_paybill"].ToString();

                string strSQL = "p_OnLineRechargeHandler";
                DynamicParameters dyParams = new DynamicParameters();
                dyParams.Add("@orderno", out_trade_no);
                dyParams.Add("@MediumMoney", decimal.Parse(rechargeMoney));
                dyParams.Add("@MediumOrderNo", transaction_id);
                dyParams.Add("@outStatus", 0, DbType.Int32, ParameterDirection.Output, 20); 

                if (sPara["result_pay"].ToString().ToLower() == "success".ToLower())
                {
                    dyParams.Add("@handlerStatus", 2);  
                }
                else
                {
                    dyParams.Add("@handlerStatus", 1);  
                }
                PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref dyParams, CommandType.StoredProcedure);
                int result = dyParams.Get<int>("@outStatus");
                 
                AccountRechareInfo accountRechare = getAccountRechare(out_trade_no);
                if (accountRechare != null)
                {
                    var para = new DynamicParameters();
                    para.Add("@UserId", accountRechare.UserId);
                    var count = PublicConn.QuerySingleWrite<int>("select count(0) from AccountRechare with(nolock) where UserId=@UserId and Status =2   and type in (2, 3, 4, 6, 8, 12)", ref para);
                    if (count == 1)
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
                        
                        

                        //第三方渠道回调
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
                    }
                }

                NetLog.WriteTraceLogHandler("交易成功", string.Concat("签名:", sPara["sign"].ToString(), "签名方式:", sPara["sign_type"].ToString(), "我方处理状态:", result.ToString().Trim(), "连连处理状态:", sPara["result_pay"].ToString()));
                Response.Write(@"{""ret_code"":""0000"",""ret_msg"":""交易成功""}");
                Response.End();
            }
        }
        else
        {
            //var out_trade_no = sPara["no_order"].ToString();
            //var rechargeMoney = sPara["money_order"].ToString();
            //var transaction_id = sPara["oid_paybill"].ToString();

            //ObjectParameter outStatus = new ObjectParameter("outStatus", "0");
            //db.p_OnLineRechargeHandler(1, out_trade_no, decimal.Parse(rechargeMoney), transaction_id, outStatus);
            ////Response.Write(@"{""ret_code"":""9999"",""ret_msg"":""验签失败""}");

            //int result = int.Parse(outStatus.Value.ToString());

            NetLog.WriteBatchwithdrawHandler("连连交易参数为空失败", "连连处理状态:9999");
            Response.Write(@"{""ret_code"":""9999"",""ret_msg"":""交易失败""}");
            Response.End();

        }

        // 解析异步通知对象
        // sPara 字典对象
        // TODO:更新订单，发货等后续处理
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

    /// <summary>
	/// 获取POST过来通知消息，并以“参数名=参数值”的形式组成字典
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public SortedDictionary<string, string> GetRequestPost()
    {
        string reqStr = readReqStr();

        SortedDictionary<string, string> sArray = JsonConvert.DeserializeObject<SortedDictionary<string, string>>(reqStr);
        return sArray;
    } 	 
    public String readReqStr()
    {
        StringBuilder sb = new StringBuilder();
        Stream inputStream = Request.GetBufferlessInputStream();
        StreamReader reader = new StreamReader(inputStream, System.Text.Encoding.UTF8);

        String line = null;
        while ((line = reader.ReadLine()) != null)
        {
            sb.Append(line);
        }
        reader.Close();
        return sb.ToString();
    }

    public class AccountRechareInfo
    {
        public string TranOrder { get; set; }
        public byte? From { get; set; }
        public decimal Amount { get; set; }
        public Guid UserId { get; set; }

        public Guid Id { get; set; }
    } 
}


