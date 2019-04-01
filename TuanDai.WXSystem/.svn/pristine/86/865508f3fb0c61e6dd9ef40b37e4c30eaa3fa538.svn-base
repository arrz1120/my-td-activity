using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.pages.newaboutus
{
    public partial class aboutUs : BasePage
    {
        protected string strType = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            strType = Tool.WEBRequest.GetQueryString("type").ToText().Trim();
            //表示从introduceApp.html跳转过来的
            string isInApp = Tool.CookieHelper.GetCookie("IsInApp");
            if (isInApp != "1")
            {
                Tool.CookieHelper.ClearCookie("AboutUsType");
            }
            else {
                strType = "mobileapp";
            } 
          
            if (strType.IsNotEmpty())
                Tool.CookieHelper.WriteCookie("AboutUsType", strType, 30);
        }
    }
}