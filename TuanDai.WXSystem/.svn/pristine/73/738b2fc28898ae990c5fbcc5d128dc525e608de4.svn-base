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
    public partial class ContractType1 : AppActivityBasePage  
    {
        /// <summary>
        /// 合同编号
        /// </summary>
        public string Key
        {
            get
            {
                if (!string.IsNullOrEmpty(Request["key"]))
                {
                    return Request["key"];
                }
                return string.Empty;
            }
        }

        /// <summary>
        /// 标信息
        /// </summary>
        protected ProjectDetailInfo proModel;
        /// <summary>
        /// 申购表
        /// </summary>
        protected SubscribeInfo submodel;

        /// <summary>
        /// 投资人信息
        /// </summary>
        protected UserBasicInfoInfo subBasicModel;
        /// <summary>
        /// 借款人信息
        /// </summary>
        protected UserBasicInfoInfo publisherModel;



        /// <summary>
        /// 担保机构 
        /// </summary>
        protected AssureOrganizationInfo assureModel;

        /// <summary>
        /// 还款时描述
        /// </summary>
        protected string RepaymentTypeDesc = "";
        /// <summary>
        /// 公司名称
        /// </summary>
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
            projectbll = new ProjectBLL();
            userbll = new UserBLL();

            if (!this.IsPostBack)
            {
                if (!string.IsNullOrEmpty(Key))
                {
                    this.GetContractInfo(Key);
                }
                else
                {
                    Response.Redirect("/");
                }
            }
        }

        private void GetContractInfo(string key)
        {
            bool isUndertake = false; //是否承接人
            string contactno = key;
            this.submodel = new SubscribeBLL().GetSubscribeInfoContractNo(contactno);
            if (submodel.AddDate < Convert.ToDateTime("2016-3-11"))
            {
                companyName = "广东俊特团贷网络信息服务股份有限公司";
            }
            else
            {
                companyName = "东莞团贷网互联网科技服务有限公司";
            }

            Dapper.DynamicParameters param = null;
            param = new Dapper.DynamicParameters();
            param.Add("@BorrowerUserId", submodel.BorrowerUserId);
            param.Add("@curUserId", WebUserAuth.UserId);
            string strSQL = "select Count(1) from project where UserId=@BorrowerUserId and UserId=@curUserId";
            bool isExist = PublicConn.QuerySingle<int>(strSQL, ref param) > 0;

            if (this.submodel.SubscribeUserId != WebUserAuth.UserId && !isExist)
            {
                string sql = @"SELECT c.* FROM (
                           SELECT b.* FROM dbo.Subscribe a
                           RIGHT JOIN dbo.t_SubScribeTransfer  b ON a.id=b.m_FromSubscribeId
                           WHERE a.ContractNo=@ContractNo) M 
                           INNER JOIN dbo.Subscribe c ON c.TranId=M.M_id
                           WHERE c.SubscribeUserId=@SubscribeUserId";
                param = new Dapper.DynamicParameters();
                param.Add("@ContractNo", contactno);
                param.Add("@SubscribeUserId", WebUserAuth.UserId);
                var mSubscribe = PublicConn.QuerySingle<SubscribeInfo>(sql, ref param);

                if (mSubscribe == null)//判断是否是承接人查看借款人与转让人的合同
                {
                    HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                    HttpContext.Current.Response.End();
                    return;
                }
                isUndertake = true;
            }
            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value);//投资人信息
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);
            this.publisherModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);//借款人信息


            UserEnterpriseInfo userEnterprise = new Common.Contract().GetBorrowerGuaranteeEnterprise(proModel.UserId.Value, proModel.AddDate.Value, proModel.Type.Value);
            if (userEnterprise != null)
            {
                assureModel = new Common.Contract().GetAssureOrganizationByUserId(userEnterprise.UserId);
            }
            else
            {
             
                if (proModel.Guarantors.ToText() == "")
                {
                    assureModel = new AssureOrganizationInfo();
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
            }

            //印章小图片
            this.assureModel.image = new Common.Contract().GetSmallImage(this.assureModel.image);

            RepaymentTypeDesc = new Common.Contract().GetRepaymentTypeDesc(proModel.RepaymentType ?? 0);

            if (WebUserAuth.UserId == publisherModel.Id)
            {
                this.subBasicModel.RealName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                this.subBasicModel.IdentityCard = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
            }
            else
            {
                this.publisherModel.RealName = StringHandler.MaskStartPre(publisherModel.RealName, 1); //借款 人
                this.publisherModel.IdentityCard = StringHandler.MaskCardNo(publisherModel.IdentityCard); //借款人身份证号
            }

            if (isUndertake)
            {
                this.subBasicModel.RealName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
                this.subBasicModel.IdentityCard = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号      
                this.publisherModel.RealName = StringHandler.MaskStartPre(publisherModel.RealName, 1); //借款 人
                this.publisherModel.IdentityCard = StringHandler.MaskCardNo(publisherModel.IdentityCard); //借款人身份证号
            }
        }

    }
}