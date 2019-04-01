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
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Contract
{
    public partial class contractType19 : AppActivityBasePage
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
        protected ProjectBLL projectbll = new ProjectBLL();
        protected UserBLL userbll = new UserBLL();
        protected string DanBaoCompany = "东莞市江辉非融资性担保有限公司";
        protected string DanBaoImage = "http://image.tuandai.com/EnterpriseImage/hetongzhang/jianghuinew.png";

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


            this.subBasicModel = userbll.GetUserBasicInfoModelById(submodel.SubscribeUserId.Value);//投资人信息
            this.proModel = projectbll.GetProjectDetailInfo(submodel.ProjectId.Value);
            this.publisherModel = userbll.GetUserBasicInfoModelById(proModel.UserId.Value);//借款人信息

            WebSettingInfo gylSet = new WebSettingBLL().GetWebSettingInfo("75F593E2-40FF-4777-A6F8-4ED54D39FF70");
            if (gylSet.Param2Value.IsEmpty())
                gylSet.Param2Value = "2017-02-10";
            if (proModel.AddDate >= DateTime.Parse(gylSet.Param2Value))
            {
                DanBaoCompany = "东莞市志诚非融资性担保有限公司";
                DanBaoImage = "http://image.tuandai.com/User/UserUpload/201508/20150825145522_3283.png";
            }

            //印章小图片
            //this.AssureModel.image = new Common.Contract().GetSmallImage(this.AssureModel.image);

            RepaymentTypeDesc = this.GetRepaymentTypeDesc(proModel.RepaymentType ?? 0);

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
        protected string GetRepaymentTypeDesc(int repaymentType)
        {
            string repaymentTypeDesc = string.Empty;

            if (repaymentType == 1)
            {
                repaymentTypeDesc = "乙方须借款到期一次性归还全部借款本金及利息";
            }
            else if (repaymentType == 2)
            {
                repaymentTypeDesc = "乙方须每月付息一次，借款到期一次性归还全部借款本金及剩余部分利息";
            }
            else if (repaymentType == 4)
            {
                repaymentTypeDesc = "乙方须出借时支付利息，借款到期一次性归还全部借款本金";
            }
            else
            {
                repaymentTypeDesc = ToolStatus.ConvertRepaymentType(repaymentType);
            } 
            return repaymentTypeDesc;
        }


    }
}