using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;


namespace TuanDai.WXApiWeb.pages.App
{
    public partial class Xmb_detail : System.Web.UI.Page
    {
        protected PageModel mPageModel = new PageModel();
        /// <summary>
        /// 获取传来的项目ID
        /// </summary>
        public Guid ProjectId
        {
            get
            {
                Guid pId = Guid.Empty;
                Guid.TryParse(Tool.WEBRequest.GetString("id"), out pId);
                return pId;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ProjectId == Guid.Empty)
                {
                    Response.Write("未找到对应的项目！");
                    Response.End();
                }
                BindProjectImg();
                BindProjectXMB();
                BindProjectProgress();
            }
        }

        /// <summary>
        /// 资料图片
        /// </summary>
        private void BindProjectImg()
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@ProjectId", ProjectId);

            string strProject = @"SELECT ImageSource AS LargeImg,
                                  REPLACE(ImageSource,(SUBSTRING (ImageSource, 1, LEN(ImageSource)-CHARINDEX('.', REVERSE(ImageSource)))),SUBSTRING (ImageSource, 1, LEN(ImageSource)-CHARINDEX('.', REVERSE(ImageSource)))+'_s') AS SmallImg,Name FROM dbo.ProjectImage WHERE ProjectId=@ProjectId AND Type=1 ORDER BY AddDate DESC";

            mPageModel.listProjectImage = PublicConn.QueryBySql<ProjectImage_Info>(strProject, ref param);
        }
        /// <summary>
        /// 绑定项目类型
        /// </summary>
        private void BindProjectXMB()
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@ProjectId", ProjectId);
            string strXMB = @"SELECT ProjectId,MinDeadLine,MaxDeadLine,MinInterestRate,MaxInterestRate,Type
                              ,ISNULL(AmountUsedDesc,'') AS AmountUsedDesc,ISNULL(ProjectDescription,'') AS ProjectDescription
                              ,ISNULL(ProjectProspect,'') AS ProjectProspect,ISNULL(ProfitBudget,'') AS ProfitBudget,
                               ISNULL(RepaymentSecurity,'') AS RepaymentSecurity,ISNULL(InvestRange, '') AS InvestRange,
                               ISNULL(InvestHighlight, '') AS InvestHighlight,ISNULL(ProfitBudget, '') AS ProfitBudget,
                               ISNULL(RepaymentSecurity, '') AS RepaymentSecurity,ISNULL(DepositOrgDesc, '') AS DepositOrgDesc,
                               ISNULL(DepositTeam, '') AS DepositTeam  FROM  Project_XMB  WHERE  ProjectId=@ProjectId";

            mPageModel.mProject_XMB = PublicConn.QuerySingle<Project_XMB_Info>(strXMB, ref param);
        }
        /// <summary>
        /// 绑定项目进度
        /// </summary>
        private void BindProjectProgress()
        {
            List<ProjectProgress_Info> listProjectProgress_Info = new List<ProjectProgress_Info>();
            List<ProjectProgressImage_Info> listProjectProgressImage_Info = new List<ProjectProgressImage_Info>();
            DynamicParameters param = new DynamicParameters();
            param.Add("@ProjectId", ProjectId);
            string strProgress = @"SELECT Id,ISNULL([Desc],'') AS [DESC],ProgressDate FROM dbo.ProjectProgress WHERE ProjectId=@ProjectId  ORDER BY ProgressDate DESC";
            string strstrProgressImage = "SELECT ProgressId,ISNULL(MinImageUrl,'') AS MinImageUrl,ISNULL(MaxImageUrl,'') AS MaxImageUrl,SortOrder FROM dbo.ProjectProgressImage WHERE ProjectId=@ProjectId  ORDER BY SortOrder ASC,AddDate ASC";

            listProjectProgress_Info = PublicConn.QueryBySql<ProjectProgress_Info>(strProgress, ref param);
            listProjectProgressImage_Info = PublicConn.QueryBySql<ProjectProgressImage_Info>(strstrProgressImage, ref param);

            List<ProjectProgress> listProjectProgress = new List<ProjectProgress>();
            foreach (var itemA in listProjectProgress_Info)
            {
                ProjectProgress mProjectProgress = new ProjectProgress();
                mProjectProgress.ProgressDate = itemA.ProgressDate;
                mProjectProgress.Desc = itemA.Desc;
                mProjectProgress.listProjectProgressImage = listProjectProgressImage_Info.Where(p => p.ProgressId == itemA.Id).ToList();
                listProjectProgress.Add(mProjectProgress);
            }
            mPageModel.listProjectProgress = listProjectProgress;
        }
    }
    /// <summary>
    /// 返回页面的实体
    /// </summary>
    public class PageModel
    {
        /// <summary>
        /// 资料图片
        /// </summary>
        public List<ProjectImage_Info> listProjectImage { get; set; }
        /// <summary>
        /// 项目信息
        /// </summary>
        public Project_XMB_Info mProject_XMB { get; set; }
        /// <summary>
        /// 项目进度展示
        /// </summary>
        public List<ProjectProgress> listProjectProgress { get; set; }
    }
    /// <summary>
    /// 标信息
    /// </summary>
    public class ProjectModel
    {
        public int? CastedShares { get; set; }
        public int Status { get; set; }

        public decimal? LowerUnit { get; set; }

    }

    /// <summary>
    /// 资料展示
    /// </summary>
    public class ProjectImage_Info
    {
        /// <summary>
        /// 大图
        /// </summary>
        public string LargeImg { get; set; }
        /// <summary>
        /// 小图
        /// </summary>
        public string SmallImg { get; set; }
        /// <summary>
        /// 图片名称
        /// </summary>
        public string Name { get; set; }
    }

    /// <summary>
    /// 项目进度展示
    /// </summary>
    public class ProjectProgress
    {
        /// <summary>
        /// 说明
        /// </summary>
        public string Desc { get; set; }
        /// <summary>
        /// 进展时间
        /// </summary>
        public DateTime ProgressDate { get; set; }
        public List<ProjectProgressImage_Info> listProjectProgressImage { get; set; }
    }
}