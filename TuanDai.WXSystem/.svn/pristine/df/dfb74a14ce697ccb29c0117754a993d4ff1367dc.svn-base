using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;
using Tool;

namespace TuanDai.WXApiWeb.user.ThirdLogin
{
    public partial class SinaLogin : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                CookieHelper.WriteCookie("WXLoginType", "2");

                string returnurl = GlobalUtils.WebURL + "/Member/my_account.aspx";
                if (!string.IsNullOrEmpty(WEBRequest.GetString("ReturnUrl")))
                {
                    returnurl = WEBRequest.GetString("ReturnUrl");//团贷网返回路径 
                    if (string.IsNullOrEmpty(returnurl))
                        returnurl = GlobalUtils.WebURL + "/Member/my_account.aspx";
                }

                string CallbackUrl = GlobalUtils.WebURL + ConfigHelper.getConfigString("CallbackUrl") + "?ReturnUrl=" + returnurl;

                ThirdLoginSDK shareSdk = new ThirdLoginSDK();
                shareSdk.InitSDK(ThirdLoginSDK.ThirdLoginType.Sina);

                string requestUrl = shareSdk.GetCodeUrl(CallbackUrl);

                Response.Redirect(requestUrl);
            }
        }
    }
}