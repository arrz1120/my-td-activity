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

namespace TuanDai.WXApiWeb.Contract
{
    public partial class contractType29 : AppActivityBasePage
    {
        protected string key;//合同编号
        protected ProjectBLL projectbll;
        protected UserBLL userbll;

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
            if (!this.IsPostBack)
            {
                if (!string.IsNullOrEmpty(this.key))
                {
                    this.GetContractInfo(this.key);
                    this.GetYearRate(proModel.Id.ToString());
                }
                else
                {
                    Response.Redirect("/");
                }
            }
        }

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
            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value); //基本信息
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);  //标信息
            this.publisherModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);

            var Params = new Dapper.DynamicParameters();
            Params.Add("@ProjectId", proModel.Id);
            string selSQL = @"select * from fq_ItemSetsProject with(nolock) where ProjectId=@ProjectId";
            itemProjectInfo = PublicConn.QuerySingle<Fq_ItemSetsProjectInfo>(selSQL, ref Params);

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

            UserEnterpriseInfo userEnterprise = new Common.Contract().GetBorrowerGuaranteeEnterprise(proModel.UserId.Value, proModel.AddDate.Value, proModel.Type.Value);
            if (userEnterprise != null)
            {
                assureModel = new Common.Contract().GetAssureOrganizationByUserId(userEnterprise.UserId);
            }
            else
            {
                int gid = 0;
                int.TryParse(proModel.Guarantors, out gid);
                assureModel = new Common.Contract().GetAssureOrganizationById(gid);
                if (gid == 1 && DateTime.Now < DateTime.Parse("2013-11-27"))
                {
                    assureModel.FullName = "东莞市俊特团贷网络信息服务有限公司";
                }
            }

            //印章小图片
            if (assureModel != null)
            {
                this.assureModel.image = this.GetSmallImage(this.assureModel.image);
            }
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

        protected void GetYearRate(string projectId)
        {
            string sqlText = @"SELECT * FROM ProjectRateContrast WITH(NOLOCK) WHERE ProjectId=@ProjectId ";
            var para = new Dapper.DynamicParameters();
            para.Add("@ProjectId", projectId);
            listRateInfo = PublicConn.QueryBySql<ProjectRateContrastInfo>(sqlText, ref para);
        }
    }
}