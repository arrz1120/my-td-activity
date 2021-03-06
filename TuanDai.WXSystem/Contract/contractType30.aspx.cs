﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using BusinessDll;

namespace TuanDai.WXApiWeb.Contract
{
    public partial class contractType30 : AppActivityBasePage
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
        protected AssureOrganizationInfo AssureModel;

        /// <summary>
        /// 还款时描述
        /// </summary>
        protected string RepaymentTypeDesc = "";
        /// <summary>
        /// 公司名称
        /// </summary>
        protected string companyName = "";

        /// <summary>
        /// 股权百份比
        /// </summary>
        protected string SharesPercent = string.Empty;

        /// <summary>
        /// 本息金额
        /// </summary>
        protected decimal PrincipalInterest = 0;


        private ProjectBLL projectbll = new ProjectBLL();
        private UserBLL userbll = new UserBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            //验证登录
            Guid? userId = WebUserAuth.UserId;
            if (userId == null || userId == Guid.Empty)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
            }
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
            if (submodel.AddDate.Value <= DateTime.Parse("2015-07-31"))
            {
                Response.Redirect(string.Format("/Contract/ContractJzdb.aspx?key={0}&type=mobileapp", key));
                return;
            }
            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            param = new Dapper.DynamicParameters();
            param.Add("@ProjectId", submodel.ProjectId);
            param.Add("@curUserId", WebUserAuth.UserId);
            string strSQL = "select Count(1) from project(nolock) where Id=@ProjectId and UserId=@curUserId";
            bool isExist = PublicConn.QuerySingle<int>(strSQL, ref param) > 0;
            if (this.submodel.SubscribeUserId != WebUserAuth.UserId && !isExist)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
                return;
            }
            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value);//投资人信息
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);
            this.publisherModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);//借款人信息
            this.SharesPercent = (publisherModel.NumberOfShares * 10000m / 100000000m * 100m).ToString("0.00");
            this.PrincipalInterest = submodel.Amount.Value + submodel.InterestAmount.Value;
            AssureModel = new Common.Contract().GetAssureOrganizationByProjectId(proModel.Id);
            //印章小图片
            this.AssureModel.image = new Common.Contract().GetSmallImage(this.AssureModel.image);
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
        }
    }
}