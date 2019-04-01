using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class invest_fail : System.Web.UI.Page
    {
        protected Guid projectId;
        /// <summary>
        /// 支付金额
        /// </summary>
        protected decimal PayMoney;
        /// <summary>
        /// 投资类型 project:投资普通标   weplan:投资we计划   
        /// </summary>
        protected string InvestType;
        /// <summary>
        /// 点击完成的url
        /// </summary>
        protected string FinishUrl;
        /// <summary>
        /// 继续投资url
        /// </summary>
        protected string GoOnUrl;
        /// <summary>
        /// 购买失败原因
        /// </summary>
        protected string errorMsg;
        protected void Page_Load(object sender, EventArgs e)
        {
            errorMsg = Request.QueryString["error"];
            var idStr = Request.QueryString["projectid"];
            if (!string.IsNullOrEmpty(idStr))
                projectId = Guid.Parse(idStr);
            else
                Response.Redirect("/pages/invest/invest_list.aspx");

            InvestType = Request.QueryString["investType"];

            var payMoneyStr = Request.QueryString["payMoney"];
            if (!string.IsNullOrEmpty(payMoneyStr))
                PayMoney = decimal.Parse(payMoneyStr);
            else
                Response.Redirect("/pages/invest/invest_list.aspx");

            if (InvestType == "project")
            {
                string sql = "select count(0) from Project with(nolock) where id=@id";
                Dapper.DynamicParameters para = new Dapper.DynamicParameters();
                para.Add("@id", projectId);
                var count = PublicConn.QuerySingle<int>(sql, ref para);
                if (count > 0)
                {
                    FinishUrl = "/pages/invest/detail.aspx?id=" + projectId;
                    GoOnUrl = "/pages/invest/invest_list.aspx";
                }
                else
                {
                    FinishUrl = "/pages/invest/zqzr_detail.aspx?projectid=" + projectId;
                    GoOnUrl = "/pages/invest/debt_list.aspx";
                } 
            }
            else
            {
                string sql = "select count(0) from we_product with(nolock) where id=@id and iswefqb = 1";
                Dapper.DynamicParameters para = new Dapper.DynamicParameters();
                para.Add("@id", projectId);
                var count = PublicConn.QuerySingle<int>(sql, ref para);
                if (count > 0)
                {
                    FinishUrl = "/pages/invest/WE/WeFqb_detail.aspx?id=" + projectId;
                }
                else
                {
                    FinishUrl = "/pages/invest/WE/WE_detail.aspx?id=" + projectId;
                }
                GoOnUrl = "/pages/invest/WE/WE_list.aspx";
            }
        }
    }
}