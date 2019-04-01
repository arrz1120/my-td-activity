using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.MemberCenter.Privilege
{
    public partial class birthdayPrivilege : UserPage
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
                    privilegeDesc = "未获得特权";
                }
                else if (vipInfo.Level == 3)
                {
                    privilegeDesc = "我的生日红包 <span class='c-212121 f17px ml5'>18元</span>";
                }
                else if (vipInfo.Level == 4)
                {
                    privilegeDesc = "我的生日红包 <span class='c-212121 f17px ml5'>28元</span>";
                }
                else if (vipInfo.Level == 5)
                {
                    privilegeDesc = "我的生日红包 <span class='c-212121 f17px ml5'>48元</span>";
                }
                else if (vipInfo.Level == 6)
                {
                    privilegeDesc = "我的生日红包 <span class='c-212121 f17px ml5'>68元</span>";
                }
                else if (vipInfo.Level == 7)
                {
                    privilegeDesc = "我的生日红包 <span class='c-212121 f17px ml5'>98元</span>";
                }
                else
                {
                    privilegeDesc = "我的生日红包 <span class='c-212121 f17px ml5'>128元</span>";
                }
            }
        }
    }
}