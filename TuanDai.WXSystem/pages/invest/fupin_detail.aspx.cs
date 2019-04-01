using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using NetDimension.Json;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class fupin_detail : BasePage
    {
        protected ProjectDetailInfo model = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
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

        protected ProjectUserInfoExt UserInfoExt;//借款人扩展信息
        protected BorrowerComplianceInfo comInfo;

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
            if (model == null || !(model.Type == 48))
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }

            var dyParams = new DynamicParameters();
            dyParams.Add("@userid", model.UserId);
            string strSQL = "select * from UserBasicInfo with(nolock) where Id=@userid";
            borrowUserInfo = PublicConn.QuerySingle<UserBasicInfoInfo>(strSQL, ref dyParams);

            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", model.Id);
            strSQL = string.Empty;
            strSQL = @"select top 1 ext from Project_Common with(nolock) where ProjectId=@ProjectId";
            string ext = PublicConn.QuerySingle<string>(strSQL, ref dyParams);
            if (!string.IsNullOrEmpty(ext))
                UserInfoExt = JsonConvert.DeserializeObject<ProjectUserInfoExt>(ext);
            if (UserInfoExt == null)
                UserInfoExt = new ProjectUserInfoExt();

            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", model.Id);
            strSQL = string.Empty;
            strSQL = @"select * from BorrowerComplianceInfo with(nolock) where ProjectId=@ProjectId";
            comInfo = PublicConn.QuerySingle<BorrowerComplianceInfo>(strSQL, ref dyParams);
            
            if(comInfo == null)
                comInfo =new BorrowerComplianceInfo();

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

    public class BorrowerComplianceInfo
    {
        public string Trade { get; set; }
        public string IncomePerMonth { get; set; }

        public string CompanyName { get; set; }

        public string RegisteredCapital { get; set; }
        public string RegisteredAddress { get; set; }

        public string EstablishedTime { get; set; }

        public string LegalPerson { get; set; }
    }
}