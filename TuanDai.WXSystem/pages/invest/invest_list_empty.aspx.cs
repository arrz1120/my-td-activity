﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb
{
    public partial class invest_list_empty : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
        }
    }
}