using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;

namespace TuanDai.WXApiWeb.Activity.ThreeYearCeleb
{
    public partial class AuthIndex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ExtendKey = WEBRequest.GetQueryString("ExtendKey");

            string requestURL = "";
            int authorType = GetAuthorType();
            if (authorType == 1)
            {
                requestURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
            }
            else
            {
                //授权模式
                requestURL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
            }
          
            string callBackURL = GlobalUtils.WebURL + "/Activity/ThreeYearCeleb/GuidePage.aspx?ExtendKey=" + ExtendKey;
            requestURL = string.Format(requestURL, GlobalUtils.AppId, callBackURL);

            Response.Redirect(requestURL);
        }
        //获取授权类型
        private int GetAuthorType() {
            try
            {
                //using (SqlConnection connection = CelebHelper.OpenConnection(2))
                //{
                //    string strSQL = " SELECT AuthorType FROM WeiXinToken WITH(NOLOCK) WHERE AppId=@AppId";
                //    DynamicParameters dyParams = new DynamicParameters();
                //    dyParams.Add("@AppId", GlobalUtils.AppId);
                //    return connection.Query<Int32>(strSQL, dyParams).FirstOrDefault().ToInt(1);
                //}
                return 0;
            }
            catch (Exception ex) {
                return 1;
            }
        }
    }
}