﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Member.MemberCenter
{
    public partial class memberSystemQuestion : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
        }
    }
}