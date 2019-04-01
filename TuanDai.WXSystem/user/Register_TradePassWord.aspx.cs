using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.user
{
    public partial class Register_TradePassWord : UserPage
    {
        protected string returnUrl;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.returnUrl = Tool.WEBRequest.GetString("ReturnUrl");
        }
    }
}