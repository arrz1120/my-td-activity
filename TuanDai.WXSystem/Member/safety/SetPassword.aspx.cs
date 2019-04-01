using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class SetPassword : UserPage
    {
        /// <summary>
        /// 手机号码
        /// </summary>
        protected string tel;
        protected void Page_Load(object sender, EventArgs e)
        {
            tel = Request.QueryString["tel"];
            if (string.IsNullOrEmpty(tel))
                Response.Redirect("BindMobile.aspx");
        }
    }
}