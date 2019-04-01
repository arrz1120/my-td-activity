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
    public partial class ContractType25 : AppActivityBasePage
    {

        protected string key;//合同编号
        protected int type;
        protected SubscribeInfo submodel;//申购表
        protected UserBasicInfoInfo subBasicModel;//申购人
        protected ProjectDetailInfo proModel;//标信息
        protected UserBasicInfoInfo publisherModel;//发标人
        protected Fq_ItemSetsProjectInfo itemProjectInfo;//项目债务人信息
        protected DateTime finishDate = DateTime.Now;//回购日期
        protected string RepaymentTypeDesc = "";//还款时描述
        protected List<ProjectRateContrastInfo> listRateInfo;
        //担保机构
        protected AssureOrganizationInfo assureModel = null;
        protected string companyName = "";
        protected ProjectBLL projectbll;
        protected UserBLL userbll;
        protected void Page_Load(object sender, EventArgs e)
        {
            //验证登录
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



        #region 获取项目发标人的担保公司

        public static UserEnterpriseInfo GetBorrowerGuaranteeEnterprise(Guid borrowerUserId, DateTime AddDate)
        {
            string sql = "select * from UserInEnterprise with(nolock) where BorrowerUserId=@BorrowerUserId";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@BorrowerUserId", borrowerUserId);
            List<UserInEnterpriseInfo> UserInEnterpriseList = PublicConn.QueryBySql<UserInEnterpriseInfo>(sql,
                ref dyParams);
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
               // UserEnterprise userenter = db.UserEnterprise.FirstOrDefault(p => p.UserId == EnterpriseUserId);
                  sql = "select * from UserEnterprise with(nolock) where UserId=@UserId";
                  dyParams = new Dapper.DynamicParameters();
                    dyParams.Add("@UserId", EnterpriseUserId);
                UserEnterpriseInfo userenter = PublicConn.QuerySingle<UserEnterpriseInfo>(sql, ref dyParams);
                return userenter;
            }
            else
            {
                return null;
            }
            
        }

        #endregion

        #region 获取合同信息

        private void GetContractInfo(string key)
        {
            string contactno = this.key;
            this.submodel = new SubscribeBLL().GetSubscribeInfoContractNo(contactno);
            if (submodel.AddDate < Convert.ToDateTime("2016-3-11"))
            {
                companyName = "广东俊特团贷网络信息服务股份有限公司";
            }
            else
            {
                companyName = "东莞团贷网互联网科技服务有限公司";
            }
            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value);
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);  //标信息
            this.publisherModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);//获取发布人信息           
            //普惠借款人基本信息
            
            string sql = "select * from fq_ItemSetsProject with(nolock) where ProjectId=@ProjectId";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@ProjectId", proModel.Id);
            itemProjectInfo = PublicConn.QuerySingle<Fq_ItemSetsProjectInfo>(sql, ref dyParams);
            
            RepaymentTypeDesc = ToolStatus.ConvertRepaymentType(proModel.RepaymentType.Value);
            if (WebUserAuth.UserId == publisherModel.Id)
            {
                this.subBasicModel.RealName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                this.subBasicModel.IdentityCard = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
            }
            else
            {
                this.itemProjectInfo.RealName = StringHandler.MaskStartPre(itemProjectInfo.RealName, 1); //借款人
                this.itemProjectInfo.IdentityCard = StringHandler.MaskCardNo(itemProjectInfo.IdentityCard);//出借人身份证号
            }


            UserEnterpriseInfo userEnterprise = GetBorrowerGuaranteeEnterprise(proModel.UserId.Value, proModel.AddDate.Value);
            if (userEnterprise != null)
            {
              //  this.assureModel = this.db.AssureOrganization.FirstOrDefault(p => p.UserId == userEnterprise.UserId);
                
                string sql1 = "select * from AssureOrganization with(nolock) where UserId=@UserId";
                var dyParams1 = new Dapper.DynamicParameters();
                dyParams1.Add("@UserId", userEnterprise.UserId);
                PublicConn.QuerySingle<AssureOrganizationInfo>(sql1, ref dyParams1);

            }
            else
            {
                if (!string.IsNullOrEmpty(proModel.Guarantors))
                {
                    int gid = 0;
                    int.TryParse(proModel.Guarantors, out gid); 
                    string sql2 = "select * from AssureOrganization with(nolock) where Id=@Id";
                    var dyParams2 = new Dapper.DynamicParameters();
                    dyParams2.Add("@Id", gid);
                    assureModel = PublicConn.QuerySingle<AssureOrganizationInfo>(sql2, ref dyParams2); 
                }
            }

            //印章小图片
            if (assureModel != null)
            {
                this.assureModel.image = this.GetSmallImage(this.assureModel.image);
            }
            // string orgsql = " select c.RealName from dbo.fq_ItemSetsProject as a with(nolock) inner join dbo.Fq_OrgItemSets as b with(nolock) on a.itemid = b.id inner join UserBasicInfo as c with(nolock) on b.orgid = c.id where projectid = @projectid";
            //args = new SqlParameter[] { new SqlParameter("projectid", proModel.Id) };
            //org = db.ExecuteStoreQuery<Org>(orgsql, args).FirstOrDefault();

        }
        #endregion

        #region 获取印章图小图片

        protected string GetSmallImage(string bigImageFile)
        {
            if (bigImageFile.ToText().IsEmpty())
                return "";
            int i = bigImageFile.LastIndexOf(".");

            return bigImageFile.Substring(0, i) + "_S" + System.IO.Path.GetExtension(bigImageFile);
        }
        #endregion

      

        public class Org
        {
            public string RealName { get; set; }
        }

    }
}