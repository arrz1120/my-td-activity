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
using System.Collections.Generic;
using System.Linq;

using System.Security;
using System.Security.Cryptography;
using System.Web.Configuration; 
using BusinessDll;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core;
using System.Data.SqlClient;
using Dapper; 


namespace TuanDai.WXApiWeb.PaymentPlatform.Baofu
{
    public partial class pay_post : System.Web.UI.Page
    {
        protected string strMemberID;
        protected string strPayID;
        protected string strTradeDate;
        protected string strTransID;
        protected string strOrderMoney;
        protected string strProductName;
        protected string strAmount;
        protected string strUsername;
        protected string strAdditionalInfo;
        protected string strPageUrl;
        protected string strReturnUrl;
        protected string strSignature;
        protected string strNoticeType;
        protected string strTerminalID;
        protected string strInterfaceVersion;
        protected string strKeyType; 

        protected string BFAction { get { return ConfigurationManager.AppSettings["BFRequestPayUrl"]; } }
        protected void Page_Load(object sender, EventArgs e)
        { 
            WebSettingInfo webSetting = new WebSettingBLL().GetWebSettingInfo("fe5e5a30-b12c-4888-9858-12cbe80e1018");

            // 商户唯一订单号
            string no_order = "" + Request.QueryString["orderno"];

            //LogHelper.WriteLog("宝付支付我方订单号", "", no_order);
            SysLogHelper.WriteTraceLog("宝付支付我方订单号", no_order);

            AccountRechareInfo rechargemodel = getAccountRechare(no_order);

            if (null == rechargemodel)
            {
                Response.Write("您好，获取充值记录为null！");
                return;
            }

            string strMd5Key;
            strMemberID = "100000178";//webSetting.Param1Value.ToString().Trim();//商户号

            strPayID = "";//Request.Params["PayID"];//招商银行是1001
            strTradeDate = DateTime.Now.ToString("yyyyMMddHHmmss");
            strTransID = rechargemodel.TranOrder.Trim();//strMemberID + DateTime.Now.ToString("MMddHHmmss");//商户订单号（交易流水号）(建议使用商户订单号加上贵方的唯一标识号)
            strOrderMoney = (float.Parse(rechargemodel.Amount.ToString("f2")) * 100).ToString();//订单金额，需要和卡面额一致(此处以分为单位)
            strProductName = "宝付在线充值";//商品名称
            strAmount = "1";//商品数量，为1
            strUsername = "";
            strAdditionalInfo = "";
            strPageUrl = GlobalUtils.WebURL + "/PaymentPlatform/Baofu/page_url.aspx"; //客户端跳转地址
            strReturnUrl = GlobalUtils.WebURL + "/PaymentPlatform/Baofu/return_url.aspx";//ConfigurationManager.AppSettings["BaofuNotifyUrl"];//ConfigurationManager.AppSettings["ReturnUrl"];//服务器端返回地址
            strNoticeType = "1";//0 不跳转 1 会跳转
            strMd5Key = "abcdefg";//webSetting.Param2Value.Trim();//ConfigurationManager.AppSettings["Md5key"];//密钥 双方约定
            strTerminalID = "10000001";//webSetting.Param3Value.Trim();//ConfigurationManager.AppSettings["TerminalID"];//终端
            strInterfaceVersion = "4.0";// webSetting.Param4Value.Trim();//ConfigurationManager.AppSettings["InterfaceVersion"];//版本 当前为4.0请勿修改 
            strKeyType = webSetting.Param5Value.Trim();//ConfigurationManager.AppSettings["KeyType"]; //加密方式默认1 MD5


            strSignature = GetMd5Sign(strMemberID, strPayID, strTradeDate,
                strTransID, strOrderMoney, strPageUrl, strReturnUrl, strNoticeType, strMd5Key);

            //LogHelper.WriteLog("支付请求签名", "", strSignature);
            SysLogHelper.WriteTraceLog("支付请求签名", no_order);
        }

        //md5签名
        private string GetMd5Sign(string _MerchantID, string _PayID, string _TradeDate, string _TransID,
            string _OrderMoney, string _Page_url, string _Return_url, string _NoticeType, string _Md5Key)
        {
            string mark = "|";
            string str = _MerchantID + mark
                        + _PayID + mark
                        + _TradeDate + mark
                        + _TransID + mark
                        + _OrderMoney + mark
                        + _Page_url + mark
                        + _Return_url + mark
                        + _NoticeType + mark
                        + _Md5Key;

            //LogHelper.WriteLog("支付请求报文", "", str);
           SysLogHelper.WriteTraceLog("支付请求报文", str);
            return Md5Encrypt(str);

        }

        //将字符串经过md5加密，返回加密后的字符串的小写表示
        public string Md5Encrypt(string strToBeEncrypt)
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
        }

        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            AccountRechareInfo model = null;

            string strSQL = " select TranOrder from AccountRechare WHERE TranOrder=@TranOrder";
            DynamicParameters paramData = new DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            model = PublicConn.QuerySingle<AccountRechareInfo>(strSQL, ref paramData);
            return model; 
        }
    }
}