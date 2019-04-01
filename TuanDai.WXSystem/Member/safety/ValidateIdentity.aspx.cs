using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class ValidateIdentity : UserPage
    {
        protected string goUrl = string.Empty;
        protected string rechargeMoney = string.Empty;
        protected string selectType = string.Empty;
        protected string backurl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GlobalUtils.IsOpenCGT)
            {
                Response.Redirect("/Member/cgt/openCgt.aspx");
            }
            goUrl = Tool.WEBRequest.GetQueryString("goUrl");
            rechargeMoney = Tool.WEBRequest.GetQueryString("rechargeMoney");
            selectType = Tool.WEBRequest.GetQueryString("selectType");
            backurl = Tool.WEBRequest.GetQueryString("backurl");
        }
    }
}