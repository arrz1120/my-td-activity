using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;

namespace TuanDai.WXApiWeb.user
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected string ReturnUrl;
        protected void Page_Load(object sender, EventArgs e)
        {
            WebUserAuth.SignOut();
            //移除OpenId allen 2015-07-30
            GlobalUtils.ClearOpenIdFromCookie();
            this.ReturnUrl = WEBRequest.GetString("ReturnUrl", "/Index.aspx"); 
        }
    }
}