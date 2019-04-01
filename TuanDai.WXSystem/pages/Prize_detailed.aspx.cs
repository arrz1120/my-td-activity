using Dapper;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.pages
{
    /// <summary>
    /// 奖品详情页
    /// </summary>
    public partial class Prize_detailed : BasePage
    {
        /// <summary>
        ///获取传递的奖品明细ID
        /// </summary>
        private string PrizeId = "";
        /// <summary>
        /// 页面显示实体
        /// </summary>
        protected dynamic Model = new System.Dynamic.ExpandoObject();

        #region Page_Load
        protected void Page_Load(object sender, EventArgs e)
        {

            PrizeId = WEBRequest.GetQueryString("id");
            if (PrizeId.ToText().IsEmpty())
            {
                Model = null;
                return;
            }
            if (!IsPostBack)
            {
                if (!GetPrizeDetail())
                {
                    Model = null;
                    return;
                }
            }
        }
        #endregion

        #region 获取奖品详情
        /// <summary>
        /// 获取奖品详情
        /// </summary>
        /// <returns></returns>
        private bool GetPrizeDetail()
        {
            var dyParams = new DynamicParameters();

            string strSQL = string.Format(@"SELECT Id,SKU,ProductName,ActivityName,ISNULL(ActivityUrl,'') ActivityUrl,
                                                    MarketPrice,ISNULL(Remark,'') Remark,ImageUrl,Description,
                                                    CreateDate,SortOrder,
                                                    CASE Upselling WHEN 1 THEN '已上架'
                                                    ELSE '已下架' END  as Upselling
                                                    FROM Mall_Product with(nolock) WHERE 1=1 AND Id=@Id

                                                    SELECT TOP 15 ProductName,ImageUrl FROM Mall_Product WHERE Upselling=1 
                                                    AND Id NOT IN (@Id)
                                                    ORDER BY SortOrder,CreateDate DESC ");
            dyParams.Add("@Id", PrizeId);
            var _PrizeModels = PublicConn.QuerySingle<Mall_ProductInfo>(strSQL, ref dyParams);
            var _OtherPrizeModels = PublicConn.QueryBySql<Mall_ProductImage>(strSQL, ref dyParams); 

            if (_PrizeModels == null)
            {
                return false;
            }
            else
            {
                Model.ImageUrl = _PrizeModels.ImageUrl;
                Model.ProductName = _PrizeModels.ProductName;
                Model.MarketPrice = _PrizeModels.MarketPrice == null ? "0.00" : Convert.ToString(_PrizeModels.MarketPrice);
                Model.Remark = _PrizeModels.Remark;
                Model.ActivityName = _PrizeModels.ActivityName;
                Model.ActivityUrl = _PrizeModels.ActivityUrl;
                Model.Description = _PrizeModels.Description;
                if (_OtherPrizeModels != null && _OtherPrizeModels.Count() > 0)
                {
                    Model.OtherPrizes = _OtherPrizeModels;
                }
                else
                {
                    Model.OtherPrizes = null;
                }
                return true;
            }
        }
        #endregion

        #region 内部Model
        public class Mall_ProductImage
        {
            public string ProductName { get; set; }
            public string ImageUrl { get; set; }
        }
        public class Mall_ProductInfo
        {
            public Guid Id { get; set; }
            public string SKU { get; set; }
            public string ProductName { get; set; }
            public string ActivityName { get; set; }
            public string ActivityUrl { get; set; }
            public decimal? MarketPrice { get; set; }
            public string Remark { get; set; }
            public string ImageUrl { get; set; }
            public string Description { get; set; }
            public DateTime CreateDate { get; set; }
            public int? SortOrder { get; set; }
            public string Upselling { get; set; }
        }
        #endregion

    } 
}
     