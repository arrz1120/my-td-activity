using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb
{
    public partial class StockSuccess : UserPage
    {
        protected string projectId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.projectId = Request.QueryString["projectId"];
            }
        }
    }
}