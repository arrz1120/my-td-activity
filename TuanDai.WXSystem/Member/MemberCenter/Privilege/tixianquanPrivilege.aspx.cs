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
    public partial class tixianquanPrivilege : UserPage
    {
        public MUserVipInfo vipInfo = null;//会员信息
        public string privilegeDesc;//特权描述
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
                    privilegeDesc = "未获得特权";
                }
                else if (vipInfo.Level == 2)
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>3元</span>";
                }
                else if (vipInfo.Level == 3)
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>5元</span>";
                }
                else if (vipInfo.Level == 4)
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>8元</span>";
                }
                else if (vipInfo.Level == 5)
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>13元</span>";
                }
                else if (vipInfo.Level == 6)
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>20元</span>";
                }
                else if (vipInfo.Level == 7)
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>30元</span>";
                }
                else
                {
                    privilegeDesc = "每月可获提现券<span class='c-212121 f17px ml5'>60元</span>";
                }
            }
        }
    }
}