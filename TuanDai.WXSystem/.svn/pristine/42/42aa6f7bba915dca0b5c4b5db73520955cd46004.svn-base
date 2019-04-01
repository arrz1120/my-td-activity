using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class productList : AppActivityBasePage
    {
        public string type = string.Empty;//地址带过来的类型
        public string inter = string.Empty;
        protected int validTuanBi = 0;
        protected bool isLogin = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            type = Tool.WEBRequest.GetQueryString("producttype");
            inter = Tool.WEBRequest.GetQueryString("inter");

            if (WebUserAuth.UserId.Value != null && WebUserAuth.UserId.Value != Guid.Empty)
            {
                isLogin = true;
                MUserVipInfo vipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
                if (vipInfo != null)
                    validTuanBi = vipInfo.ValidTuanBi;
            }
        }    
    }
}