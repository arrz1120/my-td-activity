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
    public partial class orderDetail : UserPage
    {
        public MVipExchangeHistory order = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            var idStr = Request.QueryString["orderId"];
            if (!string.IsNullOrEmpty(idStr))
            {
                MVipExchangeHistoryBLL bll = new MVipExchangeHistoryBLL();
                Guid orderId = Guid.Parse(idStr);
                order = bll.GetMVipExchangeHistoryById(orderId);
            }
            else
            {
                //跳到兑换记录页面
            }
                
        }
    }
}