using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Activity
{
    public partial class DrawGuid:Page
    {
        protected string returnUrl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.returnUrl = WEBRequest.GetString("ReturnUrl", GlobalUtils.WebURL + "/Index.aspx"); 
                Guid? userId = WebUserAuth.UserId;
                if (userId != Guid.Empty)
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Activity/20150613/FinanceDrawActivity.aspx");
                }
            }
        }
    }
}