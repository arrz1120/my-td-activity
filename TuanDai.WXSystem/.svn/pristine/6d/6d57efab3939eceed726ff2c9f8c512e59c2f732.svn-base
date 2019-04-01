using System;
using System.Linq;
using System.Web.UI;
using BusinessDll;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL; 

namespace TuanDai.WXApiWeb.Activity.inviteGetgift
{
    public partial class IndexApp : BasePage
    {
        protected bool IsLogin = false;
        protected string ExtendKey = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                #region APP如果已经登陆,官网自动登陆
                string appActivityToken = Tool.WEBRequest.GetString("t");
                if (!string.IsNullOrEmpty(appActivityToken))
                {
                    UserBasicInfoInfo model = new TuanDai.PortalSystem.BLL.AppUserTokenRecBLL().GetAppActivityUser(appActivityToken);
                    if (model != null)
                    {
                        WebUserAuth.SignIn(model.Id.ToString(), Page.Request.ToString());
                    }
                    else
                    {
                        WebUserAuth.SignOut();
                    }
                }
                #endregion
                Guid? userId = WebUserAuth.UserId;
                if (userId != Guid.Empty)
                {
                    IsLogin = true;

                    if (string.IsNullOrEmpty(Request.QueryString["key"]))
                    {
                        UserBasicInfoInfo userModel = new UserBLL().GetUserBasicInfoModelById(userId.Value);
                        ExtendKey = userModel.ExtendKey;
                        Response.Redirect("IndexApp.aspx?key=" + ExtendKey);
                    }
                }

              
            }
        }
    }
}