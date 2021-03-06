﻿using BusinessDll; 
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.Redis;
using Tool;
using TuanDai.PortalSystem.BLL;
using Dapper;

namespace TuanDai.WXApiWeb.pages.aboutus
{
    public partial class ClassRoom : AppActivityBasePage
    {
        #region 自定义变量
        protected decimal Amount;     //用户投资总额
        protected int UserCount;  //注册用户数量
        protected decimal BabyPlanAmount = 0;//质量保障服务风险保证金
        protected string IsRedis = "";
        protected DateTime BabyPlanReportDate = DateTime.Today;
        protected bool IsAppLink = false;//是否是app链接过来
        protected bool Is360Weishi = false; //是否在360卫士推广进来的 
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn"+Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            IsRedis = ConfigurationManager.AppSettings["IsRedis"];
            var type = Tool.WEBRequest.GetQueryString("type");
            if (type == "mobileapp")
            {
                IsShowRightBar = false;
                IsAppLink = true;
            }

            GetStatistics();
            string tdFrom = Tool.CookieHelper.GetCookie("tdfrom");
            if (tdFrom.ToText().Trim().ToLower() == "360sjwsyyy-m1605-01" || tdFrom.ToText().Trim().ToLower() == "360sjwsyyy-m1605-xldy")
            {
                Is360Weishi = true;
            }
        }

        #region 获取统计数据 GetStatistics

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
                }
                BabyPlanAmount = GetBabyPlanTotalAmount();
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("首页统计异常", ex.Message + "|" + ex.StackTrace);
            }
        }
        //获取质量保障服务风险金
        protected decimal GetBabyPlanTotalAmount()
        {
            try
            {
                if (IsRedis == "1")
                {
                    var redis = mRedis.GetBabyPlanMoney();
                    BabyPlanReportDate = redis.ReportDate;
                    return redis.TotalAmount;
                }
                else
                {
                    decimal totalAmount = 0;
                    string sql = @"--DECLARE @ReportDate DATETIME
                                SELECT TOP 1 @ReportDate=ReportDate FROM dbo.BaoBeiJiHua(NOLOCK) ORDER BY ReportDate DESC
                                SELECT ISNULL(HostedTotaBalance,0) AS TotalAmount FROM dbo.BaoBeiJiHua(NOLOCK) WHERE ReportDate=@ReportDate  and StatusId=1";
                    var param = new DynamicParameters();
                    param.Add("@ReportDate", null, DbType.DateTime, ParameterDirection.Output); 
                    totalAmount = PublicConn.QuerySingle<decimal>(sql, ref param); 
                    BabyPlanReportDate = param.Get<DateTime>("ReportDate");
                    string amount = string.Format("{0:n}", Math.Floor(totalAmount));
                    amount = amount.Substring(0, amount.IndexOf("."));
                    return decimal.Parse(amount);
                }
            }
            catch
            {
                return 46395598;
            }
        }

        protected string GetChineseAmount(decimal amount)
        {
            string res = "";
            if (amount == 0)
            {
                return "0";
            }
            else if (amount < 10000)
            {
                res += GetEachNumber( Convert.ToInt32(amount).ToString());
                return res + "元";
            }

            long bilion = Convert.ToInt64(amount) / 100000000;
            if (bilion > 0)
            {
                res += GetEachNumber( bilion.ToString());
                res += "<span class=\"f18px c-ff9600\">亿</span>";
            }

            long million = Convert.ToInt64(amount % 100000000) / 10000;
            if (million > 0)
            {
                res += GetEachNumber( million.ToString());
                res += "万元";
            }

            return res;
        }

        private static string GetEachNumber(string amountStr)
        {
            string res = string.Empty;
            foreach (char item in amountStr)
            {
                res += "<span class=\"num_bg\">" + item + "</span>";
            }
            return res;
        }
        #endregion
    }
}