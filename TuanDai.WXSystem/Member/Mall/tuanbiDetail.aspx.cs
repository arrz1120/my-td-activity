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
    public partial class tuanbiDetail : AppActivityBasePage
    {
        public MUserVipInfo UserVipInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url1 = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url1);
            return;
            string url = "https://mvip.tdw.cn/Member/Mall/tuanbiDetail.aspx";
            Context.Response.Redirect(url);
            return;
            if (WebUserAuth.UserId.HasValue && WebUserAuth.UserId.Value != Guid.Empty)
            {
                this.UserVipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
            }
            else
            {
                Context.Response.Redirect("https://m.tuandai.com/user/Login.aspx?ReturnUrl=" + HttpContext.Current.Request.RawUrl);
            }
        }
    }
}