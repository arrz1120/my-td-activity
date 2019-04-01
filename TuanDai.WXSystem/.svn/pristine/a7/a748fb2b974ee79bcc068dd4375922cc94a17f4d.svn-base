using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kamsoft.Data.DapperExtensions;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using BusinessDll;
using Kamsoft.Data.Dapper;
using System.Data.SqlClient;

namespace TuanDai.WXApiWeb.Contract
{
    public partial class ContractType100 : AppActivityBasePage
    {
        protected string key;//合同编号
        protected int type;
        protected MyWeOrderInfo model;
        protected UserBasicInfoInfo subBasicModel;//申购人   
        protected DateTime finishDate = DateTime.Now;//回购日期 
        protected string strCompanyName = "广东俊特团贷网络信息服务股份有限公司";
        protected List<WeRedemptionInfo> RateList; 
         protected string Sealt_TuanDai = "images/tuandai_s.png";
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

            userbll = new UserBLL();
            if (Request["key"] != null)
            {
                this.key = Request.QueryString["key"];
            }
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
            string strSQL = @"SELECT a.ProductName, a.PlanAmount,a.ProjectTypes,a.Deadline,b.RepeatInvestType,
                b.YearRate, b.MinYearRate, a.StartDate,a.UnitAmount, b.Amount as JoinAmount, b.OrderQty,
                b.UserId, b.OrderDate,c.TypeWord
                FROM dbo.We_Product a WITH(NOLOCK)
                left JOIN dbo.We_Order b WITH(NOLOCK) on b.ProductId=a.Id
                INNER JOIN dbo.We_ProductType c WITH(NOLOCK) ON a.ProductTypeId = c.Id
                WHERE b.Id=@WeOrderId";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@WeOrderId", contactno);
            model = PublicConn.QuerySingle<MyWeOrderInfo>(strSQL, ref dyParams);
            if (model == null)
            {
                model = new MyWeOrderInfo();
            }
            this.subBasicModel = userbll.GetUserBasicInfoModelById(model.UserId);
            if (model.OrderDate >= DateTime.Parse("2016-03-11"))
            {
                strCompanyName = "东莞团贷网互联网科技服务有限公司";
                Sealt_TuanDai = "images/tuandai_ss.png";
            }

            //this.subBasicModel.RealName = StringHandler.MaskStartPre(subBasicModel.RealName, 1);//出借人
            //this.subBasicModel.IdentityCard = StringHandler.MaskCardNo(subBasicModel.IdentityCard);//出借人身份证号
            this.GetRedemptionRate();
        }
        //查询赎回费用
        protected void GetRedemptionRate()
        {
            string strSQL = @" SELECT  MonthStart, MonthEnd, CostRate  FROM We_Redemption  with(NoLock) ORDER BY  MonthStart ";
            var para = new Dapper.DynamicParameters();
            RateList = PublicConn.QueryBySql<WeRedemptionInfo>(strSQL, ref para);
        }
        /// <summary>
        /// 获取投标范围
        /// </summary>
        protected string GetInvestRange(string range)
        {
            if (range == "24,25")
            {
                return "分期宝";
            }
            else
            {
                string result = "";
                string[] arrRange = range.Split(',');
                for (int i = 0; i < arrRange.Length; i++)
                {
                    if ("1,3,".IndexOf(arrRange[i] + ",") != -1 && result.IndexOf("小微企业") == -1)
                    {
                        result += "小微企业,";
                    }
                    if ("9,10,11,".IndexOf(arrRange[i] + ",") != -1 && result.IndexOf("微团贷") == -1)
                    {
                        result += "微团贷,";
                    }
                    if ("15,24,25,27,28,".IndexOf(arrRange[i] + ",") != -1 && result.IndexOf("分期宝") == -1)
                    {
                        result += "分期宝,";
                    }
                    if ("6,7,".IndexOf(arrRange[i] + ",") != -1 && result.IndexOf("资产标") == -1)
                    {
                        result += "资产标,";
                    }
                    if ((arrRange[i] == "19" || arrRange[i] == "20") && result.IndexOf("供应链") == -1)
                    {
                        result += "供应链,";
                    }
                }
                if (result != "")
                    result = result.Substring(0, result.Length - 1);
                return result;
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

            public string TypeWord { get; set; }
        }
        //赎回费用对象
        public class WeRedemptionInfo
        {
            public int MonthStart { get; set; }
            public int MonthEnd { get; set; }
            public decimal CostRate { get; set; }
        }
    }
}