using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using System.Data;
using Dapper;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class jisujie_detail : BasePage
    {
        protected ProjectDetailInfo model = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
        protected Organizations organization = null;
        protected bool IsLogin = false;
        protected UserBasicInfoInfo borrowUserInfo = null;
        protected Fq_nwjr_ItemSetsProjectInfo fq_ItemSetsProjectInfo = null;
        protected string rating = "低";
        protected BorrowUserCreditInfo creditInfo = null;
        protected string finishProcess = "0%";

        protected int SubscribeUserCount = 0;//投资人数 
        protected decimal PreInterestRate = 0; //投资1W的预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益
        protected List<PreSubscribeDetailInfo> preSubscribeList;//预回款信息
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
            if (model == null || !(model.Type == 30))
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }


            var dyParams = new DynamicParameters();
            dyParams.Add("@userid", model.UserId);
            var strSQL = "select * from UserBasicInfo with(nolock) where Id=@userid";
            borrowUserInfo = PublicConn.QuerySingle<UserBasicInfoInfo>(strSQL, ref dyParams);

            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", model.Id);

            string querySql = string.Format(@"SELECT  a.ID ,
                                                a.ItemID ,
                                                a.ItemName ,
                                                a.AddDate ,
                                                a.ProjectId ,
                                                a.Amount ,
                                                a.Deadline ,
                                                a.RealName ,
                                                a.IdentityCard ,
                                                a.TelNo ,
                                                a.MonthlyIncome ,
                                                a.Education ,
                                                a.Address ,
                                                a.IsHaveHouse ,
                                                a.ContractNo ,
                                                a.UserName ,
                                                a.InterestRate ,
                                                a.UserID ,
                                                a.OldProjectID ,
                                                a.Title ,
                                                a.StatusId ,
                                                a.FlowCount ,
                                                a.WithdrewStatus ,
                                                a.OrgId ,
                                                a.BorrowerInAmount ,
                                                a.OrgInAmount ,
                                                a.GuarantorInAmount ,
                                                a.TdInAmount ,
                                                a.WithdrawID ,
                                                a.WithdrawNumber ,
                                                a.IsSyncedFullScale ,
                                                a.ProjectType ,
                                                a.RepaymentType,
                                                b.MarrayStatus,
                                                b.HouseSituation,b.IsHaveChildren,b.BorrowerType
                                        FROM    dbo.fq_ItemSetsProject a WITH ( NOLOCK )
                                                INNER JOIN fq_ItemSetsProject_NiWoJinrong b WITH ( NOLOCK ) ON a.ID = b.ItemProjectId
                                        WHERE   ProjectId = @ProjectId
                                                OR CHARINDEX('{0}', OldProjectID) > 0", projectId);
            fq_ItemSetsProjectInfo = PublicConn.QuerySingle<Fq_nwjr_ItemSetsProjectInfo>(querySql, ref dyParams);

            //信用档案
            creditInfo = CommUtils.GetBorrowerCreditData(model.UserId.Value);
            finishProcess = CommUtils.GetProjectProcess(model);

            SubscribeUserCount = CommUtils.GetSubscribeUserCount(this.projectId.Value);
            //计算预期收益
            PreInterestRate = CommUtils.CalcInvestInterest(model, 10000);
            EbaoMultiple = int.Parse(Math.Ceiling(model.InterestRate.Value / decimal.Parse("2.5")).ToString());
            EbaoInterest = CommUtils.GetEbaoMultipleInterest(model, 10000);
            preSubscribeList = CommUtils.GetPreSubscribeDetail(model, 10000);
            InterestModel = TuanDai.PortalSystem.Redis.ProjectRedis.GetProjectInterestMode(model.Type.Value, model.RepaymentType.Value);
            return true;
        }

        protected string GetMarrayStatusText(int status)
        {
            string text = string.Empty;
            switch (status)
            {
                case 1:
                    text = "已婚";
                    break;
                case 2:
                    text = "未婚";
                    break;
                case 3:
                    text = "离异";
                    break;
                case 4:
                    text = "其他";
                    break;
            }
            return text;
        }
        protected string SubRealName(string name)
        {
            if (string.IsNullOrEmpty(name))
                return "保密";
            else
            {
                if (name.Length > 0)
                {
                    return name.Substring(0, 1) + "**";
                }
                else
                {
                    return "保密";
                }
            }
        }
    }

    public class Fq_nwjr_ItemSetsProjectInfo
    {
        public Guid ID { get; set; }
        /// <summary>
        /// 项目集ID
        /// </summary>
        public Guid ItemID { get; set; }
        /// <summary>
        /// 项目集名称
        /// </summary>
        public string ItemName { get; set; }
        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime AddDate { get; set; }
        /// <summary>
        /// 项目ID
        /// </summary>
        public Guid? ProjectId { get; set; }
        /// <summary>
        /// 申请贷款金额
        /// </summary>
        public decimal Amount { get; set; }
        /// <summary>
        /// 还款期限
        /// </summary>
        public int Deadline { get; set; }
        /// <summary>
        /// 真实姓名
        /// </summary>
        public string RealName { get; set; }
        /// <summary>
        /// 身份证号
        /// </summary>
        public string IdentityCard { get; set; }
        /// <summary>
        /// 电话号码
        /// </summary>
        public string TelNo { get; set; }
        /// <summary>
        /// 最高学历
        /// </summary>
        public string Education { get; set; }
        /// <summary>
        /// 现居住地址
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        /// 性别
        /// </summary>
        public string Sex { get; set; }
        /// <summary>
        /// 年龄
        /// </summary>
        public int Age { get; set; }
        /// <summary>
        /// 婚姻状况
        /// </summary>
        public int MarrayStatus { get; set; }
        /// <summary>
        /// 月收入
        /// </summary>
        public string MonthlyIncome { get; set; }
        /// <summary>
        /// 是否有子女
        /// </summary>
        public int isHaveChildren { get; set; }
        /// <summary>
        /// 现有住宅类型
        /// </summary>
        public string HouseSituation { get; set; }
        /// <summary>
        /// 是否有房
        /// </summary>
        public bool IsHaveHouse { get; set; }

        /// <summary>
        /// 合同编号
        /// </summary>
        public string ContractNo { get; set; }


        /// <summary>
        /// 投资利率
        /// </summary>
        public decimal InterestRate { get; set; }
        /// <summary>
        /// 对应注册用户ID
        /// </summary>
        public Guid? UserID { get; set; }
        /// <summary>
        /// 流标项目ID
        /// </summary>
        public string OldProjectID { get; set; }
        /// <summary>
        /// 项目标题
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// 项目状态
        /// </summary>
        public int? StatusId { get; set; }


        /// <summary>
        /// 流标次数
        /// </summary>
        public int? FlowCount { get; set; }
        /// <summary>
        /// 提现状态
        /// </summary>
        public int? WithdrewStatus { get; set; }
        /// <summary>
        /// 机构ID
        /// </summary>
        public Guid? OrgId { get; set; }

        /// <summary>
        /// 借款人实收金额
        /// </summary>
        public decimal? BorrowerInAmount { get; set; }
        /// <summary>
        /// 机构收入金额
        /// </summary>
        public decimal? OrgInAmount { get; set; }

        /// <summary>
        /// 团贷网收入金额
        /// </summary>
        public decimal? TdInAmount { get; set; }

        /// <summary>
        /// 关联提现ID
        /// </summary>
        public Guid? WithdrawID { get; set; }
        /// <summary>
        /// 申请提现次数
        /// </summary>
        public int? WithdrawNumber { get; set; }
        /// <summary>
        /// 标类型
        /// </summary>
        public int ProjectType { get; set; }

        /// <summary>
        /// 贷款类型 1.极速借
        /// </summary>
        public int BorrowerType { get; set; }
    }
}