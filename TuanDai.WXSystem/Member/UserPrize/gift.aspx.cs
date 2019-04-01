using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class gift : UserPage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //标记已看过
            if (!IsPostBack) {
                Tool.CookieHelper.WriteCookie("ViewGiftStatus", "1");
            }
            //Response.Redirect(GlobalUtils.WebURL + "/Member/UserPrize/gift.aspx");
        }
    }
}