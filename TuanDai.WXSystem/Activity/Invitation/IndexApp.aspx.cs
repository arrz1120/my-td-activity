using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using BusinessDll; 
using System.Text;
using System.Data.Objects;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Activity.Invitation
{
    public partial class IndexApp : System.Web.UI.Page
    {
        /// <summary>
        /// 是否已经登录.
        /// </summary>
        protected bool isAuthenticated { get; set; }
        protected void Page_Load(object sender, EventArgs e)
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
            this.isAuthenticated = WebUserAuth.IsAuthenticated;
          
        }
    }
}