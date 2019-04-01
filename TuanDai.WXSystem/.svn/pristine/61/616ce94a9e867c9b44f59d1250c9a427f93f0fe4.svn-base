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
    public partial class WePlanServiceContract :AppActivityBasePage 
    {

        public class MyWeOrderInfo
        {

            public Guid UserId { get; set; }
            public string ProductName { get; set; }
            public decimal PlanAmount { get; set; }
            public string ProjectTypes { get; set; }
            public int Deadline { get; set; }
            public int RepeatInvestType { get; set; }
            public decimal YearRate { get; set; }
            public decimal MinYearRate { get; set; }
            public DateTime? StartDate { get; set; }
            public DateTime OrderDate { get; set; }
            public decimal UnitAmount { get; set; }
            public decimal JoinAmount { get; set; }
            public int OrderQty { get; set; }

            public Guid ProductId { get; set; }
        }

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
        /// 投资人信息
        /// </summary>
        protected UserBasicInfoInfo subBasicModel = new UserBasicInfoInfo();
        /// <summary>
        /// 借款人信息
        /// </summary>
        protected UserBasicInfoInfo publisherModel;

        protected string RepaymentTypeDesc = string.Empty;

        protected MyWeOrderInfo WeOrder = new MyWeOrderInfo();

        protected string companyName = "广东俊特团贷网络信息服务股份有限公司";
        protected string Sealt_TuanDai = "images/tuandai_s.png";

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
                    this.GetContractInfo();
                }
                else
                {
                    Response.Redirect("/");
                }
            }
        }

        private void GetContractInfo()
        {
            string strSQL = @"SELECT a.Id as ProductId,a.ProductName, a.PlanAmount,a.ProjectTypes,a.Deadline,b.RepeatInvestType,
                             b.YearRate, b.MinYearRate, a.StartDate,a.UnitAmount, b.Amount as JoinAmount, b.OrderQty,
                             b.UserId, b.OrderDate
                             FROM dbo.We_Product a WITH(NOLOCK)
                             left JOIN dbo.We_Order b WITH(NOLOCK) on b.ProductId=a.Id
                             WHERE b.Id=@WeOrderId";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@WeOrderId", Key);
            List<MyWeOrderInfo> list = new List<MyWeOrderInfo>();
            list = PublicConn.QueryBySql<MyWeOrderInfo>(strSQL, ref dyParams);
            WeOrder = list.Count > 0 ? list[0] : new MyWeOrderInfo();
            if (WeOrder.OrderDate >= DateTime.Parse("2016-03-11"))
            {
                companyName = "东莞团贷网互联网科技服务有限公司";
                Sealt_TuanDai = "images/tuandai_ss.png";
            }
            
            this.subBasicModel = userbll.GetUserBasicInfoModelById(WeOrder.UserId);//投资人信息
            switch (GetTypeWord(WeOrder.ProductId).ToLower())
            {
                case "b":
                case "c":
                    RepaymentTypeDesc = "每月付息";
                    break;
                case "a":
                    RepaymentTypeDesc = "每月付息或到期本息";
                    break;
            } 
        }

        private string GetTypeWord(Guid productId) 
        {
            string sql = @"select b.TypeWord from dbo.We_Product a
                           left join We_ProductType b on b.Id =a.ProductTypeId
                           where a.Id=@id";
            var whereParams = new Dapper.DynamicParameters();
            whereParams.Add("@id", productId);
            List<string> list = new List<string>();

            list = PublicConn.QueryBySql<string>(sql, ref whereParams);
                
            return list.Count > 0 ? list[0] : string.Empty;
        }
        protected string GetInvestRange(string range)
        {
            List<string> list = range.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
            string result=string.Empty;
            list.ForEach(x =>
            {
                if (x == "1")
                {
                    result += ",项目标";
                }
                if (x == "9")
                {
                    result = result + ",微团贷";
                }
                if (x == "6")
                {
                    result = result + ",资产标";
                }
                if (x == "17")
                {
                    result = result + ",证卷宝";
                }
                if (x == "15" || x == "24" || x == "25")
                {
                    if (result.IndexOf("分期宝") < 0)
                        result = result + ",分期宝";
                }
                if (x == "22")
                {
                    result = result + ",项目宝B";
                }
                if (x == "23")
                {
                    result = result + ",项目宝A";
                }
                if (x == "18")
                {
                    result = result + ",私募宝";
                }
            });
            return result.Substring(1);

        }
    }
}