﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class saleRecord : BasePage
    {
        public Guid productid;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            var idStr = Request.QueryString["productid"];
            if (!string.IsNullOrWhiteSpace(idStr))
                productid = Guid.Parse(idStr);
            else
                Response.Redirect("productList.aspx");

            
        }
    }
}