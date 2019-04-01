using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using BusinessDll;
using Kamsoft.Data.Dapper;
using System.Data.SqlClient;

namespace TuanDai.WXApiWeb.Contract
{
    public partial class ContractType15 : AppActivityBasePage
    {

        protected string key; // 合同编号
        protected int type = 1; // 项目类型
        protected SubscribeInfo submodel; // 申购表
        protected UserBasicInfoInfo subBasicModel; //申购人
        protected ProjectDetailInfo proModel; // 标信息
        protected UserBasicInfoInfo publisherModel;//发标人       
        /// <summary>
        /// 借款人信息
        /// </summary>
        protected UserBasicInfoInfo borrowModel;
        /// <summary>
        /// 债权转让表
        /// </summary>
        ///  protected t_SubScribeTransfer mSubScribeTransfer;
        /// <summary>
        /// 还款时描述
        /// </summary>
        protected string RepaymentTypeDesc = "";
        /// <summary>
        /// 公司名称
        /// </summary>
        protected string companyName = "";

        protected OrgInfo mOrgInfo = null;
        protected fqbcontract fqbmodel = null;
        protected fqlcontract fqlmodel = null;
        protected ProjectBLL projectbll;
        protected xssdcontract xssdmodel = null;
        protected UserBLL userbll;
        protected Kldcontract kldmodel = null;
        protected AssureOrganizationInfo assureModel;

        protected void Page_Load(object sender, EventArgs e)
        {
            Guid? userId = WebUserAuth.UserId;
            if (userId == null || userId == Guid.Empty)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
            }
            if (Request["key"] != null)
            {
                this.key = Request.QueryString["key"];
            }
            projectbll = new ProjectBLL();
            userbll = new UserBLL();
            this.type = WEBRequest.GetInt("type", 1);
            if (!this.IsPostBack)
            {
                if (!string.IsNullOrEmpty(this.key))
                {
                    this.GetContractInfo(this.key);
                }
                else
                {
                    Response.Redirect("/");
                }
            }
        }

        #region 获取合同信息
        /// <summary>
        /// 获取合同信息
        /// add by huangbinglai
        /// 20160326
        /// </summary>
        /// <param name="key">合同编号</param>
        private void GetContractInfo(string key)
        {
            string contactno = this.key;
            this.submodel = new SubscribeBLL().GetSubscribeInfoContractNo(contactno);


            string sql = @"select * from project  where UserId=@UserId  and Id=@Id";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", WebUserAuth.UserId);
            dyParams.Add("@Id", submodel.ProjectId);
            ProjectDetailInfo projectModel = PublicConn.QuerySingle<ProjectDetailInfo>(sql, ref dyParams);
            if (this.submodel.SubscribeUserId != WebUserAuth.UserId && projectModel == null)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
            }

            if (submodel.AddDate < Convert.ToDateTime("2016-3-11"))
            {
                companyName = "广东俊特团贷网络信息服务股份有限公司";
            }
            else
            {
                companyName = "东莞团贷网互联网科技服务有限公司";
            }
            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value);//获取承接人信息 
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);  //标信息
            this.publisherModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);//获取发布人信息  



            sql = @"select u.OrgTypeId,u.OrgId,ISNULL(o.SubTypeId,0) AS SubTypeId from fq_UserApply u
                INNER JOIN fq_Organization o ON u.OrgId=o.OrgId
                where u.ProjectId=@ProjectId";
            dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@ProjectId", submodel.ProjectId);
            mOrgInfo =PublicConn.QuerySingle<OrgInfo>(sql, ref dyParams);

            if (mOrgInfo.OrgTypeId == 5)//分期乐
            {
                if (mOrgInfo.SubTypeId == 3)
                {
                    #region 小树时代
                    xssdmodel = new xssdcontract();
                    xssdmodel.ProContactNo = contactno; //合同
                    if (proModel.UserId == WebUserAuth.UserId)//借款人查看
                    {
                        xssdmodel.InvestUserName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                        xssdmodel.InvestCardNo = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
                        xssdmodel.OrgName = publisherModel.RealName; //机构名称
                        xssdmodel.OrgCode = publisherModel.IdentityCard; //机构编码
                    }
                    else
                    {
                        xssdmodel.InvestUserName = subBasicModel.RealName;//出借人
                        xssdmodel.InvestCardNo = subBasicModel.IdentityCard;//出借人身份证号
                        xssdmodel.OrgName = publisherModel.RealName;// StringHandler.MaskStartPre(publisherModel.RealName, 1); //机构名称
                        xssdmodel.OrgCode = publisherModel.IdentityCard;// StringHandler.MaskCardNo(publisherModel.IdentityCard); //机构编码
                    }
                    Dapper.DynamicParameters para1 = new Dapper.DynamicParameters();
                    para1.Add("@OrgId", publisherModel.Id);
                    sql = "select  OrgLegalPerson from fq_Organization where OrgId=@OrgId";
                    string OrgLegalPerson =PublicConn.QuerySingle<string>(sql, ref para1);
                    xssdmodel.OrgLegalPerson = string.IsNullOrEmpty(OrgLegalPerson) ? "" : proModel.UserId == WebUserAuth.UserId ? OrgLegalPerson : StringHandler.MaskStartPre(OrgLegalPerson, 1); //机构法定代表人

                    xssdmodel.Grade = proModel.Grade;
                    xssdmodel.SubContractNo = submodel.ContractNo;
                    xssdmodel.Amount = submodel.Amount.Value.ToString("N"); //借款金额小写
                    xssdmodel.InterestAmount = submodel.InterestAmount.Value.ToString("N"); //借款利息小写
                    xssdmodel.DeadLine = proModel.Deadline.Value.ToString();//借款期限
                    decimal PerAmount = Math.Round((submodel.Amount.Value + submodel.InterestAmount.Value) / proModel.Deadline.Value, 2);
                    xssdmodel.PerAmount = PerAmount.ToString("N");//每月回款金额
                    xssdmodel.Rate = proModel.InterestRate.Value.ToString();//利率
                    //最后回款时间
                    sql = "select  MAX(CycDate) CycDate  from SubscribeDetail where SubscribeId=@SubscribeId";
                    Dapper.DynamicParameters para2 = new Dapper.DynamicParameters();
                    para2.Add("@SubscribeId", submodel.Id);
                    DateTime? MAXDate =PublicConn.QuerySingle<DateTime?>(sql, ref para2);
                    DateTime LastDate = MAXDate ?? DateTime.Now.AddMonths(proModel.Deadline ?? 0);
                    xssdmodel.ExpireYear = LastDate.Year.ToString();
                    xssdmodel.ExpireMonth = LastDate.Month.ToString();
                    xssdmodel.ExpireDay = LastDate.Day.ToString();
                    xssdmodel.BorrowSignYear = submodel.AddDate.Value.Year.ToString();//签字日期
                    xssdmodel.BorrowSignMonth = submodel.AddDate.Value.Month.ToString();
                    xssdmodel.BorrowSignDay = submodel.AddDate.Value.Day.ToString();
                    #endregion
                }
                else if (mOrgInfo.SubTypeId == 5)
                {
                    #region 你我金融
                    kldmodel = new Kldcontract();
                    kldmodel.ProContactNo = contactno;
                    if (proModel.UserId == WebUserAuth.UserId)//借款人查看
                    {
                        kldmodel.InvestUserName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                        kldmodel.InvestCardNo = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
                        kldmodel.OrgName = publisherModel.RealName; //机构名称
                        kldmodel.OrgCode = publisherModel.IdentityCard; //机构编码
                    }
                    else
                    {
                        kldmodel.InvestUserName = subBasicModel.RealName;//出借人
                        kldmodel.InvestCardNo = subBasicModel.IdentityCard;//出借人身份证号
                        kldmodel.OrgName = publisherModel.RealName;// StringHandler.MaskStartPre(publisherModel.RealName, 1); //机构名称
                        kldmodel.OrgCode = publisherModel.IdentityCard;// StringHandler.MaskCardNo(publisherModel.IdentityCard); //机构编码
                    }
                    Dapper.DynamicParameters para2 = new Dapper.DynamicParameters();
                    para2.Add("@OrgId", publisherModel.Id);
                    sql = "select  OrgLegalPerson from fq_Organization where OrgId=@OrgId";
                    string OrgLegalPerson =PublicConn.QuerySingle<string>(sql, ref para2);
                    kldmodel.OrgLegalPerson = string.IsNullOrEmpty(OrgLegalPerson) ? "" : proModel.UserId == WebUserAuth.UserId ? OrgLegalPerson : StringHandler.MaskStartPre(OrgLegalPerson, 1); //机构法定代表人
                    kldmodel.Grade = proModel.Grade;
                    kldmodel.SubContractNo = submodel.ContractNo;
                    kldmodel.Amount = submodel.Amount.Value.ToString("N"); //借款金额小写
                    kldmodel.InterestAmount = submodel.InterestAmount.Value.ToString("N"); //借款利息小写
                    kldmodel.DeadLine = proModel.Deadline.Value.ToString();//借款期限
                    decimal PerAmount = Math.Round((submodel.Amount.Value + submodel.InterestAmount.Value) / proModel.Deadline.Value, 2);
                    kldmodel.PerAmount = PerAmount.ToString("N");//每月回款金额
                    kldmodel.Rate = proModel.InterestRate.Value.ToString();//利率
                    kldmodel.ReturnType = convertType(submodel.RepaymentType);
                    var para = new SqlParameter[] { new SqlParameter("projectid", submodel.ProjectId) };

                    sql = "select max(CycDate) from SubscribeDetail where SubscribeId=@subscribeId";
                    para2 = new Dapper.DynamicParameters();
                    para2.Add("@subscribeId", submodel.Id);
                    DateTime? maxCycDate = PublicConn.QuerySingle<DateTime?>(sql, ref para2);
                    //最后回款时间
                    DateTime LastDate = maxCycDate.HasValue ? maxCycDate.Value : DateTime.Now.AddMonths(proModel.Deadline ?? 0);
                    kldmodel.ExpireYear = LastDate.Year.ToString();
                    kldmodel.ExpireMonth = LastDate.Month.ToString();
                    kldmodel.ExpireDay = LastDate.Day.ToString();
                    kldmodel.BorrowSignYear = submodel.AddDate.Value.Year.ToString();//签字日期
                    kldmodel.BorrowSignMonth = submodel.AddDate.Value.Month.ToString();
                    kldmodel.BorrowSignDay = submodel.AddDate.Value.Day.ToString();
                    #endregion
                }
                else if (mOrgInfo.SubTypeId == 4)
                {
                    #region 快来贷
                    kldmodel = new Kldcontract();
                    kldmodel.ProContactNo = contactno;
                    if (proModel.UserId == WebUserAuth.UserId)//借款人查看
                    {
                        kldmodel.InvestUserName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                        kldmodel.InvestCardNo = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
                        kldmodel.OrgName = publisherModel.RealName; //机构名称
                        kldmodel.OrgCode = publisherModel.IdentityCard; //机构编码
                    }
                    else
                    {
                        kldmodel.InvestUserName = subBasicModel.RealName;//出借人
                        kldmodel.InvestCardNo = subBasicModel.IdentityCard;//出借人身份证号
                        kldmodel.OrgName = publisherModel.RealName;// StringHandler.MaskStartPre(publisherModel.RealName, 1); //机构名称
                        kldmodel.OrgCode = publisherModel.IdentityCard;// StringHandler.MaskCardNo(publisherModel.IdentityCard); //机构编码
                    }
                    Dapper.DynamicParameters para2 = new Dapper.DynamicParameters();
                    para2.Add("@OrgId", publisherModel.Id);
                    sql = "select  OrgLegalPerson from fq_Organization where OrgId=@OrgId";
                    string OrgLegalPerson = PublicConn.QuerySingle<string>(sql, ref para2);
                    kldmodel.OrgLegalPerson = string.IsNullOrEmpty(OrgLegalPerson) ? "" : proModel.UserId == WebUserAuth.UserId ? OrgLegalPerson : StringHandler.MaskStartPre(OrgLegalPerson, 1); //机构法定代表人

                    kldmodel.Grade = proModel.Grade;
                    kldmodel.SubContractNo = submodel.ContractNo;
                    kldmodel.Amount = submodel.Amount.Value.ToString("N"); //借款金额小写
                    kldmodel.InterestAmount = submodel.InterestAmount.Value.ToString("N"); //借款利息小写
                    kldmodel.DeadLine = proModel.Deadline.Value.ToString();//借款期限
                    decimal PerAmount = Math.Round((submodel.Amount.Value + submodel.InterestAmount.Value) / proModel.Deadline.Value, 2);
                    kldmodel.PerAmount = PerAmount.ToString("N");//每月回款金额
                    kldmodel.Rate = proModel.InterestRate.Value.ToString();//利率
                    kldmodel.ReturnType = convertType(submodel.RepaymentType); 

                    sql = "select max(CycDate) from SubscribeDetail where SubscribeId=@subscribeId";
                    para2 = new Dapper.DynamicParameters();
                    para2.Add("@subscribeId", submodel.Id);
                    DateTime? maxCycDate =PublicConn.QuerySingle<DateTime?>(sql, ref para2);

                    //最后回款时间
                    DateTime LastDate = maxCycDate.HasValue ? maxCycDate.Value : DateTime.Now.AddMonths(proModel.Deadline ?? 0);
                    kldmodel.ExpireYear = LastDate.Year.ToString();
                    kldmodel.ExpireMonth = LastDate.Month.ToString();
                    kldmodel.ExpireDay = LastDate.Day.ToString();
                    kldmodel.BorrowSignYear = submodel.AddDate.Value.Year.ToString();//签字日期
                    kldmodel.BorrowSignMonth = submodel.AddDate.Value.Month.ToString();
                    kldmodel.BorrowSignDay = submodel.AddDate.Value.Day.ToString();
                    if (string.IsNullOrEmpty(proModel.Guarantors) || proModel.Guarantors.ToInt(0) <= 0)
                    {
                        HttpContext.Current.Response.Write("对不起，该项目未指定担保机构,不能查看合同!");
                        HttpContext.Current.Response.End();
                        return;
                    }
                    #endregion
                }

                if (mOrgInfo.SubTypeId.ToString().IsIn("4", "5"))
                {
                    UserEnterpriseInfo userEnterprise = new Common.Contract().GetBorrowerGuaranteeEnterprise(proModel.UserId.Value, proModel.AddDate.Value, proModel.Type.Value);
                    if (userEnterprise != null)
                    {
                        assureModel = new Common.Contract().GetAssureOrganizationByUserId(userEnterprise.UserId);
                    }
                    else
                    {
                        //当未指定担保机构时则退出  allen  2015-05-07
                        if (string.IsNullOrEmpty(proModel.Guarantors) || proModel.Guarantors.ToInt(0) <= 0)
                        {
                            HttpContext.Current.Response.Write("对不起，该项目未指定担保机构,不能查看合同!");
                            HttpContext.Current.Response.End();
                            return;
                        }
                        int gid = 0;
                        int.TryParse(proModel.Guarantors, out gid);
                        assureModel = new Common.Contract().GetAssureOrganizationById(gid);
                        if (gid == 1 && DateTime.Now < DateTime.Parse("2013-11-27"))
                        {
                            assureModel.FullName = "东莞市俊特团贷网络信息服务有限公司";
                        }
                    }
                    //印章小图片
                    assureModel.image = new Common.Contract().GetSmallImage(assureModel.image);
                    kldmodel.Assure = assureModel != null ? assureModel.FullName : "东莞市志诚非融资性担保有限公司";
                }
            }
            else//分期宝
            {
                #region 分期宝
                fqbmodel = new fqbcontract();
                fqbmodel.ProContactNo = contactno; //合同
                if (proModel.UserId == WebUserAuth.UserId)//借款人查看
                {
                    fqbmodel.CreditorName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                    fqbmodel.CreditorCardNo = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
                    fqbmodel.DebtorName = publisherModel.RealName; //借款人
                    fqbmodel.DebtorCardNo = publisherModel.IdentityCard; //借款人身份证号
                }
                else
                {
                    fqbmodel.CreditorName = subBasicModel.RealName;//出借人
                    fqbmodel.CreditorCardNo = subBasicModel.IdentityCard;//出借人身份证号
                    fqbmodel.DebtorName = StringHandler.MaskStartPre(publisherModel.RealName, 1); //借款 人
                    fqbmodel.DebtorCardNo = StringHandler.MaskCardNo(publisherModel.IdentityCard); //借款人身份证号
                }
                Dapper.DynamicParameters para = new Dapper.DynamicParameters();
                para.Add("@projectid", submodel.ProjectId);
                sql = @"DECLARE @IsPrivateAccounts BIT=0 --是否私账，默认公账
                                SELECT @IsPrivateAccounts=ISNULL(b.IsPrivateAccounts,0) FROM dbo.fq_UserApply(nolock) a
                                INNER JOIN  dbo.fq_Organization(nolock) b ON a.OrgId=b.OrgId
                                WHERE a.ProjectId=@projectid
                                IF	@IsPrivateAccounts=0
                                BEGIN
	                                SELECT u.RealName as OrgName,o.ProductName FROM fq_UserApply a with(nolock) 
	                                INNER JOIN  fq_OrgProduct(nolock) o ON a.ProductId = o.Id  
	                                INNER JOIN  dbo.UserBasicInfo(nolock) u ON a.OrgId = u.Id
	                                where a.ProjectId=@projectid
                                END
                                ELSE
                                BEGIN
	                                SELECT u.ShortName as OrgName,o.ProductName FROM fq_UserApply a with(nolock) 
	                                INNER JOIN  fq_OrgProduct(nolock) o ON a.ProductId = o.Id  
	                                INNER JOIN  dbo.fq_Organization(nolock) u ON a.OrgId = u.OrgId
	                                where a.ProjectId=@projectid
                                END";
                var OrgInfo = PublicConn.QuerySingle<FqbOrg>(sql, ref para);
                fqbmodel.Assure = OrgInfo.OrgName;//担保人
                fqbmodel.OrgName = OrgInfo.OrgName;
                fqbmodel.ProductName = OrgInfo.ProductName;
                fqbmodel.Amount = proModel.Amount.Value.ToString("N");
                fqbmodel.BorrowMoney = submodel.Amount.Value.ToString("N"); //借款金额小写
                fqbmodel.BorrowMoneyCn = ChineseNum.GetUpperMoney(double.Parse(submodel.Amount.Value.ToString()));//借款金额大写
                fqbmodel.DeadLine = proModel.Deadline.Value.ToString();//借款期限
                fqbmodel.Rate = proModel.InterestRate.Value.ToString();//利率
                // dic["OverRate1"] = debtorModel.OverRate.Value.ToString();//逾期利率
                fqbmodel.OverRate = fqbmodel.Rate;
                fqbmodel.Address = "广东省东莞市南城区";//签署地
                fqbmodel.RepaymentTypeName = ToolStatus.ConvertRepaymentType(proModel.RepaymentType ?? 0);
                fqbmodel.BorrowSignYear = submodel.AddDate.Value.Year.ToString();//签字日期
                fqbmodel.BorrowSignMonth = submodel.AddDate.Value.Month.ToString();
                fqbmodel.BorrowSignDay = submodel.AddDate.Value.Day.ToString();

                #endregion
            }
        }

        #endregion

        public string convertType(int? type)
        {
            string convertT = string.Empty;
            switch (type)
            {
                case 1: convertT = "乙方须借款到期一次性归还全部借款本金及利息"; break;
                case 2: convertT = "乙方须每月付息一次，借款到期一次性归还全部借款本金及剩余部分利息"; break;
                case 3: convertT = "每月等本等息"; break;
                case 4: convertT = "乙方须出借时支付利息，借款到期一次性归还全部借款本金"; break;
                case 5: convertT = "每月等额本息"; break;
            }
            return convertT;
        }
    }

    #region 内部Model
    public class OrgInfo
    {
        /// <summary>
        /// 机构ID
        /// </summary>
        public Guid OrgId { get; set; }
        /// <summary>
        /// 机构类型
        /// </summary>
        public int OrgTypeId { get; set; }
        /// <summary>
        /// 机构子类
        /// </summary>
        public int SubTypeId { get; set; }
    }
    //分期宝
    public class fqbcontract
    {
        public string ProContactNo { get; set; }//合同号
        public string CreditorName { get; set; }//投资人姓名
        public string CreditorCardNo { get; set; }//投资人身份证号码
        public string DebtorName { get; set; }//借款人
        public string DebtorCardNo { get; set; }//借款人身份证号
        public string Assure { get; set; }//担保人
        public string OrgName { get; set; }//机构名称
        public string ProductName { get; set; }//产品名称
        public string Amount { get; set; }//借款金额
        public string BorrowMoney { get; set; }//投资金额小写
        public string BorrowMoneyCn { get; set; }//投资金额大写
        public string DeadLine { get; set; }//期限
        public string Rate { get; set; }//利率
        public string OverRate { get; set; }//预期利率
        public string RepaymentTypeName { get; set; }//签署地址
        public string Address { get; set; }//签署地址
        public string BorrowSignYear { get; set; }//签署年
        public string BorrowSignMonth { get; set; }//签署月
        public string BorrowSignDay { get; set; }//签署日
    }
    //分期乐
    public class fqlcontract
    {
        public string ProContactNo { get; set; }//合同号
        public string InvestUserName { get; set; }//投资人姓名
        public string InvestCardNo { get; set; }//投资人身份证号码
        public string OrgName { get; set; }//机构名称
        public string OrgCode { get; set; }//机构编码
        public string OrgLegalPerson { get; set; }//法定代表人
        public string Grade { get; set; }//标号
        public string SubContractNo { get; set; }//申购编号
        public string Amount { get; set; }//本息
        public string InterestAmount { get; set; }//利息
        public string DeadLine { get; set; }//期限
        public string PerAmount { get; set; }//每月回款金额
        public string ExpireYear { get; set; }//协议到期年
        public string ExpireMonth { get; set; }//协议到期月
        public string ExpireDay { get; set; }//协议到期日
        public string BorrowSignYear { get; set; }//签署年
        public string BorrowSignMonth { get; set; }//签署月
        public string BorrowSignDay { get; set; }//签署日
    }

    //小树时代
    public class xssdcontract
    {
        public string ProContactNo { get; set; }//合同号
        public string InvestUserName { get; set; }//投资人姓名
        public string InvestCardNo { get; set; }//投资人身份证号码
        public string OrgName { get; set; }//机构名称
        public string OrgCode { get; set; }//机构编码
        public string OrgLegalPerson { get; set; }//法定代表人
        public string Grade { get; set; }//标号
        public string SubContractNo { get; set; }//申购编号
        public string Amount { get; set; }//本息
        public string InterestAmount { get; set; }//利息
        public string DeadLine { get; set; }//期限
        public string PerAmount { get; set; }//每月回款金额
        public string Rate { get; set; }//利率
        public string ExpireYear { get; set; }//协议到期年
        public string ExpireMonth { get; set; }//协议到期月
        public string ExpireDay { get; set; }//协议到期日
        public string BorrowSignYear { get; set; }//签署年
        public string BorrowSignMonth { get; set; }//签署月
        public string BorrowSignDay { get; set; }//签署日
    }

    public class FqbOrg
    {
        public string OrgName { get; set; }
        public string ProductName { get; set; }
    }
    public class Kldcontract
    {
        public string ProContactNo { get; set; }//合同号
        public string InvestUserName { get; set; }//投资人姓名
        public string InvestCardNo { get; set; }//投资人身份证号码
        public string OrgName { get; set; }//机构名称
        public string OrgCode { get; set; }//机构编码
        public string OrgLegalPerson { get; set; }//法定代表人
        public string Grade { get; set; }//标号
        public string SubContractNo { get; set; }//申购编号
        public string Amount { get; set; }//本息
        public string InterestAmount { get; set; }//利息
        public string DeadLine { get; set; }//期限
        public string PerAmount { get; set; }//每月回款金额
        public string Rate { get; set; }//利率
        public string ExpireYear { get; set; }//协议到期年
        public string ExpireMonth { get; set; }//协议到期月
        public string ExpireDay { get; set; }//协议到期日
        public string BorrowSignYear { get; set; }//签署年
        public string BorrowSignMonth { get; set; }//签署月
        public string BorrowSignDay { get; set; }//签署日
        public string ReturnType { get; set; }//还款方式
        public string Assure { get; set; }//担保人
    }
    #endregion
}