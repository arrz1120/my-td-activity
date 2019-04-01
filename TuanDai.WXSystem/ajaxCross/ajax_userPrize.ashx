﻿<%@ WebHandler Language = "C#"  Class="TuanDai.WXApiWeb.ajaxCross.ajax_userPrize" %>

using System;
using System.Security.Cryptography;
using System.Web;
using System.Linq;
using System.Web.SessionState;
using Tool;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using System.Data;
using TuanDai.UserPrizeNew.ServiceClient.Models;
using TuanDai.WXApiWeb.Member.UserPrize;
using TuanDai.WXSystem.Core;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Data.Objects;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using TuanDai.PortalSystem.DAL;


namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// 团宝箱
    /// </summary>
    public class ajax_userPrize : SafeHandlerBase
    {
        private int pagesize = 10;
        private int totalItemCount = 0;
        UserBLL bll = new UserBLL();
        Guid UserId = WebUserAuth.UserId.Value;

        /// <summary>
        /// 精美礼品
        /// </summary>
        public void GetGift()
        {
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            string orderField = Tool.SafeConvert.ToString(WEBRequest.GetString("orderField"), "CreateDate");
            string orderType = Tool.SafeConvert.ToString(WEBRequest.GetString("orderType"), "desc");
            int isUsed = Tool.SafeConvert.ToInt32(WEBRequest.GetString("isUsed"), 1);
            int sortType = Tool.SafeConvert.ToInt32(Context.Request.Form["sortType"], 2);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            
            List<SimpleUserPrize> list = null;
            string err = "";
            //var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
            //    .GetUserPrizeListForApp(
            //       UserId, 8, pageindex, pagesize, sortType, isUsed, out err);
            //if (response != null)
            //{
            //    list = JsonConvert.DeserializeObject<List<SimpleUserPrize>>(JsonConvert.SerializeObject(response.dataList));
            //    totalItemCount = response.totalCount;
            //}
            string url = UserPrizeServiceUrl +
                         "/prizes/getUserPrizeListForApp?userId="+UserId+"&type=8&pageIndex="+pageindex+"&pageSize="+pagesize+"&sortType="+sortType+"&isUsed="+isUsed;
            string result = HttpClient.HttpUtil.HttpPost("WXTouch", url, "", out err);
            TuanDai.LogSystem.LogClient.LogClients.TraceLog("WXTouch", "获取实物奖品", UserId.ToString(), result);
            if (!string.IsNullOrEmpty(result))
            {
                try
                {
                    BaseResponse<PagerResponse<SimpleUserPrize>> resp = JsonConvert.DeserializeObject<BaseResponse<PagerResponse<SimpleUserPrize>>>(result);
                    if (resp != null && resp.returnType == "OK" && resp.data != null)
                    {
                        list = resp.data.dataList;
                        totalItemCount = resp.data.totalCount;
                    }
                }
                catch (Exception ex)
                {
                    
                }
            }
            
            if (list == null)
                list = new List<SimpleUserPrize>();
            
            int pageCount = GetPageCount();

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                string ReceiveDateStr = "";//领取过期时间
                string CreateDateStr = "";//创建时间
                string ExpirationDateStr = "";
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + pageCount + "\",\"list\":[");
                foreach (SimpleUserPrize temp in list)
                {
                    if (temp.status == 2)
                    {
                        temp.IsReceive = true;
                    }
                    if (temp.IsReceive == false && temp.ReceiveEndDate.HasValue &&
                        temp.ReceiveEndDate.Value < DateTime.Now)//已过期
                    {
                        temp.IsUsed = 2;
                    }
                    int IsExpired = 0;
                    if (temp.TypeId == 22 && DateTime.Now > temp.ExpirationDate)
                    {
                        IsExpired = 1;
                    }
                    temp.LogisticStatus = GetWuLiuStatus(temp.Id);
                    
                    int IsReceive = temp.IsReceive ? 1 : 0;
                    
                    if (temp.IsReceive == false && temp.ReceiveEndDate.HasValue && temp.ReceiveEndDate.Value < DateTime.Now)
                        IsExpired = 1;

                    CreateDateStr = string.Format("{0}获得", temp.CreateDate.ToString("yyyy-MM-dd"));
                    
                    if (temp.ReceiveEndDate.HasValue && DateTime.Now < temp.ReceiveEndDate.Value)
                    {
                        if (
                            MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, temp.ReceiveEndDate.Value) ==
                            0)
                        {
                            ReceiveDateStr = "（今天到期）";
                        }
                        else
                        {
                            ReceiveDateStr = string.Format("（领取时间剩{0}天）",
                                MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                    temp.ReceiveEndDate.Value));
                        }

                    }
                    else if (temp.ReceiveEndDate.HasValue)
                    {
                        ReceiveDateStr = string.Format("（{0}过期）", temp.ReceiveEndDate.Value.ToString("yyyy-MM-dd"));
                    }
                    if (temp.ExpirationDate.HasValue)
                    {
                        double count = MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                            temp.ExpirationDate.Value);
                        ExpirationDateStr = string.Format("（{0}天后到期）", count);
                        if (count == 0)
                            ExpirationDateStr = "（今天到期）";
                    }

                    sb.Append("{\"Id\":\"" + temp.Id + "\",\"PrizeName\":\"" + temp.PrizeName + "\",\"Description\":\"" + temp.Description +
                                 "\",\"IsExpired\":\"" + IsExpired + "\",\"IsReceive\":\"" + IsReceive +
                                 "\",\"SourceFrom\":\"" + temp.SourceFrom + 
                                 "\",\"ReceiveDateStr\":\"" + ReceiveDateStr +
                                 "\",\"LogisticStatus\":\"" + temp.LogisticStatus + "\",\"OrderId\":\"" + temp.OrderId + "\",\"CreateDateStr\":\"" + CreateDateStr + "\",\"TypeId\":\"" + temp.TypeId + "\",\"ExpirationStr\":\"" + ExpirationDateStr + "\",\"ticket\":\"" + Decrypt3Des(temp.ticket, ConfigHelper.getConfigString("JDCardDescKey", "online109y36gb18jdcarden")));

                    if (index == list.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {
                        sb.Append("\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.Replace("\n", "").ToString());
            this.Context.Response.End();
        }

        private int GetWuLiuStatus(Guid prizeId)
        {
            string sql = "select top 1 ISNULL(Status,0) as LogisticStatus from ProductReceiveAddress where UserPrizeId=@prizeId";
            var para = new Dapper.DynamicParameters();
            para.Add("@prizeId", prizeId);

            return TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int?>(TdConfig.ApplicationName, TdConfig.DBRead, sql,
                ref para) ?? 0;
        }
        /// <summary>
        /// 提现劵
        /// </summary>
        public void GetTicket()
        {
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            string orderField = Tool.SafeConvert.ToString(WEBRequest.GetString("orderField"), "CreateDate");
            string orderType = Tool.SafeConvert.ToString(WEBRequest.GetString("orderType"), "desc");
            int sortType = Tool.SafeConvert.ToInt32(Context.Request.Form["sortType"], 2);
            int isUsed = Tool.SafeConvert.ToInt32(WEBRequest.GetString("isUsed"), 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            StringBuilder sb = new StringBuilder();
            List<WXUserPrizeListInfo> list = null;
            string err = "";
            var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                .GetUserPrizeListForApp(
                    UserId, 6, pageindex, pagesize, sortType, isUsed, out err);
            if (response != null)
            {
                list = JsonConvert.DeserializeObject<List<WXUserPrizeListInfo>>(JsonConvert.SerializeObject(response.dataList));
                totalItemCount = response.totalCount;
            }

            if (list == null)
                list = new List<WXUserPrizeListInfo>();
            #region 过期
            foreach (WXUserPrizeListInfo item in list)
            {
                if ((item.IsUsed ?? 0) == 1)
                {
                    item.IsUsed = 1;//已使用
                }
                else
                {
                    if (item.IsReceive == false && item.ReceiveEndDate.HasValue && item.ReceiveEndDate < DateTime.Now)
                    {
                        item.IsUsed = 2; //领取已过期
                    }
                    if (item.IsReceive == true && item.ExpirationDate.HasValue && item.ExpirationDate < DateTime.Now)
                        item.IsUsed = 2;//使用已过期
                    if ((item.IsUsed ?? 0) != 2 && (item.ReceiveDate == null || !item.ReceiveDate.HasValue))
                        item.IsUsed = 0; //未使用
                }
            }
            #endregion

            int pageCount = GetPageCount();

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + pageCount + "\",\"list\":[");


                foreach (WXUserPrizeListInfo model in list)
                {
                    string ExpStr = "";
                    string ReceiveDateStr = "";
                    string CreateDateStr = string.Format("{0}获得", model.CreateDate.ToString("yyyy-MM-dd"));
                    if (model.ExpirationDate.HasValue && DateTime.Now < model.ExpirationDate.Value)
                    {
                        if (
                            MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, model.ExpirationDate.Value.AddSeconds(-1)) ==
                            0)
                        {
                            ExpStr = "（今天到期）";
                        }
                        else
                            ExpStr = string.Format("（{0}天后到期）", MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, model.ExpirationDate.Value.AddSeconds(-1)));
                    }
                    if (model.ExpirationDate.HasValue && DateTime.Now > model.ExpirationDate.Value)
                    {
                        ExpStr = string.Format("（{0}过期）", model.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                    }
                    if (model.ReceiveEndDate.HasValue && DateTime.Now < model.ReceiveEndDate.Value)
                    {
                        if (
                            MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, model.ReceiveEndDate.Value.AddSeconds(-1)) ==
                            0)
                        {
                            ReceiveDateStr = "（今天到期）";
                        }
                        else
                        {
                            ReceiveDateStr = string.Format("（领取时间剩{0}天）", MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, model.ReceiveEndDate.Value.AddSeconds(-1)));
                        }

                    }
                    if (model.ReceiveDate.HasValue)
                    {
                        ReceiveDateStr = string.Format("（{0}使用）", model.ReceiveDate.Value.ToString("yyyy-MM-dd"));
                    }
                    if (model.SubTypeId == 900)
                    {
                        model.PrizeName = "免费提现券";
                    }
                    sb.Append("{\"PrizeName\":\"" + model.PrizeName + "\",\"Description\":\"" + Tool.SubHtmlString.NoHTML(model.Description) + "\",\"PrizeValue\":\"" + ToolStatus.DeleteZero(model.PrizeValue)
                            + "\",\"IsUsed\":\"" + (model.IsUsed ?? 0)
                            + "\",\"SourceFrom\":\"" + model.SourceFrom
                            + "\",\"Receive\":\"" + (model.IsReceive ? 1 : 0)
                            + "\",\"ExpStr\":\"" + ExpStr
                            + "\",\"SubTypeId\":\"" + model.SubTypeId
                            + "\",\"ReceiveDateStr\":\"" + ReceiveDateStr
                            + "\",\"UseBeginDate\":\"" + (model.UseBeginDate.HasValue ? model.UseBeginDate.Value.AddSeconds(-1).ToString("yyyy.MM.dd") : "")
                            + "\",\"UseEndDate\":\"" + (model.ExpirationDate.HasValue ? model.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy.MM.dd") : "")
                            + "\",\"Id\":\"" + model.Id + "\",\"CreateDateStr\":\"" + CreateDateStr);

                    if (index == list.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {
                        sb.Append("\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        /// <summary>
        /// 红包 （现金红包、投资红包、体验金）
        /// </summary>
        public void GetRedPacketNew()
        {
            int pageindex = Tool.SafeConvert.ToInt32(WEBRequest.GetString("Pageindex"), 1);
            int type = Tool.SafeConvert.ToInt32(WEBRequest.GetString("type"), 2);
            //string orderField = Tool.SafeConvert.ToString(WEBRequest.GetString("orderField"), "CreateDate");
            //string orderType = Tool.SafeConvert.ToString(WEBRequest.GetString("orderType"), "desc");
            int sortType = Tool.SafeConvert.ToInt32(WEBRequest.GetString("sortType"), 1);
            int isUsed = Tool.SafeConvert.ToInt32(WEBRequest.GetString("isUsed"), 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            StringBuilder sb = new StringBuilder();
            List<WXUserPrizeListInfoNB> list = null;
            string err = "";
            var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                .GetUserPrizeListForApp(
                    UserId, type, pageindex, pagesize, sortType, isUsed, out err);
            if (response != null)
            {
                list = JsonConvert.DeserializeObject<List<WXUserPrizeListInfoNB>>(JsonConvert.SerializeObject(response.dataList));
                totalItemCount = response.totalCount;
            }

            //RedWXGetUserPrizeList(UserId, type, pageindex, pagesize, orderField, orderType, isUsed, out totalItemCount).ToList();

            if (list == null)
                list = new List<WXUserPrizeListInfoNB>();
            #region 过期
            if (type == 1)//现金红包
            {
                DateTime addTime = bll.WXGetAddDate(UserId);//注册日期
                foreach (WXUserPrizeListInfoNB item in list)
                {
                    //注册红包过期 
                    if (item.TypeId == 14 && item.SubTypeId != 19 && item.ExpirationDate == null && item.IsReceive == false && addTime < DateTime.Now.AddMonths(-1))
                        item.IsUsed = 2;
                    if (item.TypeId == 14 && item.SubTypeId != 19 && item.ExpirationDate != null && item.IsReceive == false && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ReceiveEndDate))
                        item.IsUsed = 2;

                    if (item.TypeId == 14 && item.SubTypeId == 19 && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ReceiveEndDate) && item.ReceiveDate == null)
                        item.IsUsed = 2;
                    //现金红包
                    if (item.TypeId.ToText().IsIn("11", "13"))
                    {
                        if (item.IsReceive == false && item.ReceiveEndDate.HasValue && DateTime.Now > item.ReceiveEndDate.Value)
                            item.IsUsed = 2;
                        if (item.IsReceive && item.IsUsed == 0 && item.ExpirationDate.HasValue && DateTime.Now > item.ExpirationDate.Value)
                        {
                            item.IsUsed = 2;
                        }
                    }
                }

            }
            if (type == 3)//投资红包
            {
                foreach (WXUserPrizeListInfoNB item in list)
                {
                    //愚人节活动过期
                    if (item.TypeId == 3 && item.SubTypeId == 10 && item.IsReceive == false && DateTime.Now > DateTime.Parse("2015-04-30 23:59:59"))
                        item.IsUsed = 2;

                    //加入领取过期判断
                    if (item.TypeId == 3 && item.IsReceive == false && item.ReceiveEndDate != null && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ReceiveEndDate))
                        item.IsUsed = 2;
                    //加入使用过期判断
                    if (item.TypeId == 3 && item.IsReceive && (item.IsUsed ?? 0) == 0 && item.ExpirationDate != null && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ExpirationDate))
                        item.IsUsed = 2;

                    //投资金币过期
                    if (item.TypeId == 12 && item.IsUsed == 0 && DateTime.Now > DateTime.Parse("2014-12-19"))
                        item.IsUsed = 2;
                    //体验金过期
                    if (item.TypeId == 16 && item.IsUsed == 0 && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ReceiveEndDate))
                        item.IsUsed = 2;
                }
            }
            //投资体验金
            if (type == 9)
            {
                foreach (WXUserPrizeListInfoNB item in list)
                {
                    //加入领取过期判断
                    if (item.TypeId == 16 && item.IsReceive == false && item.ReceiveEndDate != null && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ReceiveEndDate))
                        item.IsUsed = 2;
                    //加入使用过期判断
                    if (item.TypeId == 16 && item.IsReceive && (item.IsUsed ?? 0) == 0 && item.ExpirationDate != null && DateTime.Now > Tool.SafeConvert.ToDateTime(item.ExpirationDate))
                        item.IsUsed = 2;
                }
            }
            #endregion

            int pageCount = GetPageCount();

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXUserPrizeListInfoNB model in list)
                {
                    string receive = model.IsReceive == false ? "0" : "1";
                    int subTypeId = model.SubTypeId == null ? 0 : (int)model.SubTypeId;

                    string ExpStr = "";
                    string ReceiveDateStr = "";
                    string CreateDateStr = string.Format("{0}获得", model.CreateDate.ToString("yyyy-MM-dd"));

                    if (model.ExpirationDate.HasValue && DateTime.Now < model.ExpirationDate.Value)
                    {
                        var diffDay = MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                            model.ExpirationDate.Value.AddSeconds(-1));
                        if (diffDay == 0)
                        {
                            ExpStr = string.Format("（今天到期）");
                        }
                        else
                        {
                            ExpStr = string.Format("（{0}天后到期）", diffDay);
                        }

                    }
                    if (model.ExpirationDate.HasValue && DateTime.Now > model.ExpirationDate.Value)
                    {
                        ExpStr = string.Format("（{0}过期）", model.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                    }
                    if (model.ReceiveEndDate.HasValue && DateTime.Now < model.ReceiveEndDate.Value)
                    {
                        if (
                            MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, model.ReceiveEndDate.Value.AddSeconds(-1)) ==
                            0)
                        {
                            ReceiveDateStr = "（今天到期）";
                        }
                        else
                        {
                            ReceiveDateStr = string.Format("（领取时间剩{0}天）", MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, model.ReceiveEndDate.Value.AddSeconds(-1)));
                        }
                    }
                    if (model.ReceiveDate.HasValue)
                    {
                        ReceiveDateStr = string.Format("（{0}使用）", model.ReceiveDate.Value.ToString("yyyy-MM-dd"));
                    }
                    var ExperienceModel = new ExperienceGoldOrder();
                    ExperienceModel.Id = model.TargetProductId.HasValue ? model.TargetProductId.Value.ToString() : "";
                    if (string.IsNullOrEmpty(ExperienceModel.Id) || ExperienceModel.Id == Guid.Empty.ToString())
                    {
                        if (model.TypeId == 16 && model.SubTypeId == 1)
                        {
                            //string ExperienceSql = "SELECT ego.Id,ego.Amount,ego.Profit,ego.UseEndDate FROM ExperienceGoldOrder ego WHERE ego.ActivityCode=@ActivityCode";
                            string ExperienceSql = @"select r.Id,r.Amount,r.Profit,r.UseEndDate from ExperienceGoldLog g inner join ExperienceGoldOrder r on r.id=g.ExperienceGoldOrderId
                          where r.ActivityCode=@ActivityCode and IFNULL(g.IsInvest,0) =0 AND g.UserID=@UserId ORDER BY r.UseEndDate";
                            var ExperienceParam = new Dapper.DynamicParameters();
                            ExperienceParam.Add("@ActivityCode", model.ActivityCode);
                            ExperienceParam.Add("@UserId", UserId);
                            ExperienceModel = TuanDai.DB.MySql.TuanDaiDB_MySql.QueryFirstOrDefault<ExperienceGoldOrder>(TdConfig.ApplicationName, TdConfig.DBUserManageWrite, ExperienceSql, ref ExperienceParam);
                            TimeSpan ts = new TimeSpan();
                            ts = model.ExpirationDate.Value.Subtract(model.UseBeginDate.Value);
                            ExperienceModel.Days = (ts.Days + 1).ToString();
                        }
                    }

                    sb.Append("{\"PrizeName\":\"" + model.PrizeName + "\",\"Description\":\"" + Tool.SubHtmlString.NoHTML(model.Description) + "\",\"PrizeValue\":\"" + ToolStatus.DeleteZero(model.PrizeValue)
                           + "\",\"IsUsed\":\"" + model.IsUsed + "\",\"Id\":\"" + model.Id + "\",\"Receive\":\"" + receive
                           + "\",\"SourceFrom\":\"" + model.SourceFrom
                           + "\",\"ExpStr\":\"" + ExpStr
                           + "\",\"ReceiveDateStr\":\"" + ReceiveDateStr
                           + "\",\"InvestMoney\":\"" + ToolStatus.DeleteZero(model.InvestMoney)
                           + "\",\"TypeId\":\"" + model.TypeId + "\",\"SubTypeId\":\"" + subTypeId + "\",\"CreateDateStr\":\"" + CreateDateStr + "\",\"TiYanJinId\":\"" + ExperienceModel.Id + "\",\"TiYanJinE\":\"" + ExperienceModel.Amount + "\",\"TiYanJinProfit\":\"" + ExperienceModel.Profit + "\",\"Days\":\"" + ExperienceModel.Days);

                    if (index == list.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {
                        sb.Append("\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        /// <summary>
        /// 加息券列表
        /// </summary>
        public void GetRateCoupon()
        {
            int pageindex = Tool.SafeConvert.ToInt32(WEBRequest.GetString("pageIndex"), 1);
            //string orderField = Tool.SafeConvert.ToString(WEBRequest.GetString("orderField"), "CreateDate");
            //string orderType = Tool.SafeConvert.ToString(WEBRequest.GetString("orderType"), "desc");
            int sortType = Tool.SafeConvert.ToInt32(WEBRequest.GetString("sortType"), 2);
            int isUsed = Tool.SafeConvert.ToInt32(WEBRequest.GetString("isUsed"), 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            List<RateCoupon> list = null;
            string err = "";
            var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                .GetUserPrizeListForApp(
                    UserId, 5, pageindex, pagesize, sortType, isUsed, out err);
            if (response != null)
            {
                list = JsonConvert.DeserializeObject<List<RateCoupon>>(JsonConvert.SerializeObject(response.dataList));
                totalItemCount = response.totalCount;
            }

            if (list == null)
                list = new List<RateCoupon>();

            int pageCount = 1;
            StringBuilder sb = new StringBuilder();
            if (list != null && list.Count > 0)
            {
                foreach (var item in list)
                {
                    if (item.IsUsed == 1)
                    {
                        item.IsUsed = 1;//已使用
                    }
                    else
                    {
                        if (item.IsReceive == 0 && item.ReceiveEndDate.HasValue && item.ReceiveEndDate < DateTime.Now)
                        {
                            item.IsUsed = 2; //领取已过期
                        }
                        if (item.IsReceive == 1 && item.ExpirationDate.HasValue && item.ExpirationDate < DateTime.Now)
                            item.IsUsed = 2;//使用已过期
                        if (item.IsUsed != 2 && item.ReceiveDate == null)
                            item.IsUsed = 0; //未使用
                    }
                }

                pageCount = GetPageCount();

                if (list.Count > 0)
                {
                    int index = 1;
                    sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                    foreach (var item in list)
                    {
                        string ExpirationStr = "";
                        string ReceiveDateStr = "";//领取过期时间
                        string CreateDateStr = "";
                        string DeadlineStr = "";
                        CreateDateStr = string.Format("{0}获得", item.CreateDate.ToString("yyyy-MM-dd"));
                        if (item.ExpirationDate.HasValue && DateTime.Now < item.ExpirationDate.Value)
                        {
                            if (
                                MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                    item.ExpirationDate.Value.AddSeconds(-1)) == 0)
                            {
                                ExpirationStr = "（今天到期）";
                            }
                            else
                                ExpirationStr = "（" + MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, item.ExpirationDate.Value.AddSeconds(-1)) + "天后到期）";
                        }
                        if (item.ExpirationDate.HasValue && DateTime.Now > item.ExpirationDate.Value)
                        {
                            ExpirationStr = string.Format("（{0}过期）", item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                        }
                        if (item.ReceiveEndDate.HasValue && DateTime.Now < item.ReceiveEndDate.Value)
                        {
                            if (
                                MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                    item.ReceiveEndDate.Value.AddSeconds(-1)) == 0)
                            {
                                ReceiveDateStr = "（今天到期）";
                            }
                            else
                            {
                                ReceiveDateStr = string.Format("（领取时间剩{0}天）", MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, item.ReceiveEndDate.Value.AddSeconds(-1)));
                            }

                        }
                        if (item.ReceiveDate.HasValue && item.ExpirationDate.HasValue)
                        {
                            ReceiveDateStr = string.Format("（{0}使用）", item.ReceiveDate.Value.ToString("yyyy-MM-dd"));
                            DeadlineStr = string.Format("{0}~{1}", item.ReceiveDate.Value.ToString("yyyy-MM-dd"),
                                item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                        }
                        sb.Append("{\"PrizeName\":\"" + item.PrizeName + "\",\"ExpirationStr\":\"" + ExpirationStr + "\",\"Description\":\"" + Tool.StringUtilily.Left(item.Description, 80)
                                   + "\",\"IsUsed\":\"" + item.IsUsed + "\",\"PrizeValue\":\"" + item.PrizeValue + "\",\"Receive\":\"" + item.IsReceive
                                   + "\",\"Id\":\"" + item.Id + "\",\"SourceFrom\":\"" + Tool.StringUtilily.Left(item.SourceFrom, 18)
                                   + "\",\"ReceiveDateStr\":\"" + ReceiveDateStr + "\",\"CreateDateStr\":\"" + CreateDateStr + "\",\"DeadlineStr\":\"" + DeadlineStr
                                   );
                        if (index == list.Count())
                        {
                            sb.Append("\"}]}");
                        }
                        else
                        {
                            sb.Append("\"},");
                        }
                        index++;
                    }
                }
                else
                {
                    sb.Append("{\"result\":\"0\",\"pageCount\":\"" + pageCount + "\"}");
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
        /// 免费债转券列表
        /// </summary>
        public void GetFreeZqzr()
        {
            int pageindex = Tool.SafeConvert.ToInt32(WEBRequest.GetString("pageIndex"), 1);
            //string orderField = Tool.SafeConvert.ToString(WEBRequest.GetString("orderField"), "CreateDate");
            //string orderType = Tool.SafeConvert.ToString(WEBRequest.GetString("orderType"), "desc");
            int sortType = Tool.SafeConvert.ToInt32(WEBRequest.GetString("sortType"), 2);
            int isUsed = Tool.SafeConvert.ToInt32(WEBRequest.GetString("isUsed"), 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            List<RateCoupon> list = null;
            string err = "";
            var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                .GetUserPrizeListForApp(
                    UserId, 10, pageindex, pagesize, sortType, isUsed, out err);
            if (response != null)
            {
                list = JsonConvert.DeserializeObject<List<RateCoupon>>(JsonConvert.SerializeObject(response.dataList));
                totalItemCount = response.totalCount;
            }

            if (list == null)
                list = new List<RateCoupon>();

            int pageCount = 1;
            StringBuilder sb = new StringBuilder();
            if (list != null && list.Count > 0)
            {
                foreach (var item in list)
                {
                    if (item.IsUsed == 1)
                    {
                        item.IsUsed = 1;//已使用
                    }
                    else
                    {
                        if (item.IsReceive == 0 && item.ReceiveEndDate.HasValue && item.ReceiveEndDate < DateTime.Now)
                        {
                            item.IsUsed = 2; //领取已过期
                        }
                        if (item.IsReceive == 1 && item.ExpirationDate.HasValue && item.ExpirationDate < DateTime.Now)
                            item.IsUsed = 2;//使用已过期
                        if (item.IsUsed != 2 && item.ReceiveDate == null)
                            item.IsUsed = 0; //未使用
                    }
                }

                pageCount = GetPageCount();

                if (list.Count > 0)
                {
                    int index = 1;
                    sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                    foreach (var item in list)
                    {
                        string ExpirationStr = "";
                        string ReceiveDateStr = "";//领取过期时间
                        string CreateDateStr = "";
                        string DeadlineStr = "";
                        CreateDateStr = string.Format("{0}获得", item.CreateDate.ToString("yyyy-MM-dd"));
                        if (item.ExpirationDate.HasValue && DateTime.Now < item.ExpirationDate.Value)
                        {
                            if (
                                MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                    item.ExpirationDate.Value.AddSeconds(-1)) == 0)
                            {
                                ExpirationStr = "（今天到期）";
                            }
                            else
                                ExpirationStr = "（" + MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, item.ExpirationDate.Value.AddSeconds(-1)) + "天后到期）";
                        }
                        if (item.ExpirationDate.HasValue && DateTime.Now > item.ExpirationDate.Value)
                        {
                            ExpirationStr = string.Format("（{0}过期）", item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                        }
                        if (item.ReceiveEndDate.HasValue && DateTime.Now < item.ReceiveEndDate.Value)
                        {
                            if (
                                MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                    item.ReceiveEndDate.Value.AddSeconds(-1)) == 0)
                            {
                                ReceiveDateStr = "（今天到期）";
                            }
                            else
                            {
                                ReceiveDateStr = string.Format("（领取时间剩{0}天）", MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, item.ReceiveEndDate.Value.AddSeconds(-1)));
                            }

                        }
                        if (item.ReceiveDate.HasValue && item.ExpirationDate.HasValue)
                        {
                            ReceiveDateStr = string.Format("（{0}使用）", item.ReceiveDate.Value.ToString("yyyy-MM-dd"));
                            DeadlineStr = string.Format("{0}~{1}", item.ReceiveDate.Value.ToString("yyyy-MM-dd"),
                                item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                        }
                        sb.Append("{\"PrizeName\":\"" + item.PrizeName + "\",\"ExpirationStr\":\"" + ExpirationStr + "\",\"Description\":\"" + Tool.StringUtilily.Left(item.Description, 80)
                                   + "\",\"IsUsed\":\"" + item.IsUsed + "\",\"PrizeValue\":\"" + item.PrizeValue + "\",\"Receive\":\"" + item.IsReceive
                                   + "\",\"Id\":\"" + item.Id + "\",\"SourceFrom\":\"" + Tool.StringUtilily.Left(item.SourceFrom, 18)
                                   + "\",\"ReceiveDateStr\":\"" + ReceiveDateStr + "\",\"CreateDateStr\":\"" + CreateDateStr + "\",\"DeadlineStr\":\"" + DeadlineStr
                                   );
                        if (index == list.Count())
                        {
                            sb.Append("\"}]}");
                        }
                        else
                        {
                            sb.Append("\"},");
                        }
                        index++;
                    }
                }
                else
                {
                    sb.Append("{\"result\":\"0\",\"pageCount\":\"" + pageCount + "\"}");
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
        /// 京东资格券
        /// </summary>
        public void GetJDQuan()
        {
            int pageindex = Tool.SafeConvert.ToInt32(WEBRequest.GetString("pageIndex"), 1);
            int sortType = Tool.SafeConvert.ToInt32(WEBRequest.GetString("sortType"), 2);
            int isUsed = Tool.SafeConvert.ToInt32(WEBRequest.GetString("isUsed"), 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            List<RateCoupon> list = null;
            string err = "";
            var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                .GetUserPrizeListForApp(
                    UserId, 11, pageindex, pagesize, sortType, isUsed, out err);
            TuanDai.LogSystem.LogClient.LogClients.TraceLog("WXTouch", "获取资格券", UserId.ToString(), JsonConvert.SerializeObject(response));
            if (response != null)
            {
                list = JsonConvert.DeserializeObject<List<RateCoupon>>(JsonConvert.SerializeObject(response.dataList));
                totalItemCount = response.totalCount;
            }

            if (list == null)
                list = new List<RateCoupon>();

            int pageCount = 1;
            StringBuilder sb = new StringBuilder();
            if (list != null && list.Count > 0)
            {
                
                pageCount = GetPageCount();
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (var item in list)
                {
                    if (item.Status.HasValue && item.Status.Value == 5)
                    {
                        item.IsUsed = -1;//已失效
                    }else
                        if (item.Status.HasValue && item.Status.Value == 4)
                    {
                        item.IsUsed = 1;//已使用
                    }
                    else
                    {
                        if (item.IsReceive == 0 && item.ReceiveEndDate.HasValue && item.ReceiveEndDate < DateTime.Now)
                        {
                            item.IsUsed = 2; //未领取已过期 前台显示已过期
                        }
                        if (item.IsReceive == 1 && item.ExpirationDate.HasValue && item.ExpirationDate < DateTime.Now)
                            item.IsUsed = 2;//已领取已过期  前台显示已失效
                        if (item.IsUsed != 2 && item.ReceiveDate == null)
                            item.IsUsed = 0; //未使用
                        if (item.Status.HasValue && item.Status == 5)
                        {
                            item.IsUsed = -1;//已失效
                        }
                    }
                        
                    string ExpirationStr = "";
                    string ReceiveDateStr = "";//领取过期时间
                    string CreateDateStr = "";
                    string DeadlineStr = "";
                    CreateDateStr = string.Format("{0}获得", item.CreateDate.ToString("yyyy-MM-dd"));
                    if (item.ExpirationDate.HasValue && DateTime.Now < item.ExpirationDate.Value)
                    {
                        if (
                            MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                item.ExpirationDate.Value.AddSeconds(-1)) == 0)
                        {
                            ExpirationStr = "（今天到期）";
                        }
                        else
                            ExpirationStr = "（" + MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, item.ExpirationDate.Value.AddSeconds(-1)) + "天后到期）";
                    }
                    if (item.ExpirationDate.HasValue && DateTime.Now > item.ExpirationDate.Value)
                    {
                        ExpirationStr = string.Format("（{0}过期）", item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                        if(isUsed == -1)
                            ExpirationStr = string.Format("（{0}失效）", item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                    }
                    if (item.ReceiveEndDate.HasValue && DateTime.Now < item.ReceiveEndDate.Value)
                    {
                        if (
                            MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now,
                                item.ReceiveEndDate.Value.AddSeconds(-1)) == 0)
                        {
                            ReceiveDateStr = "（今天到期）";
                        }
                        else
                        {
                            ReceiveDateStr = string.Format("（领取时间剩{0}天）", MyDateTime.DateDiff(MyDateTime.DateDiffOption.Day, DateTime.Now, item.ReceiveEndDate.Value.AddSeconds(-1)));
                        }

                    }
                    if (item.ReceiveDate.HasValue && item.ExpirationDate.HasValue)
                    {
                        ReceiveDateStr = string.Format("（{0}使用）", item.ReceiveDate.Value.ToString("yyyy-MM-dd"));
                        DeadlineStr = string.Format("{0}~{1}", item.ReceiveDate.Value.ToString("yyyy-MM-dd"),
                            item.ExpirationDate.Value.AddSeconds(-1).ToString("yyyy-MM-dd"));
                    }
                    sb.Append("{\"PrizeName\":\"" + item.PrizeName + "\",\"ExpirationStr\":\"" + ExpirationStr + "\",\"Description\":\"" + Tool.StringUtilily.Left(item.Description, 18)
                                + "\",\"IsUsed\":\"" + item.IsUsed + "\",\"PrizeValue\":\"" + item.PrizeValue + "\",\"Receive\":\"" + item.IsReceive
                                + "\",\"Id\":\"" + item.Id + "\",\"SourceFrom\":\"" + Tool.StringUtilily.Left(item.SourceFrom, 18)
                                + "\",\"ReceiveDateStr\":\"" + ReceiveDateStr + "\",\"CreateDateStr\":\"" + CreateDateStr + "\",\"DeadlineStr\":\"" + DeadlineStr + "\",\"Descriptions\":\"" + item.Description + "\",\"TypeId\":\"" + item.TypeId
                                );
                    if (index == list.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {
                        sb.Append("\"},");
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

        #region 领取奖品
        /// <summary>
        /// 用户获取奖品
        /// </summary>
        public void GetUserPrize()
        {
            Guid userid = WebUserAuth.UserId.Value;
            Guid id = Guid.Parse(Context.Request["id"]);
            int outStatus = 0;
            WXUserPrizeListInfo model = bll.WXGetUserPrizeById(id, WebUserAuth.UserId.Value);
            if (model == null)
            {
                PrintJson("0", "操作失败");
                return;
            }
            if (model.Description.IndexOf("恶意注册，不允许领取") > -1)
            {
                PrintJson("0", "操作失败");
                return;
            }
            if (model.IsReceive)
            {
                PrintJson("-3", "已经领取");
                return;
            }
            UserBasicInfoInfo usermodel = new UserBLL().GetUserBasicInfoModelById(userid);
            
            if (usermodel == null)
            {
                PrintJson("0", "操作失败");
                return;
            }
            if (!usermodel.IsValidateMobile || !usermodel.IsValidateIdentity)
            {
                PrintJson("-2", "未安全认证");
                return;
            }
            int UserPrizeType = (int)ConstString.UserPrizeType.promotion;
            DateTime time = DateTime.Now;
            if (model.TypeId == UserPrizeType && model.ActivityCode.IndexOf("promotion_20141114") > -1 && model.CreateDate.AddDays(2) > time)
            {
                PrintJson("-18", "");
                return;
            }
            if (model != null && model.TypeId == 22)//京东卡
            {
                GetUserPrizeFromJavaService(userid, id);
            }
            if (model != null && model.TypeId != 5 && model.TypeId != 9 && model.TypeId != 10)
            {
                bll.GetUserPrize(userid, id, 2, out outStatus);//调用新的领取过程 

                string investMoneyType = "";
                //当为现金红包时才查询需投资金额
                if (outStatus == 1 && model.TypeId == 3 && model.RuleId.HasValue && model.RuleId.Value != Guid.Empty)
                {
                    Tuple<int, decimal> investMoneyObj = bll.WXGetRedPacketInvestMoney(model.RuleId.Value);
                    investMoneyType = "{ \"InvestType\":" + investMoneyObj.Item1 + ",\"InvestMoney\":" + investMoneyObj.Item2 + "}";
                }
                PrintJson(outStatus.ToString(), investMoneyType);
            }
            else if (model != null && model.TypeId == 9)
            {
                #region 实物奖品
                #endregion
            }
            else if (model != null && model.TypeId == 5)//送彩票
            {
                #region 彩票
                #endregion
            }
            else if (model != null && model.TypeId == 10)//领取云购币
            {
                #region 云购币
                #endregion
            }
            else
            {
                PrintJson("0", "用户领取奖品失败");
            }
        }
        #endregion

        /// <summary>
        /// 团宝箱服务Url
        /// </summary>
        private string UserPrizeServiceUrl
        {
            get
            {
                string url = string.Empty;
                if (string.IsNullOrEmpty(url))
                {
                    string zkErrorMessage = string.Empty;
                    url = TuanDai.ZKHelper.ZooKClient.GetValueForZK("/url/userprize/userprizeserviceurl", ref zkErrorMessage);
                    if (!string.IsNullOrEmpty(zkErrorMessage))
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "userprizeserviceurl", "获取userprizeserviceurl失败", zkErrorMessage);
                        return "";
                    }
                    TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "userprizeserviceurl",url,"团宝箱服务Url");
                    return url;
                }
                return url;
            }
        }
        /// <summary>
        /// 从java服务领取团宝箱奖品
        /// </summary>
        private void GetUserPrizeFromJavaService(Guid userId,Guid prizeId)
        {
            string url = string.Empty;
            if (string.IsNullOrEmpty(UserPrizeServiceUrl))
            {
                PrintJson("0", "领取失败");
                return;
            }
            url = UserPrizeServiceUrl + "/prizes/" + prizeId + "/receive?id=" + prizeId + "&userId=" + userId + "&receiveType=2&requestNo=" + Guid.NewGuid() + "&systemName=P2P";
            
            string err = "";
            string result = HttpClient.HttpUtil.HttpPost("WXTouch", url, "", out err);
            if (!string.IsNullOrEmpty(result))
            {
                ResponseBody<string> resp = null;
                try
                {
                    resp = JsonConvert.DeserializeObject<ResponseBody<string>>(result);
                    
                }
                catch (Exception ex)
                {
                    PrintJson("0", "领取失败");
                    return;
                }
                if (resp != null && resp.returnType == "OK")
                {
                    PrintJson("1", Decrypt3Des(resp.data, ConfigHelper.getConfigString("JDCardDescKey", "online109y36gb18jdcarden")));//A0+UIzER8NCRNyLHdyxeSg==
                    return;
                }
            }
            PrintJson("0", "领取失败");
        }
        //根据id获取团宝箱奖品明细
        public void getPrizeById()
        {
            Guid userid = WebUserAuth.UserId.Value;
            Guid id = Guid.Parse(Context.Request["id"]);
            
            string url = string.Empty;
            if (string.IsNullOrEmpty(UserPrizeServiceUrl))
            {
                PrintJson("0", "获取卡密失败");
                return;
            }
            url = UserPrizeServiceUrl + "/prizes/" + id + "?id=" + id + "&userId=" + userid;

            string err = "";
            string result = HttpClient.HttpUtil.HttpGet("WXTouch", url, "", out err);
            if (!string.IsNullOrEmpty(result))
            {
                ResponseBody<SimpleUserPrize> resp = null;
                try
                {
                    resp = JsonConvert.DeserializeObject<ResponseBody<SimpleUserPrize>>(result);
                }
                catch (Exception ex)
                {
                    PrintJson("0", "获取卡密失败");
                    return;
                }
                if (resp != null && resp.returnType == "OK" && resp.data != null)
                {
                    PrintJson("1", Decrypt3Des(resp.data.ticket, ConfigHelper.getConfigString("JDCardDescKey", "online109y36gb18jdcarden")));//A0+UIzER8NCRNyLHdyxeSg==
                    return;
                }
            }
            PrintJson("0", "获取卡密失败");
        }
        /// <summary>
        /// des 解密
        /// </summary>
        /// <param name="aStrString">加密的字符串</param>
        /// <param name="aStrKey">密钥</param>
        /// <param name="iv">解密矢量：只有在CBC解密模式下才适用</param>
        /// <param name="mode">运算模式</param>
        /// <returns>解密的字符串</returns>
        private static string Decrypt3Des(string aStrString, string aStrKey, CipherMode mode = CipherMode.ECB, string iv = "12345678")
        {
            try
            {
                var des = new TripleDESCryptoServiceProvider
                {
                    Key = Encoding.UTF8.GetBytes(aStrKey),
                    Mode = mode,
                    Padding = PaddingMode.PKCS7
                };
                if (mode == CipherMode.CBC)
                {
                    des.IV = Encoding.UTF8.GetBytes(iv);
                }
                var desDecrypt = des.CreateDecryptor();
                var result = "";
                byte[] buffer = Convert.FromBase64String(aStrString);
                result = Encoding.UTF8.GetString(desDecrypt.TransformFinalBlock(buffer, 0, buffer.Length));
                return result;
            }
            catch (Exception e)
            {
                return string.Empty;
            }
        }
        #region 团宝箱领取商城礼品
        public void GetMallUserPrize()
        {
            Guid userid = WebUserAuth.UserId.Value;
            Guid id = Guid.Parse(Context.Request["id"]);

            int outStatus = 0;
            UserBLL bll = new UserBLL();
            //ObjectParameter outStatus = new ObjectParameter("outStatus", 0);
            //UserPrize model = db.UserPrize.FirstOrDefault(p => p.Id == id && p.IsReceive == false);
            var model = new UserBLL().WXGetUserPrizeById(id, userid);
            if (model == null)
            {
                PrintJson("-1", "奖品已领取");
                return;
            }
            if (model.Description != null && model.Description.IndexOf("恶意注册，不允许领取") > -1)
            {
                PrintJson("0", "操作失败");
                return;
            }
            UserBasicInfoInfo usermodel = bll.GetUserBasicInfoModelById(userid);

            if (!usermodel.IsValidateMobile || !usermodel.IsValidateIdentity)
            {
                PrintJson("-2", "操作失败");
                return;
            }

            if (model != null && model.TypeId == 9)
            {
                if ((usermodel.IsValidateIdentity && usermodel.IsValidateMobile) == false)
                {

                    this.PrintJson("-2", "未完成实名认证！");
                    return;
                }

                bll.GetUserPrize(userid, id, 2, out outStatus);
                if (outStatus == 1)
                {
                    var lbll = new LogisticBLL();
                    var pra = new ProductReceiveAddress();
                    pra.Status = 1;
                    pra.OrderId = Guid.NewGuid();
                    pra.UserId = UserId;
                    pra.UserPrizeId = Guid.Parse(Context.Request["id"]);
                    pra.Address = Context.Request["address"];
                    pra.Privince = Context.Request["sel_city1"];
                    pra.Area = Context.Request["sel_city3"];
                    pra.City = Context.Request["sel_city2"];
                    pra.TelNo = Context.Request["phone"];
                    pra.UserName = Context.Request["name"];
                    int result = lbll.addProductReceiveAddress(pra);
                    if (result > 0)
                    {
                        string message = string.Empty;
                        PrintJson(outStatus.ToString(), message);
                    }
                    else
                    {
                        PrintJson("0", "领取奖品失败！");
                    }

                }
                else
                {
                    PrintJson(outStatus.ToString(), string.Empty);
                }
            }
            else
            {
                PrintJson("0", "用户领取奖品失败");
            }
        }
        #endregion

        //团宝箱精美礼品获取城市
        public void GetCity()
        {
            StringBuilder sb = new StringBuilder();
            string type = Context.Request.Form["vtype"].ToString();
            int parentId = Tool.SafeConvert.ToInt32(Context.Request.Form["id"], 1);
            List<AddressInfo> list = null;
            //using (SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateReadConnection())
            //{
            string sqlText = string.Empty;
            //var para = new { Id = parentId };
            var para = new Dapper.DynamicParameters();
            para.Add("@Id", parentId);
            if (type == "1")
                sqlText = @"SELECT m_CityID AS ProId,m_CityName AS ProName FROM dbo.t_Mall_City with(nolock) WHERE m_ProId=@Id";
            else if (type == "2")
                sqlText = @"SELECT m_Id AS ProId,m_DisName AS ProName FROM dbo.t_Mall_District with(nolock) WHERE m_CityID=@Id";
            list = TuanDai.DB.TuanDaiDB.Query<AddressInfo>(TdConfig.DBRead, sqlText, ref para);
            //    list = SqlMapper.Query<AddressInfo>(connection, sqlText, para).ToList();
            //    connection.Close();
            //    connection.Dispose();
            //}
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"list\":[");
                foreach (AddressInfo model in list)
                {
                    if (index == list.Count())
                    {
                        sb.Append("{\"ProId\":\"" + model.ProId + "\",\"ProName\":\"" + model.ProName + "\"}]}");
                    }
                    else
                    {
                        sb.Append("{\"ProId\":\"" + model.ProId + "\",\"ProName\":\"" + model.ProName + "\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        public class AddressInfo
        {
            public string ProName { get; set; }
            public int ProId { get; set; }
        }
        public class MallResutlInfo
        {
            public string Status { get; set; }
            public string message { get; set; }
        }
        public class ExperienceGoldOrder
        {
            public string Id { get; set; }
            public decimal Amount { get; set; }
            public decimal Profit { get; set; }
            public DateTime UseEndDate { get; set; }
            public string Days { get; set; }
        }
        /// <summary>
        /// 团宝箱详细(当前页面内部使用)
        /// </summary>
        protected class WXUserPrizeListInfoNB
        {
            /// <summary>
            /// ID
            /// </summary>
            public Guid Id { get; set; }
            /// <summary>
            /// 用户ID
            /// </summary>
            public Guid UserId { get; set; }
            /// <summary>
            /// 类型
            /// </summary>
            public int TypeId { get; set; }
            /// <summary>
            /// 子类型
            /// </summary>
            public int? SubTypeId { get; set; }
            /// <summary>
            /// 活动编号
            /// </summary>
            public string ActivityCode { get; set; }
            /// <summary>
            /// 名称
            /// </summary>
            public string PrizeName { get; set; }
            /// <summary>
            /// 
            /// </summary>
            public Guid? TargetProductId { get; set; }
            /// <summary>
            /// 奖励值
            /// </summary>
            public decimal PrizeValue { get; set; }
            /// <summary>
            /// 描述
            /// </summary>
            public string Description { get; set; }
            /// <summary>
            /// 是否领取
            /// </summary>
            public bool IsReceive { get; set; }
            /// <summary>
            /// 领取日期
            /// </summary>
            public DateTime? ReceiveDate { get; set; }
            /// <summary>
            /// 是否使用 为了json转换
            /// </summary>
            public bool isUsed { get; set; }

            private int? isused;
            /// <summary>
            /// 用于页面赋值 0:未使用 1:已使用  2:已过期
            /// </summary>
            public int? IsUsed
            {
                get { return isused ?? (isUsed ? 1 : 0); }
                set { isused = value; }
            }
            /// <summary>
            /// 使用日期
            /// </summary>
            public DateTime? UseDate { get; set; }
            /// <summary>
            /// 创建人
            /// </summary>
            public string CreateUser { get; set; }
            /// <summary>
            /// 创建日期
            /// </summary>
            public DateTime CreateDate { get; set; }
            /// <summary>
            /// 过期时间(未用)
            /// </summary>
            public DateTime? ExpirationDate { get; set; }
            /// <summary>
            ///来源哪个活动
            /// </summary>
            public string SourceFrom { get; set; }
            /// <summary>
            /// 领取开始时间
            /// </summary>
            public DateTime? ReceiveBeginDate { get; set; }
            /// <summary>
            /// 领取过期时间
            /// </summary>
            public DateTime? ReceiveEndDate { get; set; }
            /// <summary>
            /// 使用开始时间
            /// </summary>
            public DateTime? UseBeginDate { get; set; }
            /// <summary>
            /// 活动规则ID
            /// </summary>
            public Guid? RuleId { get; set; }
            /// <summary>
            /// 领取方式(0-pc,1-移动端,2-触屏版)
            /// </summary>
            public int? ReceiveType { get; set; }
            /// <summary>
            /// 需投资额
            /// </summary>
            public decimal? InvestMoney { get; set; }
        }
        /// <summary>
        /// 加息券实体
        /// </summary>
        protected class RateCoupon
        {
            /// <summary>
            /// ID
            /// </summary>
            public Guid Id { get; set; }
            /// <summary>
            /// 用户ID
            /// </summary>
            public Guid UserId { get; set; }
            /// <summary>
            /// 团宝箱名称
            /// </summary>
            public string PrizeName { get; set; }
            /// <summary>
            /// 描述
            /// </summary>
            public string Description { get; set; }
            /// <summary>
            /// 来源
            /// </summary>
            public string SourceFrom { get; set; }
            /// <summary>
            /// 是否使用 为了json转换
            /// </summary>
            public bool isUsed { get; set; }

            private int? isused;
            /// <summary>
            /// 用于页面赋值 0:未使用 1:已使用  2:已过期
            /// </summary>
            public int? IsUsed
            {
                get { return isused ?? (isUsed ? 1 : 0); }
                set { isused = value; }
            }
            /// <summary>
            /// 是否使用 为了json转换
            /// </summary>
            public bool isReceive { get; set; }

            private int? isreceive;
            /// <summary>
            /// 是否接收
            /// </summary>
            public int? IsReceive
            {
                get { return isreceive ?? (isReceive ? 1 : 0); }
                set { isreceive = value; }
            }
            /// <summary>
            /// 价值
            /// </summary>
            public decimal PrizeValue;
            public DateTime? ReceiveEndDate { get; set; }
            /// <summary>
            /// 过期时间
            /// </summary>
            public DateTime? ExpirationDate { get; set; }
            public DateTime? ReceiveDate { get; set; }

            public DateTime CreateDate { get; set; }

            public int? Status { get; set; }

            public int TypeId { get; set; }
        }

        public class ResponseBody<T>
        {
            public string returnType { get; set; }
            public string message { get; set; }
            public T data { get; set; }
        }

        public class SimpleUserPrize : WXUserPrizeListInfo
        {
            public string ticket { get; set; }
            
            public int status
            {
                get;
                set;
            }
        }
        
        
    }
}