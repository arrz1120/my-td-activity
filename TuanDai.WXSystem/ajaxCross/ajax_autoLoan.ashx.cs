﻿using System;
using System.Web;
using System.Linq;
using System.Web.SessionState;
using Dapper;
using NetDimension.Json;
using Tool;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using System.Data;
using TuanDai.WXSystem.Core;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.InfoSystem.Model;
using BusinessDll;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using System.IO;
using TuanDai.WXSystem.Core.models;
using TuanDai.ZKHelper;
using TuanDai.ZXSystem.BLL;
using TuanDai.ZXSystem.Model;
using TuanDai.PortalSystem.ExtServiceDAL;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_autoLoan 回款、还款、自动投标
    /// </summary>
    public class ajax_autoLoan : SafeHandlerBase
    {
        private object lockobj = new object();
        ProjectBLL projectBll = new ProjectBLL();
        WebLogBLL webLogBll = new WebLogBLL();
        Guid userid = WebUserAuth.UserId.Value;
        private int pagesize = 10;
        private int totalItemCount = 0;

        #region 还款回款
        /// <summary>
        /// 还款
        /// </summary>
        public void GetBorrowReturnPlan()
        {
            string type = HttpContext.Current.Request["type"];
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            try
            {
                WXLoanReturnPlan LoanReturnResponse = projectBll.WXGetBorrowReturnPlan(userid, type, pageindex, pagesize);
                totalItemCount = LoanReturnResponse.totalcount;
                int pageCount = GetPageCount();
                LoanReturnResponse.totalcount = pageCount;

                string resultStr = JsonHelper.ToJson(LoanReturnResponse);
                HttpContext.Current.Response.Write(resultStr);
                HttpContext.Current.Response.End();

            }
            catch
            {
            }

        }
        /// <summary>
        /// 回款
        /// </summary>
        public void GetLoanReturnPlan()
        {
            string type = HttpContext.Current.Request["type"];
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);//1按月 0 天

            WXLoanReturnPlan LoanReturnResponse = projectBll.WXGetLoanReturnPlan(userid, type, pageindex, pagesize);

            totalItemCount = LoanReturnResponse.totalcount;
            int pageCount = GetPageCount();
            LoanReturnResponse.totalcount = pageCount;

            string resultStr = JsonHelper.ToJson(LoanReturnResponse);
            HttpContext.Current.Response.Write(resultStr);
            HttpContext.Current.Response.End();
        }
        /// <summary>
        /// 是否是分期宝类型15的用户
        /// </summary>
        /// <returns></returns>
        private bool IsFqbUser()
        {
            var userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                return false;
            }
            string sql = "select count(0) from dbo.fq_UserApply with(nolock) where ApplyUserId=@UserId";
            var para = new Dapper.DynamicParameters();
            para.Add("@UserId", userid);

            return TuanDai.DB.TuanDaiDB.QuerySingleOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql,
                ref para) > 0;
        }
        /// <summary>
        /// 获得回款还款按月列表
        /// </summary>
        public void GetReturnAndPayMonths()
        {
            string tempsql = string.Empty;
            if (IsFqbUser())
            {
                tempsql = @"SELECT  CONVERT(VARCHAR(7), MAX(a.CycDate), 120) AS CycDate ,
                                        SUM(CASE WHEN b.[TYPE] = 15 THEN CASE WHEN c.OrgTypeId <> 5 THEN ISNULL(a.Amount, 0) + ISNULL(a.PublisherRedPacket,0) ELSE ( ISNULL(a.Amount, 0) + ISNULL(a.InterestAmout,0)+ ISNULL(a.BorrorCommission, 0) + ISNULL(a.PublisherRedPacket, 0) ) END ELSE ISNULL(a.Amount, 0) + ISNULL(a.InterestAmout, 0)+ ISNULL(a.PublisherRedPacket, 0) END) AS TotalAmount
                            FROM  dbo.SubscribeDetail a WITH ( NOLOCK )
                            INNER JOIN dbo.Project b WITH ( NOLOCK ) ON a.ProjectId = b.Id
                            LEFT JOIN fq_UserApply c ON a.ProjectId = c.ProjectId
                            WHERE   b.userid = @UserId  AND CycDate >= @StartDate   AND CycDate < @EndDate AND b.Type<>17
                            GROUP BY CONVERT (VARCHAR(7), CycDate, 120)";
            }
            else
            {
                tempsql = @"SELECT  CONVERT(VARCHAR(7), MAX(a.CycDate), 120) AS CycDate ,
                                        SUM(isnull(a.Amount, 0) + isnull(a.InterestAmout, 0) + isnull(a.PublisherRedPacket, 0)) AS TotalAmount
                            FROM  dbo.SubscribeDetail a WITH ( NOLOCK )
                            WHERE   a.borroweruserid = @UserId  AND CycDate >= @StartDate   AND CycDate < @EndDate
                            GROUP BY CONVERT (VARCHAR(7), CycDate, 120)";
            }

            string sql = @"
                         SELECT   ROW_NUMBER() over(order by CASE WHEN a.CycDate IS NOT NULL THEN a.CycDate ELSE b.CycDate END) rownum,  
                          CASE WHEN a.CycDate IS NOT NULL THEN a.CycDate ELSE b.CycDate END AS myMonth ,
                          ISNULL(a.TotalAmount, 0) AS returnMoney , ISNULL(b.TotalAmount, 0) AS payMoney
                                FROM( 
                        SELECT  CONVERT(VARCHAR(7), MAX(CycDate), 120) AS CycDate , ( SUM(ISNULL(Amount, 0))+ SUM(ISNULL(InterestAmout, 0))+ SUM(ISNULL(TuandaiRedPacket, 0)) + SUM(ISNULL(PublisherRedPacket, 0)) ) AS TotalAmount FROM 
                         (  
                          SELECT sd.CycDate, CASE WHEN sd.InvestType IN(3,2) THEN 0 ELSE  sd.Amount END AS Amount,
	                          CASE WHEN sd.InvestType = 3 THEN 0 ELSE sd.InterestAmout END AS InterestAmout,
	                          CASE WHEN sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.TuandaiRedPacket,0) END AS TuandaiRedPacket, 
	                          CASE WHEN sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.PublisherRedPacket,0) END AS PublisherRedPacket 
	                          FROM dbo.SubscribeDetail sd with(nolock)  
                         WHERE isnull(sd.InvestType,0)!=1 and sd.SubscribeUserId = @UserId AND sd.CycDate >= @StartDate   AND sd.CycDate < @EndDate 
	                        union all
	                         select we.CycDate, we.Amount, we.InterestAmount, we.TuanDaiRedPacket, we.PublisherRedPacket from dbo.We_OrderDetail we
	                         where  we.CycDate>=@StartDate and we.CycDate<@EndDate and we.IsHandle=0 and we.UserId=@UserId
                         )temp  GROUP BY  CONVERT (VARCHAR(7), CycDate, 120)
                          ) A
                        FULL JOIN ( " + tempsql
                         + ") B ON a.CycDate = b.CycDate";
            var startDate = int.Parse(WEBRequest.GetString("startDate"));
            
            var paras = new Dapper.DynamicParameters();
            paras.Add("@UserId", userid);
            DateTime st;
            DateTime et;
            if (startDate == 1)
            {
                st = DateTime.Parse(DateTime.Now.AddDays(1).ToShortDateString());
                et = new DateTime(DateTime.Now.AddMonths(3).Year, DateTime.Now.AddMonths(3).Month, 1).AddMilliseconds(-1);
                paras.Add("@StartDate", DateTime.Parse(DateTime.Now.AddDays(1).ToShortDateString()));
                paras.Add("@EndDate", new DateTime(DateTime.Now.AddMonths(3).Year, DateTime.Now.AddMonths(3).Month, 1).AddMilliseconds(-1));
            }
            else
            {
                st = new DateTime(DateTime.Now.AddMonths(3 * (startDate - 1)).Year, DateTime.Now.AddMonths(3 * (startDate - 1)).Month, 1);
                et = new DateTime(DateTime.Now.AddMonths(3 * (startDate)).Year, DateTime.Now.AddMonths(3 * (startDate)).Month, 1).AddMilliseconds(-1);
                paras.Add("@StartDate", new DateTime(DateTime.Now.AddMonths(3 * (startDate - 1)).Year, DateTime.Now.AddMonths(3 * (startDate - 1)).Month, 1));
                paras.Add("@EndDate", new DateTime(DateTime.Now.AddMonths(3 * (startDate)).Year, DateTime.Now.AddMonths(3 * (startDate)).Month, 1).AddMilliseconds(-1));
            }


            MyReturnAndPayList myList = new MyReturnAndPayList();
            //var list = PublicConn.QueryBySql<MyReturnAndPayInfo>(sql, ref paras);
            var list = new List<MyReturnAndPayInfo>();
            //if (list == null)
            //{
            //    list = new List<MyReturnAndPayInfo>();
            //}

            if (GlobalUtils.IsOpenSubscribeApi)
            {
                //从聚合拿数据，待收部分（包含智享）
                string postUrl = GlobalUtils.SubApiUrl;
                RequestGetBackListByMonth request = new RequestGetBackListByMonth();
                request.startDate = st.ToString("yyyy-MM-dd HH:mm:ss");
                request.endDate = et.ToString("yyyy-MM-dd HH:mm:ss");
                request.userId = userid;
                request.haveOverdue = false;
                request.pageIndex = 1;
                request.pageSize = 15;
                string err = "";
                ResponsePublicModel<ResponseGetBackListByMonth> response = new ResponsePublicModel<ResponseGetBackListByMonth>();
                string respJson = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, postUrl + "/app/APPGetBackSectionListByMonth",
                        JsonConvert.SerializeObject(request), out err, null, 5);
                if (!string.IsNullOrEmpty(respJson))
                {
                    response = JsonConvert.DeserializeObject<ResponsePublicModel<ResponseGetBackListByMonth>>(respJson);
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "/app/APPGetBackSectionListByMonth", JsonConvert.SerializeObject(request), err);
                }
                if (response != null && response.data != null && response.data.dataList != null &&
                    response.data.dataList.Count > 0)
                {
                    foreach (var data in response.data.dataList)
                    {
                        if (list.Exists(o => o.myMonth == data.returnTime.ToString("yyyy-MM")))
                        {
                            list.Where(o => o.myMonth == data.returnTime.ToString("yyyy-MM"))
                                .ToList()
                                .ForEach(o => o.returnMoney = data.amount + data.interest);
                        }
                        else
                        {
                            MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                            info.myMonth = data.returnTime.ToString("yyyy-MM");
                            info.returnMoney = data.amount + data.interest;
                            list.Add(info);
                        }
                    }
                }
            }
            //取智享的待结清部分
            var listZxOut =
                JsonConvert.DeserializeObject<List<FundPlan>>(
                    JsonConvert.SerializeObject(new ZXWXSelectBLL().GetZXWxUserWealthDateInfo(userid, st,
                        et)));
            if (listZxOut != null && listZxOut.Count > 0)
            {
                foreach (var plan in listZxOut)
                {
                    if (list.Exists(o => o.myMonth == DateTime.Parse(plan.cycDate).ToString("yyyy-MM")))
                    {
                        list.Where(o => o.myMonth == DateTime.Parse(plan.cycDate).ToString("yyyy-MM"))
                            .ToList()
                            .ForEach(o => o.payZxMoney += plan.outAmount);
                        if (!GlobalUtils.IsOpenSubscribeApi)
                            list.Where(o => o.myMonth == DateTime.Parse(plan.cycDate).ToString("yyyy-MM"))
                                .ToList()
                                .ForEach(o => o.returnMoney += plan.inAmount);
                    }
                    else
                    {
                        MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                        info.myMonth = DateTime.Parse(plan.cycDate).ToString("yyyy-MM");
                        info.payZxMoney += plan.outAmount;
                        if (!GlobalUtils.IsOpenSubscribeApi)
                            info.returnMoney = plan.inAmount;
                        list.Add(info);
                    }
                }
            }
            

            myList.list = list;

            string resultStr = JsonHelper.ToJson(myList);
            PrintJson(resultStr);
        }
        /// <summary>
        /// 获得回款还款明细
        /// </summary>
        public void GetReturnAndPayDetail()
        {
            string tempsql = string.Empty;
            if (IsFqbUser())
            {
                tempsql = @"SELECT  CONVERT(VARCHAR(10),MAX(a.CycDate),120) AS CycDate , 
                        SUM( CASE WHEN b.[TYPE]=15 THEN 
                        case when c.OrgTypeId<>5 then ISNULL(a.Amount,0) + isnull(a.PublisherRedPacket,0)
                        else (ISNULL(a.Amount,0)+ISNULL(a.InterestAmout,0)+ISNULL(a.BorrorCommission,0) + isnull(a.PublisherRedPacket,0)) end  
                        ELSE ISNULL(a.Amount,0)+ISNULL(a.InterestAmout,0) + isnull(a.PublisherRedPacket,0) end ) AS TotalAmount
                        FROM dbo.SubscribeDetail a with(nolock)
                        INNER JOIN dbo.Project b with(nolock) ON a.ProjectId=b.Id
                        left join fq_UserApply c  on a.ProjectId=c.ProjectId
                        WHERE a.borroweruserid=@UserId AND CycDate>=@StartDate AND CycDate<@EndDate  AND b.Type<>17
                           GROUP BY Convert ( VARCHAR(10),CycDate,120) ";
            }
            else
            {
                tempsql = @"SELECT  CONVERT(VARCHAR(10),MAX(a.CycDate),120) AS CycDate , 
                        SUM( ISNULL(a.Amount,0)+ISNULL(a.InterestAmout,0) + isnull(a.PublisherRedPacket,0) ) AS TotalAmount
                        FROM dbo.SubscribeDetail a with(nolock)
                        WHERE a.borroweruserid=@UserId AND CycDate>=@StartDate AND CycDate<@EndDate  
                           GROUP BY Convert ( VARCHAR(10),CycDate,120) ";
            }
            string sql = @"select * from (
                        SELECT CASE WHEN a.CycDate IS NOT NULL THEN a.CycDate ELSE b.CycDate END AS myDate,ISNULL(a.TotalAmount,0) AS returnMoney,ISNULL(b.TotalAmount,0) AS payMoney FROM (
                        SELECT  CONVERT(VARCHAR(10),MAX(CycDate),120) AS CycDate,
                        (SUM(ISNULL(Amount,0))+SUM(ISNULL(InterestAmout,0))+SUM(ISNULL(TuandaiRedPacket,0)) +SUM(ISNULL(PublisherRedPacket,0)) ) AS TotalAmount
                        FROM (SELECT  sd.CycDate,
                        CASE WHEN sd.InvestType IN(3,2) THEN 0 ELSE  sd.Amount END AS Amount,
                        CASE WHEN   sd.InvestType = 3 THEN 0 ELSE sd.InterestAmout END AS InterestAmout, 
                        CASE WHEN   sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.TuandaiRedPacket,0) END AS TuandaiRedPacket, 
                        CASE WHEN   sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.PublisherRedPacket,0) END AS PublisherRedPacket  
                        FROM dbo.SubscribeDetail sd with(nolock) 
                        WHERE isnull(sd.InvestType,0)!=1 and sd.SubscribeUserId=@UserId AND sd.CycDate>=@StartDate AND sd.CycDate<@EndDate
                         union all
                         select we.CycDate, we.Amount, we.InterestAmount,we.TuanDaiRedPacket, we.PublisherRedPacket  from dbo.We_OrderDetail we
                         where  we.CycDate>=@StartDate and we.CycDate<@EndDate and we.IsHandle=0 and we.UserId=@UserId
                        )temp  GROUP BY Convert ( VARCHAR(10),CycDate,120) 
                        )a
                        FULL JOIN (" + tempsql +
                        ")b ON b.CycDate = a.CycDate" +
                        ")main order by myDate";

            int year = Tool.SafeConvert.ToInt32(Context.Request.Form["year"], 2016);
            int month = Tool.SafeConvert.ToInt32(Context.Request.Form["month"], 8);
            DateTime startTime;
            DateTime endTime;
            if (year == DateTime.Now.Year && month == DateTime.Now.Month)
            {
                startTime = DateTime.Parse(DateTime.Now.AddDays(1).ToShortDateString());
                endTime = new DateTime(startTime.AddMonths(1).Year, startTime.AddMonths(1).Month, 1); ;
            }
            else
            {
                startTime = new DateTime(year, month, 1);
                endTime = startTime.AddMonths(1);
            }
            var paras = new Dapper.DynamicParameters();
            paras.Add("@UserId", userid);
            paras.Add("@StartDate", startTime);
            paras.Add("@EndDate", endTime);
            //List<MyReturnAndPayInfo> list = PublicConn.QueryBySql<MyReturnAndPayInfo>(sql, ref paras);
            List<MyReturnAndPayInfo> list  = new List<MyReturnAndPayInfo>();
            //if (list.Count ==0) list = new List<MyReturnAndPayInfo>();

            if (GlobalUtils.IsOpenSubscribeApi)
            {
                //从聚合拿数据，待收部分（包含智享）
                string postUrl = GlobalUtils.SubApiUrl;
                RequestGetBackListByMonth request = new RequestGetBackListByMonth();
                request.startDate = startTime.ToString("yyyy-MM-dd HH:mm:ss");
                request.endDate = endTime.ToString("yyyy-MM-dd HH:mm:ss");
                request.userId = userid;
                request.haveOverdue = false;
                request.pageIndex = 1;
                request.pageSize = 15;
                string err = "";
                ResponsePublicModel<ResponseGetBackListByMonth> response = new ResponsePublicModel<ResponseGetBackListByMonth>();
                string respJson = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, postUrl + "/app/APPGetBackSectionListByDay",
                        JsonConvert.SerializeObject(request), out err, null, 5);
                if (!string.IsNullOrEmpty(respJson))
                {
                    response = JsonConvert.DeserializeObject<ResponsePublicModel<ResponseGetBackListByMonth>>(respJson);
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "/app/APPGetBackSectionListByDay", JsonConvert.SerializeObject(request), err);
                }
                if (response != null && response.data != null && response.data.dataList != null &&
                    response.data.dataList.Count > 0)
                {
                    foreach (var data in response.data.dataList)
                    {
                        if (data.returnTime > DateTime.Now)
                        {
                            if (list.Exists(o => o.myDate == data.returnTime.ToString("yyyy-MM-dd")))
                            {
                                list.Where(o => o.myDate == data.returnTime.ToString("yyyy-MM-dd"))
                                    .ToList()
                                    .ForEach(o => o.returnMoney = data.amount + data.interest);
                            }
                            else
                            {
                                MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                                info.myDate = data.returnTime.ToString("yyyy-MM-dd");
                                info.returnMoney = data.amount + data.interest;
                                info.returnBen = data.amount;
                                info.returnLi = data.interest;
                                list.Add(info);
                            }
                        }

                    }
                }
            }
            //取智享的待结清数据
            var listZxOut =
                JsonConvert.DeserializeObject<List<FundPlan>>(
                    JsonConvert.SerializeObject(new ZXWXSelectBLL().GetZXWxUserWealthDateInfo(userid, startTime,
                        endTime)));
            if (listZxOut != null && listZxOut.Count > 0)
            {
                foreach (var plan in listZxOut)
                {
                    if (list.Exists(o => o.myDate == DateTime.Parse(plan.cycDate).ToString("yyyy-MM-dd")))
                    {
                        list.Where(o => o.myDate == DateTime.Parse(plan.cycDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.payZxMoney = plan.outAmount);
                        list.Where(o => o.myDate == DateTime.Parse(plan.cycDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.payZxBen = plan.dueOutZxBenJin);
                        list.Where(o => o.myDate == DateTime.Parse(plan.cycDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.payZxLi = plan.dueOutZxLiXi);
                        if (!GlobalUtils.IsOpenSubscribeApi)
                            list.Where(o => o.myDate == DateTime.Parse(plan.cycDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.returnMoney += plan.inAmount);
                        
                    }
                    else
                    {
                        MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                        info.myDate = DateTime.Parse(plan.cycDate).ToString("yyyy-MM-dd");
                        info.payZxMoney = plan.outAmount;
                        info.payZxBen = plan.dueOutZxBenJin;
                        info.payZxLi = plan.dueOutZxLiXi;
                        if(!GlobalUtils.IsOpenSubscribeApi)
                            info.returnMoney += plan.inAmount;
                        list.Add(info);
                    }
                }
            }

            //p2p待还
            string payMoneySql = @"SELECT  CONVERT(VARCHAR(10),MAX(a.CycDate),120) AS myDate , 
                        SUM( ISNULL(a.Amount,0) ) AS payBen,sum(ISNULL(a.InterestAmout,0) + isnull(a.PublisherRedPacket,0)) as payLi
                        FROM dbo.SubscribeDetail a with(nolock)
                        WHERE a.borroweruserid=@UserId AND CycDate>=@StartDate AND CycDate<@EndDate  
                           GROUP BY Convert ( VARCHAR(10),CycDate,120)";
            var payMoneyList = PublicConn.QueryBySql<MyReturnAndPayInfo>(payMoneySql, ref paras);
            if (payMoneyList != null && payMoneyList.Count > 0)
            {
                foreach (var pay in payMoneyList)
                {
                    if (list.Exists(o => o.myDate == DateTime.Parse(pay.myDate).ToString("yyyy-MM-dd")))
                    {
                        list.Where(o => o.myDate == DateTime.Parse(pay.myDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.payBen = pay.payBen);
                        list.Where(o => o.myDate == DateTime.Parse(pay.myDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.payLi = pay.payLi);
                        list.Where(o => o.myDate == DateTime.Parse(pay.myDate).ToString("yyyy-MM-dd"))
                            .ToList()
                            .ForEach(o => o.payMoney = pay.payBen + pay.payLi);
                    }
                    else
                    {
                        MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                        info.myDate = DateTime.Parse(pay.myDate).ToString("yyyy-MM-dd");
                        info.payBen = pay.payBen;
                        info.payLi = pay.payLi;
                        info.payMoney = pay.payBen+pay.payLi;
                        list.Add(info);
                    }
                }
            }

            string resultStr = JsonHelper.ToJson(list.OrderBy(o => o.myDate));
            PrintJson(resultStr);
        }
        #endregion

        #region 自动投标
        /// <summary>
        /// 更新状态
        /// </summary>
        public void updateStatusOld()
        {
            int status = int.Parse(HttpContext.Current.Request["status"]);
            if (status > 1 || status < 0)
            {
                status = 0;
            }
            Guid id = Guid.Parse(HttpContext.Current.Request["id"]);
            Guid userid = WebUserAuth.UserId.Value;
            var bll = new UserAutoTenderSettingBLL();
            //UserAutoTenderSetting setmodel = db.UserAutoTenderSettings.First(p => p.Id == id && p.UserId == userid);
            var setmodel = bll.GetUserAutoTenderSettingById(id);
            if (setmodel == null)
            {
                PrintJson("0", "操作失败");
            }
            int pre = setmodel.Status ?? 0;
            setmodel.Status = status;
            if (status == 1)
            {
                //UserAutoTenderQueue model1 = db.UserAutoTenderQueues.FirstOrDefault(p => p.UserId == userid);
                var model1 = bll.GetUserAutoTenderQueueByUserId(userid);
                if (model1 != null)
                {
                    model1.SetDate = DateTime.Now;
                    var isQueue = bll.UpdateUserAutoTenderQueue(model1);
                    if (!isQueue)
                    {
                        PrintJson("0", "操作失败");
                    }
                }
                else
                {
                    UserAutoTenderQueueInfo model3 = new UserAutoTenderQueueInfo();
                    model3.Id = Guid.NewGuid();
                    model3.UserId = userid;
                    model3.StatusId = 0;
                    model3.SetDate = DateTime.Now;
                    model3.CreateDate = DateTime.Now;
                    //db.UserAutoTenderQueues.AddObject(model3);
                    var isAdd = bll.AddUserAutoTenderQueue(model3);
                    if (!isAdd)
                    {
                        PrintJson("0", "操作失败");
                    }
                }
            }
            else
            {
                var list = bll.GetUserAutoTenderSettingListByUserId(userid);
                var count = list.Where(o => o.Status == 1 && o.Id != id).ToList().Count;
                //if (!db.UserAutoTenderSettings.Any(p => p.Status == 1 && p.UserId == userid && p.Id != id))
                if (count == 0)
                {
                    //UserAutoTenderQueue model2 = db.UserAutoTenderQueues.FirstOrDefault(p => p.UserId == userid);
                    var model2 = bll.GetUserAutoTenderQueueByUserId(userid);
                    if (model2 != null)
                    {
                        //db.UserAutoTenderQueues.DeleteObject(model2);
                        var isDel = bll.DeteleUserAutoTenderQueueById(model2.Id);
                        if (!isDel)
                        {
                            PrintJson("0", "操作失败");
                        }
                    }
                }

            }
            var isSetting = bll.UpdateUserAutoTenderSettingStatus(setmodel.Id, setmodel.Status.Value);
            if (isSetting)
            //if (db.SaveChanges() > 0)
            {
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = userid.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                log.Content1 = "更新自动投标Id:" + id + "的状态,更新之前状态：" + pre.ToString() + ";更新之后状态：" + status.ToString();
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);

                NetLog.WriteTraceLogHandler("更新自动投标状态", log.Content1, "Wap Or Wx");

                //LogHelper.WriteLog("更新自动投标状态", "", log.Content1);
                PrintJson("1", "操作成功");
            }
            else
            {
                PrintJson("0", "操作失败");
            }
        }
        /// <summary>
        /// 获取自动投标信息
        /// </summary>
        public void getSingleAuto()
        {

            string strid = Context.Request["id"];
            //Guid userid = WebUserAuth.UserId.Value;
            Guid id = Guid.Parse(strid);
            var model = new UserAutoTenderSettingBLL().GetUserAutoTenderSettingById(id);
            if (model == null)
            {
                PrintJson("0", "未找到对应方案");
                return;
            }
            PrintJson("1", ToJson(model));
        }
        /// <summary>
        /// 获取we计划自动投标
        /// </summary>
        public void getWeAuto()
        {
            string strid = Tool.WEBRequest.GetString("id");
            Guid id = Guid.Parse(strid);
            var model = new UserAutoWePlanSettingBLL().GetUserAutoWePlanSettingById(id);
            if (model == null)
            {
                PrintJson("0", "未找到对应方案");
                return;
            }
            PrintJson("1", ToJson(model));
        }

        public void addAuto()
        {
            string pattern = Tool.WEBRequest.GetString("pattern");//1是散标  2是we计划
            string ProjectType = Tool.WEBRequest.GetString("ProjectType");
            string beginRate = Tool.WEBRequest.GetString("beginRate");
            string endRate = Tool.WEBRequest.GetString("endRate");
            string beginDeadline = Tool.WEBRequest.GetString("beginDeadline");
            string endDeadline = Tool.WEBRequest.GetString("endDeadline");
            string RepaymentType = Tool.WEBRequest.GetString("RepaymentType");
            string ReservedAmout = Tool.WEBRequest.GetString("ReservedAmout");
            string preAmout = "100000000";
            string beginDate = Tool.WEBRequest.GetString("beginDate");
            string endDate = Tool.WEBRequest.GetString("endDate");
            string autoRun = "1";//触屏版增加时默认开启
            string StartDeadType = Tool.WEBRequest.GetString("StartDeadType");
            string EndDeadType = Tool.WEBRequest.GetString("EndDeadType");

            Guid userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                PrintJson("-99", "登录已失效");
            }
            DateTime endTime1;
            DateTime.TryParse(endDate + " 23:59:59", out endTime1);
            if (endTime1 < DateTime.Now)
            {
                PrintJson("0", "结束时间不能小于当前时间");
            }
            lock (lockobj)
            {
                string sql1 = "select count(0) From UserAutoTenderSetting with(nolock) Where UserId=@UserId ";
                string sql2 = "select count(0) From dbo.UserAutoWePlanSetting with(nolock) Where UserId=@UserId";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@UserId", userid);
                int rows1 = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql1, ref dyParams);
                int rows2 = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql2, ref dyParams);

                if (rows1 + rows2 > 2)
                {
                    PrintJson("-2", "最多设置三条");
                }

                if (pattern != "1" && pattern != "2")
                {
                    PrintJson("0", "操作失败");
                }

                UserAutoTenderSettingInfo model = new UserAutoTenderSettingInfo();
                model.UserId = userid;
                model.ProjectType = ProjectType;
                if (!string.IsNullOrWhiteSpace(beginRate))
                {
                    model.StartRate = Tool.SafeConvert.ToDecimal(beginRate);
                }
                if (!string.IsNullOrWhiteSpace(endRate))
                {
                    model.EndRate = Tool.SafeConvert.ToDecimal(endRate);
                }
                else
                {
                    model.EndRate = 20;
                }
                if (!string.IsNullOrWhiteSpace(beginDeadline))
                {
                    model.StartDeadLine = Tool.SafeConvert.ToInt32(beginDeadline);
                }
                if (!string.IsNullOrWhiteSpace(endDeadline))
                {
                    model.EndDeadLine = Tool.SafeConvert.ToInt32(endDeadline);
                }
                model.RepaymentType = RepaymentType;
                if (!string.IsNullOrWhiteSpace(ReservedAmout))
                {
                    ReservedAmout = Tool.SafeConvert.ToDecimal(ReservedAmout) > 0 ? ReservedAmout : "0";
                    model.ReservedAmout = Tool.SafeConvert.ToDecimal(ReservedAmout);


                }
                if (!string.IsNullOrWhiteSpace(preAmout))
                {
                    model.PreAmout = Tool.SafeConvert.ToDecimal(preAmout);
                }
                if (!string.IsNullOrWhiteSpace(beginDate))
                {
                    DateTime startDate;
                    if (DateTime.TryParse(beginDate, out startDate))
                    {
                        model.StartDate = startDate;
                    }
                }
                if (!string.IsNullOrWhiteSpace(endDate))
                {
                    DateTime endTime;
                    if (DateTime.TryParse(endDate + " 23:59:59", out endTime))
                    {
                        model.EndDate = endTime;
                    }
                }
                model.SortOrder = rows1 + rows2 + 1;
                model.Id = Guid.NewGuid();
                model.CreateDate = DateTime.Now;
                if (autoRun == "1")
                {
                    model.Status = 1;
                }
                else
                {
                    model.Status = 0;
                }

                if (!string.IsNullOrWhiteSpace(StartDeadType))
                {
                    model.StartDeadType = Tool.SafeConvert.ToInt32(StartDeadType);
                }
                if (!string.IsNullOrWhiteSpace(EndDeadType))
                {
                    model.EndDeadType = Tool.SafeConvert.ToInt32(EndDeadType);
                }

                UserAutoTenderSettingBLL atQueueBLL = new UserAutoTenderSettingBLL();
                bool result = false;
                if (model.Status == 1)
                {
                    UserAutoTenderQueueInfo model2 = atQueueBLL.GetUserAutoTenderQueueByUserId(userid);
                    if (model2 != null)
                    {
                        model2.SetDate = DateTime.Now;
                        result = atQueueBLL.UpdateUserAutoTenderQueue(model2);
                    }
                    else
                    {
                        UserAutoTenderQueueInfo model3 = new UserAutoTenderQueueInfo();
                        model3.Id = Guid.NewGuid();
                        model3.UserId = userid;
                        model3.StatusId = 0;
                        model3.SetDate = DateTime.Now;
                        model3.CreateDate = DateTime.Now;
                        result = atQueueBLL.AddUserAutoTenderQueue(model3);
                    }
                    if (!result)
                    {
                        PrintJson("0", "操作失败");
                    }
                }
                else
                {
                    result = true;
                }
                if (result)
                {
                    if (pattern == "1")
                    {
                        UserAutoTenderSettingBLL settingBLL = new UserAutoTenderSettingBLL();
                        result = settingBLL.AddUserAutoTenderSetting(model);
                    }
                    else
                    {
                        UserAutoWePlanSettingBLL settingBLL = new UserAutoWePlanSettingBLL();
                        UserAutoWePlanSettingInfo WePlanModel = new UserAutoWePlanSettingInfo();
                        WePlanModel.Id = model.Id;
                        WePlanModel.UserId = model.UserId;
                        WePlanModel.ProjectType = model.ProjectType;
                        WePlanModel.StartDate = model.StartDate;
                        WePlanModel.EndDate = model.EndDate;
                        WePlanModel.ReservedAmout = model.ReservedAmout;
                        WePlanModel.SortOrder = model.SortOrder;
                        WePlanModel.Status = model.Status;
                        WePlanModel.CreateDate = model.CreateDate;
                        result = settingBLL.AddUserAutoWePlanSetting(WePlanModel);
                    }

                }
                if (result)
                {
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = model.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                    log.UserId = userid.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                    StringBuilder content = new StringBuilder();
                    content.Append("[{\"投标方式\":\"" + pattern + "\",\"项目类型:\":\"" + ProjectType + "\",\"年化率\":\"" + beginRate + "%-" + endRate + "%\",\"回购期限\":\"" + beginDeadline + "-" + endDeadline + "\",");
                    content.Append("\"开始期限单位\":\"" + StartDeadType + "\",\"结束期限单位\":\"" + EndDeadType + "\",\"还款类型\":\"" + RepaymentType + "\",\"预留金额\":\"" + ReservedAmout + "\",\"投标金额\":\"" + preAmout + "\",\"有效期\":\"" + beginDate + "~" + endDate + "\"}]");
                    log.Content1 = "添加自动投标:" + content.ToString();
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);
                    PrintJson("1", "操作成功");
                }
                else
                {
                    PrintJson("0", "操作失败");
                }
            }
        }
        /// <summary>
        /// 更新自动投标
        /// </summary>
        public void updateAuto()
        {
            string pattern = Context.Request["pattern"];
            if (pattern != "1" && pattern != "2")
            {
                PrintJson("0", "操作失败");
            }
            string ProjectType = Context.Request["ProjectType"];
            string beginRate = Context.Request["beginRate"];
            string endRate = Context.Request["endRate"];
            string beginDeadline = Context.Request["beginDeadline"];
            string endDeadline = Context.Request["endDeadline"];
            string RepaymentType = Context.Request["RepaymentType"];
            string ReservedAmout = Context.Request["ReservedAmout"];
            string preAmout = "";
            if (string.IsNullOrEmpty(Context.Request["preAmout"]))
            {
                preAmout = "100000000";
            }
            else
            {
                preAmout = Context.Request["preAmout"];
            }
            string beginDate = Context.Request["beginDate"];
            string endDate = Context.Request["endDate"];
            string strid = Context.Request["id"];
            string StartDeadType = Context.Request["StartDeadType"];
            string EndDeadType = Context.Request["EndDeadType"];

            DateTime endTime1;
            DateTime.TryParse(endDate + " 23:59:59", out endTime1);
            if (endTime1 < DateTime.Now)
            {
                PrintJson("0", "结束时间不能小于当前时间");
            }

            lock (lockobj)
            {
                Guid userid = WebUserAuth.UserId.Value;
                Guid id = Guid.Parse(strid);
                string sql = string.Empty;
                if (pattern == "1")
                {
                    sql = "Select top 1 * From UserAutoTenderSetting with(nolock) Where Id=@Id and UserId=@UserId ";
                }
                else
                {
                    sql = "Select top 1 * From UserAutoWePlanSetting with(nolock) Where Id=@Id and UserId=@UserId ";
                }

                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@Id", id);
                dyParams.Add("@UserId", userid);
                UserAutoTenderSettingInfo model = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<UserAutoTenderSettingInfo>(TdConfig.ApplicationName, TdConfig.DBRead, sql, ref dyParams);

                StringBuilder content = new StringBuilder();
                content.Append("{\"投标方式\":\"" + pattern + "\",\"更新前\":[{\"标Id\":\"" + model.Id + "\",\"项目类型:\":\"" + model.ProjectType + "\",\"年化率\":\"" + model.StartRate + "%-" + model.EndRate + "%\"");
                content.Append(",\"回购期限\":\"" + model.StartDeadLine + "-" + model.EndDeadLine + "\",");
                content.Append("\"还款类型\":\"" + model.RepaymentType + "\",\"预留金额\":\"" + model.ReservedAmout + "\",");
                content.Append("\"开始期限单位\":\"" + model.StartDeadType + "\",\"结束期限单位\":\"" + model.EndDeadType + "\",");
                content.Append("\"投标金额\":\"" + model.PreAmout + "\",\"有效期\":\"" + model.StartDate + "~" + model.EndDate + "\"}]");

                model.ProjectType = ProjectType;
                if (!string.IsNullOrWhiteSpace(beginRate))
                {
                    model.StartRate = Tool.SafeConvert.ToDecimal(beginRate);
                }
                if (!string.IsNullOrWhiteSpace(endRate))
                {
                    model.EndRate = Tool.SafeConvert.ToDecimal(endRate);
                }
                else
                {
                    model.EndRate = 20;
                }
                if (!string.IsNullOrWhiteSpace(beginDeadline))
                {
                    model.StartDeadLine = Tool.SafeConvert.ToInt32(beginDeadline);
                }
                if (!string.IsNullOrWhiteSpace(endDeadline))
                {
                    model.EndDeadLine = Tool.SafeConvert.ToInt32(endDeadline);
                }
                model.RepaymentType = RepaymentType;
                if (!string.IsNullOrWhiteSpace(ReservedAmout))
                {
                    ReservedAmout = Tool.SafeConvert.ToDecimal(ReservedAmout) > 0 ? ReservedAmout : "0";
                    model.ReservedAmout = Tool.SafeConvert.ToDecimal(ReservedAmout);
                }

                if (model.PreAmout != 100000000)
                {
                    model.PreAmout = Tool.SafeConvert.ToDecimal(preAmout);
                }

                if (!string.IsNullOrWhiteSpace(beginDate))
                {
                    DateTime startDate;
                    if (DateTime.TryParse(beginDate, out startDate))
                    {
                        model.StartDate = startDate;
                    }
                }
                else
                {
                    if (model.StartDate != null)
                    {
                        model.StartDate = null;
                    }
                }

                if (!string.IsNullOrWhiteSpace(endDate))
                {
                    DateTime endTime;
                    if (DateTime.TryParse(endDate + " 23:59:59", out endTime))
                    {
                        model.EndDate = endTime;
                    }
                }
                else
                {
                    if (model.EndDate != null)
                    {
                        model.EndDate = null;
                    }
                }
                if (!string.IsNullOrWhiteSpace(StartDeadType))
                {
                    model.StartDeadType = Tool.SafeConvert.ToInt32(StartDeadType);
                }
                if (!string.IsNullOrWhiteSpace(EndDeadType))
                {
                    model.EndDeadType = Tool.SafeConvert.ToInt32(EndDeadType);
                }

                bool result = false;
                UserAutoTenderSettingBLL queueBLL = new UserAutoTenderSettingBLL();
                if (model.Status == 1)
                {
                    UserAutoTenderQueueInfo model2 = queueBLL.GetUserAutoTenderQueueByUserId(userid);
                    if (model2 != null)
                    {
                        model2.SetDate = DateTime.Now;
                        result = queueBLL.UpdateUserAutoTenderQueue(model2);
                    }
                    else
                    {
                        UserAutoTenderQueueInfo model3 = new UserAutoTenderQueueInfo();
                        model3.Id = Guid.NewGuid();
                        model3.UserId = userid;
                        model3.StatusId = 0;
                        model3.SetDate = DateTime.Now;
                        model3.CreateDate = DateTime.Now;
                        result = queueBLL.AddUserAutoTenderQueue(model3);
                    }
                }
                else if (model.Status == 0)
                {
                    string sql1 = "Select Count(0) From UserAutoTenderSetting with(nolock) Where Status=1 and UserId=@UserId and Id!=@Id ";
                    string sql2 = "Select Count(0) From UserAutoWePlanSetting with(nolock) Where Status=1 and UserId=@UserId and Id!=@Id ";
                    dyParams = new Dapper.DynamicParameters();
                    dyParams.Add("@UserId", userid);
                    dyParams.Add("@Id", id);

                    int runingCount1 = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql1, ref dyParams);
                    int runingCount2 = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql2, ref dyParams);

                    if ((runingCount1 + runingCount2) <= 0)//如果没有有正在启用的方案，删除queue
                    {
                        UserAutoTenderQueueInfo model2 = queueBLL.GetUserAutoTenderQueueByUserId(userid);
                        if (model2 != null)
                        {
                            sql = " Delete From UserAutoTenderQueue Where UserId=@UserId ";
                            dyParams.Add("@UserId", userid);
                            int count = TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBUserWrite, sql, ref dyParams);
                            if (count > 0)
                            {
                                result = true;
                            }
                        }
                        else
                        {
                            result = true;
                        }
                    }
                    else
                    {
                        result = true;
                    }
                }

                if (result)
                {
                    if (pattern == "1")
                    {
                        UserAutoTenderSettingBLL settingBLL = new UserAutoTenderSettingBLL();
                        result = settingBLL.UpdateUserAutoTenderSetting(model);
                    }
                    else
                    {
                        UserAutoWePlanSettingBLL settingBLL = new UserAutoWePlanSettingBLL();
                        UserAutoWePlanSettingInfo WePlanModel = new UserAutoWePlanSettingInfo();
                        WePlanModel.Id = model.Id;
                        WePlanModel.UserId = model.UserId;
                        WePlanModel.ProjectType = model.ProjectType;
                        WePlanModel.StartDate = model.StartDate;
                        WePlanModel.EndDate = model.EndDate;
                        WePlanModel.ReservedAmout = model.ReservedAmout;
                        WePlanModel.SortOrder = model.SortOrder;
                        WePlanModel.Status = model.Status;
                        WePlanModel.CreateDate = model.CreateDate;
                        result = settingBLL.UpdateUserAutoWePlanSetting(WePlanModel);
                    }

                }

                if (result)
                {

                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.UserId = userid.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                    content.Append(",\"更新后\":[{\"投标方式\":\"" + pattern + "\",\"标Id\":\"" + id + "\",\"项目类型:\":\"" + ProjectType + "\",\"年化率\":\"" + beginRate + "%-" + endRate + "%\",\"回购期限\":\"" + beginDeadline + "-" + endDeadline + "\",");
                    content.Append("\"开始期限单位\":\"" + StartDeadType + "\"\"结束期限单位\":\"" + EndDeadType + "\"\"还款类型\":\"" + RepaymentType + "\",\"预留金额\":\"" + ReservedAmout + "\",\"投标金额\":\"" + preAmout + "\",\"有效期\":\"" + beginDate + "~" + endDate + "\"}]}");
                    log.Content1 = "更新自动投标信息" + content.ToString();
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);
                    PrintJson("1", "操作成功");
                }
                else
                {
                    PrintJson("0", "操作失败");
                }
            }
        }
        /// <summary>
        /// 删除自动投标
        /// </summary>
        public void deleteAuto()
        {
            string pattern = Context.Request["pattern"];
            if (pattern != "1" && pattern != "2")
            {
                PrintJson("0", "操作失败");
            }

            string strid = Context.Request["id"];
            Guid userid = WebUserAuth.UserId.Value;
            StringBuilder content = new StringBuilder();
            var bll = new UserAutoTenderSettingBLL();
            Guid id = Guid.Empty;
            if (!Guid.TryParse(strid, out id))
            {
                PrintJson("0", "操作失败");
                return;
            }

            UserAutoTenderSettingInfo model;

            if (pattern == "1")
            {
                model = bll.GetUserAutoTenderSettingById(id);
            }
            else
            {
                UserAutoWePlanSettingInfo WePlanModel = new UserAutoWePlanSettingBLL().GetUserAutoWePlanSettingById(id);
                model = new UserAutoTenderSettingInfo();
                model.Id = WePlanModel.Id;
                model.UserId = WePlanModel.UserId;
                model.ProjectType = WePlanModel.ProjectType;
                model.StartDate = WePlanModel.StartDate;
                model.EndDate = WePlanModel.EndDate;
                model.ReservedAmout = WePlanModel.ReservedAmout;
                model.SortOrder = WePlanModel.SortOrder;
                model.Status = WePlanModel.Status;
                model.CreateDate = WePlanModel.CreateDate;
            }


            content.Append("[{\"投标方式\":\"" + pattern + "\",\"标Id\":\"" + model.Id + "\",\"项目类型:\":\"" + model.ProjectType + "\",\"年化率\":\"" + model.StartRate + "%-" + model.EndRate + "%\"");
            content.Append(",\"回购期限\":\"" + model.StartDeadLine + "-" + model.EndDeadLine + "\",");
            content.Append("\"还款类型\":\"" + model.RepaymentType + "\",\"预留金额\":\"" + model.ReservedAmout + "\",");
            content.Append("\"开始期限单位\":\"" + model.StartDeadType + "\",\"结束期限单位\":\"" + model.EndDeadType + "\",");
            content.Append("\"投标金额\":\"" + model.PreAmout + "\",\"有效期\":\"" + model.StartDate + "~" + model.EndDate + "\"}]");


            string sql1 = "Select Count(0) From UserAutoTenderSetting with(nolock) Where Status=1 and UserId=@UserId and Id!=@Id ";
            string sql2 = "Select Count(0) From UserAutoWePlanSetting with(nolock) Where Status=1 and UserId=@UserId and Id!=@Id ";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userid);
            dyParams.Add("@Id", id);

            int runingCount1 = TuanDai.DB.TuanDaiDB.ExecuteScalar<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql1, ref dyParams);
            int runingCount2 = TuanDai.DB.TuanDaiDB.ExecuteScalar<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql2, ref dyParams);

            if ((runingCount1 + runingCount2) <= 0)//如果没有有正在启用的方案，删除queue
            {
                string sql = " Delete From UserAutoTenderQueue Where UserId=@UserId ";
                dyParams.Add("@UserId", userid);
                TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBUserWrite, sql, ref dyParams);
            }

            var isDel = false;
            if (pattern == "1")
            {
                isDel = bll.DeleteUserAutoTenderSettingById(id);
            }
            else
            {
                isDel = new UserAutoWePlanSettingBLL().DeleteUserAutoWePlanSettingById(id);
            }

            if (isDel)
            {
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Delete;
                log.UserId = userid.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                log.Content1 = "删除自动投标:" + content.ToString();
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);
                PrintJson("1", "操作成功");
            }
            else
            {
                PrintJson("0", "操作失败");
            }
        }
        /// <summary>
        /// 更新状态
        /// </summary>
        public void updateStatus()
        {
            string pattern = Context.Request["pattern"];
            if (pattern != "1" && pattern != "2")
            {
                PrintJson("0", "操作失败");
            }
            int status = int.Parse(Context.Request["status"]);
            if (status > 1 || status < 0)
            {
                status = 0;
            }
            Guid id = Guid.Parse(Context.Request["id"]);
            Guid userid = WebUserAuth.UserId.Value;
            var bll = new UserAutoTenderSettingBLL();

            UserAutoTenderSettingInfo setmodel = new UserAutoTenderSettingInfo();
            if (pattern == "1")
            {
                setmodel = bll.GetUserAutoTenderSettingById(id);
            }
            else
            {
                UserAutoWePlanSettingInfo WePlanModel = new UserAutoWePlanSettingBLL().GetUserAutoWePlanSettingById(id);
                setmodel.Id = WePlanModel.Id;
                setmodel.UserId = WePlanModel.UserId;
                setmodel.ProjectType = WePlanModel.ProjectType;
                setmodel.StartDate = WePlanModel.StartDate;
                setmodel.EndDate = WePlanModel.EndDate;
                setmodel.ReservedAmout = WePlanModel.ReservedAmout;
                setmodel.SortOrder = WePlanModel.SortOrder;
                setmodel.Status = WePlanModel.Status;
                setmodel.CreateDate = WePlanModel.CreateDate;
            }

            if (setmodel == null)
            {
                PrintJson("0", "操作失败");
            }
            int pre = setmodel.Status ?? 0;
            setmodel.Status = status;
            if (status == 1)
            {
                var model1 = bll.GetUserAutoTenderQueueByUserId(userid);
                if (model1 != null)
                {
                    model1.SetDate = DateTime.Now;
                    var isQueue = bll.UpdateUserAutoTenderQueue(model1);
                    if (!isQueue)
                    {
                        PrintJson("0", "操作失败");
                    }

                }
                else
                {
                    UserAutoTenderQueueInfo model3 = new UserAutoTenderQueueInfo();
                    model3.Id = Guid.NewGuid();
                    model3.UserId = userid;
                    model3.StatusId = 0;
                    model3.SetDate = DateTime.Now;
                    model3.CreateDate = DateTime.Now;
                    var isAdd = bll.AddUserAutoTenderQueue(model3);
                    if (!isAdd)
                    {
                        PrintJson("0", "操作失败");
                    }
                }
            }
            else
            {
                string sql1 = "Select Count(0) From UserAutoTenderSetting with(nolock) Where Status=1 and UserId=@UserId and Id!=@Id ";
                string sql2 = "Select Count(0) From UserAutoWePlanSetting with(nolock) Where Status=1 and UserId=@UserId and Id!=@Id ";
                Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@UserId", userid);
                dyParams.Add("@Id", id);

                int runingCount1 = TuanDai.DB.TuanDaiDB.ExecuteScalar<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql1, ref dyParams);
                int runingCount2 = TuanDai.DB.TuanDaiDB.ExecuteScalar<int>(TdConfig.ApplicationName, TdConfig.DBRead, sql2, ref dyParams);

                if ((runingCount1 + runingCount2) <= 0)//如果没有有正在启用的方案，删除queue
                {
                    string sql = " Delete From UserAutoTenderQueue Where UserId=@UserId ";
                    dyParams.Add("@UserId", userid);
                    TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBUserWrite, sql, ref dyParams);
                }

            }
            var isSetting = false;
            if (pattern == "1")
            {
                isSetting = bll.UpdateUserAutoTenderSettingStatus(setmodel.Id, setmodel.Status.Value);
            }
            else
            {
                isSetting = new UserAutoWePlanSettingBLL().UpdateUserAutoWePlanSettingStatus(setmodel.Id, setmodel.Status.Value);
            }

            if (isSetting)
            {
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = userid.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                log.Content1 = "更新自动投标Id:" + id + "的状态,投标方式：" + pattern + ",更新之前状态：" + pre.ToString() + ";更新之后状态：" + status.ToString();
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);
                PrintJson("1", "操作成功");
            }
            else
            {
                PrintJson("0", "操作失败");
            }
        }
        #region 旧的添加自动投标
        /// <summary>
        /// 添加自动投标(旧的)
        /// </summary>
        public void addAutoOld()
        {
            string ProjectType = Tool.WEBRequest.GetString("ProjectType");
            string beginRate = Tool.WEBRequest.GetString("beginRate");
            string endRate = Tool.WEBRequest.GetString("endRate");
            string beginDeadline = Tool.WEBRequest.GetString("beginDeadline");
            string endDeadline = Tool.WEBRequest.GetString("endDeadline");
            string RepaymentType = Tool.WEBRequest.GetString("RepaymentType");
            string ReservedAmout = Tool.WEBRequest.GetString("ReservedAmout");
            //新增的默认保存值都是1亿
            string preAmout = "100000000";
            string beginDate = DateTime.Now.ToShortDateString();
            string endDate = Tool.WEBRequest.GetString("endDate");
            Guid userid = WebUserAuth.UserId.Value;
            var bll = new UserAutoTenderSettingBLL();
            lock (lockobj)
            {
                int rows = bll.GetUserAutoTenderSettingListByUserId(userid).Count;
                if (rows > 2)
                {
                    PrintJson("-2", "最多设置三条");
                }
                UserAutoTenderSettingInfo model = new UserAutoTenderSettingInfo();
                model.UserId = userid;
                model.ProjectType = ProjectType;
                if (!string.IsNullOrWhiteSpace(beginRate))
                {
                    try
                    {
                        model.StartRate = decimal.Parse(beginRate);
                    }
                    catch (Exception)
                    {

                        PrintJson("-1", "最小利率有误");
                    }

                }
                if (!string.IsNullOrWhiteSpace(endRate))
                {
                    try
                    {
                        model.EndRate = decimal.Parse(endRate);
                    }
                    catch (Exception)
                    {
                        PrintJson("-1", "最大利率有误");
                    }
                }
                if (!string.IsNullOrWhiteSpace(beginDeadline))
                {
                    try
                    {
                        model.StartDeadLine = int.Parse(beginDeadline);
                    }
                    catch (Exception)
                    {
                        PrintJson("-1", "最小期限有误");
                    }

                }
                if (!string.IsNullOrWhiteSpace(endDeadline))
                {
                    try
                    {
                        model.EndDeadLine = int.Parse(endDeadline);
                    }
                    catch (Exception)
                    {
                        PrintJson("-1", "最大期限有误");
                    }
                }
                model.RepaymentType = RepaymentType;
                if (!string.IsNullOrWhiteSpace(ReservedAmout))
                {
                    try
                    {
                        model.ReservedAmout = decimal.Parse(ReservedAmout);
                    }
                    catch (Exception)
                    {
                        PrintJson("-1", "预留金额有误");
                    }

                }
                if (!string.IsNullOrWhiteSpace(preAmout))
                {
                    model.PreAmout = decimal.Parse(preAmout);
                }
                if (!string.IsNullOrWhiteSpace(beginDate))
                {
                    model.StartDate = DateTime.Parse(beginDate);
                }
                if (!string.IsNullOrWhiteSpace(endDate))
                {
                    try
                    {
                        model.EndDate = DateTime.Parse(endDate + " 23:59:59");
                    }
                    catch (Exception)
                    {
                        PrintJson("-1", "截止日期有误");
                    }

                }
                model.SortOrder = rows + 1;
                model.Id = Guid.NewGuid();
                model.CreateDate = DateTime.Now;
                model.Status = 1;
                model.StartDeadType = 1;
                model.EndDeadType = 1;
                if (model.Status == 1)
                {
                    var model2 = bll.GetUserAutoTenderQueueByUserId(userid);
                    if (model2 != null)
                    {
                        model2.SetDate = DateTime.Now;
                        var isUpdate = bll.UpdateUserAutoTenderQueue(model2);
                        if (!isUpdate)
                        {
                            PrintJson("0", "更新操作失败");
                        }
                    }
                    else
                    {
                        var model3 = new UserAutoTenderQueueInfo();
                        model3.Id = Guid.NewGuid();
                        model3.UserId = userid;
                        model3.StatusId = 0;
                        model3.SetDate = DateTime.Now;
                        model3.CreateDate = DateTime.Now;
                        var isAddQ = bll.AddUserAutoTenderQueue(model3);
                        if (!isAddQ)
                        {
                            PrintJson("0", "操作失败");
                        }
                    }
                }
                var isAdd = bll.AddUserAutoTenderSetting(model);
                if (isAdd)
                {
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = model.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                    log.UserId = userid.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                    StringBuilder content = new StringBuilder();
                    content.Append("[{\"项目类型:\":\"" + ProjectType + "\",\"年化率\":\"" + beginRate + "%-" + endRate + "%\",\"回购期限\":\"" + beginDeadline + "-" + endDeadline + "\",");
                    content.Append("\"还款类型\":\"" + RepaymentType + "\",\"预留金额\":\"" + ReservedAmout + "\",\"投标金额\":\"" + preAmout + "\",\"有效期\":\"" + beginDate + "~" + endDate + "\"}]");
                    log.Content1 = "添加自动投标:" + content.ToString();
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);


                    SysLogHelper.WriteTraceLog("添加自动投标", content.ToString());
                    PrintJson("1", "操作成功");
                }
                else
                {
                    PrintJson("0", "对不起,操作失败");
                }
            }
        }
        #endregion
        #region 旧的更新自动投标
        /// <summary>
        /// 更新自动投标
        /// </summary>
        public void updateAutoOld()
        {
            string ProjectType = Context.Request["ProjectType"];
            string beginRate = Context.Request["beginRate"];
            string endRate = Context.Request["endRate"];
            string beginDeadline = Context.Request["beginDeadline"];
            string endDeadline = Context.Request["endDeadline"];
            string RepaymentType = Context.Request["RepaymentType"];
            string ReservedAmout = Context.Request["ReservedAmout"];

            //Modify by xieyun 2015-07-30
            string preAmout = "";
            if (string.IsNullOrEmpty(Context.Request["preAmout"]))
            {
                preAmout = "100000000";
            }
            else
            {
                preAmout = Context.Request["preAmout"];
            }
            //string preAmout = Context.Request["preAmout"];
            string beginDate = Context.Request["beginDate"];
            string endDate = Context.Request["endDate"];
            string strid = Context.Request["id"];
            var bll = new UserAutoTenderSettingBLL();
            lock (lockobj)
            {
                Guid userid = WebUserAuth.UserId.Value;
                Guid id = Guid.Parse(strid);
                //UserAutoTenderSetting model = db.UserAutoTenderSettings.FirstOrDefault(p => p.Id == id && p.UserId == userid);
                var model = bll.GetUserAutoTenderSettingById(id);
                if (model == null)
                {
                    PrintJson("0", "操作失败");
                    return;
                }
                StringBuilder content = new StringBuilder();
                content.Append("{\"更新前\":[{\"标Id\":\"" + model.Id + "\",\"项目类型:\":\"" + model.ProjectType + "\",\"年化率\":\"" + model.StartRate + "%-" + model.EndRate + "%\"");
                content.Append(",\"回购期限\":\"" + model.StartDeadLine + "-" + model.EndDeadLine + "\",");
                content.Append("\"还款类型\":\"" + model.RepaymentType + "\",\"预留金额\":\"" + model.ReservedAmout + "\",");
                content.Append("\"投标金额\":\"" + model.PreAmout + "\",\"有效期\":\"" + model.StartDate + "~" + model.EndDate + "\"}]");

                model.ProjectType = ProjectType;
                if (!string.IsNullOrWhiteSpace(beginRate))
                {
                    model.StartRate = decimal.Parse(beginRate);
                }
                if (!string.IsNullOrWhiteSpace(endRate))
                {
                    model.EndRate = decimal.Parse(endRate);
                }
                if (!string.IsNullOrWhiteSpace(beginDeadline))
                {
                    model.StartDeadLine = int.Parse(beginDeadline);
                }
                if (!string.IsNullOrWhiteSpace(endDeadline))
                {
                    model.EndDeadLine = int.Parse(endDeadline);
                }
                model.RepaymentType = RepaymentType;
                if (!string.IsNullOrWhiteSpace(ReservedAmout))
                {
                    model.ReservedAmout = decimal.Parse(ReservedAmout);
                }

                if (model.PreAmout != 100000000)
                {
                    model.PreAmout = Tool.SafeConvert.ToDecimal(preAmout);
                }
                /*******修改为1亿
                if (!string.IsNullOrWhiteSpace(preAmout))
                {
                    model.PreAmout = decimal.Parse(preAmout);
                }
                *****/
                //////////////////
                if (!string.IsNullOrWhiteSpace(beginDate))
                {
                    model.StartDate = DateTime.Parse(beginDate);
                }
                if (!string.IsNullOrWhiteSpace(endDate))
                {
                    model.EndDate = DateTime.Parse(endDate + " 23:59:59");
                }

                if (model.Status == 1)
                {
                    //UserAutoTenderQueue model2 = db.UserAutoTenderQueues.FirstOrDefault(p => p.UserId == userid);
                    var model2 = bll.GetUserAutoTenderQueueByUserId(userid);
                    if (model2 != null)
                    {
                        model2.SetDate = DateTime.Now;
                        var isUpdateQ = bll.UpdateUserAutoTenderQueue(model2);
                        if (!isUpdateQ)
                        {
                            PrintJson("0", "操作失败");
                        }
                    }
                    else
                    {
                        //UserAutoTenderQueue model3 = new UserAutoTenderQueue();
                        var model3 = new UserAutoTenderQueueInfo();
                        model3.Id = Guid.NewGuid();
                        model3.UserId = userid;
                        model3.StatusId = 0;
                        model3.SetDate = DateTime.Now;
                        model3.CreateDate = DateTime.Now;
                        //db.UserAutoTenderQueues.AddObject(model3);
                        var isAddQ = bll.AddUserAutoTenderQueue(model3);
                        if (!isAddQ)
                        {
                            PrintJson("0", "操作失败");
                        }
                    }
                }
                var isUpdate = bll.UpdateUserAutoTenderSetting(model);
                //if (db.SaveChanges() > 0)
                if (isUpdate)
                {

                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.UserId = userid.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                    content.Append(",\"更新后\":[{\"标Id\":\"" + id + "\",\"项目类型:\":\"" + ProjectType + "\",\"年化率\":\"" + beginRate + "%-" + endRate + "%\",\"回购期限\":\"" + beginDeadline + "-" + endDeadline + "\",");
                    content.Append("\"还款类型\":\"" + RepaymentType + "\",\"预留金额\":\"" + ReservedAmout + "\",\"投标金额\":\"" + preAmout + "\",\"有效期\":\"" + beginDate + "~" + endDate + "\"}]}");
                    log.Content1 = "更新自动投标信息" + content.ToString();
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);
                    //LogHelper.WriteLog("更新自动投标", "", content.ToString());
                    SysLogHelper.WriteTraceLog("更新自动投标", content.ToString());
                    PrintJson("1", "操作成功");
                }
                else
                {
                    PrintJson("0", "操作失败");
                }
            }
        }
        #endregion
        /// <summary>
        /// 删除自动投标
        /// </summary>
        public void deleteAutoOld()
        {
            string strid = Context.Request["id"];
            string DelId = "";
            Guid userid = WebUserAuth.UserId.Value;
            StringBuilder content = new StringBuilder();

            Guid id = Guid.Parse(strid);
            var bll = new UserAutoTenderSettingBLL();
            //UserAutoTenderSetting model = db.UserAutoTenderSettings.FirstOrDefault(p => p.Id == id && p.UserId == userid);
            var model = bll.GetUserAutoTenderSettingById(id);
            content.Append("[{\"标Id\":\"" + model.Id + "\",\"项目类型:\":\"" + model.ProjectType + "\",\"年化率\":\"" + model.StartRate + "%-" + model.EndRate + "%\"");
            content.Append(",\"回购期限\":\"" + model.StartDeadLine + "-" + model.EndDeadLine + "\",");
            content.Append("\"还款类型\":\"" + model.RepaymentType + "\",\"预留金额\":\"" + model.ReservedAmout + "\",");
            content.Append("\"投标金额\":\"" + model.PreAmout + "\",\"有效期\":\"" + model.StartDate + "~" + model.EndDate + "\"}]");
            //db.UserAutoTenderSettings.DeleteObject(model);

            DelId = model.Id.ToString();
            int sort = model.SortOrder ?? 1;
            //IQueryable<UserAutoTenderSetting> setlist2 = db.UserAutoTenderSettings.Where(p => p.UserId == userid && p.Id != id && p.SortOrder > sort);
            var setlist2 = bll.GetUserAutoTenderSettingListByUserId(userid)
                .Where(o => o.Id != id && o.SortOrder > sort).ToList();

            var isUpdSort = false;
            if (setlist2 != null && setlist2.Count > 0)
            {
                foreach (var temp in setlist2)
                {
                    temp.SortOrder = temp.SortOrder - 1;
                    isUpdSort = bll.UpdateUserAutoTenderSettingSortOrder(temp.Id, temp.SortOrder.Value);
                    if (!isUpdSort)
                    {
                        PrintJson("0", "操作失败");
                    }
                }
            }

            var count = bll.GetUserAutoTenderSettingListByUserId(userid)
                .Where(o => o.Id != id && o.Status == 1).ToList().Count;
            //if (!db.UserAutoTenderSettings.Any(p => p.Status == 1 && p.UserId == userid && p.Id != id))
            if (count == 0)
            {
                //UserAutoTenderQueue model2 = db.UserAutoTenderQueues.FirstOrDefault(p => p.UserId == userid);
                var model2 = bll.GetUserAutoTenderQueueByUserId(userid);
                if (model2 != null)
                {
                    //db.UserAutoTenderQueues.DeleteObject(model2);
                    var isDelQ = bll.DeteleUserAutoTenderQueueById(model2.Id);
                    if (!isDelQ)
                    {
                        PrintJson("0", "操作失败");
                    }
                }
            }
            var isDel = bll.DeleteUserAutoTenderSettingById(id);
            //if (db.SaveChanges() > 0)
            if (isDel)
            {
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Delete;
                log.UserId = userid.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.AutoTender;
                log.Content1 = "删除自动投标:" + content.ToString();
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);
                //LogHelper.WriteLog("删除自动投标", "", content.ToString());
                SysLogHelper.WriteTraceLog("删除自动投标", content.ToString());
                PrintJson("1", "操作成功");
            }
            else
            {
                PrintJson("0", "操作失败");
            }
        }
        #endregion

        #region 投资记录
        /// <summary>
        /// 我的智享计划投资记录
        /// </summary>
        public void GetZxReturnList()
        {
            string strOrderBy = Context.Request.Form["orderBy"].ToString();
            string status = Context.Request.Form["status"].ToString();
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int total = 0;
            List<ZXWxInvestShowModel> list = new ZXWXSelectBLL().GetZxWxInvestShowModels(userid, pageindex, pagesize,
                status, strOrderBy, out total);

            totalItemCount = total;
            int pageCount = GetPageCount();

            if (list != null && list.Count > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (var model in list)
                {
                    string Type = "智享计划";
                    string PreCycDate = model.PreCycDate == null ? "" : Convert.ToDateTime(model.PreCycDate).ToString("yyyy-MM-dd");
                    string Title = (model.Title.Length > 16 ? model.Title.Substring(0, 16) + "..." : model.Title);
                    string tenderModel = "网站";
                    tenderModel = WXConverter.GetTenderModeString(model.TenderMode);
                    sb.AppendLine("{\"Type\":\"" + Type + "\",\"Title\":\"" + Title + "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(model.Amount)
                          + "\",\"TenderMode\":\"" + tenderModel + "\",\"RefundedMonths\":\"" + model.RefundedMonths + "\",\"TotalRefundMonths\":\"" + model.TotalRefundMonths
                          + "\",\"Status\":\"" + WXConverter.GetSubscribeStatusString(37, model.Status, model.IsBorrow) + "\",\"PreCycDate\":\"" + PreCycDate
                          + "\",\"SubscribeId\":\"" + model.SubscribeId + "\",\"ProjectId\":\"" + model.ProjectId
                          + "\",\"SubscribeDate\":\"" + Convert.ToDateTime(model.AddDate).ToString("yyyy-MM-dd")
                          + "\"}");

                    if (index == list.Count())
                    {
                        sb.Append("]}");
                    }
                    else
                    {
                        sb.Append(",");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"pageCount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();

        }
        /// <summary>
        /// 我的优质项目投资记录
        /// </summary>
        public void GetProjectReturnList()
        {
            string strOrderBy = Context.Request.Form["orderBy"].ToString();
            string status = Context.Request.Form["status"].ToString();
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int total = 0;
            //List<ZXWxInvestShowModel> list = new ZXWXSelectBLL().GetZxWxInvestShowModels(userid, pageindex, pagesize,
            //   status, strOrderBy, out total);



            RequestGetMyInvestListProject request = new RequestGetMyInvestListProject();
            request.pageIndex = pageindex;
            request.pageSize = pagesize;
            request.userId = WebUserAuth.UserId.Value;
            request.whereType = status == "Inprogress" ? 1 : status == "CompletedAndFlow" ? 2 : 3;
            request.orderBy = strOrderBy == "1" ? 0 : 1;//0倒序  1顺序

            string postUrl = GlobalUtils.SubApiUrl;
            string errorMsg = "";
            string response = TuanDai.HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName, postUrl + "/app/APPGetMyInvestListProject?userId=" + request.userId + "&pageIndex=" + request.pageIndex + "&pageSize=" + request.pageSize + "&whereType=" + request.whereType + "&orderBy=" + request.orderBy,
                "", out errorMsg, null, 3);
            ResponsePublicModel<ResponseGetMyInvestListProject> resModel = new ResponsePublicModel<ResponseGetMyInvestListProject>();
            if (!string.IsNullOrEmpty(response))
            {
                resModel = JsonConvert.DeserializeObject<ResponsePublicModel<ResponseGetMyInvestListProject>>(response);
            }


            if (resModel != null && resModel.data.dataList != null && resModel.data.dataList.Count > 0)
            {
                totalItemCount = resModel.data.totalCount;
                int pageCount = GetPageCount();
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (var model in resModel.data.dataList)
                {

                    string PreCycDate = model.preCycDate == null ? "" : Convert.ToDateTime(model.preCycDate).ToString("yyyy-MM-dd");
                    string Title = (model.title.Length > 16 ? model.title.Substring(0, 16) + "..." : model.title);
                    Guid ti;
                    if (Guid.TryParse(model.tranId,out ti))
                    {
                        string sql = "select m_title as Title from t_SubScribeTransfer with(nolock) where m_id =@tranId";
                        Dapper.DynamicParameters para = new Dapper.DynamicParameters();
                        para.Add("@tranId", Guid.Parse(model.tranId));
                        var tran =
                            TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<ProjectZQZRDetailInfo>(TdConfig.ApplicationName,
                                TdConfig.DBRead, sql, ref para);
                        if (tran != null)
                        {
                            Title = tran.Title;
                        }
                        else
                        {
                            Title = "P2P转让";
                        }
                        
                    }
                    string tenderModel = "网站";
                    tenderModel = WXConverter.GetTenderModeString(model.tenderMode);
                    sb.AppendLine("{\"Type\":\"" + ToolStatus.ConvertProjectType((int)model.type) + "\",\"Title\":\"" + Title + "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(model.amount)
                          + "\",\"TenderMode\":\"" + tenderModel + "\",\"RefundedMonths\":\"" + model.refundedMonths + "\",\"TotalRefundMonths\":\"" + model.totalRefundMonths
                          + "\",\"Status\":\"" + WXConverter.GetSubscribeStatusString(model.type, model.status, !model.isOverDue) + "\",\"PreCycDate\":\"" + PreCycDate
                          + "\",\"SubscribeId\":\"" + model.investId + "\",\"ProjectId\":\"" + model.projectId
                          + "\",\"SubscribeDate\":\"" + Convert.ToDateTime(model.addDate).ToString("yyyy-MM-dd")
                          + "\"}");

                    if (index == resModel.data.dataList.Count())
                    {
                        sb.Append("]}");
                    }
                    else
                    {
                        sb.Append(",");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"pageCount\":\"" + 0 + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();

        }
        public void GetReturnList()
        {
            string strSearchType = Context.Request.Form["searchType"].ToString();
            string strOrderBy = Context.Request.Form["orderBy"].ToString();

            string status = Context.Request.Form["status"].ToString();
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            if (strSearchType == "ZxPlan")
            {//已投资智享计划列表
                GetZxReturnList();
                return;
            }

            if (GlobalUtils.IsOpenSubscribeApi)
            {
                if (strSearchType == "Disperse")
                {//已投资散标列表
                    GetProjectReturnList();
                    return;
                }
            }
            

            double floatProfit = projectBll.GetSimubaoBaseHold(userid).Profit;
            bool isAddedSmb = projectBll.WXGetIsAddedSmb(userid);

            StringBuilder sb = new StringBuilder();
            SuperMyInvestList_Info resultObj = projectBll.WXGetReturnList(userid, status, strSearchType, strOrderBy, pagesize, pageindex);

            //移除非完成状态的数据
            //if (status == "CompletedAndFlow")
            //{
            //    resultObj.List.RemoveAll(p =>p.Type.Value ==100 && p.WeStatus != 2);
            //}

            totalItemCount = resultObj != null ? resultObj.Total : 0;
            int pageCount = GetPageCount();
            decimal RecoverBorrowOut = resultObj != null ? resultObj.AmountReceived : 0;
            decimal AmountCast = resultObj != null ? resultObj.AmountCast : 0;
            if (resultObj != null && resultObj.List.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"FloatProfit\":\"" + ToolStatus.ConvertLowerMoney(floatProfit) + "\",\"IsAddedSmb\":\"" + isAddedSmb.ToString().ToLower() + "\",\"RecoverBorrowOut\":\"" + ToolStatus.ConvertLowerMoney(RecoverBorrowOut) +
                              "\",\"WeAmountCast\":\"" + ToolStatus.ConvertLowerMoney(AmountCast) + "\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXInvestProject model in resultObj.List)
                {
                    string Type = model.Type == null ? "" : ((model.Type ?? 0) == 100 ? GetWePlanTitle(model.Title, 1) : ToolStatus.ConvertProjectType((int)model.Type));
                    string PreCycDate = model.PreCycDate == null ? "" : Convert.ToDateTime(model.PreCycDate).ToString("yyyy-MM-dd");
                    string Process = Tool.WebFormHandler.ProcessBar(Convert.ToDecimal(model.CastedShares), Convert.ToDecimal(model.TotalShares), 1);
                    string Title = (model.Type ?? 0) == 100 ? model.Title : (model.Title.Length > 16 ? model.Title.Substring(0, 16) + "..." : model.Title);
                    string tenderModel = "网站";
                    if (model.Type.Value == 100)
                    {
                        tenderModel = WXConverter.GetWeDeviceTypeString(model.TenderMode);
                    }
                    else
                    {
                        tenderModel = WXConverter.GetTenderModeString(model.TenderMode);
                    }
                    sb.AppendLine("{\"Type\":\"" + Type + "\",\"Title\":\"" + Title + "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(model.Amount)
                          + "\",\"TenderMode\":\"" + tenderModel + "\",\"RefundedMonths\":\"" + model.RefundedMonths + "\",\"TotalRefundMonths\":\"" + model.TotalRefundMonths
                          + "\",\"Status\":\"" + WXConverter.GetSubscribeStatusString(model.Type, model.Status, model.IsBorrow) + "\",\"PreCycDate\":\"" + PreCycDate + "\",\"Process\":\"" + Process
                          + "\",\"SubscribeId\":\"" + model.SubscribeId + "\",\"ProjectId\":\"" + model.ProjectId
                          + "\",\"SubscribeDate\":\"" + Convert.ToDateTime(model.SubscribeDate).ToString("yyyy-MM-dd")
                          + "\",\"InterestAmount\":\"" + ToolStatus.ConvertLowerMoney(model.InterestAmount)
                          + "\",\"CountInterestPrice\":\"" + ToolStatus.ConvertLowerMoney(model.CountInterestPrice)
                          + "\",\"CountInterestRate\":\"" + ToolStatus.ConvertLowerMoney(model.CountInterestRate)
                          + "\",\"ProfitTypeId\":\"" + model.ProfitTypeId //收益方式
                          + "\",\"TotalMoney\":\"" + ToolStatus.ConvertLowerMoney(model.Amount + model.InterestAmount) //待收本息
                          + "\",\"WeStatus\":\"" + model.WeStatus
                          + "\",\"PurchaseAmount\":\"" + ToolStatus.ConvertLowerMoney(model.PurchaseAmount)
                          + "\",\"PaymentNumber\":\"" + model.WeTotalbid
                          + "\",\"ProjectType\":\"" + model.Type
                          + "\",\"IsWeFQB\":\"" + (model.IsWeFQB ? "1" : "0")
                          + "\",\"StatusDate1\":\"" + (model.StatusDate1 == null ? "" : Convert.ToDateTime(model.StatusDate1).ToString("yyyy-MM-dd"))
                          + "\",\"RepeatInvestType\":\"" + model.RepeatInvestType
                          + "\",\"HoldDay\":\"" + model.HoldDay + "\"}");

                    if (index == resultObj.List.Count())
                    {
                        sb.Append("]}");
                    }
                    else
                    {
                        sb.Append(",");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"FloatProfit\":\"" + ToolStatus.ConvertLowerMoney(floatProfit) + "\",\"IsAddedSmb\":\"" + isAddedSmb.ToString().ToLower() + "\",\"RecoverBorrowOut\":\"" + ToolStatus.ConvertLowerMoney(RecoverBorrowOut) +
                          "\",\"WeAmountCast\":\"" + ToolStatus.ConvertLowerMoney(AmountCast) + "\",\"pageCount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();

        }
        /// <summary>
        /// 获得we计划的Title
        /// </summary>
        /// <param name="productName"></param>
        /// <param name="flag"></param>
        /// <returns></returns>
        private string GetWePlanTitle(string productName, int flag)
        {
            if (flag == 1)
            {
                return productName.GetCharLeft("(").Trim();
            }
            else
            {
                return productName.GetCharRight("(").GetCharLeft(")").Trim();
            }
        }
        /// <summary>
        /// 获取We计划投资列表
        /// </summary>
        public void GetWeProjectList()
        {
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid weOrderId = WEBRequest.GetFormGuid("WeOrderId");
            StringBuilder sb = new StringBuilder();
            MyInvestWeDetail_Info resultObj = projectBll.GetMyInvestWeDetail(userid, weOrderId, pageindex, pagesize);
            totalItemCount = resultObj != null ? resultObj.Total : 0;
            int pageCount = GetPageCount();
            if (resultObj.List.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"ProductName\":\"" + GetWePlanTitle(resultObj.ProductName, 1) +
                            "\",\"OrderDate\":\"" + resultObj.OrderDate.ToString("yyyy-MM-dd") +
                            "\",\"YearRate\":\"" + ToolStatus.DeleteZero(resultObj.YearRate) + "%" +
                            "\",\"Deadline\":\"" + resultObj.Deadline + "个月" +
                            "\",\"StatusId\":\"" + resultObj.StatusId +
                            "\",\"OrderStatus\":\"" + resultObj.OrderStatus +
                            "\",\"OrderAviAmount\":\"" + ToolStatus.ConvertLowerMoney(resultObj.OrderAviAmount) +
                            "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(resultObj.Amount) +
                            "\",\"AmountInvestment\":\"" + ToolStatus.ConvertLowerMoney(resultObj.AmountInvestment) +
                            "\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (SubMyInvestWeDetail_Info model in resultObj.List)
                {
                    string ProjectType = model.Type == 15 ? (model.SubType == 1 ? "分期宝" : model.SubType == 2 ? "分期乐" : "小树时代") : ToolStatus.ConvertProjectType((int)model.Type);
                    string Title = model.Title.Length > 20 ? model.Title.Substring(0, 20) + "..." : model.Title;

                    sb.Append("{\"ProjectType\":\"" + ProjectType + "\",\"Title\":\"" + Title + "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(model.Amount)
                        + "\",\"SubscribeId\":\"" + model.InvestId
                        + "\",\"Type\":\"" + model.Type
                        + "\",\"RefundedMonths\":\"" + model.RefundedMonths
                        + "\",\"TotalRefundMonths\":\"" + model.TotalRefundMonths
                        + "\",\"StatusDesc\":\"" + GetWeProjectStatusDesc(model)
                        + "\",\"ProjectId\":\"" + model.ProjectId
                        + "\",\"AddDate\":\"" + model.AddDate.ToString("yyyy-MM-dd")
                        + "\",\"TotalRecord\":\"" + model.TotalRecord +
                        (index == resultObj.List.Count() ? "\"}]}" : "\"},"));

                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"ProductName\":\"" + GetWePlanTitle(resultObj.ProductName, 1) +
                            "\",\"OrderDate\":\"" + resultObj.OrderDate.ToString("yyyy-MM-dd") +
                            "\",\"YearRate\":\"" + ToolStatus.DeleteZero(resultObj.YearRate) + "%" +
                            "\",\"Deadline\":\"" + resultObj.Deadline + "个月" +
                            "\",\"StatusId\":\"" + resultObj.StatusId +
                            "\",\"OrderStatus\":\"" + resultObj.OrderStatus +
                            "\",\"OrderAviAmount\":\"" + ToolStatus.ConvertLowerMoney(resultObj.OrderAviAmount) +
                            "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(resultObj.Amount) +
                            "\",\"AmountInvestment\":\"" + ToolStatus.ConvertLowerMoney(resultObj.AmountInvestment) +
                            "\",\"pageCount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        /// <summary>
        /// 得到页数
        /// </summary>
        /// <returns></returns>
        public int GetPageCount()
        {
            double divide = totalItemCount / pagesize;
            double floor = System.Math.Floor(divide);
            if (totalItemCount % pagesize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数
            return pageCount;
        }
        private string GetWeProjectStatusDesc(SubMyInvestWeDetail_Info model)
        {
            string cycleDate = model.FirstDate.ToString("yyyy-MM-dd") == "1900-01-01" ? "暂无" : model.FirstDate.ToString("yyyy-MM-dd");
            if (model.Status == 1 || model.Status == 2)
                return "等待满标";
            else if (model.Status == 3)
            {

                return cycleDate + " 回款(" + model.RefundedMonths + "/" + model.TotalRefundMonths + ")";
            }
            else if (model.Status == 4)
            {
                return cycleDate + " 已流标";
            }
            else if (model.Status == 5)
            {
                return " 已逾期";
            }
            else if (model.Status == 6)
            {
                return cycleDate + " 已完成";
            }
            return "";
        }
        private string GetWeProjectStatus(int status)
        {
            //投标中 3：还款中 4：已流标 5：已逾期 6：已完成 
            if (status == 1 || status == 2)
                return "投标中";
            else if (status == 3)
                return "还款中";
            else if (status == 4)
                return "已流标";
            else if (status == 5)
                return "已逾期";
            else if (status == 6)
                return "已完成";
            return "";
        }
        #endregion

        #region 债权转让承接记录
        /// <summary>
        /// 债权转让承接记录
        /// </summary>
        public void GetDebtCarryBind()
        {
            Guid userid = WebUserAuth.UserId.Value;
            List<InvestingProject> list = null;

            string Status = Context.Request.Form["status"].ToString();
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            var count1 = 0;
            var count2 = 0;
            if (userid != Guid.Empty)
            {
                var _status = 0;
                switch (Status)
                {
                    case "All"://所有
                        _status = 0;
                        break;
                    case "Inprogress"://回收中
                        _status = 2;
                        break;
                    case "Overdue"://逾期
                        _status = 3;
                        break;
                    case "CompletedAndFlow"://完成
                        _status = 4;
                        break;
                }

                var param = new Dapper.DynamicParameters();
                param.Add("@UserId", userid);
                param.Add("@Status", _status);
                param.Add("@Month", 0);
                param.Add("@Count", 0, DbType.Int32, ParameterDirection.Output);
                param.Add("@PageNum", 0, DbType.Int32, ParameterDirection.Output);
                param.Add("@PageCountPer", 8);
                param.Add("@Page", pageindex);
                param.Add("@Count2", 0, DbType.Int32, ParameterDirection.Output);
                param.Add("@Count3", 0, DbType.Int32, ParameterDirection.Output);
                param.Add("@Count4", 0, DbType.Int32, ParameterDirection.Output);
                //using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ReadConnectionString))
                //{
                //    list = connection.Query<InvestingProject>("p_ShowTransferSubscribe", param, null, true, null, CommandType.StoredProcedure).ToList();
                //    count1 = param.Get<int>("@Count");
                //    connection.Close();
                //    connection.Dispose();
                //}

                //string con = DBConfig.GetCon(path, ref errorMessage);

                list = TuanDai.DB.TuanDaiDB.Query<InvestingProject>(TuanDai.WXApiWeb.TdConfig.DBRead, "Exec p_ShowTransferSubscribe @UserId,@Status,@Month,@Count out,@PageNum out,@PageCountPer,@Page,@Count2 out,@Count3 out,@Count4 out",
                    ref param);
                count1 = param.Get<int>("@Count");
                if (_status == 2)
                {
                    var list1 = new List<InvestingProject>();
                    var param1 = new Dapper.DynamicParameters();
                    param1.Add("@UserId", userid);
                    param1.Add("@Status", 3);
                    param1.Add("@Month", 0);
                    param1.Add("@Count", null, DbType.Int32, ParameterDirection.Output);
                    param1.Add("@PageNum", null, DbType.Int32, ParameterDirection.Output);
                    param1.Add("@PageCountPer", 8);
                    param1.Add("@Page", pageindex);
                    param1.Add("@Count2", null, DbType.Int32, ParameterDirection.Output);
                    param1.Add("@Count3", null, DbType.Int32, ParameterDirection.Output);
                    param1.Add("@Count4", null, DbType.Int32, ParameterDirection.Output);
                    //using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ReadConnectionString))
                    //{
                    //    list1 = connection.Query<InvestingProject>("p_ShowTransferSubscribe", param1, null, true, null, CommandType.StoredProcedure).ToList();
                    //    count2 = param1.Get<int>("@Count");
                    //    connection.Close();
                    //    connection.Dispose();
                    //}
                    list1 = TuanDai.DB.TuanDaiDB.Query<InvestingProject>(TdConfig.DBRead, "Exec p_ShowTransferSubscribe @UserId,@Status,@Month,@Count out,@PageNum out,@PageCountPer,@Page,@Count2 out,@Count3 out,@Count4 out",
                    ref param1);
                    count2 = param1.Get<int>("@Count");
                    if (list1 != null && list1.Count > 0)
                    {
                        list.AddRange(list1);
                    }
                }
            }
            if (list != null && list.Count > 0)
            {
                foreach (var item in list)
                {
                    item.DetailList = GetSubscribeDetailListNew(item.Id);
                    if (item.DetailList != null && item.DetailList.Count > 0)
                    {
                        var m = item.DetailList.Where(o => o.Status == 1).ToList();
                        if (m != null && m.Any())
                            item.NextCycDate = m.OrderBy(o => o.CycDate).FirstOrDefault().CycDate.ToString("yyyy-MM-dd");
                    }
                    item.NextCycDate = item.NextCycDate.ToText();
                }

                var jsonDemo = new JsonDemo();
                jsonDemo.PageNum = (int)Math.Ceiling(((count1 + count2) / 8.0));
                jsonDemo.list = list;
                this.Context.Response.Write(JsonHelper.ToJson(jsonDemo));
                this.Context.Response.End();
            }
            else
            {
                PrintJson("0", "没有记录");
            }
        }
        protected List<SubscribeDetailInfo> GetSubscribeDetailListNew(Guid subscribeId)
        {
            List<SubscribeDetailInfo> sdList = new List<SubscribeDetailInfo>();
            //using (IDbConnection conn = new SqlConnection(TuanDai.Config.BaseConfig.ReadConnectionString))
            //{
            string sqlText = @"select CycDate,Amount,InterestAmout,ISNULL(InvestCommission,0) AS Commission,ISNULL(TuandaiRedPacket,0) AS TuandaiRedPacket,ISNULL(PublisherRedPacket,0)AS PublisherRedPacket,Periods,0 as OverDueAmount,0 RealAmount,0 AdvanceAmount,NULL IsRefundAdvance,1 Status
            from SubscribeDetail with(nolock)
            where SubscribeId=@SubscribeID
            order by Periods ";
            var para = new Dapper.DynamicParameters();
            para.Add("@SubscribeID", subscribeId);
            sdList = TuanDai.DB.TuanDaiDB.Query<SubscribeDetailInfo>(TdConfig.DBRead, sqlText, ref para);
            sqlText = @"select Adddate  CycDate,RealAmount Amount,RealInterestAmout InterestAmout,isnull(InvestCommission, 0) as Commission,isnull(TuandaiRedPacket, 0) TuandaiRedPacket,isnull(PublisherRedPacket, 0) PublisherRedPacket,Periods ,0 OverDueAmount,0 RealAmount,0 AdvanceAmount,NULL IsRefundAdvance,2 as Status ,'已回款' as [Desc] from SubscribeDetailHistory_h1 with(nolock) where SubscribeId=@SubscribeID order by Periods";
            var hlist = TuanDai.DB.TuanDaiDB.Query<SubscribeDetailInfo>(TdConfig.ApplicationName,
                TdConfig.DBSubDetailHisRead, sqlText, ref para);
            if (hlist != null && hlist.Count > 0)
            {
                sdList.AddRange(hlist);
            }
            if (sdList != null && sdList.Count > 0)
            {
                sdList = sdList.OrderBy(o => o.Periods).ToList();
            }
            return sdList;
        }
        #endregion


        #region 回款日历
        /// <summary>
        /// 回款日历获取数据
        /// </summary>
        public void GetFundPlan()
        {
            InvestProfit item = new InvestProfit();
            List<FundPlan> list;
            DateTime date = Tool.SafeConvert.ToDateTime(Context.Request.Form["Date"]);
            int activeIndex = Tool.SafeConvert.ToInt32(Context.Request.Form["ActiveIndex"]);
            if (activeIndex > 0)
            {
                date = DateTime.Parse(date.ToString("yyyy-MM-01")).AddMonths(activeIndex);
            }
            DateTime date2 = DateTime.Parse(DateTime.Now.ToString("yyyy-MM") + "-01");
            if (date < date2)
            {
                list = null;
                Context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(list));
                return;
            }
            if (date <= DateTime.Now)
            {
                if (DateTime.Now.Hour == 0 && DateTime.Now.Minute <= 15)
                {
                    date2 = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
                }
                else
                {
                    date2 = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd")).AddDays(1);
                }
            }
            else
            {
                date2 = date;
            }
            Guid userid = WebUserAuth.UserId.Value;
            var param = new Dapper.DynamicParameters();
            param.Add("@StartDate", date2);
            param.Add("@EndDate", date.AddMonths(1));
            param.Add("@UserID", userid);
            string tempsql = string.Empty;
            if (IsFqbUser())
            {
                tempsql = @"SELECT  CONVERT(VARCHAR(10),MAX(a.CycDate),120) AS CycDate , 
                                sum(isnull(a.Amount,0)) as TotalAmount,
                                SUM( CASE WHEN b.[TYPE]=15 THEN 
                                    case when c.OrgTypeId<>5 then  0 else ISNULL(a.InterestAmout,0) end  
                                    ELSE ISNULL(a.InterestAmout,0)  end ) AS TotalInterest,
                                SUM( CASE WHEN b.[TYPE]=15 THEN 
                                    case when c.OrgTypeId<>5 then  isnull(a.PublisherRedPacket,0)
                                    else ISNULL(a.BorrorCommission,0) + isnull(a.PublisherRedPacket,0) end  
                                    ELSE isnull(a.PublisherRedPacket,0) end ) AS JiangLi
                                FROM dbo.SubscribeDetail a with(nolock)
                                INNER JOIN dbo.Project b with(nolock) ON a.ProjectId=b.Id
                                left join fq_UserApply c  on a.ProjectId=c.ProjectId 
                                WHERE b.userid=@UserId AND CycDate>=@StartDate AND CycDate<@EndDate  AND b.Type<>17
                                GROUP BY Convert ( VARCHAR(10),CycDate,120)";
            }
            else
            {
                tempsql = @"SELECT  CONVERT(VARCHAR(10),MAX(a.CycDate),120) AS CycDate , 
                                sum(isnull(a.Amount,0)) as TotalAmount,
                                SUM(ISNULL(a.InterestAmout,0)) AS TotalInterest,
                                SUM( isnull(a.PublisherRedPacket,0)) AS JiangLi
                                FROM dbo.SubscribeDetail a with(nolock)
                                WHERE a.borroweruserid=@UserId AND CycDate>=@StartDate AND CycDate<@EndDate
                                GROUP BY Convert ( VARCHAR(10),CycDate,120)";
            }
            //p2p库每天回款  还款明细
            string sqlText = @"SELECT CASE WHEN a.CycDate IS NOT NULL THEN a.CycDate ELSE b.CycDate END AS CycDate,
                                 CASE WHEN a.CycDate IS NOT NULL THEN datepart(day,a.CycDate)  ELSE  datepart(day,b.CycDate) END AS day, 
                                isnull(a.TotalAmount,0) as dueRecBenJin, isnull(a.TotalInterest,0) as dueRecShouYi, isnull(a.JiangLi,0) as dueRecJiangLi,
                                isnull(b.TotalAmount,0) as dueOutBenJin, isnull(b.TotalInterest,0) as dueOutLiXi,isnull(b.JiangLi,0) as dueOutJiangLi
                                FROM (
                                SELECT  CONVERT(VARCHAR(10),MAX(CycDate),120) AS CycDate, 
                                sum(isnull(Amount,0)) as TotalAmount,
                                SUM(ISNULL(InterestAmout,0)) as TotalInterest,
                                SUM(ISNULL(TuandaiRedPacket,0)) +SUM(ISNULL(PublisherRedPacket,0)) as JiangLi
                                FROM 
                                (SELECT  sd.CycDate,
                                CASE WHEN sd.InvestType IN(3,2) THEN 0 ELSE  sd.Amount END AS Amount,
                                CASE WHEN sd.InvestType = 3 THEN 0 ELSE sd.InterestAmout END AS InterestAmout,
                                CASE WHEN sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.TuandaiRedPacket,0) END AS TuandaiRedPacket,
                                CASE WHEN sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.PublisherRedPacket,0) END AS PublisherRedPacket  
                                FROM dbo.SubscribeDetail sd with(nolock) 
                                WHERE isnull(sd.InvestType,0)!=1 and sd.SubscribeUserId=@UserId AND sd.CycDate>=@StartDate AND sd.CycDate<@EndDate
                                union all
                                select we.CycDate, we.Amount, we.InterestAmount, we.TuanDaiRedPacket, we.PublisherRedPacket from dbo.We_OrderDetail we
                                where  we.CycDate>=@StartDate and we.CycDate<@EndDate and we.IsHandle=0 and we.UserId=@UserId
                                )temp  
                                GROUP BY Convert ( VARCHAR(10),CycDate,120)
                                )a
                                FULL JOIN ( " + tempsql +
                                ") b ON b.CycDate = a.CycDate " +
                                "order by day";

            //list = PublicConn.QueryBySql<FundPlan>(sqlText, ref param);
            list = new List<FundPlan>();
            item = new InvestProfit();
            if (list != null && list.Count > 0)
            {
                item.cycDate = list[0].cycDate;
                item.dueRecBenJin = list.Sum(p => p.dueRecBenJin);
                item.dueRecShouYi = list.Sum(p => p.dueRecShouYi);
                item.dueRecJiangLi = list.Sum(p => p.dueRecJiangLi);

                item.dueOutBenJin = list.Sum(p => p.dueOutBenJin);
                item.dueOutLiXi = list.Sum(p => p.dueOutLiXi);
                item.dueOutJiangLi = list.Sum(p => p.dueOutJiangLi);
            }

            if (GlobalUtils.IsOpenSubscribeApi)
            {

                //从聚合拿数据  查询回款计划按月 包括智享
                string postUrl = GlobalUtils.SubApiUrl;
                RequestGetBackListByMonth request = new RequestGetBackListByMonth();
                request.startDate = date2.ToString("yyyy-MM-dd HH:mm:ss");
                request.endDate = date.AddMonths(1).ToString("yyyy-MM-dd HH:mm:ss");
                request.userId = userid;
                request.haveOverdue = false;
                request.pageIndex = 1;
                request.pageSize = 15;
                string err = "";
                ResponsePublicModel<ResponseGetBackListByMonth> response =
                    new ResponsePublicModel<ResponseGetBackListByMonth>();
                string respJson = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName,
                    postUrl + "/app/APPGetBackSectionListByMonth",
                    JsonConvert.SerializeObject(request), out err, null, 5);
                if (!string.IsNullOrEmpty(respJson))
                {
                    response = JsonConvert.DeserializeObject<ResponsePublicModel<ResponseGetBackListByMonth>>(respJson);
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName,
                        "/app/APPGetBackSectionListByMonth", JsonConvert.SerializeObject(request), err);
                }


                if (response != null && response.data != null && response.data.dataList != null)
                {
                    item.dueRecBenJin = response.data.dataList.Sum(p => p.amount);
                    item.dueRecShouYi = response.data.dataList.Sum(p => p.interest);
                    item.dueRecJiangLi = 0;
                }

                //从聚合拿数据  查询回款计划按天 包括智享
                ResponsePublicModel<ResponseGetBackListByMonth> responseDay =
                    new ResponsePublicModel<ResponseGetBackListByMonth>();
                string respJsonDay = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName,
                    postUrl + "/app/APPGetBackSectionListByDay",
                    JsonConvert.SerializeObject(request), out err, null, 5);
                if (!string.IsNullOrEmpty(respJsonDay))
                {
                    responseDay =
                        JsonConvert.DeserializeObject<ResponsePublicModel<ResponseGetBackListByMonth>>(respJsonDay);
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName,
                        "/app/APPGetBackSectionListByDay", JsonConvert.SerializeObject(request), err);
                }
                if (responseDay != null && responseDay.data != null && responseDay.data.dataList != null)
                {
                    item.listBack = new List<FundPlan>(); //每天还款，聚合数据
                    foreach (var data in responseDay.data.dataList)
                    {
                        if (string.IsNullOrEmpty(item.cycDate))
                        {
                            item.cycDate = data.returnTime.ToString("yyyy-MM-dd");
                        }
                        FundPlan plan = new FundPlan();
                        plan.dueRecBenJin = data.amount;
                        plan.dueRecShouYi = data.interest;
                        plan.dueRecJiangLi = 0;
                        plan.cycDate = data.returnTime.ToString("yyyy-MM-dd");
                        plan.day = data.returnTime.Day;
                        item.listBack.Add(plan);
                    }
                }

                var listZxBack =
                    JsonConvert.DeserializeObject<List<FundPlan>>(
                        JsonConvert.SerializeObject(new ZXWXSelectBLL().GetZXWxUserWealthDateInfo(userid, date2,
                            date.AddMonths(1))));
                if (listZxBack != null && listZxBack.Count > 0)
                {
                    item.listZxBack = listZxBack;
                    item.dueOutZxBenJin = listZxBack.Sum(o => o.dueOutBenJin);
                    item.dueOutZxLiXi = listZxBack.Sum(o => o.dueOutLiXi);
                }

                if (list != null && list.Count > 0)
                {
                    item.list = list;
                    if (item.listBack != null && item.listBack.Count > 0)
                    {
                        foreach (var back in item.listBack)
                        {
                            if (item.list.Exists(o => o.day == back.day))
                            {
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueRecBenJin = back.dueRecBenJin);
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueRecShouYi = back.dueRecShouYi);
                            }
                            else
                            {
                                FundPlan plan = new FundPlan();
                                plan.dueRecBenJin = back.dueRecBenJin;
                                plan.dueRecShouYi = back.dueRecShouYi;
                                plan.dueRecJiangLi = 0;
                                plan.cycDate = back.cycDate;
                                plan.day = back.day;
                                item.list.Add(plan);
                            }
                        }
                    }
                    if (item.listZxBack != null && item.listZxBack.Count > 0)
                    {
                        foreach (var back in item.listZxBack)
                        {
                            if (item.list.Exists(o => o.day == back.day))
                            {
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueOutZxBenJin = back.dueOutBenJin);
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueOutZxLiXi = back.dueOutLiXi);
                            }
                            else
                            {
                                FundPlan plan = new FundPlan();
                                plan.dueOutZxBenJin = back.dueOutBenJin;
                                plan.dueOutZxLiXi = back.dueOutLiXi;
                                plan.cycDate = back.cycDate;
                                plan.day = back.day;
                                item.list.Add(plan);
                            }
                        }
                    }
                }
            }
            else
            {
                item.list = list;
                var listZxBack =
                    JsonConvert.DeserializeObject<List<FundPlan>>(
                        JsonConvert.SerializeObject(new ZXWXSelectBLL().GetZXWxUserWealthDateInfo(userid, date2,
                            date.AddMonths(1))));
                if (listZxBack != null && listZxBack.Count > 0)
                {
                    item.listZxBack = listZxBack;
                    item.dueOutZxBenJin = listZxBack.Sum(o => o.dueOutBenJin);
                    item.dueOutZxLiXi = listZxBack.Sum(o => o.dueOutLiXi);
                    item.dueRecBenJin += listZxBack.Sum(o => o.dueRecBenJin);
                    item.dueRecShouYi += listZxBack.Sum(o => o.dueRecShouYi);
                    item.dueRecJiangLi += listZxBack.Sum(o => o.dueRecJiangLi);
                    
                }

                if (list != null && list.Count > 0)
                {
                    item.list = list;
                    if (item.listBack != null && item.listBack.Count > 0)
                    {
                        foreach (var back in item.listBack)
                        {
                            if (item.list.Exists(o => o.day == back.day))
                            {
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueRecBenJin = back.dueRecBenJin);
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueRecShouYi = back.dueRecShouYi);
                            }
                            else
                            {
                                FundPlan plan = new FundPlan();
                                plan.dueRecBenJin = back.dueRecBenJin;
                                plan.dueRecShouYi = back.dueRecShouYi;
                                plan.dueRecJiangLi = 0;
                                plan.cycDate = back.cycDate;
                                plan.day = back.day;
                                item.list.Add(plan);
                            }
                        }
                    }
                    if (item.listZxBack != null && item.listZxBack.Count > 0)
                    {
                        foreach (var back in item.listZxBack)
                        {
                            if (item.list.Exists(o => o.day == back.day))
                            {
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueOutZxBenJin = back.dueOutBenJin);
                                item.list.Where(o => o.day == back.day)
                                    .ToList()
                                    .ForEach(o => o.dueOutZxLiXi = back.dueOutLiXi);
                                item.list.Where(o=>o.day == back.day).ToList().ForEach(o=>o.dueRecBenJin+=back.dueRecBenJin);
                                item.list.Where(o => o.day == back.day).ToList().ForEach(o => o.dueRecJiangLi += back.dueRecJiangLi);
                                item.list.Where(o => o.day == back.day).ToList().ForEach(o => o.dueRecShouYi += back.dueRecShouYi);
                            }
                            else
                            {
                                FundPlan plan = new FundPlan();
                                plan.dueOutZxBenJin = back.dueOutBenJin;
                                plan.dueOutZxLiXi = back.dueOutLiXi;
                                plan.cycDate = back.cycDate;
                                plan.day = back.day;
                                plan.dueRecBenJin = back.dueRecBenJin;
                                plan.dueRecJiangLi = back.dueRecJiangLi;
                                plan.dueRecShouYi = back.dueRecShouYi;
                                item.list.Add(plan);
                            }
                        }
                    }
                }
            }
            

            if (list == null || list.Count == 0)
            {
                item = new InvestProfit();
                item.cycDate = "该月无回款日";
                item.recBenJin = 0;
                item.recShouYi = 0;
                item.dueRecBenJin = 0;
                item.dueRecShouYi = 0;
                item.list = null;
            }
            string resultStr = JsonHelper.ToJson(item);
            Context.Response.Write(resultStr);
        }
        /// <summary>
        /// 获取当月的待收和已收(暂时发现未使用2017-11-22)
        /// </summary>
        public void GetInvestProfit()
        {
            InvestProfit item = new InvestProfit();
            DateTime date = Tool.SafeConvert.ToDateTime(Context.Request.Form["Date"]);
            date = DateTime.Parse(date.ToString("yyyy-MM-01"));
            int activeIndex = Tool.SafeConvert.ToInt32(Context.Request.Form["ActiveIndex"]);
            if (activeIndex > 0)
            {
                date = DateTime.Parse(date.ToString("yyyy-MM-01")).AddMonths(activeIndex);
            }
            Guid userid = WebUserAuth.UserId.Value;
            var param = new Dapper.DynamicParameters();
            param.Add("@StartDate", date);
            param.Add("@EndDate", date.AddMonths(1));
            param.Add("@UserID", userid);
            string sqlText = @" SELECT  cycDate , SUM(recBenJin) AS  recBenJin,
                                        SUM(Amount) recShouYi ,
                                        SUM(dueBenJin) AS dueBenJin,
                                        SUM(dueAmount) dueShouYi FROM (
                                SELECT ISNULL(InterestAmout,0)+ISNULL(PublisherRedPacket,0)+ISNULL(TuandaiRedPacket,0) AS dueAmount,
                                0 Amount,ISNULL(Amount, 0) AS dueBenJin,--待收本金
                                0 AS recBenJin,CONVERT(VARCHAR(7),CycDate,121) cycDate
                                FROM dbo.SubscribeDetail WITH(NOLOCK)  
                                WHERE SubscribeUserId=@UserID AND CycDate>@StartDate AND CycDate<@EndDate 
                                UNION ALL 
                                SELECT 0 dueAmount,ISNULL(RealInterestAmout,0)
                                +ISNULL(PublisherRedPacket,0)+ISNULL(TuandaiRedPacket,0) AS Amount,0 AS dueBenJin,
                                ISNULL(Amount, 0) AS recBenJin, --已还本金 
                                CONVERT(VARCHAR(7),ISNULL(a.RepayAdvanceDate,A.CycDate),121) cycDate 
                                FROM td_SubDetailHis.dbo.SubscribeDetailHistory_h1 a WITH(NOLOCK) 
                                WHERE NOT EXISTS (SELECT b.SubscribeId,b.periods FROM dbo.OverDueRecord b WITH(NOLOCK) where b.SubscribeId = a.SubscribeId AND b.Periods = a.periods 
                                and b.SubscribeUserId=@UserID AND b.IsBorrow=0  and isnull(b.IsHide,0)=0 ) and SubscribeUserId=@UserID   AND ISNULL(a.RepayAdvanceDate,A.CycDate)>@StartDate  AND ISNULL(a.RepayAdvanceDate,A.CycDate)<@EndDate 
                            )T  
                            GROUP BY CycDate ORDER BY cycDate";
            item = PublicConn.QuerySingle<InvestProfit>(sqlText, ref param);

            string resultStr = JsonHelper.ToJson(item);
            Context.Response.Write(resultStr);
        }
        /// <summary>
        /// 获取某一天的回款 还款项目列表
        /// </summary>
        public void GetReturnAndPayByDay()
        {
            var list = new List<ReturnAndPayProjectDetail>();

            DateTime dt = DateTime.Parse(Context.Request.Form["Date"]);
            var paras = new Dapper.DynamicParameters();
            paras.Add("@UserId", WebUserAuth.UserId.Value);
            paras.Add("@CycDate", dt.ToString("yyyy-MM-dd"));

            if (GlobalUtils.IsOpenSubscribeApi)
            {
                string postUrl = GlobalUtils.SubApiUrl;
                string err = "";
                string response = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName,
                    postUrl + "/wap/getReturnAndPayDetail?userId=" + WebUserAuth.UserId.Value + "&cycDate=" +
                    dt.ToString("yyyy-MM-dd") + " 00:00:00", "", out err, null, 5);
                if (!string.IsNullOrEmpty(response) && string.IsNullOrEmpty(err))
                {
                    ResponsePublicModel<List<ReturnAndPayProjectDetail>> model =
                        JsonConvert.DeserializeObject<ResponsePublicModel<List<ReturnAndPayProjectDetail>>>(response);
                    if (model != null && model.data != null)
                        list = model.data;
                }
                if(list == null)
                    list = new List<ReturnAndPayProjectDetail>();
                if (list != null && list.Count > 0)
                {
                    list = list.Where(o => o.Title != null && o.Title != "").ToList();//过滤掉we计划类
                }
                string sql = @"select   we.Amount, we.InterestAmount InterestAmout, isnull(we.TuanDaiRedPacket,0)+isnull(we.PublisherRedPacket,0) as  JiangLi,
                                100 as Type,pro.ProductName Title, 1 as Periods,1 as Deadline, 0 as SubTypeId,1 as IsReturn,0 as RepeatInvestType
                                from dbo.We_OrderDetail we
                                left join dbo.We_Product pro on pro.Id=we.ProductId
                                where Convert (VARCHAR(10),we.CycDate,120)=@CycDate and we.IsHandle=0 and we.UserId=@UserId";
                var welist = PublicConn.QueryBySql<ReturnAndPayProjectDetail>(sql, ref paras);
                if (welist != null && welist.Count > 0)
                {
                    list.AddRange(welist);
                }
                
                List<ZXWxReturnAndPayProjectDetail> returnAndPayProjectDetails =
                new ZXWXSelectBLL().GetReturnAndPayProjectDetails(userid, dt.ToString("yyyyMMdd"));
                if (returnAndPayProjectDetails != null && returnAndPayProjectDetails.Count > 0)
                {
                    var listzx =
                        JsonConvert.DeserializeObject<List<ReturnAndPayProjectDetail>>(
                            JsonConvert.SerializeObject(returnAndPayProjectDetails));
                    if (listzx != null && listzx.Count > 0)
                    {
                        foreach (var item in listzx)
                        {
                            list.Add(item);
                        }
                    }
                }
            }
            else
            {
                string sql = @" SELECT CASE WHEN sd.InvestType IN(3,2) THEN 0 ELSE  sd.Amount END AS Amount, 
                             CASE WHEN sd.InvestType = 3 THEN 0 ELSE sd.InterestAmout END AS InterestAmout,
                             CASE WHEN sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.TuandaiRedPacket,0)+ isnull(sd.PublisherRedPacket,0) END AS JiangLi,
                             p.Type,p.Title,sd.Periods,
                             CASE WHEN p.DeadType = 1 THEN p.Deadline ELSE 1 END AS Deadline,
                             0 AS SubTypeId ,1 AS IsReturn,ISNULL(sd.InvestType,0) AS RepeatInvestType
                              FROM dbo.SubscribeDetail sd with(nolock)  
                                INNER JOIN dbo.Project p with(nolock)  ON sd.ProjectId = p.Id
                                WHERE isnull(sd.InvestType,0)!=1 and  sd.SubscribeUserId=@UserId AND Convert (VARCHAR(10),sd.CycDate,120) =@CycDate
                                UNION ALL
                                SELECT sd.Amount,sd.InterestAmout,
                                CASE WHEN (p.[TYPE]=15 AND c.OrgTypeId=5) THEN  (ISNULL(sd.BorrorCommission,0) + isnull(sd.PublisherRedPacket,0))  ELSE isnull(sd.PublisherRedPacket,0) END AS JiangLi,
                                p.Type,p.Title,sd.Periods,CASE WHEN p.DeadType = 1 THEN p.Deadline ELSE 1 END AS Deadline,
                                CASE WHEN c.OrgTypeId = 5 THEN 2 ELSE 1 END AS SubTypeId,
                                0 AS IsReturn,0 AS RepeatInvestType 
                                FROM dbo.SubscribeDetail sd with(nolock)  
                                INNER JOIN dbo.Project p with(nolock)  ON sd.ProjectId = p.Id
                                left join fq_UserApply c with(nolock)   on p.Id=c.ProjectId
                                WHERE p.UserId=@UserId AND Convert ( VARCHAR(10),sd.CycDate,120) =@CycDate
                                union all
                                select   we.Amount, we.InterestAmount, isnull(we.TuanDaiRedPacket,0)+isnull(we.PublisherRedPacket,0) as  JiangLi,
                                100 as Type,pro.ProductName, 1 as Periods,1 as Deadline, 0 as SubTypeId,1 as IsReturn,0 as RepeatInvestType
                                from dbo.We_OrderDetail we
                                left join dbo.We_Product pro on pro.Id=we.ProductId
                                where Convert (VARCHAR(10),we.CycDate,120)=@CycDate and we.IsHandle=0 and we.UserId=@UserId";
                list = PublicConn.QueryBySqlSlow<ReturnAndPayProjectDetail>(sql, ref paras);

                List<ZXWxReturnAndPayProjectDetail> returnAndPayProjectDetails =
                new ZXWXSelectBLL().GetReturnAndPayProjectDetails(userid, dt.ToString("yyyyMMdd"));
                if (returnAndPayProjectDetails != null && returnAndPayProjectDetails.Count > 0)
                {
                    var listzx =
                        JsonConvert.DeserializeObject<List<ReturnAndPayProjectDetail>>(
                            JsonConvert.SerializeObject(returnAndPayProjectDetails));
                    if (listzx != null && listzx.Count > 0)
                    {
                        foreach (var item in listzx)
                        {
                            list.Add(item);
                        }
                    }
                }
            }



            foreach (var item in list)
            {
                if (item.Type == 100)
                {
                    item.TypeName = "复投宝";
                }
                else
                {
                    item.TypeName = invest_list.GetTypeName(item.Type, item.SubTypeId);
                }
            }
            string resultStr = JsonHelper.ToJson(list);
            PrintJson(resultStr);
        }
        #endregion


    }
    public class ReturnAndPayProjectDetail
    {
        /// <summary>
        /// 待付（回款）本金
        /// </summary>
        public decimal Amount { get; set; }
        /// <summary>
        /// 待付（回款）利息
        /// </summary>
        public decimal InterestAmout { get; set; }
        /// <summary>
        /// 待付（回款）奖励
        /// </summary>
        public decimal JiangLi { get; set; }
        /// <summary>
        /// 项目Type
        /// </summary>
        public int Type { get; set; }
        /// <summary>
        /// 标的类型
        /// </summary>
        public string TypeName { get; set; }
        /// <summary>
        /// 项目名称
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// 期数
        /// </summary>
        public int Periods { get; set; }
        /// <summary>
        /// 总期数
        /// </summary>
        public int Deadline { get; set; }

        public int SubTypeId { get; set; }
        /// <summary>
        /// 是否是回款  1回款 0还款
        /// </summary>
        public int IsReturn { get; set; }
        /// <summary>
        /// 复投类型 1本息复投 2本金复投 0非
        /// </summary>
        public int RepeatInvestType { get; set; }
    }
    public class MyReturnAndPayList
    {
        public int totalCount { get; set; }

        public List<MyReturnAndPayInfo> list { get; set; }
    }

    public class MyReturnAndPayInfo
    {
        public int TotalCount { get; set; }
        public string myMonth { get; set; }

        public decimal returnMoney { get; set; }

        public decimal payMoney { get; set; }

        public decimal payZxMoney { get; set; }

        public string myDate { get; set; }

        public decimal returnBen { get; set; }

        public decimal returnLi { get; set; }

        public decimal payBen { get; set; }

        public decimal payLi { get; set; }

        public decimal payZxBen { get; set; }

        public decimal payZxLi { get; set; }
    }
    public class JsonDemo
    {
        public int PageNum;
        public List<InvestingProject> list;
    }

    public class InvestProfit
    {
        /// <summary>
        /// 月份
        /// </summary>
        public string cycDate { get; set; }
        /// <summary>
        /// 当月已收本金
        /// </summary>
        public decimal recBenJin { get; set; }
        /// <summary>
        /// 当月已收收益
        /// </summary>
        public decimal recShouYi { get; set; }
        /// <summary>
        /// 当月待收本金
        /// </summary>
        public decimal dueRecBenJin { get; set; }
        /// <summary>
        /// 当月待收收益
        /// </summary>
        public decimal dueRecShouYi { get; set; }
        /// <summary>
        /// 当月待付本金
        /// </summary>
        public decimal dueOutBenJin { get; set; }
        /// <summary>
        /// 当月待付利息
        /// </summary>
        public decimal dueOutLiXi { get; set; }
        /// <summary>
        /// 待收奖励
        /// </summary>
        public decimal dueRecJiangLi { get; set; }
        /// <summary>
        /// 待付奖励
        /// </summary>
        public decimal dueOutJiangLi { get; set; }

        public List<FundPlan> list { get; set; }

        public List<FundPlan> listBack { get; set; }

        public List<FundPlan> listZxBack { get; set; }

        public decimal dueOutZxBenJin { get; set; }
        public decimal dueOutZxLiXi { get; set; }
    }
    public class FundPlan
    {
        public decimal inAmount
        {
            get
            {
                return dueRecBenJin + dueRecShouYi + dueRecJiangLi;
            }
        }
        public decimal outAmount
        {
            get
            {
                return dueOutBenJin + dueOutLiXi + dueOutJiangLi;
            }
        }
        public string cycDate { get; set; }
        public int day { get; set; }


        /// <summary>
        /// 当月待收本金
        /// </summary>
        public decimal dueRecBenJin { get; set; }
        /// <summary>
        /// 当月待收收益
        /// </summary>
        public decimal dueRecShouYi { get; set; }
        /// <summary>
        /// 当月待付本金
        /// </summary>
        public decimal dueOutBenJin { get; set; }
        /// <summary>
        /// 当月待付利息
        /// </summary>
        public decimal dueOutLiXi { get; set; }
        /// <summary>
        /// 待收奖励
        /// </summary>
        public decimal dueRecJiangLi { get; set; }
        /// <summary>
        /// 待付奖励
        /// </summary>
        public decimal dueOutJiangLi { get; set; }
        /// <summary>
        /// 智享待付本金
        /// </summary>
        public decimal dueOutZxBenJin { get; set; }
        /// <summary>
        /// 智享待付利息
        /// </summary>
        public decimal dueOutZxLiXi { get; set; }

    }
    public class InvestingProject
    {
        public Guid Id { get; set; }

        public int type { get; set; }

        public string ContractNo { get; set; }
        public Guid m_FromSubscribeId { get; set; }
        public Guid m_Id { get; set; }
        /// <summary>
        /// 购买日期
        /// </summary>
        public DateTime AddDate { get; set; }

        /// <summary>
        /// 标题
        /// </summary>
        public string m_Title { get; set; }

        /// <summary>
        /// 还款方式
        /// </summary>
        public int RepaymentType { get; set; }

        /// <summary>
        /// 利率
        /// </summary>
        public decimal ReceiveRate { get; set; }

        /// <summary>
        /// 购买的时候已经还得期数
        /// </summary>
        public int TranMonth { get; set; }

        /// <summary>
        /// 当前已经还的期数
        /// </summary>
        public int RefundedMonths { get; set; }

        /// <summary>
        /// 总期数
        /// </summary>
        public int TotalRefundMonths { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        public decimal Amount { get; set; }

        /// <summary>
        /// 待还利息
        /// </summary>
        public decimal InterestAmount { get; set; }
        /// <summary>
        /// 应计利息
        /// </summary>
        public decimal ReceiveInterest { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public int Status { get; set; }
        /// <summary>
        /// 是否提前还款
        /// </summary>
        public bool IsRepayAdvance { get; set; }
        /// <summary>
        /// 折让后的本金
        /// </summary>
        public decimal ReceiveAmount { get; set; }
        /// <summary>
        /// 回款明细列表
        /// </summary>
        public List<SubscribeDetailInfo> DetailList;
        /// <summary>
        /// 下次回款日期
        /// </summary>
        public string NextCycDate { get; set; }
    }
    /// <summary>
    /// 回款明细
    /// </summary>
    public class SubscribeDetailInfo
    {
        /// <summary>
        /// 还款时间
        /// </summary>
        public DateTime CycDate { get; set; }
        /// <summary>
        /// 本金
        /// </summary>
        public decimal Amount { get; set; }
        /// <summary>
        /// 利息
        /// </summary>
        public decimal InterestAmout { get; set; }
        /// <summary>
        /// 投资佣金
        /// </summary>
        public decimal Commission { get; set; }
        /// <summary>
        /// 团贷奖励
        /// </summary>
        public decimal TuandaiRedPacket { get; set; }
        /// <summary>
        /// 借款人奖励
        /// </summary>
        public decimal PublisherRedPacket { get; set; }
        /// <summary>
        /// 期数
        /// </summary>
        public int Periods { get; set; }
        /// <summary>
        /// 逾期本息
        /// </summary>
        public decimal OverDueAmount { get; set; }
        /// <summary>
        /// 逾期已还本息
        /// </summary>
        public decimal RealAmount { get; set; }
        /// <summary>
        /// 垫付金额
        /// </summary>
        public decimal AdvanceAmount { get; set; }
        /// <summary>
        /// 是否已还垫付
        /// </summary>
        public bool? IsRefundAdvance { get; set; }
        /// <summary>
        /// 回款状态（1待回款，2已回款）
        /// </summary>
        public int Status { get; set; }
    }
}