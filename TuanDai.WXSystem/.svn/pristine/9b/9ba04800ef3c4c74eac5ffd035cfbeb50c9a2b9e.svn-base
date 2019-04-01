using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;
using Dapper;
using System.Data;
using TuanDai.ZKHelper;
using Newtonsoft.Json;

namespace TuanDai.WXApiWeb.pages.App.find
{
    public partial class DailyCommission : AppActivityBasePage
    {
        //  protected List<ExtendEarnRecordInfo> ExtendEarnRecordList;
        //    protected int recordCount = 0;
        //   protected int pageCount = 0;
        //   protected string userId;
        protected string extendKey;
        protected string t;
        protected decimal TotalEranMoney;
        protected void Page_Load(object sender, EventArgs e)
        {
            extendKey = WEBRequest.GetQueryString("extendKey");
            //t = WEBRequest.GetQueryString("t");
            //Response.Redirect(GlobalUtils.WebURL + "/pages/app/find/DailyCommission.aspx?t=" + t + "&extendkey=" + extendKey);
            if (!IsPostBack)
            {
                //   this.IsShowRightBar = GlobalUtils.IsWeiXinBrowser ? false : true;
                this.GetData();
            }
        }

        private void GetData()
        {
            UserBasicInfoInfo user = null;
            if (WebUserAuth.IsAuthenticated)
            {
                user = new UserBLL().GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
            }
            else
            {
                user = new UserBLL().GetUserBasicInfoByExtendKey(extendKey);
            }
            if (user == null)
                TotalEranMoney = 0;
            else
                TotalEranMoney = GetExtendEarn(user.Id) ?? 0;


            #region .net数据库版
            //var dyParams = new Dapper.DynamicParameters();
            //dyParams.Add("@UserId", user.Id);
            //string querySql = @"   SELECT  SUM([EarnMoney]) [EarnMoney] FROM dbo.ExtendEarnRecord   with(nolock)
            //                 where UserID= @UserId ";
            //decimal? eranMoney = TuanDai.DB.TuanDaiDB.Query<decimal?>(TdConfig.ApplicationName, TdConfig.DBReportWrite, querySql, ref dyParams).FirstOrDefault();
            //TotalEranMoney = Math.Floor((eranMoney ?? 0) * 100) / 100;  
            #endregion
        }


        public decimal? GetExtendEarn(Guid userid)
        {
            #region 昨日佣金java接口版
            string errorMsg = "";
            string Url = System.Configuration.ConfigurationManager.AppSettings["CommissionApiUrl"] ?? ZooKClient.GetValueForZK("/url/CommissionApiUrl", ref errorMsg);
            if (string.IsNullOrWhiteSpace(errorMsg))
            {
                if (!string.IsNullOrWhiteSpace(Url))
                {
                    string startDate = "";
                    string endDate = "";
                    string newUserAPIURL = string.Format("{0}/commission/{1}/totalEarn", Url, userid.ToString());
                    try
                    {
                        string result = "";
                        errorMsg = string.Empty;
                        result = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName, newUserAPIURL, "", out errorMsg,
                            null, 2);
                        CommissionApiResponse<EarnMoneyResponse> commissionInfo = JsonConvert.DeserializeObject<CommissionApiResponse<EarnMoneyResponse>>(result);
                        if (commissionInfo != null && commissionInfo.code == "SUCCESS")//如果返回银行卡为空，返回默认值
                        {
                            return commissionInfo.data.earnMoneyTotal;
                        }
                        else if (commissionInfo == null)
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "DailyCommission.aspx", "commissionInfo为空", Url);
                            return null;
                        }
                        else
                        {
                            if (commissionInfo != null && commissionInfo.code != "SEARCH_USER_ID_NOT_FOUND_ERROR")
                            {
                                TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "DailyCommission.aspx", "用户不存在", "json=" + result);
                                return null;
                            }
                            else
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "DailyCommission.aspx", "数据异常", "json=" + result);
                                return null;
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "DailyCommission.aspx", "获取数据异常", ex.Message + "  |  " + ex.StackTrace);
                        return null;
                    }
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "DailyCommission.aspx", "Url为空", Url);
                    return null;
                }
            }
            else
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "DailyCommission.aspx", "获取CommissionApiUrl失败", errorMsg);
                return null;
            }
            #endregion
        }

        /// <summary>
        /// 获取个人佣金排名
        /// huangbinglai 2016/08/26
        /// </summary>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="recordCount"></param>
        /// <returns></returns>
        public Tuple<Int32, decimal> WXGetExtendEarnRank(Guid userid)
        {
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userid);
            string querySql = @" SELECT  AA.RowNum
                                                from ( select ROW_NUMBER() OVER(ORDER BY TotalEranMoney DESC) AS RowNum  ,UserId
                                                        from rp_ExtenderStatis with(nolock) )AA
                                                 where AA.UserId=@UserId ";
            int? rowNum = TuanDai.DB.TuanDaiDB.Query<int?>(TdConfig.ApplicationName, TdConfig.DBReportWrite, querySql, ref dyParams).FirstOrDefault();
            querySql = @"   SELECT  SUM([EarnMoney]) [EarnMoney] FROM dbo.ExtendEarnRecord 
                             where UserID= @UserId ";
            decimal? eranMoney = GetExtendEarn(userid);
            Tuple<Int32, decimal> result = new Tuple<Int32, decimal>(rowNum ?? 0, eranMoney ?? 0);
            return result;

        }


        //public static string GetDateData(ExtendEarnRecordInfo item)
        //{
        //    if (item.Adddate.Date == DateTime.Now.AddDays(-1).Date)
        //    {
        //        return "昨日佣金";
        //    }
        //    else
        //        return item.Adddate.ToShortDateString();
        //}

        //public static string GetMonthData(ExtendEarnRecordInfo item)
        //{
        //    return string.Format("{0}年{1}月",item.Adddate.Year,item.Adddate.Month );  
        //}


        public class CommissionApiResponse<T>
        {
            public string code { get; set; }

            public string message { get; set; }

            public T data { get; set; }
        }


        public class EarnMoneyResponse
        {
            public decimal earnMoneyTotal { get; set; }

            public Guid userId { get; set; }
        }
    }
}