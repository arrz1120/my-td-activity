using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;
using Kamsoft.Data.Dapper;
using System.Data.SqlClient;

namespace TuanDai.WXApiWeb
{
    public partial class WeiXinIndex : BasePage
    { 

        protected IList<ProjectAdImageInfo> BannerList;   //首页头部广告图  

        protected WeProductDetailInfo FirstWeInfo; //We计划数据
        protected WXProjectListInfo FirstProjectInfo;
        protected List<WXProjectListInfo> NewHandProjectList; //新手标
        protected ProjectBLL projectBll = null;
        protected WebSettingInfo SetModel;
        protected WebSettingInfo SetModel1;
        protected void Page_Load(object sender, EventArgs e)
        {
            //以后两首页全统一成一个页面
            Response.Redirect("/Index.aspx"); 

            //if (!IsPostBack)
            //{
            //    this.IsShowRightBar = GlobalUtils.IsWeiXinBrowser ? false : true;
            //    projectBll = new ProjectBLL();
            //    this.InitData();
            //}
        }

        #region 获取数据
        private void InitData()
        {
            SetModel = new WebSettingBLL().GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
            SetModel1 = new WebSettingBLL().GetWebSettingInfo("06A6344D-E1FB-4AAA-890A-E39351D5E7A3");
            GetBannerList();

            GetWeList();
            GetLatestProject();
            GetNewHandProject();
        }
        #endregion 

        //获取头部广告图
        private void GetBannerList()
        {
            int type = (int)ConstString.AdImageType.WXIndexImage;
            int count = 8;
            BannerList = new AdImageBLL().GetTuanDaiHot(type, count);
        }

        //获取We计划数据
        protected void GetWeList()
        {
            //FirstWeInfo = projectBll.WXGetHomeWeList(1).ToList().FirstOrDefault();
            string sql =
                 @"  SELECT top 1 A.Id AS ProductId, A.ProductName, A.ProductTypeId, A.YearRate, A.StatusId, A.Deadline, A.StartDate, A.EndDate, A.InvestCompleteDate, A.OrderCompleteDate, ISNULL(A.MinYearRate, 0) AS MinYearRate, ISNULL(A.IsWeFQB, 0) AS IsWeFQB,pd.OrderQty,A.UnitAmount,A.PlanAmount,B.TypeWord
                        FROM  dbo.We_Product A WITH (NOLOCK)
                        INNER JOIN dbo.We_ProductType B WITH (NOLOCK) ON A.Id=b.NewProductId
                        INNER JOIN dbo.We_ProductDetail pd WITH(NOLOCK) ON a.Id = pd.ProductId
                        WHERE b.TypeWord IN('Y','C','X','B','A','G')
                        ORDER BY A.StatusId, B.SortOrder asc, A.YearRate desc, A.Deadline, A.StartDate desc";
            var para = new Dapper.DynamicParameters();
            FirstWeInfo = PublicConn.QuerySingle<WeProductDetailInfo>(sql, ref para);
        }

        //获取最近的几个热标
        protected void GetLatestProject()
        {
            ProjectListRequest projectRequest = new ProjectListRequest();
            projectRequest.RequestSource = 1;
            projectRequest.ProjectType = 0;
            projectRequest.PageSize = 1;
            projectRequest.PageIndex = 1;
            int projectItemNum = 0;
            List<WXProjectListInfo> projectList = projectBll.WXGetProjectShowList(projectRequest, out projectItemNum);
            if (projectList.Any())
                FirstProjectInfo = projectList[0];
        }
        
        #region 前台显示格式化函数 

        #region We计划
        protected string GetWePlanYearRate(WeProductDetailInfo item)
        {

            string formatStr = "<p class=\"c-ff881f {1}\">{0}<span class='c-ff881f f18px'>%</span></p>";
            string fontSize = "f60px";
            if (item.ProductName.ToUpper().Contains("计划D") || item.ProductName.ToUpper().Contains("计划E") || item.ProductName.ToUpper().Contains("计划F"))
            {
                fontSize = "f30px";
            }

            string yearRate = "";
            if (item.MinYearRate > 0 && !item.IsWeFQB)
                yearRate = ToolStatus.DeleteZero(item.MinYearRate) + "-";
            yearRate += ToolStatus.DeleteZero(item.YearRate);
            if (item.ProductName.ToUpper().IndexOf("计划D") > -1 || item.ProductName.ToUpper().IndexOf("计划E") > -1)
            {
                yearRate += "+X";
            }
            if (yearRate.IndexOf("+") != -1 || yearRate.IndexOf("-") != -1)
            {
                return string.Format(formatStr, yearRate, fontSize);
            }
            else
            {
                return string.Format(formatStr, ToolStatus.DeleteZero(decimal.Parse(yearRate.Trim())), HasFloatDigt(decimal.Parse(yearRate)) ? "f50px" : "f60px");
            }
        }

        protected string GetWePlanSurplusMoney(WeProductDetailInfo weInfo)
        {
            decimal o = (weInfo.PlanAmount ?? 0) - (weInfo.OrderQty ?? 0) * (weInfo.UnitAmount ?? 0);
            return string.Format("<span class=\"c-212121 f13px\">{0}{1}</span>", (o >= 10000) ? ToolStatus.ConvertWanMoney(o) : ToolStatus.ConvertLowerMoney(o), (o >= 10000) ? "万" : "元");
        }
        #endregion

        #region 优质标区
        protected bool HasFloatDigt(decimal yearRate)
        {
            if (yearRate == 0)
                return false;
            else
            {
                return yearRate % 1 != 0;
            }
        }
        protected string GetProjectYearRate(WXProjectListInfo temp)
        {
            string strFormat = "<p class=\"c-ff881f {1}\">{0}<span class=\"c-ff881f f18px\">%</span></p>";
            if (temp.TypeId == 18 || temp.TypeId == 23)
            {
                if (temp.ProfitTypeId == 1)
                    return string.Format(strFormat, ToolStatus.DeleteZero(temp.PreProfitRate_S) + "~" + ToolStatus.DeleteZero(temp.PreProfitRate_E), "f30px");
                else
                    return string.Format(strFormat, ToolStatus.DeleteZero(temp.PreProfitRate_S), HasFloatDigt(temp.PreProfitRate_S) ? "f50px" : "f60px");
            }
            else
            {
                return string.Format(strFormat, ToolStatus.DeleteZero(temp.YearRate), HasFloatDigt(temp.YearRate ?? 0) ? "f50px" : "f60px");
            }
        }
        protected string GetTypeName(int typeId, int subTypeId)
        {
            switch (typeId)
            {
                case 1:
                    return "商";
                case 3:
                    return "零";
                case 6:
                case 7:
                    return "资";
                case 9:
                    return "车";
                case 10:
                    return "消";
                case 11:
                    return "房";
                case 15:
                    if (subTypeId == 1)
                        return "分";
                    else
                        return "乐";
                case 17:
                    return "配";
                case 18:
                    return "私";
                case 20:
                    return "供";
                case 22:
                case 23:
                    return "项";
                case 24:
                case 25:
                    return "分";
                case 99:
                    return "债";
            }
            return "未知";
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
                    return string.Format(strTemplate, project.Deadline, project.DeadType.Value == 1 ? "个月" : "天");
                }
            }
        }
        #endregion
        #endregion 
         

        #region 获取新手标
        protected void GetNewHandProject()
        {
            NewHandProjectList = new List<WXProjectListInfo>();
            string strSQL = @"SELECT TOP 1 p.Id,p.AddDate,p.Amount,p.CastedShares,p.TotalShares,p.CompleteDate,p.Deadline ,
                                p.FullSuccessDate,p.LowerUnit,p.InterestRate as YearRate,p.[Status],p.RepaymentType,p.[Type] as TypeId,
	                            p.TuandaiRate as NewHandRate,p.PublisherRate,p.DeadType
                                FROM Project p with(nolock)
                                WHERE IsNewHand=1 AND Type in ({0}) AND AddDate>dateadd(day,-15,getdate()) and Status in(2,3,7,6)
                                ORDER BY Status,AddDate desc ";

            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            var gyl = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<WXProjectListInfo>(TdConfig.DBRead, string.Format(strSQL, "19,20"), ref dyParams);
            if (gyl != null)
                NewHandProjectList.Add(gyl);
            var syd = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<WXProjectListInfo>(TdConfig.DBRead, string.Format(strSQL, 1), ref dyParams);
            if (syd != null)
                NewHandProjectList.Add(syd);
        }
        #endregion
    }
}