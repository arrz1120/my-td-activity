using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 补充保证金
    /// Allen 2015-07-01
    /// </summary>
    public partial class deposit : UserPage
    {
        protected WXMyLoanDetailInfo model = null;
        protected Guid projectId { get; set; }
        protected ProjectBLL bll = null;

        protected void Page_Load(object sender, EventArgs e)
        {
             this.projectId = WEBRequest.GetGuid("id");
            if (!IsPostBack)
            {
                bll = new ProjectBLL();
                if (this.projectId != Guid.Empty)
                {
                    if (!this.GetData())
                    {
                        return;
                    }
                }
                else
                {
                    Response.Redirect(GlobalUtils.MTuanDaiURL + "/Member/Repayment/borrowLog.aspx");
                }
            } 
        }

        private bool GetData()
        {
            Guid userId = WebUserAuth.UserId.Value;
            UserBLL userbll = new UserBLL();
            //获取项目信息
            model = bll.WXGetMyLoanDetail(this.projectId, userId);
            if (model == null)
            {
                Response.Redirect(GlobalUtils.MTuanDaiURL + "/Member/Repayment/borrowLog.aspx");
                return false;
            }
            return true;
        }
    }
}