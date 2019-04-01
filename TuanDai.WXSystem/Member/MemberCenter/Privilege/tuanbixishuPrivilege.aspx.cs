﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.MemberCenter.Privilege
{
    public partial class tuanbixishuPrivilege : UserPage
    {
        public MUserVipInfo vipInfo = null;//会员信息
        public decimal tuanbiRatio = 1;//团币系数
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            if (!IsPostBack && WebUserAuth.UserId.Value != null && WebUserAuth.UserId.Value != Guid.Empty)
            {
                vipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
                if (vipInfo.Level == 1)
                {
                    tuanbiRatio = 1;
                }
                else if (vipInfo.Level == 2)
                {
                    tuanbiRatio =(decimal)1.05;
                }
                else if (vipInfo.Level == 3)
                {
                    tuanbiRatio = (decimal)1.10;
                }
                else if (vipInfo.Level == 4)
                {
                    tuanbiRatio = (decimal)1.15;
                }
                else if (vipInfo.Level == 5)
                {
                    tuanbiRatio = (decimal)1.20;
                }
                else if (vipInfo.Level == 6)
                {
                    tuanbiRatio = (decimal)1.25;
                }
                else if (vipInfo.Level == 7)
                {
                    tuanbiRatio = (decimal)1.30;
                }
                else 
                {
                    tuanbiRatio = (decimal)1.35;
                }
            }
        }
    }
}