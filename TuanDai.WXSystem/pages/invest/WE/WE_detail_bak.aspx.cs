using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest.WE
{
    /// <summary>
    /// WE计划详情界面
    /// Allen 2015-05-21
    /// </summary>
    public partial class WE_detail_bak :BasePage
    {
        protected Guid? projectId { get; set; }
        private WeProductBLL bll = null;
        protected WeProductDetailInfo model = null;
        protected string ReChangeStr = "<a href=\"/Member/Bank/Recharge.aspx\" class=\"btn-chargemoney\">充值</a>";

        protected void Page_Load(object sender, EventArgs e)
        {
            projectId = Tool.SafeConvert.ToGuid(WEBRequest.GetQueryString("id"));
            if (!IsPostBack)
            {

                bll = new WeProductBLL();
                if (this.projectId != Guid.Empty)
                {
                    if (!this.GetData())
                    {
                        return;
                    }
                    //未登陆时,充值处显示登陆按钮
                    if(!WebUserAuth.IsAuthenticated){
                        ReChangeStr = "<a href=\"javascript:window.location.href='/user/login.aspx?ReturnUrl='+location.href\" class=\"btn-chargemoney\">登录</a>";
                    }
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/pages/invest/WE/WE_list.aspx");
                }
            }
        }

        private bool GetData() {
           model=bll.GetWeProductInfo(projectId.Value);
           if (model == null)
               return false;

            return true;
        }
    }
}