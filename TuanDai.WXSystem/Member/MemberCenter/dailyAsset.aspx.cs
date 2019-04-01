﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.MemberCenter
{
    public partial class dailyAsset : UserPage
    {
        public MUserVipInfo UserVipInfo;

        public decimal PreAvgDailyAsset = 0;//上月日均净资产
        public decimal CurrAvgDailyAsset = 0;//本月日均资产
        public List<MDayNetAssets> PreDailyAssets; //上月资产列表
        public List<MDayNetAssets> CurrDailyAssets; //本月资产列表

        public int CurrYYMM; //当前月份
        public decimal nextLevelAsset = 0;//下一个等级需要的日均资产数

        public int nextMonthLevel = 1;//下一个月可能的等级，根据本月日均资产来计算

        public string tab = "cur";
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            if (!IsPostBack)
            {
                tab = Tool.WEBRequest.GetString("tab");
                CurrYYMM = DateTime.Now.Month;
                UserVipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
                if (UserVipInfo.Level == 1)
                {
                    nextLevelAsset = 10000;
                }
                else if (UserVipInfo.Level == 2)
                {
                    nextLevelAsset = 50000;
                }
                else if (UserVipInfo.Level == 3)
                {
                    nextLevelAsset = 100000;
                }
                else if (UserVipInfo.Level == 4)
                {
                    nextLevelAsset = 200000;
                }
                else if (UserVipInfo.Level == 5)
                {
                    nextLevelAsset = 500000;
                }
                else if (UserVipInfo.Level == 6)
                {
                    nextLevelAsset = 1000000;
                }
                else if (UserVipInfo.Level == 7)
                {
                    nextLevelAsset = 3000000;
                }
                else
                {
                    nextLevelAsset = 3000000;
                }
                List<MDayNetAssets> dayNetAssets = MVipNetAssetsBLL.GetDayOfNetAssets(WebUserAuth.UserId.Value);
                PreDailyAssets =
                    dayNetAssets.Where(o => o.ReportDate < new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)).OrderByDescending(o=>o.ReportDate).ToList();
                if (PreDailyAssets.Count > 0)
                {
                    PreAvgDailyAsset = PreDailyAssets.Sum(o => o.NetAssets) / PreDailyAssets.Count;
                }
                CurrDailyAssets =
                    dayNetAssets.Where(o => o.ReportDate >= new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)).OrderByDescending(o => o.ReportDate).ToList();
                if (CurrDailyAssets.Count > 0)
                {
                    CurrAvgDailyAsset = CurrDailyAssets.Sum(o => o.NetAssets) / CurrDailyAssets.Count;
                }

                if (CurrAvgDailyAsset < 10000)
                {
                    nextMonthLevel = 1;
                }
                else if (CurrAvgDailyAsset >= 10000 && CurrAvgDailyAsset < 50000)
                {
                    nextMonthLevel = 2;
                }
                else if (CurrAvgDailyAsset >= 50000 && CurrAvgDailyAsset < 100000)
                {
                    nextMonthLevel = 3;
                }
                else if (CurrAvgDailyAsset >= 100000 && CurrAvgDailyAsset < 200000)
                {
                    nextMonthLevel = 4;
                }
                else if (CurrAvgDailyAsset >= 200000 && CurrAvgDailyAsset < 500000)
                {
                    nextMonthLevel = 5;
                }
                else if (CurrAvgDailyAsset >= 500000 && CurrAvgDailyAsset < 1000000)
                {
                    nextMonthLevel = 6;
                }
                else if (CurrAvgDailyAsset >= 1000000 && CurrAvgDailyAsset < 3000000)
                {
                    nextMonthLevel = 7;
                }
                else if (CurrAvgDailyAsset > 3000000)
                {
                    nextMonthLevel = 8;
                }
            }
        }
    }
}