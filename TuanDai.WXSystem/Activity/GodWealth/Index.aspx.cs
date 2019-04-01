using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using Tool;

namespace TuanDai.WXApiWeb.Activity.GodWealth
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ExtendKey = WEBRequest.GetQueryString("ExtendKey");

            string requestURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

            string callBackURL = GlobalUtils.WebURL + "/Activity/GodWealth/WealthPage.aspx?ExtendKey=" + ExtendKey;

            requestURL = string.Format(requestURL, GlobalUtils.AppId, callBackURL);

            Response.Redirect(requestURL);
        }
         
    }
}