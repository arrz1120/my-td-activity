using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 

namespace TuanDai.WXApiWeb.Activity.inviteGetgift
{
    public partial class register : BasePage
    {
        protected string ExtendKey="";
        protected string tdFrom = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                ExtendKey = Request.QueryString["ExtendKey"];
                tdFrom = Request.QueryString["tdFrom"] == null ? "" : Request.QueryString["tdFrom"];
                if (WebUserAuth.IsAuthenticated || string.IsNullOrEmpty(ExtendKey))
                {
                    Response.Redirect("Index.aspx");
                }
            }
        }
    }
}