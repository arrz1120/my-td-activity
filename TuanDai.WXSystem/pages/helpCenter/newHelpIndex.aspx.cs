﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.News.Contract;
using TuanDai.News.Client;
using Tool;

namespace TuanDai.WXApiWeb.pages.helpCenter
{
    public partial class newHelpIndex : BasePage
    {
        protected List<WXHelpCategoryInfo> categroyList;
        protected List<WXHelpDetialInfo> hotQueList;//热门问题
        protected string strType = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("http://info.tdw.cn/wap/help/index.html");
            //strType = WEBRequest.GetQueryString("type").ToLower();
            //if (!IsPostBack)
            //{
            //    BinderData();
            //}
            //if (strType == "mobileapp")
            //{
            //    Tool.CookieHelper.WriteCookie("HelpCenterType", strType, 30);
            //}
            //else
            //{
            //    Tool.CookieHelper.ClearCookie("HelpCenterType");
            //}
        }

        protected void BinderData()
        {
            categroyList = WXHelpService.GetCategoryInfoTop(0, 9);

            hotQueList = WXHelpService.GetDetailInfoTopByCategoryId(20, 0);
        }
    }
}