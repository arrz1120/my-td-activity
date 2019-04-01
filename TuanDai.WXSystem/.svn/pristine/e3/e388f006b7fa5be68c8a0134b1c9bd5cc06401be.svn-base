using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class invest_baot : BasePage
    {
        protected List<WXProjectListInfo> projectList = new List<WXProjectListInfo>();
          protected ProjectBLL   projectBll = new ProjectBLL();
          protected int projectItemNum = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            if (!IsPostBack)
            {
                ProjectListRequest projectRequest = new ProjectListRequest();
                projectRequest.RequestSource = 1;
                projectRequest.ProjectType = 0;
                projectRequest.PageSize = 3;
                projectRequest.PageIndex = 1;
                projectList = projectBll.WXGetProjectShowList(projectRequest, out projectItemNum);
                
            }
        }

        protected string GetYearRate(WXProjectListInfo temp)
        {
            if (temp.TypeId == 18 || temp.TypeId == 23)
            {
                return string.Format("{0}", temp.ProfitTypeId == 1 ? ToolStatus.DeleteZero(temp.PreProfitRate_S) + "~" + ToolStatus.DeleteZero(temp.PreProfitRate_E) : ToolStatus.DeleteZero(temp.PreProfitRate_S));
            }
            else
            {
                return ToolStatus.DeleteZero(temp.YearRate ?? 0);
            }
        }

        protected string GetProjectSurplusMoney(WXProjectListInfo project)
        {
            decimal num = ((project.TotalShares ?? 0) - (project.CastedShares ?? 0)) * project.LowerUnit;
            return string.Format("<span class=\"c-212121 f13px\">{0}{1}</span>", (num >= 10000) ? ToolStatus.ConvertWanMoney(num) : ToolStatus.ConvertLowerMoney(num), (num >= 10000) ? "万" : "元");
        }

        protected string GetProjectShowDeadline(WXProjectListInfo project)
        {
            string strTemplate = "<span class=\"c-212121 f13px\">{0}{1}</span>";
            if (project.TypeId == 17 || (project.TypeId == 6 && project.DeadType == 2) || project.TypeId == 99)
            {
                return string.Format(strTemplate, project.Deadline, "天");
            }
            else
            {
                if (project.TypeId == 23)
                {
                    return string.Format(strTemplate, project.MinDeadLine + "-" + project.MaxDeadLine, "个月");
                }
                else
                {
                    return string.Format(strTemplate, project.Deadline, project.DeadType.Value==1?"个月":"天");
                }
            }
        }
    }
}