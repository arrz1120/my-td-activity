using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BusinessDll;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;
namespace TuanDai.WXApiWeb.user
{
    public partial class Register_Succeed : UserPage
    {
        protected string UserCount, UserName, returnUrl, tdfrom,channel,showActivity;
        protected WebSettingInfo WebSetting;
        protected UserBasicInfoInfo userBasicObj;
        protected void Page_Load(object sender, EventArgs e)
        {
            WebSetting = new WebSettingBLL().GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
            tdfrom = Tool.WEBRequest.GetQueryString("tdfrom");
            showActivity = Tool.WEBRequest.GetQueryString("showActivity");//用来标识是否显示四周年加息活动浮窗
            if (tdfrom.Contains("SNSMH-M1607-fzzxTT")|| !string.IsNullOrEmpty(showActivity))
            {
                IsShowRightBar = false;//分众传媒渠道去掉导航
            }
            channel = Tool.WEBRequest.GetQueryString("channel");//用来标识是否显示App下载
            if (!IsPostBack)
            {
                GetStatistics();
            }
        }

        #region 获取统计数据 GetStatistics
        /// <summary>
        /// 获取统计数据
        /// </summary>
        private void GetStatistics()
        {

            WebSiteDataInfo websitedatemodel = new WebSiteDataBLL().GetWebSiteData();
            if (websitedatemodel != null)
            {
                this.UserCount = websitedatemodel.TotalUser.ToString();
                this.UserName = Tool.CookieHelper.GetCookie("TDWUserName");
                TuanDai.PortalSystem.BLL.UserBLL userBll = new TuanDai.PortalSystem.BLL.UserBLL();
                userBasicObj = userBll.GetUserBasicInfoModelById(WebUserAuth.UserId.Value); 
                if (this.UserName.IsEmpty())
                {
                    if (userBasicObj != null)
                    {
                        this.UserName = userBasicObj.UserName;
                    }
                }
                this.returnUrl = Tool.WEBRequest.GetString("ReturnUrl");
                if (!string.IsNullOrEmpty(returnUrl) && returnUrl.ToLower().Contains(TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl.ToLower()))//跳转回ReturnUrl
                {
                    try
                    {
                        Response.Redirect(returnUrl, false);
                    }
                    catch (Exception ex)
                    {
                        SysLogHelper.WriteErrorLog("注册成功页面跳转异常", Tool.ExceptionHelper.GetExceptionMessage(ex));  
                    }
                    finally {
                        Response.End();
                    } 
                }
            } 
        }
        #endregion
    }
}