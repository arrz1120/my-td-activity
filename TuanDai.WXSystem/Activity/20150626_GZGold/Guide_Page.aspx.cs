using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Activity._20150626_GZGold
{
    public partial class Guide_Page : System.Web.UI.Page
    {
        protected string ReturnUrl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ReturnUrl = WEBRequest.GetString("ReturnUrl", GlobalUtils.WebURL + "/Index.aspx");
                Guid? userId = WebUserAuth.UserId;
                if (userId != Guid.Empty)
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Activity/20150626_GZGold/Index.aspx");
                }
            }
        }
    }
}