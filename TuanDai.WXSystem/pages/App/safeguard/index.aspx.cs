﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.pages.App.safeguard
{
    public partial class index : BasePage
    {
        protected decimal BabyPlanAmount = 0;//质量保障服务风险保证金
        protected DateTime BabyPlanReportDate;
        protected void Page_Load(object sender, EventArgs e)
        {
            //var type = Request.QueryString["type"];
            //Response.Redirect("//m.tdw.cn/pages/app/safeguard/index.aspx?type="+type);
            BabyPlanAmount = CommUtils.GetBabyPlanAmount(ref BabyPlanReportDate);
        }

        public string GetBabyPlanAmountStr(decimal BabyPlanAmount)
        {
            if (BabyPlanAmount > 100000000)
            {
                return Math.Floor(BabyPlanAmount/100000000) + "亿多";
            }
            else if (BabyPlanAmount > 10000000)
            {
                return Math.Floor(BabyPlanAmount / 10000000) + "千多万";
            }
            else
            {
                return Math.Floor(BabyPlanAmount / 10000) + "多万";
            }
        }

        public string GetBabyPlanAmountString(decimal BabyPlanAmount)
        {
            if (BabyPlanAmount > 100000000)
            {
                return Math.Floor(BabyPlanAmount / 100000000) + "亿";
            }
            else
            {
                return Math.Floor(Math.Floor(BabyPlanAmount / 10000) / 100) * 100 + "万";
            }
        }
    }
}