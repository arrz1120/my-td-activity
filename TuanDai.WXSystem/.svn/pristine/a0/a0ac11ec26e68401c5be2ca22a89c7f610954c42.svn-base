using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Dapper;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class xmb_detail : BasePage
    {
        /// <summary>
        /// 项目明细信息
        /// </summary>
        protected ProjectDetailInfo model = null;
        /// <summary>
        /// 项目宝扩展表信息
        /// </summary>
        protected Project_XMB_Info xmbModel = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
        /// <summary>
        /// 申购人数
        /// </summary>
        protected int SubscribeUserCount = 0;
        /// <summary>
        /// 担保机构名
        /// </summary>
        protected string EnterpriseName = "";
        /// <summary>
        /// 借款方信用档案
        /// </summary>
        protected WXUserCreditInfo userCreditInfo = null;
        /// <summary>
        /// 用户基本信息
        /// </summary>
        protected UserBasicInfoInfo borrowerUserInfo = null;
        /// <summary>
        /// 逾期还款率
        /// </summary>
        protected string allMonthBadrate = "0";
        /// <summary>
        /// 浮动利率对照信息
        /// </summary>
        protected List<ProjectRateContrastInfo> rateRangeList;
        protected bool IsSMBGuQuan = false; //是否私募股权标

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
                        return;
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

            ProjectXMBBLL xbmbll = new ProjectXMBBLL();
            if (this.model.Type == 23)
            {
                rateRangeList = xbmbll.GetXMBRateContrastInfo(projectId.Value);
            }

            this.SubscribeUserCount = TuanDai.WXApiWeb.Common.WXInvest.WXGetSubscribeUserCount(this.projectId.Value);
            borrowerUserInfo = userbll.GetUserBasicInfoModelById(model.UserId.Value);

            #region 获取担保公司 
            UserEnterpriseInfo userEnterprise = GetBorrowerGuaranteeEnterprise(this.model.UserId.Value, model.AddDate.Value);
            if (userEnterprise != null)
            {
                string sql = "select NickName from UserBasicInfo with(nolock) where id=@enterpriseuserid"; 
                DynamicParameters args = new DynamicParameters();
                args.Add("@enterpriseuserid", userEnterprise.UserId);
                this.EnterpriseName =PublicConn.QuerySingle<string>(sql, ref args);
            }
            else
            {
                if (model.Guarantors != null && model.Guarantors != "")
                {
                    this.EnterpriseName = BusinessDll.business.GetAssureNameById(int.Parse(model.Guarantors.ToString()));
                }
            }
            #endregion

            ProjectBLL projbll = new ProjectBLL();
            xmbModel = projbll.GetProjectXMBInfo(projectId.Value);
            if (xmbModel == null)
            {
                xmbModel = new Project_XMB_Info();
            }
            allMonthBadrate = calcrate(model.TotalSumShares ?? 0, model.badShares ?? 0);
            IsSMBGuQuan = xmbModel.Type == 1;

            //modify by shellben 2015-12-29 处理元旦活动加息，以下是规则
            //2015-12-29 00:00至2016-1-25 24:00期间加息标的仅含“小微企业”“微团贷”“项目宝B”
            //加息幅度根据期限适配：
            //1-5个月：+1%
            //6-11个月：+1.5%
            //12个月及以上：+2%
            if (DateTime.Now >= DateTime.Parse("2015/12/29 00:00:00") &&
                DateTime.Now < DateTime.Parse("2016/1/26 00:00:00"))
            {
                if (new int[] { 1, 3, 9, 10, 11, 22 }.Contains(model.Type ?? 0) && (model.TuandaiRate ?? 0) <= 0)
                {
                    if (model.Deadline <= 5)
                        model.TuandaiRate = 1;
                    else if (model.Deadline >= 12)
                        model.TuandaiRate = 2;
                    else
                        model.TuandaiRate = 1.5;
                }

            }

            return true;
        }

        #region 获取项目发标人的担保公司

        public static UserEnterpriseInfo GetBorrowerGuaranteeEnterprise(Guid borrowerUserId, DateTime AddDate)
        {

            string strSQL = "select * from UserInEnterprise where BorrowerUserId=@borrowerUserId";
            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@borrowerUserId", borrowerUserId);

            List<UserInEnterpriseInfo> UserInEnterpriseList = PublicConn.QueryBySql<UserInEnterpriseInfo>(strSQL, ref dyParams); 
            UserInEnterpriseInfo userInEnterprise;
            if (UserInEnterpriseList.Count() > 1)
            {
                userInEnterprise = UserInEnterpriseList.Where(p => p.CreateDate < AddDate).OrderByDescending(p => p.CreateDate).FirstOrDefault();
            }
            else
            {
                userInEnterprise = UserInEnterpriseList.FirstOrDefault();
            }
            if (userInEnterprise != null)
            {
                Guid EnterpriseUserId = userInEnterprise.EnterpriseUserId;
                strSQL = "select * from UserEnterprise where UserId=@userId";
                dyParams = new DynamicParameters();
                dyParams.Add("@userId", EnterpriseUserId);
                UserEnterpriseInfo userenter = PublicConn.QuerySingle<UserEnterpriseInfo>(strSQL, ref dyParams);
                return userenter;
            }
            else
            {
                return null;
            }
        }

        //获取用户信用档案
        private void GetBorrowerData()
        {
            userCreditInfo = bll.WXGetUserCreditInfo(model.UserId.Value);

            //特殊处理
            Guid tempBorrowUserId = Guid.Parse("73810E55-E2D4-4F40-8FF9-F0A23F909A75");
            if (borrowerUserInfo.Id == tempBorrowUserId)
            {
                Guid tempProjectId = Guid.Parse("EA7A69C1-38B4-4073-A69D-CFBE2944B4E3");
                ProjectDetailInfo tempProjectModel = bll.GetProjectDetailInfo(tempProjectId);
                userCreditInfo.DueOutPAndI = userCreditInfo.DueOutPAndI - ((tempProjectModel.TotalAmount ?? 0) + (tempProjectModel.TotalInterest ?? 0) - (tempProjectModel.RefundInterest ?? 0) - (tempProjectModel.RefundCaptital ?? 0));

                //LogHelper.WriteLog("待还本息特殊处理", "", tempProjectModel.TotalAmount.Value.ToString());
                BusinessDll.NetLog.WriteTraceLogHandler("待还本息特殊处理", tempProjectModel.TotalAmount.Value.ToString(), "触屏版");
            }
        }
        #endregion

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
    }
}