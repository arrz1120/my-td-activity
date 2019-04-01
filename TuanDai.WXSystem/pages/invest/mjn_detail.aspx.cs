using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class mjn_detail : BasePage
    {
        protected ProjectDetailInfo model = null;
        protected Guid? projectId = Guid.Empty;
        private ProjectBLL bll = null;
        protected Organizations organization = null;
        protected bool IsLogin = false;
        protected UserBasicInfoInfo borrowUserInfo = null;
        protected Fq_mjn_ItemSetsProjectInfo fq_ItemSetsProjectInfo = null;
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
            if (model == null || (model.Type != 29))
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
                organization.ShortName = "沐金农";
            }

            dyParams = new DynamicParameters();
            dyParams.Add("@userid", model.UserId);
            strSQL = "select * from UserBasicInfo with(nolock) where Id=@userid";
            borrowUserInfo = PublicConn.QuerySingle<UserBasicInfoInfo>(strSQL, ref dyParams);

            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", model.Id);
            strSQL = string.Format(@"SELECT a.*,b.Profession,b.HouseSituation,b.BorrowerType,b.FarmingLand,b.LastZJBTAmount,b.LastNJGZBTAmount,b.LastLZBTAmount,b.Plant,b.BreedDes FROM dbo.fq_ItemSetsProject a with(nolock)
								   inner join fq_ItemSetsProject_mjn b with(nolock) on a.ID=b.ItemProjectId
								    WHERE ProjectId=@ProjectId OR CHARINDEX('{0}',OldProjectID)>0", model.Id);
            fq_ItemSetsProjectInfo = PublicConn.QuerySingle<Fq_mjn_ItemSetsProjectInfo>(strSQL, ref dyParams);


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

        public string MaskStartPre(string content, int top)
        {
            content = content.ToText();
            if (content.Length < top)
                return content;

            int length = content.Length;
            string star = "";
            for (int i = 0; i < length - top; i++)
            {
                star += "*";
            }
            return content.Substring(0, top) + star;
        }
        public string MaskPre(string content, int top)
        {
            content = content.ToText();
            if (content.Length <= top)
                return content;

            int length = content.Length;
            string star = "...";

            return content.Substring(0, top) + star;
        }


        public class Fq_mjn_ItemSetsProjectInfo
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
            /// 婚姻状况
            /// </summary>
            public bool MarrayStatus { get; set; }
            /// <summary>
            /// 月收入
            /// </summary>
            public string MonthlyIncome { get; set; }
            /// <summary>
            /// 最高学历
            /// </summary>
            public string Education { get; set; }
            /// <summary>
            /// 现居住地址
            /// </summary>
            public string Address { get; set; }
            /// <summary>
            /// 单位地址
            /// </summary>
            public string UnitAddress { get; set; }
            /// <summary>
            /// 公司规模
            /// </summary>
            public string OfficeScale { get; set; }
            /// <summary>
            /// 公司行业
            /// </summary>
            public string CompanyIndustryTypeId { get; set; }
            /// <summary>
            /// 职务
            /// </summary>
            public string Position { get; set; }
            /// <summary>
            /// 是否有房
            /// </summary>
            public bool IsHaveHouse { get; set; }
            /// <summary>
            /// 是否有车
            /// </summary>
            public bool IsHaveCar { get; set; }
            /// <summary>
            /// 合同编号
            /// </summary>
            public string ContractNo { get; set; }
            /// <summary>
            /// 网站注册用户名
            /// </summary>
            public string UserName { get; set; }
            /// <summary>
            /// 第一联系人姓名
            /// </summary>
            public string ContactOne { get; set; }
            /// <summary>
            /// 第一联系人关系
            /// </summary>
            public string RelationShopOne { get; set; }
            /// <summary>
            /// 第一联系人手机号
            /// </summary>
            public string ContactOnePhone { get; set; }
            /// <summary>
            /// 银行账号
            /// </summary>
            public string BankAccountNo { get; set; }
            /// <summary>
            /// 银行名称
            /// </summary>
            public int? BankType { get; set; }
            /// <summary>
            /// 开户银行所在省
            /// </summary>
            public string BankProvice { get; set; }
            /// <summary>
            /// 开户银行所在市
            /// </summary>
            public string BankCity { get; set; }
            /// <summary>
            /// 开户行支行名称
            /// </summary>
            public string OpenBankName { get; set; }
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
            /// 是否加急
            /// </summary>
            public bool? IsExpedited { get; set; }
            /// <summary>
            /// 游标次数
            /// </summary>
            public int? FlowCount { get; set; }
            /// <summary>
            /// 提现状态(用于正和金融)
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
            /// 风险拨备账户收入金额
            /// </summary>
            public decimal? GuarantorInAmount { get; set; }
            /// <summary>
            /// 团贷网收入金额
            /// </summary>
            public decimal? TdInAmount { get; set; }
            /// <summary>
            /// 开户行(银行名称)
            /// </summary>
            public string BankName { get; set; }
            /// <summary>
            /// 关联提现ID
            /// </summary>
            public Guid? WithdrawID { get; set; }
            /// <summary>
            /// 是否已同步到正合 
            /// </summary>
            public bool? IsSynced { get; set; }
            /// <summary>
            /// 申请提现次数
            /// </summary>
            public int? WithdrawNumber { get; set; }
            /// <summary>
            /// 标类型
            /// </summary>
            public int ProjectType { get; set; }


            //沐金农业务新增字段  guoqu  2016-10-19
            /// <summary>
            /// 所属职业
            /// </summary>
            public string Profession { get; set; }
            /// <summary>
            /// 房产类别
            /// </summary>
            public string HouseSituation { get; set; }
            /// <summary>
            /// 关系
            /// </summary>
            public string Relation { get; set; }
            /// <summary>
            /// 配偶身份证
            /// </summary>
            public string SpouseIdentityCard { get; set; }
            /// <summary>
            /// 贷款人实收费率
            /// </summary>
            public decimal BorrowerRate { get; set; }
            /// <summary>
            /// 代扣费率
            /// </summary>
            public decimal MjnRate { get; set; }
            /// <summary>
            /// 担保费率
            /// </summary>
            public decimal GuarantorRate { get; set; }
            /// <summary>
            /// 贷款类型 1.信担贷 2.土转贷
            /// </summary>
            public int BorrowerType { get; set; }
            /// <summary>
            /// 耕作土地
            /// </summary>
            public string FarmingLand { get; set; }
            /// <summary>
            /// 上年直接补贴金额
            /// </summary>
            public decimal? LastZJBTAmount { get; set; }
            /// <summary>
            /// 上年农机构置补贴金额
            /// </summary>
            public decimal? LastNJGZBTAmount { get; set; }
            /// <summary>
            /// 上年良种补贴金额
            /// </summary>
            public decimal? LastLZBTAmount { get; set; }
            /// <summary>
            /// 种植作物
            /// </summary>
            public string Plant { get; set; }

            /// <summary>
            /// 养殖数量
            /// </summary>
            public int BreedCount { get; set; }
            /// <summary>
            /// 养殖牲畜
            /// </summary>
            public string BreedDes { get; set; }
            /// <summary>
            /// 户籍属性
            /// </summary>
            public string HouseholdPro { get; set; }
        }
    }
}