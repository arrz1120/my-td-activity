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
    public partial class contractType17 : AppActivityBasePage 
    {
        protected ProjectBLL projectbll = new ProjectBLL();
        protected UserBLL userbll = new UserBLL();
        protected SubscribeInfo submodel;
        /// <summary>
        /// 公司名称
        /// </summary>
        protected string companyName = "";
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

            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            param = new Dapper.DynamicParameters();
            param.Add("@projectId", submodel.ProjectId);
            param.Add("@curUserId", WebUserAuth.UserId);
            string strSQL = "select Count(1) from project where Id=@projectId and UserId=@curUserId";
            bool isExist = PublicConn.QuerySingle<int>(strSQL, ref param)> 0;

            if (this.submodel.SubscribeUserId != WebUserAuth.UserId && !isExist)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
                return;
            }
            
        }
    }
}