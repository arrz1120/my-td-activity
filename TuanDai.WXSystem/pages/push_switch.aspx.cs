using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.InfoSystem.Model;
using TuanDai.SMS.Client;

namespace TuanDai.WXApiWeb.pages
{
    public partial class push_switch : UserPage
    {
        public string openId;
        protected void Page_Load(object sender, EventArgs e)
        {
            openId = GlobalUtils.OpenId;
            if (string.IsNullOrWhiteSpace(openId))
            {
                Response.Redirect("/member/my_account.aspx");
            }
        }
    } 
}