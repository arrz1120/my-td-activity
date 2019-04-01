using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core;
using Tool;
using Dapper;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 微团贷详情界面
    /// Allen 2015-05-18
    /// </summary>
    public partial class mini_detail : BasePage
    {
        protected ProjectDetailInfo model = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
        protected UserBasicInfoInfo borrowUserInfo = null;
        protected UserBasicInfoExtInfo borrowerUserInfoExt;
        protected WXUserCreditInfo userCreditInfo = null; 
 
        protected string rating = "<span style=\"color:Green;\">低</span>";  
        protected BorrowUserCreditInfo creditInfo = null;
        protected List<ProjectImageInfo> imageList;
        protected string finishProcess = "0%";

        protected int SubscribeUserCount = 0;//投资人数 
        protected decimal PreInterestRate = 0; //投资1W的预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益
        protected List<PreSubscribeDetailInfo> preSubscribeList;//预回款信息

        protected UserCarDetailInfoInfo mUserCarDetailInfoInfo;
        protected UserHouseDetailInfoInfo mUserHouseDetailInfoInfo;
        protected WebSettingInfo regulaSet = new WebSettingInfo();
        protected int InterestModel = 1;//起息方式
        protected Project_xdInfo projectXDInfo = null;
        protected string allMonthBadrate = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
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
                    Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                }
            }
        }

        protected bool GetData()
        {
            UserBLL userbll = new UserBLL();
            //获取项目信息
            model = bll.GetProjectDetailInfo(projectId.Value);
            if (model == null)
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }
            borrowUserInfo = userbll.GetUserBasicInfoModelById(model.UserId.Value);
            borrowerUserInfoExt = userbll.GetUserBasicInfoExtInfo(model.UserId.Value); 
           
            //信用档案
            creditInfo = CommUtils.GetBorrowerCreditData(model.UserId.Value);
            imageList = CommUtils.GetProjectImages(this.projectId.Value);
            finishProcess = CommUtils.GetProjectProcess(model);

            this.GetUserDetailInfo();
            //风险等级
            switch (model.Rating)
            {
                case 1:
                    this.rating = "<span style=\"color:Green;\">低</span>";
                    break;
                case 2:
                    this.rating = "<span style=\"color:Orange;\">中</span>";
                    break;
                case 3:
                    this.rating = "<span style=\"color:Red;\">高</span>";
                    break;
            }

            SubscribeUserCount = CommUtils.GetSubscribeUserCount(this.projectId.Value);
            //计算预期收益
            PreInterestRate = CommUtils.CalcInvestInterest(model, 10000);
            EbaoMultiple = int.Parse(Math.Ceiling(model.InterestRate.Value / decimal.Parse("2.5")).ToString());
            EbaoInterest = CommUtils.GetEbaoMultipleInterest(model, 10000);
            preSubscribeList = CommUtils.GetPreSubscribeDetail(model, 10000);
            allMonthBadrate = calcrate(model.TotalSumShares ?? 0, model.badShares ?? 0);

            regulaSet = new WebSettingBLL().GetWebSettingInfo("293A1C07-1D90-4D22-ADD4-39E6735DAC06");
            InterestModel = TuanDai.PortalSystem.Redis.ProjectRedis.GetProjectInterestMode(model.Type.Value, model.RepaymentType.Value);
            //截标时间为NULL时候取审核时间  +5 天
            if (model.TenderDate == null)
            {
                model.TenderDate = Convert.ToDateTime(model.AuditDate == null ? model.AddDate : model.AuditDate).AddDays(5);
            }
            else
            {
                model.TenderDate = model.TenderDate;
            }

            if (model.AuditDate == null)
            {
                model.TenderStartDate = model.AddDate;
            }
            else
            {
                model.TenderStartDate = model.AuditDate;
            }
            string sql = "select RiskAssessment,FundUse,RepaymentAssure from project_xd with(nolock) where ProjectId=@ProjectId";
            Dapper.DynamicParameters Parprojectxd = new Dapper.DynamicParameters();
            Parprojectxd.Add("@ProjectId", projectId);
            projectXDInfo = PublicConn.QuerySingle<Project_xdInfo>(sql, ref Parprojectxd);
            if (projectXDInfo == null)
                projectXDInfo = new Project_xdInfo();
            return true;
        }      
      
         
        //用户详细信息
        private void GetUserDetailInfo() {             
           // this.UserDetail = new UserBLL().GetUserDetailInfoByProjectId(this.model.Id, this.model.UserId.ToString());   
            userDetailInfoInfo UserDetail = null;
            if (model.Type == 9 || model.Type == 26 || model.Type==40)//车贷
            {
                string strSQL = @"SELECT Id,ProjectID,CarBrand,CarOrigin,CarType,ISNULL(CarPrice,0) AS CarPrice,CarKM,CarIsBigRepair,CarPlace,AddDate,CarDisplacement 
                                FROM dbo.UserCarDetailInfo WITH(NOLOCK) WHERE ProjectID=@ProjectId";
                Dapper.DynamicParameters par = new Dapper.DynamicParameters();
                par.Add("@ProjectId", projectId);

                mUserCarDetailInfoInfo = PublicConn.QuerySingle<UserCarDetailInfoInfo>(strSQL, ref par);
                if (mUserCarDetailInfoInfo == null)
                {
                    mUserCarDetailInfoInfo = new UserCarDetailInfoInfo();
                    UserDetail = new UserBLL().GetUserDetailInfoByProjectId(projectId.Value, model.UserId.Value.ToString());
                    mUserCarDetailInfoInfo.CarBrand = UserDetail.CarBrand;
                    mUserCarDetailInfoInfo.CarIsBigRepair = UserDetail.CarIsBigRepair.HasValue ? UserDetail.CarIsBigRepair.Value : false;
                    mUserCarDetailInfoInfo.CarKM = UserDetail.CarKM.HasValue ? UserDetail.CarKM.Value : 0;
                    mUserCarDetailInfoInfo.CarOrigin = UserDetail.CarOrigin;
                    mUserCarDetailInfoInfo.CarPlace = UserDetail.CarOrigin;
                    mUserCarDetailInfoInfo.CarPrice = UserDetail.CarPrice.HasValue ? UserDetail.CarPrice.Value : 0;
                    mUserCarDetailInfoInfo.CarType = UserDetail.CarType;
                }
            }
            else
            {//房贷 
                string strSQL = @"SELECT  Id,ProjectID,HouseBuyDate,ISNULL(HouseArea,0) AS HouseArea,ISNULL(HousePrice,0) AS HousePrice,ISNULL(HouseYears,0)AS HouseYears,ISNULL(IsHouseRenovation,0) AS IsHouseRenovation,ISNULL(IsHouseLoan,0) AS IsHouseLoan
                                  ,ISNULL(HouseLoanAmount,0) AS HouseLoanAmount,ISNULL(HouseLoanYears,0) AS HouseLoanYears,AddDate FROM dbo.UserHouseDetailInfo WITH(NOLOCK) WHERE ProjectID=@ProjectId";
                Dapper.DynamicParameters par = new Dapper.DynamicParameters();
                par.Add("@ProjectId", projectId);

                mUserHouseDetailInfoInfo = PublicConn.QuerySingle<UserHouseDetailInfoInfo>(strSQL, ref par);
                if (mUserHouseDetailInfoInfo == null)
                {
                    mUserHouseDetailInfoInfo = new UserHouseDetailInfoInfo();
                    UserDetail = new UserBLL().GetUserDetailInfoByProjectId(projectId.Value, model.UserId.Value.ToString());

                    mUserHouseDetailInfoInfo.HouseBuyDate = UserDetail.HouseBuyDate.Value;
                    mUserHouseDetailInfoInfo.HouseArea = UserDetail.HouseArea.HasValue ? UserDetail.HouseArea.Value : 0;
                    mUserHouseDetailInfoInfo.HousePrice = UserDetail.HousePrice.HasValue ? UserDetail.HouseArea.Value : 0;
                    mUserHouseDetailInfoInfo.HouseYears = UserDetail.HouseYears.HasValue ? UserDetail.HouseYears.Value : 0;
                    mUserHouseDetailInfoInfo.IsHouseRenovation = UserDetail.IsHouseRenovation.HasValue ? UserDetail.IsHouseRenovation.Value : false;
                    mUserHouseDetailInfoInfo.IsHouseLoan = UserDetail.IsHouseLoan.HasValue ? UserDetail.IsHouseLoan.Value : false;
                    mUserHouseDetailInfoInfo.HouseLoanAmount = UserDetail.HouseLoanAmount.HasValue ? UserDetail.HouseArea.Value : 0;
                    mUserHouseDetailInfoInfo.HouseLoanYears = UserDetail.HouseLoanYears.HasValue ? UserDetail.HouseLoanYears.Value : 0;
                }
            }
        }
       

        #region 前端显示 
        /// <summary>
        /// 计算逾期还款率
        /// </summary>
        /// <param name="successcount">成功记录数</param>
        /// <param name="badcount">逾期记录数</param>
        /// <returns></returns>
        private string calcrate(int successcount, int badcount)
        {
            if (successcount != 0)
            {
                return ((double)(badcount) / (double)(successcount) * 100).ToString("0.00");
            }
            else
            {
                return "0";
            }
        }
        #endregion
    }
}