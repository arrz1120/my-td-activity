using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// We计划投资列表
    /// Allen 2015-09-24
    /// </summary>
    public partial class We_project : UserPage
    {
        protected Guid? weOrderId = Guid.Empty;
        protected string tab;
        protected WeProductDetailInfo model = null;
        protected WebSettingInfo SetModel;
        protected decimal DueInterestAmount = 0; //预期收益
        protected decimal RewardInterest = 0; //加息奖励利息
        protected decimal RewardRate = 0; //奖励加息利率

        /// <summary>
        /// 是否是we计划4周年庆
        /// </summary>
        protected bool IsWeZnq = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            weOrderId = WEBRequest.GetGuid("weorderid");
            tab = WEBRequest.GetQueryString("tab");
            if (!IsPostBack) {
                SetModel = new WebSettingBLL().GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
                LoadData();
            }
        }

        protected void LoadData()
        {
            Guid? userId = WebUserAuth.UserId;
            WeProductBLL bll = new WeProductBLL();
            WebSettingBLL setbll = new WebSettingBLL();
            WebSettingInfo setInfo1 = setbll.GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
            WebSettingInfo setInfo2 = setbll.GetWebSettingInfo("06A6344D-E1FB-4AAA-890A-E39351D5E7A3");
            decimal rewardInterest_1 = 0;

            string strSQL = "select ProductId, OrderDate, isnull(InvestedAmount,0) as InvestedAmount, isnull(TuandaiRedRate,0) as TuandaiRedRate  from dbo.We_Order with(nolock) where Id=@weOrderId";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@weOrderId", weOrderId);
            MyWePlanOrderInfo weOrderInfo = PublicConn.QuerySingle<MyWePlanOrderInfo>(strSQL, ref dyParams);
            //model = bll.GetWeProductInfo(weOrderInfo.ProductId);
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                string err = string.Empty;
                var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(weOrderInfo.ProductId,
                    out err, TdConfig.ApplicationName);
                if (weRedisInfo != null)
                    model = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                if (model == null || !string.IsNullOrEmpty(err))
                    model = new WeProductBLL().GetWeProductInfo(weOrderInfo.ProductId);
            }
            else
            {
                model = new WeProductBLL().GetWeProductInfo(weOrderInfo.ProductId);
            }
            DueInterestAmount = 0;

            //查询订单加息
            RewardRate += GetOrderJxRate(weOrderInfo.TuandaiRedRate, weOrderId.Value, userId.Value);

            rewardInterest_1 = GetInterest(weOrderInfo.InvestedAmount, model.Deadline ?? 0, GetOrderJxRate(weOrderInfo.TuandaiRedRate, weOrderId.Value, userId.Value));
            RewardInterest = rewardInterest_1;
            DueInterestAmount = GetInterest(weOrderInfo.InvestedAmount, model.Deadline ?? 0, model.YearRate ?? 0);
            DueInterestAmount += RewardInterest;
        }
        /// <summary>
        /// 获取订单加息的利率
        /// </summary>
        /// <param name="orderid"></param>
        /// <returns></returns>
        private decimal GetOrderJxRate(decimal tuandaiRate,Guid orderid, Guid userid)
        {
            if (tuandaiRate > 0)
            {
                return tuandaiRate;
            }
            else
            {
                string sql = "SELECT RatePercent FROM RateCoupon20151226 with(nolock) WHERE UserId=@UserId AND OrderId=@OrderId";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@UserId", userid);
                dyParams.Add("@OrderId", orderid);
                return   PublicConn.QuerySingle<decimal?>(sql, ref dyParams) ?? 0;
            }
        }

        protected decimal GetInterest(decimal investAmount, int deadLine, decimal yearRate)
        {
            if (investAmount == 0)
                return 0;
            return investAmount * yearRate * decimal.Parse("0.01") * deadLine / 12;
        } 
        public class MyWePlanOrderInfo {
            public Guid ProductId { get; set; }
            public DateTime OrderDate { get; set; }
            public decimal InvestedAmount { get; set; }

            public decimal TuandaiRedRate { get; set; } 
        }
    }
}