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
    /// We计划分期宝投资详情
    /// Allen 2016-01-25
    /// </summary>
    public partial class Wefqb_project : UserPage
    {
        protected Guid? weOrderId = Guid.Empty;
        protected WXInvestWeFQBDetail_Info model;
        protected string tab;
        protected WebSettingInfo SetModel;
        protected decimal DueInterestAmount = 0; //预期收益
        protected decimal RewardInterest = 0; //加息奖励利息
        protected decimal RewardRate = 0; //奖励加息利率
        /// <summary>
        /// 是否是we计划4周年庆
        /// </summary>
        protected bool IsWeZnq = false;
        /// <summary>
        /// 是否是Y7Z7
        /// </summary>
        protected bool IsY7Z7 = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            weOrderId = WEBRequest.GetGuid("weorderid");
            tab = WEBRequest.GetQueryString("tab");
            if (!IsPostBack)
            {
                SetModel = new WebSettingBLL().GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
                if (weOrderId == null || weOrderId == Guid.Empty) {
                    Response.Redirect("/Member/my_account.aspx");
                    return;
                }
                Guid? userId = WebUserAuth.UserId;
                WeOrderBLL webll = new WeOrderBLL();
                model = webll.GetMyInvestWeFQBBaseDetail(userId.Value, weOrderId.Value);   
                GetIsWeZnq();
            }
        }

        protected string GetWeFQBStatus()
        {
            switch (model.WeStatusId)
            {
                case 1:
                    return "匹配中";
                case 2:
                    return "持有中";
                case 3:
                    return "转让中";
                case 4:
                    return "已完成";
                case 5:
                    return "退出中"; 
            }
            return "投资中";
        }

        private void GetIsWeZnq()
        {
            Guid? userId = WebUserAuth.UserId;
            WeProductBLL bll = new WeProductBLL();
            WebSettingBLL setbll = new WebSettingBLL();
            //var weproduct = bll.GetWeProductInfo(model.ProductId);
            WeProductDetailInfo weproduct = null;
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                string err = string.Empty;
                var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(model.ProductId,
                    out err, TdConfig.ApplicationName);
                if (weRedisInfo != null)
                    weproduct = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                if (weproduct == null || !string.IsNullOrEmpty(err))
                    weproduct = new WeProductBLL().GetWeProductInfo(model.ProductId);
            }
            else
            {
                weproduct = new WeProductBLL().GetWeProductInfo(model.ProductId);
            }
            IsY7Z7 = weproduct.TypeWord.ToLower().Contains("y7") || weproduct.TypeWord.ToLower().Contains("z7");

            //查询订单加息
            RewardRate += GetOrderJxRate(weOrderId.Value, userId.Value);
            RewardInterest = GetInterest(model.AmountInvestment, model.Deadline, RewardRate);

            DueInterestAmount = model.DueInterestAmount + RewardInterest;
            if (RewardRate > 0) {
                IsWeZnq = true;
            }

            /*

            WebSettingInfo setInfo1 = setbll.GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
            WebSettingInfo setInfo2 = setbll.GetWebSettingInfo("06A6344D-E1FB-4AAA-890A-E39351D5E7A3");
            decimal rewardInterest_1 = 0, rewardInterest_2 = 0, rewardInterest_3 = 0;
            //查询预热期加息
            if (setInfo1 != null)
            {
                if (weproduct.StartDate.Value >= DateTime.Parse(setInfo1.Param1Value) && weproduct.StartDate.Value < DateTime.Parse(setInfo1.Param2Value))
                {
                    IsWeZnq = weproduct.TypeWord.ToLower().IsIn("p", "q", "r");
                    if (IsWeZnq)
                    {
                        RewardRate += decimal.Parse(setInfo1.Param3Value);
                        rewardInterest_1 = GetInterest(model.AmountInvestment, model.Deadline, decimal.Parse(setInfo1.Param3Value));
                    }
                }
            }
            //查询7.8号后加息
            if (setInfo2 != null)
            {
                if (weproduct.StartDate.Value >= DateTime.Parse(setInfo2.Param1Value) && weproduct.StartDate.Value < DateTime.Parse(setInfo2.Param2Value))
                {
                    IsWeZnq = true;
                    RewardRate += decimal.Parse(setInfo2.Param3Value);
                    rewardInterest_2 = GetInterest(model.AmountInvestment, model.Deadline, decimal.Parse(setInfo2.Param3Value));
                }
            }
            //查询定向加息
            string strSQL = "SELECT TOP 1 RedRate FROM dbo.UserAddInterest with(nolock) WHERE UserId=@UserId AND @OrderDate>=StartDate AND @OrderDate<EndDate AND @Deadline>=StartDeadline AND @Deadline<=EndDeadline order by RedRate desc";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userId);
            dyParams.Add("@Deadline", model.Deadline);
            dyParams.Add("@OrderDate", weproduct.StartDate.Value);
            decimal? specialRate = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal?>(TdConfig.DBRead, strSQL, ref dyParams);
            if (specialRate.HasValue && specialRate.Value > 0)
            {
                IsWeZnq = true;
                RewardRate += specialRate.Value;
                rewardInterest_3 = GetInterest(model.AmountInvestment, model.Deadline, specialRate.Value);
            }
            RewardInterest = rewardInterest_1 + rewardInterest_2 + rewardInterest_3;
            DueInterestAmount = model.DueInterestAmount + RewardInterest;
             */ 
        }
        /// <summary>
        /// 获取订单加息的利率
        /// </summary>
        /// <param name="orderid"></param>
        /// <returns></returns>
        private decimal GetOrderJxRate(Guid orderid, Guid userid)
        {
            string sql = @"select TuandaiRedRate+isnull(R.RatePercent,0) from dbo.We_Order W
                            left join dbo.RateCoupon20151226 R on W.Id=R.OrderId 
                            where  W.UserId=@UserId and  W.Id=@OrderId";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userid);
            dyParams.Add("@OrderId", orderid); 
            return TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal?>(TdConfig.DBRead, sql, ref dyParams) ?? 0;
        }
        protected decimal GetInterest(decimal investAmount,int deadLine,decimal yearRate) {
            if (investAmount == 0)
                return 0;
            return investAmount * yearRate * decimal.Parse("0.01") * deadLine / 12;
        } 
    }
}