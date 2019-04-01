using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 

namespace TuanDai.WXApiWeb.Activity.inviteGetgift
{
    public partial class Gift : BasePage
    {
        protected string ExtendKey="";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                ExtendKey = Request.QueryString["ExtendKey"];
                if (WebUserAuth.IsAuthenticated)
                {
                    Response.Redirect("Index.aspx");
                }
            }
        }
    }
}