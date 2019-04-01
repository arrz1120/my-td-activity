using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Activity._20150901Vote
{
    public partial class AuthIndex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ExtendKey = WEBRequest.GetQueryString("ExtendKey");

            string requestURL = "";
            //int authorType = GetAuthorType();
            //if (authorType == 1)
            //{
                requestURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
            //}
            //else
            //{
            //    //授权模式
            //    requestURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
            //}

                string callBackURL = GlobalUtils.WebURL + "/Activity/20150901Vote/Index.aspx?ExtendKey=" + ExtendKey;
            requestURL = string.Format(requestURL, GlobalUtils.AppId, callBackURL);

            Response.Redirect(requestURL);
        }
    }
}