using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Configuration;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb
{
    public partial class WXIndex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string postString = string.Empty;
                string action = Tool.WEBRequest.GetQueryString("action");
                if (string.IsNullOrEmpty(action))
                {
                    if (HttpContext.Current.Request.HttpMethod.ToUpper() == "POST")
                    {
                        using (Stream stream = HttpContext.Current.Request.InputStream)
                        {
                            Byte[] postBytes = new Byte[stream.Length];
                            stream.Read(postBytes, 0, (Int32)stream.Length);
                            postString = Encoding.UTF8.GetString(postBytes);
                            string msg = new EventHandle().ReturnMessage(postString);
                            Response.Write(msg);
                        }
                    }
                    if (HttpContext.Current.Request.HttpMethod.ToUpper() == "GET")
                    {
                        new WeiXin().Auth();
                    }
                }
                else if (action.ToLower() == "clearcache")
                {
                    string user_Ip = Tool.WEBRequest.GetIP();
                    if (IsValidIp(user_Ip))
                    {
                        //清理客户端WCF缓存
                        //TuanDai.BalancedSystem.Client.BalancedSystemClient client = new TuanDai.BalancedSystem.Client.BalancedSystemClient();
                        //client.ClearCacheByClient();
                        Response.Write("1");
                        Response.End();
                    }
                    else
                    {
                        Response.Write("非法的来访IP");
                        Response.End();
                    }
                }
                else if (action.ToLower() == "cleartoken")
                {
                    string strValidatePass = Tool.WEBRequest.GetQueryString("ValidatePass");
                    if (strValidatePass == "tuandaiisgood")
                    {
                      //  TuanDai.WXApiWeb.Common.WeiXinApi.removeCache("WeiXinTicket");
                        //请求完检测DB中Token状态 Allen 2015-08-12
                        ThirdLoginSDK.CheckDBTokenDelegate chkStatus = new ThirdLoginSDK.CheckDBTokenDelegate(ThirdLoginSDK.CheckDBTokenStatus);
                        chkStatus.BeginInvoke(GlobalUtils.AppId, null, null);
                    }
                }
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("微信请求", "错误详细信息：" + ex.Message + "|" + ex.StackTrace); 
            }
        }

        /// <summary>
        /// 校验访问ip是否合法
        /// </summary>
        /// <param name="user_IP">访问者IP</param>
        /// <returns></returns>
        private bool IsValidIp(String user_IP)
        {
            //从配置的节点ClearCacheAccessIp中获取可访问的IP
            string AccessIp = ConfigurationManager.AppSettings["ClearCacheAccessIp"];
            if (!string.IsNullOrEmpty(AccessIp))
            {
                string[] AccessIpArray = AccessIp.Split(',');
                foreach (string strIp in AccessIpArray)
                {
                    if (user_IP == strIp)
                    {
                        return true;
                    }
                }
            }
            return false;
        }
    }
}