﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Member
{
    public partial class my_account_more : UserPage
    {
        protected int IsInWeiXin = 0; 
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect(GlobalUtils.WebURL+"/Member/my_account_more.aspx");
            IsInWeiXin = GlobalUtils.IsWeiXinBrowser ? 1 : 0;
        }
    }
}