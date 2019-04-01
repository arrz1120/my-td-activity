﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.CunGuanTong.Model;

namespace TuanDai.WXApiWeb.pages
{
    public partial class downOpenApp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!WebUserAuth.IsAuthenticated)
            {
                Response.Redirect("//passport.tuandai.com/2register?From=wap", false);
            }
        }
    }
}