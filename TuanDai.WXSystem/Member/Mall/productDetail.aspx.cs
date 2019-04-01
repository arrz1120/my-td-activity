using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class productDetail : AppActivityBasePage
    {
        /// <summary>
        /// 商品
        /// </summary>
        public MVipProduct VipProduct;
        /// <summary>
        /// 当前商品的SKU最新价格
        /// </summary>   
        public int CurrSkuPriceValue;

        public Dictionary<KeyValuePair<Guid, string>, List<AttrValues>> Attrs = new Dictionary<KeyValuePair<Guid, string>, List<AttrValues>>();

        public string AttributesJson;

        protected bool IsExchangeHF=false;
        protected bool IsExchangeFlow = false;

        //特价商品
        protected bool IsJoinBuying = false;
        protected MVipScareBuying BuyingProduct = null;
        protected string LeftHour = string.Empty;    //剩余小时
        protected string LeftMinute = string.Empty;  //剩余分
        protected string LeftSecond = string.Empty;  //剩余秒

        //每天每种商品限制兑换次数
        protected int LimitNum = 0;
        //最低兑换等级
        protected int LeastLevel = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            Guid pId = WEBRequest.GetGuid("Id");
            if (pId==Guid.Empty)
                Response.Redirect("productList.aspx");

            //根据prodectid获取商品详情
            this.VipProduct = MVipProductBLL.GetVipProductDetail(pId);
            CurrSkuPriceValue = VipProduct.ProductValues.Where(en => VipProduct.SkuId == en.SkuId).FirstOrDefault().PriceValue;
            if (this.VipProduct.ProductValues != null && this.VipProduct.ProductValues.Any())
            {
                var attrs = this.VipProduct.ProductValues.GroupBy(g => new { AttributeId = g.AttributeId, AttributeName = g.AttributeName });
                var DefSKU = this.VipProduct.ProductValues.Where(a => a.SkuId == this.VipProduct.SkuId).GroupBy(b => b.ValueId).Select(c => c.Key).ToList();
                foreach (var attr in attrs)
                {
                    if (attr.Key.AttributeId != null && attr.Key.AttributeId != Guid.Empty)
                    {
                        //添加属性值
                        var key = new KeyValuePair<Guid, string>(attr.Key.AttributeId, attr.Key.AttributeName);
                        var values = this.VipProduct.ProductValues.Where(a => a.AttributeId == attr.Key.AttributeId).GroupBy(b => new
                        {
                            ValueId = b.ValueId,
                            ValueStr = b.ValueStr
                        }).Select(en => new AttrValues
                        {
                            ValueId = en.Key.ValueId,
                            ValueStr = en.Key.ValueStr,
                            IsDefault = false//DefSKU.Contains(en.Key.ValueId)
                        }).ToList();
                        if (values.Count > 0)
                        {
                            Attrs.Add(key, values);
                        }
                    }
                    AttributesJson = JsonConvert.SerializeObject(this.VipProduct.ProductValues);
                }
            }

            if (VipProduct.SubType == 22 && VipProduct.Type == 1)
            {
                GetIsExchangeHF(pId.ToString());
            }
            else if (VipProduct.SubType == 25 && VipProduct.Type == 1)
            {
                GetIsExchangeFlow();
            }

            //获取特价商品详情
            GetScareBuyingProduct(pId.ToString());

            GetLimitNum();
        }
        //不再使用以前的那个拼接方式的方法，防止漏洞注入
        //查询今天是否已经兑换过
        private void GetIsExchangeHF(string productId)
        {
            IsExchangeHF = IsExchangeProduct(22);
        }

        //查询今天是否已经兑换过流量包
        private void GetIsExchangeFlow()
        {
            IsExchangeFlow = IsExchangeProduct(25);
        }

        private bool IsExchangeProduct(int type)
        {
            //每天限制为白天08：00-22：00  
            if ((DateTime.Now.Hour < 8 || DateTime.Now.Hour >= 22))
            {
                return true;
            }
            if (!WebUserAuth.UserId.HasValue || WebUserAuth.UserId.Value == Guid.Empty)
            {
                return false;
            }
            string sqlText = " select top 1 *from dbo.MVipExchangeHistory(nolock) where SubType=@subType and UserId=@userId order by AddDate desc";
            var param = new Dapper.DynamicParameters();
            param.Add("@userId", WebUserAuth.UserId.Value);
            param.Add("@subType", type);
            List<MVipExchangeHistory> list = TuanDai.DB.TuanDaiDB.Query<MVipExchangeHistory>(TdConfig.ApplicationName, TdConfig.DBVipWrite, sqlText, ref param);
            if (list != null && list.Count >= 1)
            {
                DateTime exTime = list[0].AddDate;
                if (exTime.Date == DateTime.Now.Date)  //当天有兑换过
                {
                    return true;
                }
            }
            return false;
        }

        //获取特价状态
        private void GetScareBuyingProduct(string productId)
        {
            Guid g;
            if (!Guid.TryParse(productId, out g))
            {
                return;
            }
            BuyingProduct = new MVipScareBuyingBLL().GetBuyingModel(g);
            if (BuyingProduct != null && BuyingProduct.IsJoin.HasValue && BuyingProduct.IsJoin.Value)
            {                
                //如果结束时间已过，则修改特价状态为不再加入特价状态
                if ( BuyingProduct.BuyingEndDate < DateTime.Now)
                {
                    if (!BuyingProduct.IsDone)
                    {
                        BuyingProduct.DoneDate = DateTime.Now;
                        BuyingProduct.IsDone = true;
                        BuyingProduct.IsJoin = null;
                        new MVipScareBuyingBLL().UpdateBuyingModel(BuyingProduct);
                    }
                    return;
                }

                if (!BuyingProduct.IsDone && BuyingProduct.BuyingEndDate > DateTime.Now)
                {
                    IsJoinBuying = true;
                }


                if (BuyingProduct.BuyingStartDate > DateTime.Now)
                {
                    TimeSpan leftTime = BuyingProduct.BuyingStartDate - DateTime.Now;
                    LeftHour = (leftTime.Days * 24 + leftTime.Hours) >= 10 ? (leftTime.Days * 24 + leftTime.Hours).ToString() : "0" + (leftTime.Days * 24 + leftTime.Hours).ToString();
                    LeftMinute = leftTime.Minutes >= 10 ? leftTime.Minutes.ToString() : "0" + leftTime.Minutes.ToString();
                    LeftSecond = leftTime.Seconds >= 10 ? leftTime.Seconds.ToString() : "0" + leftTime.Seconds.ToString();
                }
                else
                {
                    TimeSpan leftTime = BuyingProduct.BuyingEndDate - DateTime.Now;
                    LeftHour = (leftTime.Days * 24 + leftTime.Hours) >= 10 ? (leftTime.Days * 24 + leftTime.Hours).ToString() : "0" + (leftTime.Days * 24 + leftTime.Hours).ToString();
                    LeftMinute = leftTime.Minutes >= 10 ? leftTime.Minutes.ToString() : "0" + leftTime.Minutes.ToString();
                    LeftSecond = leftTime.Seconds >= 10 ? leftTime.Seconds.ToString() : "0" + leftTime.Seconds.ToString();
                }
            }
        }

        //获取每种商品每天的个人的最大兑换数量
        private void GetLimitNum()
        {
            string id = Context.Request.QueryString["id"];
            string sql = " select @LimitNum=LimitNum,@IsLimitNum=IsLimitNum,@LeastLevel=LeastLevel,@IsLeastLevel=IsLeastLevel from dbo.MVipProductConfigure where ProductId=@productId ";
            var param = new Dapper.DynamicParameters();
            param.Add("@LimitNum", 0, DbType.Int32, ParameterDirection.Output);
            param.Add("@IsLimitNum", 0, DbType.Boolean, ParameterDirection.Output);
            param.Add("@LeastLevel", 0, DbType.Int32, ParameterDirection.Output);
            param.Add("@IsLeastLevel", 0, DbType.Boolean, ParameterDirection.Output);
            param.Add("@productId", id);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql, ref param);
            bool isLimitNum = param.Get<bool?>("@IsLimitNum").HasValue ? param.Get<bool>("@IsLimitNum") : false;
            if (isLimitNum)
            {
                LimitNum = param.Get<int?>("@LimitNum").HasValue ? param.Get<int>("@LimitNum") : 0;
            }
            bool isLeastLevel = param.Get<bool?>("@IsLeastLevel").HasValue ? param.Get<bool>("@IsLeastLevel") : false;
            if (isLeastLevel)
            {
                LeastLevel = param.Get<int?>("@LeastLevel").HasValue ? param.Get<int>("@LeastLevel") : 1;
            }
        }
        
    }

    public class AttrValues
    {
        public Guid ValueId { get; set; }
        public string ValueStr { get; set; }
        public bool IsDefault { get; set; }
    }
}