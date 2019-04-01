using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetDimension.Json;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model; 
using System.Data;
using Dapper;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 普惠类-分期宝详情页
    /// Allen 2016-01-27
    /// </summary>
    public partial class puhui_detail : BasePage
    {
        protected ProjectDetailInfo model = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
        protected Organizations organization = null;
        protected bool IsLogin = false; 
        protected Fq_ItemSetsProjectInfo fq_ItemSetsProjectInfo = null;
        protected string rating = "低";
        protected BorrowUserCreditInfo creditInfo = null;
        protected string finishProcess = "0%";

        protected int SubscribeUserCount = 0;//投资人数 
        protected decimal PreInterestRate = 0; //投资1W的预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益
        protected List<PreSubscribeDetailInfo> preSubscribeList;//预回款信息
         
        protected WebSettingInfo regulaSet = new WebSettingInfo();
        protected int InterestModel = 1;//起息方式

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
            Guid? userId = WebUserAuth.UserId;
            IsLogin = userId != null && userId != Guid.Empty;

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
            if (model == null || !(model.Type == 24) && !(model.Type == 25) && !(model.Type==42))
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }


            string strSQL = @"select b.id,b.ShortName, ProjectDesc,OrgDecription from dbo.fq_ItemSetsProject  a with(nolock)
                                 INNER JOIN dbo.fq_OrganizationExtend b ON a.OrgId=b.OrgId AND b.ProjectType=@ProjectType
                                 WHERE   projectid = @projectid OR CHARINDEX(@projectid,OldProjectID)>0";

            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@projectid", model.Id.ToString());
            dyParams.Add("@ProjectType", model.Type);
            organization = PublicConn.QuerySingle<Organizations>(strSQL, ref dyParams);
            if (organization == null)
                organization = new Organizations();
             

            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", model.Id);
            strSQL = string.Format("SELECT * FROM dbo.fq_ItemSetsProject with(nolock) WHERE ProjectId=@ProjectId OR CHARINDEX('{0}',OldProjectID)>0", model.Id);
            fq_ItemSetsProjectInfo = PublicConn.QuerySingle<Fq_ItemSetsProjectInfo>(strSQL, ref dyParams);

          
            //信用档案
            creditInfo = CommUtils.GetBorrowerCreditData(model.UserId.Value);
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
    }

    public class Organizations
    {
        public Guid OrgId { get; set; }
        public string OrgName { get; set; }
        public string ProjectDesc { get; set; }
        public int OrgTypeId { get; set; }
        public string ShortName { get; set; }
        public string OrgDecription { get; set; }
        public string ProjectRiskDesc { get; set; }
    }
    /// <summary>
    /// 用户扩展表信息(为42类型正好有钱使用)
    /// </summary>
    public class ProjectUserInfoExt
    {
        public string age { get; set; }

        public string sex { get; set; }

        public string mobile { get; set; }

        public string address { get; set; }

        public string job { get; set; }

        public string salary { get; set; }

        public string housingSituation { get; set; }

        public string education { get; set; }

        public string marriage { get; set; }

        public string riskAssessment { get; set; }

        public string fundPurpose { get; set; }

        public string projectIntroduction { get; set; }

        public string repaymentSafeguard { get; set; }

        public string name { get; set; }
    }
}