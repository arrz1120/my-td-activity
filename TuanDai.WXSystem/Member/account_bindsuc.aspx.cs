using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Member
{
    public partial class account_bindsuc : UserPage
    {
        protected string weiXinNickName;
        protected string tel;
        protected void Page_Load(object sender, EventArgs e)
        {
            weiXinNickName = CookieHelper.GetCookie("shellben4wxname");
            tel = CookieHelper.GetCookie("shellben4tel");
            if (string.IsNullOrEmpty(tel))
            {
                tel = "1*********";
            }
            CookieHelper.ClearCookie("shellben4tel");
            CookieHelper.ClearCookie("shellben4wxname");
        }
    }
}