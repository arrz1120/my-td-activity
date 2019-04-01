using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Activity.Minions
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string requestURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

            string callBackURL = GlobalUtils.WebURL + "/Activity/Minions/MinionsPage.aspx";

            requestURL = string.Format(requestURL, GlobalUtils.AppId, callBackURL);

            Response.Redirect(requestURL);
        }
    }
}