using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QConnectSDK.Context;
using QConnectSDK;
using QConnectSDK.Models;
using Tool;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.user.ThirdLogin
{
    public partial class QQLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetRequestToken(); 
        }

        private void GetRequestToken()
        {
            CookieHelper.WriteCookie("WXLoginType", "1");

            #region 获取返回路径
            string returnurl = GlobalUtils.WebURL + "/Member/my_account.aspx";

            if (!string.IsNullOrEmpty(WEBRequest.GetString("ReturnUrl")))
            {
                returnurl = WEBRequest.GetString("ReturnUrl");
                if (string.IsNullOrEmpty(returnurl))
                    returnurl = GlobalUtils.WebURL + "/Member/my_account.aspx";
            }
            #endregion 

            string CallbackUrl = "ReturnUrl=" + returnurl;
            ThirdLoginSDK shareSdk = new ThirdLoginSDK();
            shareSdk.InitSDK(ThirdLoginSDK.ThirdLoginType.QQ);
            //获取微信授权时URL
            string requestUrl = shareSdk.GetCodeUrl(CallbackUrl);

            Response.Redirect(requestUrl);

        } 
    }
}