using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 项目宝--项目进展
    /// Allen 2015-11-16
    /// </summary>
    public partial class xmb_progress : BasePage
    {
        protected Guid projectId;

        protected List<ProjectProgress_Info> xmbProgress;
        protected List<ProjectProgressImage_Info> xmbProgressImg;

        protected void Page_Load(object sender, EventArgs e)
        {
            projectId = WEBRequest.GetGuid("projectid");
            if (!IsPostBack)
            {
                if (this.projectId != Guid.Empty)
                {
                    this.GetData();
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                }
            }
        }

        protected void GetData()
        {
            ProjectXMBBLL xbmbll = new ProjectXMBBLL();
            xmbProgress = xbmbll.GetXMBProjectProcess(projectId);
            xmbProgressImg = xbmbll.GetXMBProjectProcessImage(projectId);
        }

    }
}