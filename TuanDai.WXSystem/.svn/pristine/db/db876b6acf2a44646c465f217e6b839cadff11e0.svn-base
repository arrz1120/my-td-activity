using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool; 
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.user.ThirdLogin
{
    /// <summary>
    /// 微信授权页面
    /// Allen 2015-07-03
    /// </summary>
    public partial class WeiboLogin : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CookieHelper.WriteCookie("WXLoginType", "3");

                #region 获取返回路径
                string returnurl = GlobalUtils.WebURL + "/Member/my_account.aspx";

                if (!string.IsNullOrEmpty(WEBRequest.GetString("ReturnUrl")))
                {
                    returnurl = WEBRequest.GetString("ReturnUrl");//团贷网返回路径 
                    if (string.IsNullOrEmpty(returnurl))
                        returnurl = GlobalUtils.WebURL + "/Member/my_account.aspx";
                }
                #endregion

                string CallbackUrl = GlobalUtils.WebURL + ConfigHelper.getConfigString("CallbackUrl") + "?ReturnUrl=" + returnurl;
                ThirdLoginSDK shareSdk = new ThirdLoginSDK();
                shareSdk.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                //获取微信授权时URL
                string requestUrl = shareSdk.GetCodeUrl(CallbackUrl);

                Response.Redirect(requestUrl);
            }
        }
    }
}