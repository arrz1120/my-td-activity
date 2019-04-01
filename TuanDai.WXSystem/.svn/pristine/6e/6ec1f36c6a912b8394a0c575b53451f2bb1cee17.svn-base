using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Contract
{
    public partial class contractFTB : AppActivityBasePage
    {
        protected UserBLL userbll = new UserBLL();
        protected ProjectBLL probll = new ProjectBLL();

        protected string key;//合同编号
        protected int type;
        protected MyWeOrderInfo model;
        protected UserBasicInfoInfo subBasicModel;//申购人   
        protected DateTime finishDate = DateTime.Now;//回购日期 
        protected string strCompanyName = "东莞团贷网互联网科技服务有限公司";
        protected string Sealt_TuanDai = "//js.tuandai.com/images/member/contract/newtuandai_s.png";
        protected List<WeProductFTBRateInfo> ftbRateList;

        protected void Page_Load(object sender, EventArgs e)
        {
            //验证登录
            if (!WebUserAuth.IsAuthenticated)
            {
                HttpContext.Current.Response.Write("对不起，您没有权限查看此合同。");
                HttpContext.Current.Response.End();
            }


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
                             b.UserId, b.OrderDate, c.TypeWord, a.ProductTypeId,a.ExitLockMonth
                             FROM dbo.We_Product a WITH(NOLOCK)
                             left JOIN dbo.We_Order b WITH(NOLOCK) on b.ProductId=a.Id
                             inner join We_ProductType c  WITH(NOLOCK) on c.Id=a.ProductTypeId
                             WHERE b.Id=@WeOrderId";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@WeOrderId", contactno);
            model = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<MyWeOrderInfo>(TdConfig.ApplicationName,TdConfig.DBRead, strSQL, ref dyParams);
            if (model == null)
            {
                model = new MyWeOrderInfo();
            }

            this.subBasicModel = userbll.GetUserBasicInfoModelById(model.UserId);

            WeFTBBLL ftbll = new WeFTBBLL();
            ftbRateList = this.GetWeFTBRateList(model.ProductTypeId,model.StartDate??DateTime.Today);
            if (ftbRateList == null)
                ftbRateList = new List<WeProductFTBRateInfo>();

        }

        /// <summary>
        /// 获取某类复投宝的利率设置
        /// </summary>
        /// <param name="productTypeId">产品类型Id</param>
        /// <returns></returns>
        public List<WeProductFTBRateInfo> GetWeFTBRateList(int productTypeId, DateTime publisherDate)
        {
            string strSQL = "select * from We_ProductFTBRate where ProductTypeId=@typeId and ( (@publisherDate between StartDate and EndDate) or  StartDate is null) order by MonthType";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@typeId", productTypeId);
            dyParams.Add("@publisherDate", publisherDate);
            return PublicConn.QueryBySql<WeProductFTBRateInfo>(strSQL, ref dyParams);
        }

        protected string GetRepaymentTypeStr()
        {
            return "到期本息";
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
                    if ("20,".IndexOf(arrRange[i] + ",") != -1 && result.IndexOf("供应链") == -1)
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
            public int ProductTypeId { get; set; }
            public int ExitLockMonth { get; set; }

            public int? DeadType { get; set; }
        } 
    }
}