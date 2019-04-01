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
using System.Data.SqlClient;

namespace TuanDai.WXApiWeb.Contract
{
    public partial class contractZqzr : AppActivityBasePage
    { 
        /// <summary>
        /// 合同编号
        /// </summary>
        protected string key;
        /// <summary>
        /// 项目类型
        /// </summary>
        protected int type = 1;
        /// <summary>
        /// 标信息
        /// </summary>
        protected ProjectDetailInfo proModel;
        /// <summary>
        /// 申购表
        /// </summary>
        protected SubscribeInfo submodel;

        /// <summary>
        /// 转让人的申购记录
        /// </summary>
        protected SubscribeInfo mSubscribe;

        /// <summary>
        /// 获取承接人信息
        /// </summary>
        protected UserBasicInfoInfo subBasicModel;
        /// <summary>
        /// 获取转让人信息
        /// </summary>
        protected UserBasicInfoInfo publisherModel;

        /// <summary>
        /// 借款人信息
        /// </summary>
        protected UserBasicInfoInfo borrowModel;

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
            if (userId==null||userId==Guid.Empty)
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
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);

            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value);//获取承接人信息  

            string strSQL = " Select top 1 * From t_SubScribeTransfer with(nolock) Where m_Id=@m_Id ";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@m_Id", submodel.TranId);
            t_SubScribeTransferInfo mSubScribeTransfer = PublicConn.QuerySingle<t_SubScribeTransferInfo>(strSQL, ref dyParams);
             
            mSubscribe = new SubscribeBLL().GetSubscribeById(mSubScribeTransfer.m_FromSubscribeId);

               
            if (this.mSubscribe.SubscribeUserId != WebUserAuth.UserId && this.submodel.SubscribeUserId != WebUserAuth.UserId)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
            } 

            this.publisherModel = userbll.GetUserBasicInfoModelById(mSubscribe.SubscribeUserId.Value);//获取转让人信息  

            this.borrowModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);

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

        /// <summary>
        /// 传入开始时间与月份获取最后还款时间
        /// </summary>
        /// <param name="starTime">开始时间</param>
        /// <param name="month">月份</param>
        /// <param name="repaymentType">还款方式</param>
        /// <returns></returns>
        public DateTime GetEndTime(DateTime starTime, int month, int repaymentType)
        {
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@StarTime", starTime);
            dyParams.Add("@Month", month);
            dyParams.Add("@RepaymentType", repaymentType);
            string strSQL = "SELECT dbo.f_GetMaxRepayment_Date(@StarTime,@month,@RepaymentType)";
            return PublicConn.QuerySingle<DateTime>(strSQL, ref dyParams);
        }
        #endregion
    }
}