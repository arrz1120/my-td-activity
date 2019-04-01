using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Text;
using Tool;

namespace TuanDai.WXApiWeb
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //初始化WebSet表缓存
            TuanDai.PortalSystem.Redis.WebSetRedis.Init();
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            try
            {
                OnHandlerApplicationError(sender, e);
            }
            catch
            {
            }
        }
        internal void OnHandlerApplicationError(object sender, EventArgs e)
        {
            try
            {
                //是否写错误信息到日志
                bool isWriteLog = ConfigHelper.getConfigInt("IsLogInFile") == 1;
                if (isWriteLog)
                {
                    Exception objErr = Server.GetLastError().GetBaseException();
                    StringBuilder ErrorMsg = new StringBuilder();
                    string logUserId = "";
                    string strIP = "";
                    if (this.Context != null)
                    {
                        strIP = Tool.WebFormHandler.GetIP();
                        ErrorMsg.AppendFormat("\r\n上次请求URL: {0}\r\n", this.Context.Request.UrlReferrer);
                        ErrorMsg.AppendFormat("当前请求URL: {0}\r\n", this.Context.Request.RawUrl);
                        ErrorMsg.AppendFormat("用户IP: {0}\r\n", strIP);
                        ErrorMsg.AppendFormat("用户浏览器: {0}\r\n", this.Context.Request.UserAgent);
                        logUserId = WebUserAuth.UserId.ToText();                      
                    }
                    ErrorMsg.AppendFormat("内部错误: {0}\r\n", objErr.InnerException);
                    ErrorMsg.AppendFormat("堆栈: {0}\r\n", objErr.StackTrace);
                    ErrorMsg.AppendFormat("信息: {0}\r\n", objErr.Message);
                    ErrorMsg.AppendFormat("来源: {0}\r\n", objErr.Source + " 用户Id:" + logUserId);
                     
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog("WXTouch", "应用系统错误", objErr.TargetSite.Name, ErrorMsg.ToString(), true);                   
                }
            }
            catch
            {
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}