using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;
using Tool;

namespace TuanDai.WXApiWeb.user.ThirdLogin
{
    public partial class BindLogin : System.Web.UI.Page
    {
        public string returnUrl { get; set; }
        //获取第三方响应后的code参数值
        protected string code { get; set; }
        protected int LoginType = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.returnUrl = WEBRequest.GetQueryString("ReturnUrl");
            LoginType = CookieHelper.GetCookie("WXLoginType").ToInt(0);  
            code = WEBRequest.GetQueryString("code");

            if (this.returnUrl.IsEmpty())
            {
                this.returnUrl = "/Member/my_account.aspx";
            } 
        }
    }
}