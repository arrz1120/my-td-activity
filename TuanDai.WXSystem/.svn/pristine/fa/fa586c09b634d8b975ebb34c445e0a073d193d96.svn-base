using BusinessDll;
using Dapper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.DQSystemAPI.Client;
using TuanDai.DQSystemAPI.Contract;
using Tuandai.Redis;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Redis;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.pages.aboutus
{
    public partial class BigData : AppActivityBasePage
    {
        #region 自定义变量
        protected decimal Amount;          //用户投资总额
        protected int UserCount;           //注册用户数量
        protected decimal EarnedInterest;  //投资人已赚取收益
        protected decimal TodayAmount;     //今日交易额
        protected List<InvestDayReport> ReportList;  //近期交易金额
        protected decimal BabyPlanAmount = 0;//质量保障服务风险保证金
        protected DateTime BabyPlanReportDate;
        protected string IsRedis = "";
        protected decimal AvgInvestMoney = 0;//人均投资
        protected MaxSignDaysUser SignDaysUser;//最高连续签到
        protected MaxInvestAgeUser InvestAgeUser;//投龄最长
        protected MaxInvestUser _MaxInvestUser;
        protected MaxIncomeUser _MaxIncomeUser;

        //****************计算时间变量
        /// <summary>
        /// 上线时间
        /// </summary>
        private DateTime onLineDate = DateTime.Parse("2012-07-15");
        /// <summary>
        /// 去年1月1号日期
        /// </summary>
        private DateTime lastYearDate = Convert.ToDateTime(DateTime.Now.AddYears(-1).ToString("yyyy") + "-01-01");
        /// <summary>
        /// 前8天第一天
        /// </summary>
        private static DateTime lastWeekDate = DateTime.Now.AddDays(-7);

        public int Year = 3;//已运行年数
        public int Day = 0;//已运行天数
        public int Hour = 0;//已运行小时数
        public bool IsLogin = false;
        public bool IsApp = false;

        public static string NowYear = string.Empty;
        public static string LastYear = string.Empty;
        private static string Path = "/redis/PCRedis";
        public int OnlineTotalDays = 0;

        //**************end****************** 

        #endregion


        public void UpdateSystemRunTime()
        {
            var today = DateTime.Now;
            if (int.Parse(onLineDate.ToString("MMdd")) > int.Parse(today.ToString("MMdd")))//当上线日期大于当前日期
            {
                Year = int.Parse(today.ToString("yyyy")) - int.Parse(onLineDate.ToString("yyyy")) - 1;//已运行年数 = 当前年 - 上线年 -1
                Day = new DateTime(today.Ticks).Subtract(new DateTime(DateTime.Parse((int.Parse(today.ToString("yyyy")) - 1) + onLineDate.ToString("-MM-dd")).Ticks)).Days;//已运行天数 = 当前时间 - 去年的上线那天
            }
            else
            {
                Year = int.Parse(today.ToString("yyyy")) - int.Parse(onLineDate.ToString("yyyy"));//已运行年数 = 当前年 - 上线年
                Day = new DateTime(today.Ticks).Subtract(new DateTime(DateTime.Parse(today.ToString("yyyy") + onLineDate.ToString("-MM-dd")).Ticks)).Days;//已运行天数 = 当前时间 - 今年的上线那天
            }
            Hour = DateTime.Now.Hour;//已运行小时数 = 当前小时

            OnlineTotalDays = new TimeSpan(DateTime.Now.Ticks - onLineDate.Ticks).Days;
        } 
        protected void Page_Load(object sender, EventArgs e)
        {
            IsRedis = ConfigurationManager.AppSettings["IsRedis"]; 
            //移动APP端屏蔽功能按钮
            if (Tool.WEBRequest.GetQueryString("type").ToLower() == "mobileapp")
            {
                this.IsShowRightBar = false;
                IsApp = true;
            }
            
            if (WebUserAuth.IsAuthenticated)
            {
                IsLogin = true;
            }
            

            UpdateSystemRunTime();
            GetStatistics();
            ReportList = GetInvestDayReport(-6);
            if (IsRedis == "1")
            {
                BabyPlanAmount = mRedis.GetBabyPlanMoney().TotalAmount;
            }
            else
            {
                BabyPlanAmount = CommUtils.GetBabyPlanAmount(ref BabyPlanReportDate);
            }
            

            AvgInvestMoney = Amount/UserCount;//人均投资
            GetMaxTotalInvestUser();
            GetMaxTotalIncomeInvestUser();
            //GetMaxSignDaysUser();
        }
        /// <summary>
        /// 获取统计数据
        /// </summary>
        private void GetStatistics()
        {
            try
            {
                WebSiteDataInfo websitedatemodel = null;
                if (IsRedis == "1")
                {
                    websitedatemodel = mRedis.GetTotayInvestMoney();
                }
                else
                {
                    websitedatemodel = new WebSiteDataBLL().GetWebSiteData();
                }  
                if (websitedatemodel != null)
                {
                    this.Amount = websitedatemodel.TotalAmount ?? 0;
                    this.UserCount = websitedatemodel.TotalUser ?? 0;
                    this.EarnedInterest = websitedatemodel.EarnedInterest ?? 0;

                }
                this.TodayAmount = new SubscribeBLL().GetSubscribeTotalAmount();
                CalcDQWebSite();
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("统计异常", ex.Message + "|" + ex.StackTrace);
            }
        }

        protected string GetChineseAmount(decimal amount,int type)
        {
            string res = "";
            if (amount == 0)
            {
                return "0";
            }
            else if (amount < 10000)
            {
                return Convert.ToInt32(amount).ToString() ;
            }

            long bilion = Convert.ToInt64(amount) / 100000000;
            if (bilion > 0)
            {
                if (type == 1)
                {
                    res += bilion.ToString() + "<span>亿</span>";
                }
                else 
                {
                    res += bilion.ToString() + "<span>亿</span>";
                }
            }

            long million = Convert.ToInt64(amount % 100000000) / 10000;
            if (million > 0)
            {
                if (type == 1)
                {
                    res += million + "<span>万</span>";
                }
                else
                {
                    res += million + "<span>万</span>";
                }
                
            }

            return res;
        }

        //获取交易额数据
        protected List<InvestDayReport> GetInvestDayReport(int dayCount)
        {
            string result = string.Empty;
            //if (IsRedis == "1")
            //{
            //    result = mRedis.InvestDayReport("", true);
            //}
            List<InvestDayReport> list = new List<InvestDayReport>();
            if (result != null)
            {
                list = JsonService.DeSerializeObject<List<InvestDayReport>>(result);
            }
            if (string.IsNullOrEmpty(result) || list.Where(m=>m.Date.Day == DateTime.Now.AddDays(-1).Day).Count()==0 || DateTime.Now < DateTime.Parse(DateTime.Now.ToShortDateString()+" 00:15:00"))
            {
                string sql = "select CONVERT(varchar(5),DayDate,110) as Date,Total as Amount from InvestDayReport(nolock) where DayDate >=dateadd(day,@dayCout,getdate()) AND DayDate<getdate()";
                Dapper.DynamicParameters param = new Dapper.DynamicParameters();
                param.Add("@dayCout", dayCount);
                list = TuanDai.DB.TuanDaiDB.Query<InvestDayReport>(TuanDai.WXApiWeb.TdConfig.ApplicationName, TuanDai.WXApiWeb.TdConfig.DBRead, sql, ref param);


                List<InvestDayReportModel> listDQ = WebSiteDataClient.GetInvestDayReport(System.Math.Abs(dayCount));//定期理财交易数据

                if (list.Any() && listDQ.Any())
                {
                    foreach (var item in list)
                    {
                        foreach (var itemDQ in listDQ)
                        {
                            if (item.Date == itemDQ.Date)
                            {
                                item.Amount += itemDQ.Amount;
                            }
                        }
                    }
                }
                if (IsRedis == "1" && list != null && list.Count > 0)
                {
                    mRedis.InvestDayReport(JsonService.SerializeObject<List<InvestDayReport>>(list), false);
                }
            }
            else
            {
                list = JsonService.DeSerializeObject<List<InvestDayReport>>(result);
            }
            return list;
        }
        /// <summary>
        /// 注册总人数
        /// </summary>
        /// <param name="userCount"></param>
        /// <returns></returns>
        protected string GetTotalUserString(int userCount)
        {
            if (userCount > 10000)
                return userCount / 10000 + "<span>万</span>" + (userCount - (userCount / 10000) * 10000) + "<span>人</span>";
            else
                return userCount + "<span>人</span>";
        }
        /// <summary>
        /// 风险拨备金
        /// </summary>
        /// <param name="babyPlanAmount"></param>
        /// <returns></returns>
        protected string GetBabyPlanAmountString(decimal babyPlanAmount)
        {
            if (babyPlanAmount > 100000000)
            {
                return (int)(babyPlanAmount / 100000000) + "<span>亿</span>" +
                       (int)Math.Floor((babyPlanAmount - Math.Floor(babyPlanAmount / 100000000) * 100000000) / 10000) + "<span>万</span>" +
                       (int)(babyPlanAmount - Math.Floor(babyPlanAmount / 10000) * 10000) + "<span>元</span>";
            }
            else if(babyPlanAmount > 10000)
            {
                return
                      (int)(babyPlanAmount / 10000) + "<span>万</span>" +
                      (int)(babyPlanAmount - Math.Floor(babyPlanAmount / 10000) * 10000) + "<span>元</span>";
            }
            else
            {
                return (int)babyPlanAmount + "<span>元</span>";
            }
        }
        /// <summary>
        /// 获取累计投资最大用户
        /// </summary>
        protected void GetMaxTotalInvestUser()
        {
            string sql = "select top 1 Amount,NickName from  [dbo].[RealTime_InvestRank] with(nolock) where Adddate > dateadd(day,-30,getdate()) order by CONVERT(VARCHAR(10), Adddate,23)  desc,Amount desc";
            var param = new Dapper.DynamicParameters();
            string errorInfo = string.Empty;
            _MaxInvestUser = TuanDai.DB.TuanDaiDB.Query<MaxInvestUser>(TdConfig.ApplicationName, TdConfig.DBStatisticsWrite, sql, ref param).FirstOrDefault();
            if (_MaxInvestUser==null)
            {
                _MaxInvestUser = new MaxInvestUser();
                _MaxInvestUser.Amount = 0;
                _MaxInvestUser.NickName = "";
            }
            else
            {
                _MaxInvestUser.NickName = GetNickNameString(_MaxInvestUser.NickName);
            }
        }
        /// <summary>
        /// 获取累计收益最大用户
        /// </summary>
        protected void GetMaxTotalIncomeInvestUser()
        {
            string sql = "select top 1 InterestAmount,NickName from dbo.RealTime_InvestRank with(nolock) where Adddate > dateadd(day,-30,getdate()) order by CONVERT(VARCHAR(10), Adddate,23)  desc,InterestAmount desc";
            var param = new Dapper.DynamicParameters();
            _MaxIncomeUser = TuanDai.DB.TuanDaiDB.Query<MaxIncomeUser>(TdConfig.ApplicationName, TdConfig.DBStatisticsWrite, sql, ref param).FirstOrDefault();
            if (_MaxIncomeUser== null)
            {
                _MaxIncomeUser = new MaxIncomeUser();
                _MaxIncomeUser.InterestAmount = 0;
                _MaxIncomeUser.NickName = "";
            }
            else
            {
                _MaxIncomeUser.NickName = GetNickNameString(_MaxIncomeUser.NickName);
            }
            
        }
        /// <summary>
        /// 获取签到最长的用户
        /// </summary>
        protected void GetMaxSignDaysUser()
        {
            bool _isRedis = IsRedis == "1";
            string result = mRedis.GetMaxSignDaysUser(_isRedis);            
            SignDaysUser = JsonService.DeSerializeObject<MaxSignDaysUser>(result);
        }
        /// <summary>
        /// 获取隐藏NickName
        /// </summary>
        /// <param name="nickName"></param>
        /// <returns></returns>
        protected string GetNickNameString(string nickName)
        {
            if (string.IsNullOrEmpty(nickName))
                return "星**";
            if (nickName.Length <= 1)
                return nickName+"*";
            else if (nickName.Length == 2)
                return nickName.Substring(0, 1) + "*";
            else if (nickName.Length > 2 && nickName.Length <= 4)
                return nickName.Substring(0, 1) + "**";
            else
                return nickName.Substring(0, 1) + "***" + nickName.Substring(nickName.Length - 2, 2);
        }

        /// <summary>
        /// 汇总定期理财库的报表数据
        /// </summary>
        protected void CalcDQWebSite()
        {
            //获取今日累计交易额
            decimal todayDQAmount = TuanDai.DQSystemAPI.Client.WebSiteDataClient.GetSubscribeTotalAmount();
            this.TodayAmount += todayDQAmount;
        }
    }

    public class MaxIncomeUser
    {
        public decimal InterestAmount { get; set; }
        public string NickName { get; set; }
    }
    public class MaxInvestUser
    {
        public decimal Amount { get; set; }
        public string NickName { get; set; }
    }
    public class InvestDayReport
    {
        public DateTime Date;
        public decimal Amount;
    }
    public class UserVisitModel
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid userId { get; set; }
        /// <summary>
        /// 用户名
        /// </summary>
        public string userName { get; set; }
        /// <summary>
        /// 用户昵称
        /// </summary>
        public string nickName { get; set; }
    }
    /// <summary>
    /// 累计最高投资用户
    /// </summary>
    public class MaxTotalInvestUser
    {
        public decimal MaxTotalInvest { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid UserId { get; set; }

        public UserVisitModel user { get; set; }
    }
    /// <summary>
    /// 累计最高收益用户
    /// </summary>
    public class MaxTotalIncomeInvestUser
    {
        public decimal MaxTotalIncomeInvest { get; set; }
        public UserVisitModel user { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid UserId { get; set; }
    }
    /// <summary>
    /// 累计最高签到用户
    /// </summary>
    public class MaxSignDaysUser
    {
        public decimal MaxSignDays { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid UserId { get; set; }
        public UserVisitModel user { get; set; }
    }
    /// <summary>
    /// 累计最长投龄用户
    /// </summary>
    public class MaxInvestAgeUser
    {
        public decimal MaxInvestAge { get; set; }
        public UserVisitModel user { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid UserId { get; set; }
    }
}