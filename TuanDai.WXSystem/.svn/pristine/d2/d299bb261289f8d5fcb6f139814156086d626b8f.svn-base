using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using Dapper;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;  
using System.Data;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 供应链电商详情页
    /// Allen 2016-06-28
    /// </summary>
    public partial class gylds_detail : BasePage
    {
        protected Guid? projectId = Guid.Empty; 
        protected ProjectDetailInfo model = null;
        private ProjectBLL bll = null;
        protected string rating = "<span style=\"color:Green;\">低</span>";
        protected UserBasicInfoInfo borrowerUserInfo = null;
        protected string allMonthBadrate = "0";
        protected decimal GylPlusRate = 0; //供应链加息利息
        protected decimal Day15PlusRate = 0;
        protected bool IsShowPlusRate = false;
        protected decimal NewHandRate = 0; //是否新手投资者利率
        protected string EnterpriseName = ""; 
        protected string finishProcess = "0%";

        protected int SubscribeUserCount = 0;//投资人数 
        protected decimal PreInterestRate = 0; //投资1W的预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益
        protected List<PreSubscribeDetailInfo> preSubscribeList;//预回款信息
         
        /// <summary>
        /// 供应链扩展属性
        /// </summary>
        protected Project_GYLInfo ProjectGylInfo;
        //项目展示图
        protected List<ProjectImageInfo> imageList;
        protected BorrowUserCreditInfo creditInfo = null;

        protected decimal limitInvest = 10000;//新手标限制投资金额
        protected string limitInvestStr = string.Empty;
        protected string DanBaoCompany = "东莞市江辉非融资性担保有限公司";
            protected WebSettingInfo regulaSet = new WebSettingInfo();
        protected int InterestModel = 1;//起息方式
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
            if (!IsPostBack)
            {
                GetLimitInvestMoney();
                bll = new ProjectBLL();
                if (this.projectId != Guid.Empty)
                {

                    if (!this.GetData())
                        return;
                    //信用档案
                    creditInfo = CommUtils.GetBorrowerCreditData(model.UserId.Value);
                    imageList = CommUtils.GetProjectImages(this.projectId.Value);
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                }
            }
        }
        /// <summary>
        /// 获取新手标限制金额
        /// </summary>
        private void GetLimitInvestMoney()
        {
            string sql = "SELECT Param1Value FROM WebSetting with(nolock) where id='FC5BAE60-716E-4344-9C10-F1E808064FC7'";
            var para = new Dapper.DynamicParameters();
            limitInvest = PublicConn.QuerySingle<decimal>(sql, ref para);

            if (limitInvest >= 10000)
            {
                limitInvestStr = ToolStatus.DeleteZero(Math.Floor(limitInvest / 10000)) + "万";
            }
            else if (limitInvest >= 1000 && limitInvest < 10000)
            {
                limitInvestStr = ToolStatus.DeleteZero(Math.Floor(limitInvest / 1000)) + "千";
            }
            else
            {
                limitInvestStr = Math.Floor(limitInvest).ToString();
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
            if (model.Type.Value != 19) {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }

            WebSettingInfo  gylSet = new WebSettingBLL().GetWebSettingInfo("75F593E2-40FF-4777-A6F8-4ED54D39FF70");
            if (gylSet.Param2Value.IsEmpty())
                gylSet.Param2Value = "2017-02-10";
            if (model.AddDate >= DateTime.Parse(gylSet.Param2Value))
            {
                DanBaoCompany = "东莞市志诚非融资性担保有限公司";
            }

            switch (model.Rating)
            {
                case 1:
                    rating = "<span style=\"color:Green;\">低</span>";
                    break;
                case 2:
                    rating = "<span style=\"color:Orange;\">中</span>";
                    break;
                case 3:
                    rating = "<span style=\"color:Red;\">高</span>";
                    break;
            }
            GetBorrowUserInfo();

            WebSettingBLL setbll = new WebSettingBLL();
            //新手加息判断
            WebSettingInfo GylSetInfo = setbll.GetWebSettingInfo("5AC96A83-B678-4191-BADB-C39C02DFEBB5");
            if (GylSetInfo != null)
            {
                GylPlusRate = Tool.StrObj.StrToDecimalDef(GylSetInfo.Param3Value, 0);
                Day15PlusRate = Tool.StrObj.StrToDecimalDef(GylSetInfo.Param4Value, 0);
            }
            if (this.model.DeadType.Value == 2 && (this.model.Deadline == 7 && GylPlusRate > 0) || (this.model.Deadline == 15 && Day15PlusRate > 0))
                IsShowPlusRate = true;

            
                DynamicParameters dyParams;
                string sql = "";
                if (WebUserAuth.IsAuthenticated && IsShowPlusRate)
                {
                    //判断是否投资新手
                    sql = "select count(1) from Subscribe with(Nolock) where SubscribeUserId=@userid";
                    dyParams = new DynamicParameters();
                    dyParams.Add("@userid", WebUserAuth.UserId.Value);

                    bool IsNewHand = PublicConn.QuerySingle<int>(sql,ref dyParams)==0;
                    NewHandRate = IsNewHand ? (this.model.Deadline == 7 ? GylPlusRate : Day15PlusRate) : 0;
                }

                dyParams = new DynamicParameters();
                dyParams.Add("@projectid", projectId);
                sql = @"select  ProjectID,ProjectDesc2,CreditStatus,EnterpriseCredit,OperatingConditions,RoyalRiskAbility from dbo.Project_GYL with(nolock) where ProjectID=@projectid";
                ProjectGylInfo = PublicConn.QuerySingle<Project_GYLInfo>(sql, ref dyParams);
                
             
            finishProcess = CommUtils.GetProjectProcess(model);

            SubscribeUserCount = CommUtils.GetSubscribeUserCount(this.projectId.Value);
            //计算预期收益
            PreInterestRate = CommUtils.CalcInvestInterest(model, 10000);
            EbaoMultiple = int.Parse(Math.Ceiling(model.InterestRate.Value / decimal.Parse("2.5")).ToString());
            EbaoInterest = CommUtils.GetEbaoMultipleInterest(model, 10000);
            preSubscribeList = CommUtils.GetPreSubscribeDetail(model, 10000);

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
            return true;
        } 

        //获取借款人信息
        protected void GetBorrowUserInfo()
        {
            UserBLL userbll = new UserBLL();
            this.borrowerUserInfo = userbll.GetUserBasicInfoModelById(model.UserId.Value);

            //借款次数统计
            allMonthBadrate = calcrate(model.TotalSumShares ?? 0, model.badShares ?? 0);
        }

      
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