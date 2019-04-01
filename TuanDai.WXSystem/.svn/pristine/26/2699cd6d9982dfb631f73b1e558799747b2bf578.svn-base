using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using Newtonsoft.Json.Linq;
using LLPay;
using System.Net; 
using BusinessDll;
using System.Configuration;
using TuanDai.WXSystem.Core;
using System.Data.SqlClient;  
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Dapper; 

namespace TuanDai.WXApiWeb.PaymentPlatform.lianlian
{
    public partial class plainPay : UserPage
    {
       
        protected PartnerConfig partnerConfig = null;
        protected string acctName, user_id, telno = "";
        protected Guid userid;
        protected UserBasicInfoInfo userInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
 
            WebSettingInfo webSetting = new WebSettingBLL().GetWebSettingInfo("E27798C9-9301-4176-AC0B-6F3916F389EA"); 
            //string oidPartner = "201408071000001543";
            //string md5key = "201408071000001543test_20140812";
            //string TraderPriKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOilN4tR7HpNYvSBra/DzebemoAiGtGeaxa+qebx/O2YAdUFPI+xTKTX2ETyqSzGfbxXpmSax7tXOdoa3uyaFnhKRGRvLdq1kTSTu7q5s6gTryxVH2m62Py8Pw0sKcuuV0CxtxkrxUzGQN+QSxf+TyNAv5rYi/ayvsDgWdB3cRqbAgMBAAECgYEAj02d/jqTcO6UQspSY484GLsL7luTq4Vqr5L4cyKiSvQ0RLQ6DsUG0g+Gz0muPb9ymf5fp17UIyjioN+ma5WquncHGm6ElIuRv2jYbGOnl9q2cMyNsAZCiSWfR++op+6UZbzpoNDiYzeKbNUz6L1fJjzCt52w/RbkDncJd2mVDRkCQQD/Uz3QnrWfCeWmBbsAZVoM57n01k7hyLWmDMYoKh8vnzKjrWScDkaQ6qGTbPVL3x0EBoxgb/smnT6/A5XyB9bvAkEA6UKhP1KLi/ImaLFUgLvEvmbUrpzY2I1+jgdsoj9Bm4a8K+KROsnNAIvRsKNgJPWd64uuQntUFPKkcyfBV1MXFQJBAJGs3Mf6xYVIEE75VgiTyx0x2VdoLvmDmqBzCVxBLCnvmuToOU8QlhJ4zFdhA1OWqOdzFQSw34rYjMRPN24wKuECQEqpYhVzpWkA9BxUjli6QUo0feT6HUqLV7O8WqBAIQ7X/IkLdzLa/vwqxM6GLLMHzylixz9OXGZsGAkn83GxDdUCQA9+pQOitY0WranUHeZFKWAHZszSjtbe6wDAdiKdXCfig0/rOdxAODCbQrQs7PYy1ed8DuVQlHPwRGtokVGHATU=";
            //string YTPublicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSS/DiwdCf/aZsxxcacDnooGph3d2JOj5GXWi+q3gznZauZjkNP8SKl3J2liP0O6rU/Y/29+IUe+GTMhMOFJuZm1htAtKiu5ekW0GlBMWxf4FPkYlQkPE0FtaoMP3gYfh+OwI+fIRrpW3ySn3mScnc6Z700nU/VYrRkfcSCbSnRwIDAQAB";
            partnerConfig = new PartnerConfig(webSetting.Param1Value, webSetting.Param2Value, webSetting.Param3Value, webSetting.Param5Value);//new PartnerConfig(oidPartner, md5key, TraderPriKey, YTPublicKey);
            //partnerConfig.YTPublicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSS/DiwdCf/aZsxxcacDnooGph3d2JOj5GXWi+q3gznZauZjkNP8SKl3J2liP0O6rU/Y/29+IUe+GTMhMOFJuZm1htAtKiu5ekW0GlBMWxf4FPkYlQkPE0FtaoMP3gYfh+OwI+fIRrpW3ySn3mScnc6Z700nU/VYrRkfcSCbSnRwIDAQAB";
            //partnerConfig.TraderPriKey = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMhKNA1Ws0H6PrZ8t1lQxhQjERj0hYf8QWBlF2DtlMajYU52WsiGIvid6iQQhJGc+aPNTf3MfWCWSHk2XRIYRpjoVPQ8Oz8sLF8j3pT3I2h2gDRNvO2xqX+x+jyFDMnAXm4uMyBYS9wabuhUchF5JkHT1A3rZZFYapPqMTj/zeEFAgMBAAECgYB+uPwwCFAIiYVOPqBe4U1CBmHV8TffLwpKLAvbptX/y/VQCHAt+Th9JqSyxsSpwLDuI4KZ9tzI1KzsDCpcvYFEMuoPNgwjZBFBsmTdXD+nxUTKVbTII6kITyzMMWDBnF8LxAicMKpYcRKaVOULCg/AHPGV32Efd4pH8cyJGcJ6TQJBAP+7+YygfcJLvxI9kk/2Se+dI//mX6WVh1V0RFgSl0cWry+xq9xTQofy0wU++TiXkA05aCJbwY0EjyodUOcpHkMCQQDIf3r3WVpW4Fx6t6B2geew4mllckFEHHDf0pXE5GWymccQHHxo6knFrzZ8F/97XwAIGTabNBXQiWd9G1DfEyMXAkEAow/84wpCpe0efEb+UDY+lqagGb+PJUne7UIhgfb4tr9kHQkxCF+egIj4vNOWndsmYwhDugS/uWc60iO3Pm4deQJAC3qA57hN27tsj/oDTcWSJiZQMmagJe4a6DV+LY+F4vu60clPthHzt0WYsPIOxllh/xSyc6A/v3ieXCM8Ngk6cQJBAJiX6nzlyLyHrHQ0jIdQ97bYtJTqh0ZC6bZ3PShCj3we/Cu+5v6L5Rmwx0s+OJ84OnWIopuuc5QwmOT53VRIntE=";
            //partnerConfig.MD5Key = "201306031000001013";

        }

        protected SortedDictionary<string, string> getBaseParamDict()
        {

            if (WebUserAuth.UserId != Guid.Empty)
            {
                userid = WebUserAuth.UserId.Value;
            }
            else
            {
                Response.Redirect("~/user/login.aspx");
                return null;
            }

            /**订单信息**/
            // 商户唯一订单号
            string no_order = "" + Request.QueryString["orderno"];
            // 商户订单时间
            string dt_order = PaymentUtil.GetCurrentDateTimeStr();

            AccountRechareInfo rechargemodel = getAccountRechare(no_order);
            if (rechargemodel == null)
            {
                return null;
            }
            // 交易金额 单位为RMB-元
            string money_order = rechargemodel.Amount.ToString("f2");

            // 商品名称
            string name_goods = "Online Recharge";

            // 订单描述
            string info_order = "Online Recharge";

            
            //var userInfo = db.UserBasicInfo.FirstOrDefault(x => x.AuditRecordId == userid);
            //if (null == userInfo)
            //{
                                
            //}
            SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
            try
            {
                UserBLL bll = new UserBLL();
                userInfo = bll.GetUserBasicInfoModelById(userid);
                //从UserBasicInfo表获取银行卡号
                if (string.IsNullOrEmpty(userInfo.BankAccountNo))
                {

                    string sql = @"SELECT BankAccountNo as BankNo FROM UserBasicInfo WITH(NOLOCK) WHERE Id = @UserId ";
                    DynamicParameters para = new DynamicParameters();
                    para.Add("@UserId", userid);
                    userInfo.BankAccountNo = PublicConn.QuerySingle<string>(sql, ref para); 
                }
                /** 商户提交参数**/
                string version = partnerConfig.Version;						//接口版本号
                string oid_partner = partnerConfig.OidPartner;		//商户编号
                user_id = userid.ToString();				//用户ID
                string sign_type = partnerConfig.SignType;					//签名类型：RSA/MD5
                string busi_partner = partnerConfig.BusiPartner; 			//业务类型 虚拟商品销售
               // string notify_url = ConfigurationManager.AppSettings["WebUrl"] + "/PaymentPlatform/lianlian/notify_url.aspx";//接收异步通知地
                string notify_url = "https://www.tuandai.com/PaymentPlatform/lianlian/notify_url.aspx";

                string url_return = ConfigurationManager.AppSettings["WebUrl"] + "/PaymentPlatform/lianlian/urlReturn.aspx";//支付结束后返回地址

                string userreq_ip = PaymentUtil.LocalIPAddress();//IP *
                //string url_order = "";
                string valid_order = "10080";								// 订单有效期 单位分钟，可以为空，默认7天
                string timestamp = PaymentUtil.GetCurrentDateTimeStr();		//时间戳
                //string idType = "0"; //证件类型
                string idNo = userInfo.IdentityCard;//"623026199206016992";
                acctName = userInfo.RealName;//"彭思微";
                telno = userInfo.TelNo;

                

                sParaTemp.Add("app_request", "3");
                sParaTemp.Add("bg_color", "d93f3f");
                sParaTemp.Add("busi_partner", busi_partner);
                sParaTemp.Add("card_no", userInfo.BankAccountNo);
                sParaTemp.Add("dt_order", dt_order);
                sParaTemp.Add("id_no", idNo);
                sParaTemp.Add("info_order", info_order);
                sParaTemp.Add("money_order", money_order);
                sParaTemp.Add("name_goods", name_goods);
                //sParaTemp.Add("no_agree", "");
                sParaTemp.Add("no_order", no_order);
                sParaTemp.Add("notify_url", notify_url);
                sParaTemp.Add("oid_partner", oid_partner);
                sParaTemp.Add("acct_name", acctName);
                sParaTemp.Add("risk_item", createRiskItem(userid, acctName, idNo, userInfo.TelNo, userInfo.AddDate.Value.ToString("yyyyMMddHHmmss")));
            //    sParaTemp.Add("risk_item", createRiskItemOld(user_id, acctName));
                sParaTemp.Add("sign_type", sign_type);
                sParaTemp.Add("url_return", url_return);
                sParaTemp.Add("user_id", telno);
                sParaTemp.Add("valid_order", valid_order);

                NetLog.WriteBatchwithdrawHandler("连连充值请求", string.Concat("签名方式", sign_type, "订单号:", no_order, ",用户编号:", user_id, "充值金额", money_order, "IP地址", userreq_ip), "触屏版");
                //LogHelper.WriteLog("连连充值请求", "", string.Concat("签名方式", sign_type, "订单号:", no_order, ",用户编号:", user_id, "充值金额", money_order, "IP地址", userreq_ip));
                
            }
            catch (Exception ex)
            {
                string errormessage = "内部错误:" + ex.InnerException + "\r\n堆栈:" + ex.StackTrace + "\r\n信息:" + ex.Message + "\r\n来源:" + ex.Source;
                //LogTextHelper.Instance.AddLog(errormessage); 
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog("WXTouch", "连连充值请求", "", errormessage);   
            }
            return sParaTemp;
        }

        /**
         * 根据连连支付风控部门要求的参数进行构造风控参数
         * @return
         */
        public String createRiskItemOld(string userId, string userName)
        {
            return "{\"frms_ware_category\":\"" + userId + "\",\"user_info_full_name\":\"" + userName + "\"}";
        }
        /**
         * 根据连连支付风控部门要求的参数进行构造风控参数
         * @return
         */
        protected string createRiskItem(Guid userId, string userName, string idNo, string mobileNo, string regeisterDate)
        {
            var category = "2009";
            var idType = "0";
            var identifyType = "1";
            var identityStates = "1";
            return "{\"frms_ware_category\":\"" + category + "\",\"user_info_mercht_userno\":\"" + userId.ToString() + "\",\"user_info_bind_phone\":\"" + mobileNo + "\",\"user_info_dt_register\":\"" + regeisterDate + "\",\"user_info_full_name\":\"" + userName + "\",\"user_info_id_type\":\"" + idType + "\",\"user_info_id_no\":\"" + idNo + "\",\"user_info_identify_state\":\"" + identityStates + "\",\"user_info_identify_type\":\"" + identifyType + "\"}";
        }

        protected void SaveRequestSign(string key)
        {
            TuanDai.LogSystem.LogClient.LogClients.TraceLog("WXTouch", "连连充值请求签名", "", key);   
        }

        public class AccountRechareInfo
        {
            public string TranOrder { get; set; }
            public byte? From { get; set; }
            public decimal Amount { get; set; }

            public Guid Id { get; set; }
        }

        private AccountRechareInfo getAccountRechare(string TranOrder)
        {
            AccountRechareInfo model = null;
            string strSQL = " select Id,TranOrder,Amount from AccountRechare WITH(NOLOCK) WHERE TranOrder=@TranOrder";
            DynamicParameters paramData = new DynamicParameters();
            paramData.Add("@TranOrder", TranOrder);
            model = PublicConn.QuerySingleWrite<AccountRechareInfo>(strSQL, ref paramData);
            return model;
        }
    }
}