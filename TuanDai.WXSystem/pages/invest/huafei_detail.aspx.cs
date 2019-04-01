using Dapper;
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
    public partial class huafei_detail :BasePage
    {
        protected ProjectDetailInfo model = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
        protected Organizations organization = null;
        protected bool IsLogin = false;
        protected UserBasicInfoInfo borrowUserInfo = null;
        protected Fq_ItemSetsProjectInfo fq_ItemSetsProjectInfo = null;
        protected string rating = "低";
        protected BorrowUserCreditInfo creditInfo = null;
        protected string finishProcess = "0%";

        protected int SubscribeUserCount = 0;//投资人数 
        protected decimal PreInterestRate = 0; //投资1W的预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益
        protected List<PreSubscribeDetailInfo> preSubscribeList;//预回款信息

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
            if (model == null || (model.Type != 27))
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }

            string strSQL = @"select b.OrgId,b.ShortName, ProjectDesc,OrgDecription,ProjectDescription,ProjectRiskDesc from dbo.fq_ItemSetsProject  a with(nolock)
                            INNER JOIN dbo.fq_Organization b ON a.OrgId=b.OrgId
                            WHERE   projectid = @projectid OR CHARINDEX(@projectid,OldProjectID)>0";

            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@projectid", model.Id.ToString());
            organization = PublicConn.QuerySingle<Organizations>(strSQL, ref dyParams);
            if (organization == null)
            {
                organization = new Organizations();
                organization.ShortName = "快来贷";
            }

            dyParams = new DynamicParameters();
            dyParams.Add("@userid", model.UserId);
            strSQL = "select * from UserBasicInfo with(nolock) where Id=@userid";
            borrowUserInfo = PublicConn.QuerySingle<UserBasicInfoInfo>(strSQL, ref dyParams);

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
            return true;
        }
    }
}