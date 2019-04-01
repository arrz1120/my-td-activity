﻿using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using System.Text;
using Tool;
using System.Data;
using TuanDai.UserPrizeNew.ServiceClient.Models;
using BusinessDll;
using TuanDai.DQSystemAPI.Client;
using System.Configuration;
using WebSettingInfo = TuanDai.PortalSystem.Model.WebSettingInfo;
using TuanDai.ZKHelper;

//using TuanDai.PortalSystem.Redis;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_AppFind 的摘要说明
    /// </summary>
    public class ajax_AppFind : SafeHandlerBase
    {
        /// <summary>
        /// 获取我的邀请人列表
        /// </summary>
        public void GetInvestList()
        {

            string extendkey = Context.Request.Form["extendkey"];

            #region 判断用户是否存在
            if (string.IsNullOrEmpty(extendkey))
            {
                this.PrintJson("-1", "请重新登录");
            }
            Guid? userid = Guid.Empty;
            Dapper.DynamicParameters whereParam = new Dapper.DynamicParameters();
            if (WebUserAuth.IsAuthenticated)
            {
                var user = new UserBLL().GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
                if (user != null)
                {
                    userid = user.Id;
                }
            }
            else
            {
                whereParam = new Dapper.DynamicParameters();
                whereParam.Add("@extendkey", extendkey);
                string useridsql = "select id from UserBasicInfo with(nolock) where ExtendKey =@extendkey";
                userid = PublicConn.QuerySingle<Guid?>(useridsql, ref whereParam);
            }
            if (!userid.HasValue || userid == Guid.Empty)
            {
                this.PrintJson("-1", "请重新登录");
            }
            #endregion

            int pagesize = SafeConvert.ToInt32(Context.Request.Form["pagesize"], 6);
            int pageindex = SafeConvert.ToInt32(Context.Request.Form["pageindex"], 1);

            if (pageindex < 1)
            {
                pageindex = 1;
            }
            int type = SafeConvert.ToInt32(Context.Request.Form["type"], 0);//0：表示全部 1：表示最近一月 2：表示最近一周

            WebSettingInfo timeset = new WebSettingBLL().GetWebSettingInfo("CF25D857-6144-4242-AA51-1227D5918024");
            DateTime NewPartnerBeginDate = DateTime.Parse(timeset.Param1Value);
            DateTime NewPartnerEndDate = DateTime.Parse(timeset.Param2Value);
            string wheresql = " AND r.AddDate >= @begintime --AND r.AddDate < @activityEndTime ";
            if (type == 1)
            {
                DateTime lastDay = Tool.SafeConvert.ToDateTime(DateTime.Now.ToString("yyyy-MM-01"));
                DateTime beginDay = lastDay.AddMonths(-1);
                NewPartnerBeginDate = beginDay > NewPartnerBeginDate ? beginDay : NewPartnerBeginDate;
                NewPartnerEndDate = lastDay;
                wheresql = " AND r.AddDate >= @begintime AND r.AddDate<@activityEndTime ";
            }
            else if (type == 2)
            {
                int weekCount = DateTime.Now.DayOfWeek == DayOfWeek.Sunday ? 7 : (int)DateTime.Now.DayOfWeek;
                DateTime lastSunday = DateTime.Now.AddDays(-weekCount + 1).Date;
                DateTime beginDay = lastSunday.AddDays(-8);
                NewPartnerBeginDate = beginDay > NewPartnerBeginDate ? beginDay : NewPartnerBeginDate;
                NewPartnerEndDate = lastSunday;
                wheresql = " AND r.AddDate >= @begintime AND r.AddDate<@activityEndTime";
            }

            string sql = string.Format(@"SELECT * FROM (
                                SELECT  r.UserId,ISNULL(u.TelNo,'') as TelNo,ISNULL(f.TotalInvest,0)+ISNULL(wf.TotalInvest,0) TotalInvest,r.AddDate AddDate,ROW_NUMBER() OVER ( ORDER BY r.AddDate ) RowId,sum(1) over() Total 
                                FROM dbo.ExtenderRelation(nolock) r 
                                LEFT JOIN dbo.FundAccountInfo(nolock) f ON f.UserId = r.UserId 
                                LEFT JOIN dbo.We_FundAccountInfo(nolock) wf ON wf.UserId = r.UserId
                                LEFT JOIN dbo.UserBasicInfo(nolock) u ON u.Id = r.UserId 
                                WHERE r.ExtenderKey =@extendkey {0}
                            ) t
                           WHERE   rowId between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize", wheresql);

            whereParam = new Dapper.DynamicParameters();
            whereParam.Add("@extendkey", extendkey);
            whereParam.Add("@pageSize", pagesize);
            whereParam.Add("@pageIndex", pageindex);
            whereParam.Add("@begintime", NewPartnerBeginDate);
            whereParam.Add("@activityEndTime", NewPartnerEndDate);

            List<InvestModel> list = new List<InvestModel>();
            list = PublicConn.QueryBySql<InvestModel>(sql, ref whereParam);
            list.ForEach(x =>
            {
                x.IsTender = "否";
                x.TelNo = !string.IsNullOrEmpty(x.TelNo) ? Tool.Common.Utils.StringHandler.MaskTelNo(x.TelNo) : "";
                if (x.TotalInvest > 0)
                {
                    x.IsTender = "是";
                }
                else
                {
                    var totalInvest = DQHelperClient.GetUserInvest(x.UserId.ToString());
                    if (totalInvest != null)
                    {
                        List<UserInvestFlag> totalInvestlist = ToObject<List<UserInvestFlag>>(totalInvest);
                        if (list != null && list.Count > 0)
                        {
                            if (Tool.SafeConvert.ToDecimal(totalInvestlist.FirstOrDefault().TotalInvest ?? 0) > 0)
                            {
                                x.IsTender = "是";
                            }
                            else
                            {
                                x.IsTender = "否";
                            }
                        }
                    }


                }



                //x.TotalInvest > 0 ? "是" : "否";
                x.AddDate = Tool.SafeConvert.ToDateTime(x.AddDate).ToString("yyyy/MM/dd");
            });



            InvestInfo model = new InvestInfo();
            model.InvestList = list != null ? list : new List<InvestModel>();
            model.Total = list.Count > 0 ? list[0].Total : 0;

            this.PrintJson("1", ToJson(model));
        }


        /// <summary>
        /// 邀请人数排行榜
        /// </summary>
        public void GetInvestNumList()
        {
            string extendkey = Context.Request.Form["extendkey"];

            #region 判断用户是否存在
            if (string.IsNullOrEmpty(extendkey))
            {
                this.PrintJson("-1", "请重新登录");
            }

            Guid? userid = Guid.Empty;
            Dapper.DynamicParameters whereParam = null;
            if (WebUserAuth.IsAuthenticated)
            {
                var user = new UserBLL().GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
                if (user != null)
                {
                    userid = user.Id;
                }
            }
            else
            {
                whereParam = new Dapper.DynamicParameters();
                whereParam.Add("@extendkey", extendkey);
                string useridsql = "select id from UserBasicInfo with(nolock) where ExtendKey =@extendkey";
                userid = PublicConn.QuerySingle<Guid?>(useridsql, ref whereParam);
            }

            if (!userid.HasValue || userid == Guid.Empty)
            {
                this.PrintJson("-1", "请重新登录");
            }
            #endregion

            int type = SafeConvert.ToInt32(Context.Request.Form["type"], 0);//0：表示全部 1：表示最近一月 2：表示最近一周

            InvestNumInfo model = new InvestNumInfo();

            #region 获取排行前十的数据
            //获取排行前十的数据
            string typesql = " TotalExtendNum ";

            if (type == 1)
            {
                typesql = " MonthExtendNum ";
            }
            else if (type == 2)
            {
                typesql = " WeekExtendNum ";
            }


            string sql = string.Format(@"select TOP 10 ROW_NUMBER() OVER ( ORDER BY {0} desc ) as [Num],TelNo,{0} as InvestCount from rp_ExtenderStatis (nolock)", typesql);
            List<InvestNumModel> list = new List<InvestNumModel>();
            whereParam = new Dapper.DynamicParameters();
            list = PublicConn.QueryReportBySql<InvestNumModel>(sql, ref whereParam);
            model.InvestNum = list;

            list.ForEach(x =>
            {
                x.TelNo = !string.IsNullOrEmpty(x.TelNo) ? Tool.Common.Utils.StringHandler.MaskTelNo(x.TelNo) : "";
            });
            #endregion

            #region 获取用户排行情况
            //获取用户排行情况
            string mysql = string.Format("SELECT 11 as [Num] , TelNo,{0} as InvestCount from rp_ExtenderStatis(nolock) where UserId=@userId", typesql);
            whereParam = new Dapper.DynamicParameters();
            whereParam.Add("@UserId", userid ?? Guid.Empty);
            InvestNumModel investNumModel = new InvestNumModel();
            investNumModel = PublicConn.QueryReportBySql<InvestNumModel>(mysql, ref whereParam).FirstOrDefault();

            int difference = list.Count > 1 ? list[0].InvestCount - (investNumModel != null ? investNumModel.InvestCount : 0) : 0;
            model.Difference = difference > 0 ? difference : 0;
            model.MyInvestCount = investNumModel != null ? investNumModel.InvestCount : 0;
            #endregion

            model.InvestUrl = "https://hd.tuandai.com/weixin/Invite/InviteIndex.aspx?type=mobileapp";

            this.PrintJson("1", ToJson(model));
        }

        /// <summary>
        /// 判断是否停服
        /// </summary>
        public void ShutdownMaintenance()
        {
            string isAppStop = ConfigurationManager.AppSettings["AppIsStop"];
            StringBuilder sb = new StringBuilder();
            if (!string.IsNullOrWhiteSpace(isAppStop))
            {
                if (isAppStop == "0")
                    sb.Append("{\"result\":\"1\",\"isStop\": 0 }");
                else
                    sb.Append("{\"result\":\"1\",\"isStop\": 1 }");
            }
            else
            {
                sb.Append("{\"result\":\"1\",\"isStop\": 0 }");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }


        #region 获取个人佣金
        /// <summary>
        /// 获取个人佣金 列表
        ///  huangbinglai 2016/08/26
        /// </summary>
        public void GettExtendEarnRecordList()
        {
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            int pageSize = Tool.SafeConvert.ToInt32(Context.Request.Form["pageSize"], 10);
            string extendKey = Context.Request.Form["extendkey"];
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
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
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"0\"}");
                this.Context.Response.Write(sb.ToString());
                this.Context.Response.End();
                return;
            }

            // ExtendEarnRecordBLL bll = new ExtendEarnRecordBLL();
            WebSettingInfo timeset = new WebSettingBLL().GetWebSettingInfo("CF25D857-6144-4242-AA51-1227D5918024");
            var newPartnerBeginDate = Tool.SafeConvert.ToDateTime(timeset.Param1Value);
            List<ExtendEarnRecordInfo> ExtendEarnRecordList = WXGetExtendEarnRecordList(user.Id, pageSize, pageindex, out totalcount, newPartnerBeginDate);

            if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (ExtendEarnRecordInfo temp in ExtendEarnRecordList)
                {
                    sb.Append("{\"Adddate\":\"" + temp.Adddate.ToShortDateString()
                          + "\",\"EarnMoney\":\"" + temp.EarnMoney.ToString("0.00")//RetainTwoDecimal(temp.EarnMoney)
                    + "\",\"sendEarnStatusText\":\"" + (temp.sendEarnStatus.HasValue && temp.sendEarnStatus.Value == 2 ? "(补发)" : "")
                          );
                    if (index == ExtendEarnRecordList.Count())
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
            else if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count() == 0)
            {
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\"}");
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        /// <summary>
        /// 获取个人佣金列表
        /// huangbinglai 2016/08/26
        /// </summary>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="recordCount"></param>
        /// <returns></returns>
        //public List<ExtendEarnRecordInfo> WXGetExtendEarnRecordList(Guid userid, int pageSize, int pageIndex, out int recordCount, DateTime PartnerBeginDate)
        //{
        //    var param = new Dapper.DynamicParameters();
        //    param.Add("@userId", userid);
        //    param.Add("@pageSize", pageSize);
        //    param.Add("@pageIndex", pageIndex);
        //    param.Add("@ActivityStartDate", PartnerBeginDate);
        //    //,[HandleStatus],isnull(UserLevel,0) UserLevel, SUM(1) OVER() RecordCount
        //    string querySql = string.Format(@"with t as (select ROW_NUMBER() over (ORDER BY CONVERT(VARCHAR(10),Adddate,23)  DESC) AS rowId ,[UserID],  ISNULL(SUM([Count_1]),0)  [Count_1],ISNULL(SUM([DueInAmount_1]),0) [DueInAmount_1],
        //                                  ISNULL(SUM([EarnMoney]),0)  [EarnMoney], CONVERT(VARCHAR(10),Adddate,23) Adddate
        //                    from [dbo].[ExtendEarnRecord](NOLOCK)  where UserID=@UserId and ISNULL([EarnMoney],0)>0   and  Adddate>=@ActivityStartDate   GROUP BY CONVERT(VARCHAR(10),Adddate,23),[UserID] ) 
        //                    select *,SUM(1) OVER() RecordCount  from t where rowId>@pageSize*(@pageIndex-1) and rowId<=@pageSize*@pageIndex and ISNULL([EarnMoney],0)>0");
        //    List<ExtendEarnRecordInfo> list = TuanDai.DB.TuanDaiDB.Query<ExtendEarnRecordInfo>(TdConfig.ApplicationName, TdConfig.DBReportWrite, querySql, ref param);
        //    recordCount = list.Count > 0 ? list[0].RecordCount : 0; //暂时不需要
        //    return list;
        //}




        /// <summary>
        /// 获取个人佣金 排名
        ///  huangbinglai 2016/08/26
        /// </summary>
        public void GetAccumulatedData()
        {
            string extendKey = Context.Request.Form["extendkey"];
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
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
            {
                sb.Append("{\"result\":\"0\",\"rank\":\"0\",\"TotalEranMoney\":\"0\"}");
                this.Context.Response.Write(sb.ToString());
                this.Context.Response.End();
                return;
            }


            //  ExtendEarnRecordBLL bll = new ExtendEarnRecordBLL();
            WebSettingInfo timeset = new WebSettingBLL().GetWebSettingInfo("CF25D857-6144-4242-AA51-1227D5918024");
            var newPartnerBeginDate = Tool.SafeConvert.ToDateTime(timeset.Param1Value);
            List<ExtendEarnRecordSolveInfo> ExtendEarnRecordList = WXGetExtendEarnRecordSolveList(user.Id, out totalcount, newPartnerBeginDate);//WXGetExtendEarnRecordList(user.Id, 5, 1, out totalcount, newPartnerBeginDate);
            Tuple<Int32, decimal> tlExtendEarnRank = WXGetExtendEarnRank(user.Id);
            if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"rank\":\"" + tlExtendEarnRank.Item1.ToString() + "\",\"TotalEranMoney\":\"" + tlExtendEarnRank.Item2.ToString() + "\",\"list\":[");
                foreach (ExtendEarnRecordSolveInfo temp in ExtendEarnRecordList)
                {
                    sb.Append("{\"Adddate\":\"" + temp.Adddate.ToShortDateString()
                          + "\",\"EarnMoney\":\"" + RetainTwoDecimal(temp.EarnMoney)

                          );
                    if (index == ExtendEarnRecordList.Count())
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
            else if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count() == 0)
            {
                sb.Append("{\"result\":\"1\",\"rank\":\"" + tlExtendEarnRank.Item1.ToString() + "\",\"TotalEranMoney\":\"" + RetainTwoDecimal(tlExtendEarnRank.Item2) + "\"}");
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"rank\":\"" + tlExtendEarnRank.Item1.ToString() + "\",\"TotalEranMoney\":\"" + RetainTwoDecimal(tlExtendEarnRank.Item2) + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();


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
            dyParams.Add("@RowNum", 0, DbType.Int32, ParameterDirection.Output);
            dyParams.Add("@TotalEranMoney", 0, DbType.Decimal, ParameterDirection.Output, 18, null, 2);

            string querySql = @"SELECT @RowNum= AA.RowNum,@TotalEranMoney=AA.TotalEranMoney
                                                from ( select ROW_NUMBER() OVER(ORDER BY TotalEranMoney DESC) AS RowNum ,UserId,TelNo,TotalEranMoney
                                                        from rp_ExtenderStatis with(nolock) )AA
                                                 where AA.UserId=@userId";




            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBReportWrite, querySql, ref dyParams);

            decimal? totalEranMoney = GetExtendEarn(userid) ?? 0;
            totalEranMoney = Math.Floor((totalEranMoney ?? 0) * 100) / 100;

            Tuple<Int32, decimal> result = new Tuple<Int32, decimal>(0, totalEranMoney ?? 0);
            return result;

        }


        /// <summary>
        /// 获取佣金排行版
        ///  huangbinglai 2016/08/26
        /// </summary>
        public void GettExtendEarnRecordRank()
        {
            string extendKey = Context.Request.Form["extendkey"];
            UserBasicInfoInfo user = null;
            if (WebUserAuth.IsAuthenticated)
            {
                user = new UserBLL().GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
            }
            else
            {
                user = new UserBLL().GetUserBasicInfoByExtendKey(extendKey);
            }


            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            int pageSize = Tool.SafeConvert.ToInt32(Context.Request.Form["pageSize"], 5);
            //   string extendKey = Context.Request.Form["extendKey"];
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            // ExtendEarnRecordBLL bll = new ExtendEarnRecordBLL();
            //List<ExtenderStatisInfo> ExtendEarnRecordList = WXGetExtenderStatisList(pageSize, pageindex, out totalcount);
            int rank = 0;
            decimal totalAmount = 0;
            List<RankInfo> ExtendEarnRecordList = WXGetExtenderStatisForJavaList(user.Id.ToString(), pageSize, pageindex, out totalcount,ref rank,ref totalAmount);

            if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"rank\":\"" + rank + "\",\"totalAmount\":\"" + totalAmount + "\",\"list\":[");
                int count = (pageindex - 1) * pageSize;

                foreach (RankInfo temp in ExtendEarnRecordList)
                {
                    count = count + 1;
                    sb.Append("{\"rowId\":\"" + count
                          + "\",\"TelNo\":\"" + temp.phone
                           + "\",\"TotalEranMoney\":\"" + RetainTwoDecimal(temp.totalAmount)
                          );
                    if (index == ExtendEarnRecordList.Count())
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
            else if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count() == 0)
            {
                sb.Append("{\"result\":\"1\",\"rank\":\"" + rank + "\",\"totalAmount\":\"" + totalAmount + "\",\"totalcount\":\"" + totalcount + "\"}");
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"rank\":\"" + rank + "\",\"totalAmount\":\"" + totalAmount + "\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        //
        /// <summary>
        /// 获取佣金排行榜
        /// huangbinglai 2016/08/26
        /// </summary>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="recordCount"></param>
        /// <returns></returns>
        public List<ExtenderStatisInfo> WXGetExtenderStatisList(int pageSize, int pageIndex, out int recordCount)
        {
            var param = new Dapper.DynamicParameters();
            param.Add("@pageSize", pageSize);
            param.Add("@pageIndex", pageIndex);
            string querySql = string.Format(@"with t as (select ROW_NUMBER() OVER(ORDER BY TotalEranMoney DESC) AS rowId ,UserId,TelNo,TotalEranMoney, SUM(1) OVER() RecordCount
                                            from rp_ExtenderStatis with(nolock)  ) 
                                                select * from t where  rowId<=100 AND  rowId>@pageSize*(@pageIndex-1) and rowId<=@pageSize*@pageIndex");
            List<ExtenderStatisInfo> list = TuanDai.DB.TuanDaiDB.Query<ExtenderStatisInfo>(TdConfig.ApplicationName, TdConfig.DBReportWrite, querySql, ref param);
            list.ForEach(x =>
            {
                x.TelNo = StringHandler.MaskTelNo(x.TelNo);
            });

            recordCount = list.Count > 0 ? list[0].RecordCount : 0; //暂时不需要
            return list;
        }

        public List<RankInfo> WXGetExtenderStatisForJavaList(string userid, int pageSize, int pageIndex, out int recordCount,ref int rank,ref decimal totalAmount)
        {

            List<RankInfo> list = new List<RankInfo>();
            recordCount = 0;
            #region 个人佣金列表java接口版

            string errorMsg = string.Empty;
            string Url = System.Configuration.ConfigurationManager.AppSettings["CommissionApiUrl"] ?? ZooKClient.GetValueForZK("/url/CommissionApiUrl", ref errorMsg);

            if (!string.IsNullOrWhiteSpace(Url))
            {
                string newUserAPIURL = string.Format("{0}/commission/{1}/second/rank", Url, userid);
                try
                {
                    string result = "";
                    errorMsg = string.Empty;
                    result = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName, newUserAPIURL, "", out errorMsg,
                        null, 2);
                    CommissionApiResponse<RankResponse> commissionInfo = JsonConvert.DeserializeObject<CommissionApiResponse<RankResponse>>(result);
                    if (commissionInfo != null && commissionInfo.code == "SUCCESS")//如果返回银行卡为空，返回默认值
                    {
                        if (commissionInfo.data.rankList != null)
                        {
                            if (commissionInfo.data.personRank != null)
                            {
                                rank = commissionInfo.data.personRank ?? 0;
                            }
                            if (commissionInfo.data.totalAmount != null)
                            {
                                totalAmount = commissionInfo.data.totalAmount ?? 0;
                            }
                            if (commissionInfo.data.rankList.Count > 0)
                            {
                                recordCount = commissionInfo.data.rankList.Count;

                                int? count = commissionInfo.data.rankList.Skip((pageIndex - 1) * pageSize).Take(pageSize).Count();

                                List<RankInfo> rankList = count > 0 ? commissionInfo.data.rankList.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList() : new List<RankInfo>();

                                rankList.ForEach(x =>
                                {
                                    x.phone = StringHandler.MaskTelNo(x.phone);
                                });

                                return rankList;
                            }
                            
                        }
                    }
                    else if (commissionInfo == null)
                    {
                        recordCount = 0;
                        return list;
                    }
                    else
                    {
                        if (commissionInfo != null && commissionInfo.code != "USERID_PARAM_EMPTY_ERROR")
                        {
                            TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtendEarnRecordList", "用户不存在", "json=" + result);
                            recordCount = 0;
                            return list;
                        }
                        else if (commissionInfo != null && commissionInfo.code != "USERID_PARAM_EMPTY_ERROR")
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtenderStatisForJavaList", "查询用户佣金排行榜失败", "json=" + result);
                            recordCount = 0;
                            return list;
                        }
                        else
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtenderStatisForJavaList", "数据异常", "json=" + result);
                            recordCount = 0;
                            return list;
                        }
                    }

                }
                catch (Exception ex)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtenderStatisForJavaList", "获取数据异常", ex.Message + "  |  " + ex.StackTrace);
                    recordCount = 0;
                    return list;
                }
            }
            else
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtenderStatisForJavaList", "Url为空", Url);
                recordCount = 0;
                return list;
            }

            #endregion



            return list;
        }



        public void GetRedPacketPrizeList()
        {
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            int pageSize = Tool.SafeConvert.ToInt32(Context.Request.Form["pageSize"], 10);
            string extendKey = Context.Request.Form["extendkey"];
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
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
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"0\"}");
                this.Context.Response.Write(sb.ToString());
                this.Context.Response.End();
                return;
            }

            // ExtendEarnRecordBLL bll = new ExtendEarnRecordBLL();
            List<RedPacketPrizeInfo> RedPacketPrizeList = WXGetRedPacketPrizeList(user.Id, pageSize, pageindex, out totalcount);
            if (RedPacketPrizeList != null && RedPacketPrizeList.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (RedPacketPrizeInfo temp in RedPacketPrizeList)
                {
                    sb.Append("{\"PrizeName\":\"" + temp.PrizeName
                          + "\",\"PrizeValue\":\"" + temp.PrizeValue
                          + "\",\"CreateDate\":\"" + temp.CreateDate.ToString("yyyy.MM.dd")
                          + "\",\"ExpirationDate\":\"" + temp.ExpirationDate.ToString("yyyy.MM.dd")
                          + "\",\"IsUsed\":\"" + temp.IsUsed
                          + "\",\"FromTelNo\":\"" + temp.FromTelNo
                          );
                    if (index == RedPacketPrizeList.Count())
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
            else if (RedPacketPrizeList != null && RedPacketPrizeList.Count() == 0)
            {
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\"}");
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        /// <summary>
        /// 获取红包列表
        /// huangbinglai 2016/08/27
        /// </summary>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="recordCount"></param>
        /// <returns></returns>
        public List<RedPacketPrizeInfo> WXGetRedPacketPrizeList(Guid userid, int pageSize, int pageIndex, out int recordCount)
        {
            var param = new Dapper.DynamicParameters();
            param.Add("@userId", userid);
            param.Add("@pageSize", pageSize);
            param.Add("@pageIndex", pageIndex);
            //string querySql = @"with t as (SELECT  PrizeName ,PrizeValue,CreateDate,ExpirationDate,IsUsed,ROW_NUMBER() over (ORDER BY CreateDate DESC) AS rowId
            //                                 FROM dbo.UserPrize (NOLOCK)
            //                                WHERE  USERID =@userId AND ActivityCode = 'xianshituijian_20160401'
            //                                and ((IsReceive=0 and ReceiveEndDate >GETDATE()) or (IsReceive =1 and IsUsed=0 and  ExpirationDate>GETDATE()))
            //                                AND SourceFrom = '限时推荐有红包,还有3重大礼包(推荐好友)' ) 
            //                             select * from t where rowId>@pageSize*(@pageIndex-1) and rowId<=@pageSize*@pageIndex";
            //List<RedPacketPrizeInfo> list = TuanDai.DB.TuanDaiDB.Query<RedPacketPrizeInfo>(TdConfig.ApplicationName, TdConfig.DBRead, querySql, ref param);
            List<RedPacketPrizeInfo> list = null;

            string err = "";
            GetUserPrizeByTypeAndPagerRequest request = new GetUserPrizeByTypeAndPagerRequest();
            request.userId = userid;
            request.pageIndex = pageIndex;
            request.pageSize = pageSize;
            request.activityCodeList = new List<string>() { "xianshituijian_20160401" };
            request.sourceFrom = "限时推荐有红包,还有3重大礼包(推荐好友)";
            request.isUsed = false;
            request.isExpired = false;
            var response = new TuanDai.UserPrizeNew.Client.UserPrizeQueryClient(TdConfig.ApplicationName)
                .GetUserPrizeByTypeAndPager(request, out err);
            list =
                JsonConvert.DeserializeObject<List<RedPacketPrizeInfo>>(
                    JsonConvert.SerializeObject(
                        response.dataList));
            if (list == null)
                list = new List<RedPacketPrizeInfo>();

            recordCount = response.totalCount;
            return list;
        }


        public static decimal RetainTwoDecimal(object obj)
        {
            if (obj == null || obj.ToString() == "")
            {
                decimal i = 0;
                return Math.Floor(i);
            }
            decimal amount = decimal.Parse(obj.ToString());
            amount = Math.Floor(amount * 100) / 100;
            return amount;
        }

        #endregion


        #region java接口版
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
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.GetExtendEarn", "commissionInfo为空", Url);
                            return null;
                        }
                        else
                        {
                            if (commissionInfo != null && commissionInfo.code != "SEARCH_USER_ID_NOT_FOUND_ERROR")
                            {
                                TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "ajax_AppFind.GetExtendEarn", "用户不存在", "json=" + result);
                                return null;
                            }
                            else
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.GetExtendEarn", "数据异常", "json=" + result);
                                return null;
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.GetExtendEarn", "获取数据异常", ex.Message + "  |  " + ex.StackTrace);
                        return null;
                    }
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.GetExtendEarn", "Url为空", Url);
                    return null;
                }
            }
            else
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.GetExtendEarn", "获取CommissionApiUrl失败", errorMsg);
                return null;
            }
            #endregion
        }


        public List<ExtendEarnRecordInfo> WXGetExtendEarnRecordList(Guid userid, int pageSize, int pageIndex, out int recordCount, DateTime PartnerBeginDate)
        {
            List<ExtendEarnRecordInfo> list = new List<ExtendEarnRecordInfo>();


            #region 个人佣金列表java接口版
            string errorMsg = "";
            string Url = System.Configuration.ConfigurationManager.AppSettings["CommissionApiUrl"] ?? ZooKClient.GetValueForZK("/url/CommissionApiUrl", ref errorMsg);
            if (string.IsNullOrWhiteSpace(errorMsg))
            {
                if (!string.IsNullOrWhiteSpace(Url))
                {
                    string startDate = "";
                    string endDate = "";
                    string newUserAPIURL = string.Format("{0}/commission/{1}/earnDetail?startDate={2}&currentPage={3}&pageSize={4}", Url, userid.ToString(), PartnerBeginDate.ToString("yyyy-MM-dd"), pageIndex, pageSize);
                    try
                    {
                        string result = "";
                        errorMsg = string.Empty;
                        result = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName, newUserAPIURL, "", out errorMsg,
                            null, 2);
                        CommissionApiResponse<ExtendEarnRecordResponse> commissionInfo = JsonConvert.DeserializeObject<CommissionApiResponse<ExtendEarnRecordResponse>>(result);
                        if (commissionInfo != null && commissionInfo.code == "SUCCESS")//如果返回银行卡为空，返回默认值
                        {
                            recordCount = commissionInfo.data.totalPages;
                            return list = commissionInfo.data.pageData;
                        }
                        else if (commissionInfo == null)
                        {
                            recordCount = 0;
                            return list;
                        }
                        else
                        {
                            if (commissionInfo != null && commissionInfo.code != "SEARCH_USER_ID_NOT_FOUND_ERROR")
                            {
                                TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtendEarnRecordList", "用户不存在", "json=" + result);
                                recordCount = 0;
                                return list;
                            }
                            else
                            {
                                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtendEarnRecordList", "数据异常", "json=" + result);
                                recordCount = 0;
                                return list;
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtendEarnRecordList", "获取数据异常", ex.Message + "  |  " + ex.StackTrace);
                        recordCount = 0;
                        return list;
                    }
                }
                else
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtendEarnRecordList", "Url为空", Url);
                    recordCount = 0;
                    return list;
                }
            }
            else
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "ajax_AppFind.WXGetExtendEarnRecordList", "获取CommissionApiUrl失败", errorMsg);
                recordCount = 0;
                return list;
            }
            #endregion
        }


        public List<ExtendEarnRecordSolveInfo> WXGetExtendEarnRecordSolveList(Guid userid, out int recordCount, DateTime PartnerBeginDate)
        {
            int totalcount = 0;
            List<ExtendEarnRecordSolveInfo> list = new List<ExtendEarnRecordSolveInfo>();
            List<ExtendEarnRecordInfo> ExtendEarnRecordList = WXGetExtendEarnRecordList(userid, 20, 1, out totalcount, PartnerBeginDate);
            if (ExtendEarnRecordList != null && ExtendEarnRecordList.Count > 0)
            {
                ExtendEarnRecordList.ForEach(x => {
                    ExtendEarnRecordSolveInfo model = new ExtendEarnRecordSolveInfo();
                    if (list.Any(s => s.Adddate.ToString("yyyy-MM-dd") == x.Adddate.ToString("yyyy-MM-dd")))
                    {
                        list.ForEach(a => {
                            if (a.Adddate.ToString("yyyy-MM-dd") == x.Adddate.ToString("yyyy-MM-dd"))
                            {
                                a.EarnMoney = Math.Floor((a.EarnMoney + x.EarnMoney) * 100) / 100;
                            }
                        });

                    }
                    else
                    {
                        model.Adddate = Tool.SafeConvert.ToDateTime(x.Adddate.ToString("yyyy-MM-dd"));
                        model.EarnMoney = Math.Floor(x.EarnMoney * 100) / 100;
                        list.Add(model);
                    }

                });
                list = list.OrderByDescending(c => c.Adddate).Take(5).ToList();
            }



            recordCount = list != null ? list.Count : 0;
            return list;
        }

        #endregion

    }

    public class RankResponse
    {
        public int? personRank { get; set; }

        public decimal? totalAmount { get; set; }

        private List<RankInfo> _rankList = new List<RankInfo>();

        public List<RankInfo> rankList
        {
            get { return _rankList; }
            set { _rankList = value; }
        }
    }

    public class RankInfo
    {
        public string phone { get; set; }

        public decimal totalAmount { get; set; }
    }


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

    public class ExtendEarnRecordResponse
    {
        private int _totalPages = 0;
        public int totalPages
        {
            get { return _totalPages; }
            set { _totalPages = value; }
        }

        private int _pageSize = 20;

        public int pageSize
        {
            get { return _pageSize; }
            set { _pageSize = value; }
        }

        private List<ExtendEarnRecordInfo> _pageData = new List<ExtendEarnRecordInfo>();

        public List<ExtendEarnRecordInfo> pageData
        {
            get { return _pageData; }
            set { _pageData = value; }
        }
    }



    /// <summary>
    /// 邀请人数排行榜
    /// </summary>
    public class InvestNumModel
    {
        private string telNo = string.Empty;
        /// <summary>
        /// 被邀请的人电话号码
        /// </summary>
        public string TelNo
        {
            get { return telNo; }
            set { telNo = value; }
        }

        private int investCount = 0;
        /// <summary>
        /// 邀请人数
        /// </summary>
        public int InvestCount
        {
            get { return investCount; }
            set { investCount = value; }
        }

        private int num = 0;
        /// <summary>
        /// 排名
        /// </summary>
        public int Num
        {
            get { return num; }
            set { num = value; }
        }


    }

    /// <summary>
    /// 邀请人数排行榜实体
    /// </summary>
    public class InvestNumInfo
    {
        private List<InvestNumModel> investNum = new List<InvestNumModel>();
        /// <summary>
        /// 邀请人数排行榜
        /// </summary>
        public List<InvestNumModel> InvestNum
        {
            get { return investNum; }
            set { investNum = value; }
        }

        private int myInvestCount = 0;
        /// <summary>
        /// 我的邀请人数
        /// </summary>
        public int MyInvestCount
        {
            get { return myInvestCount; }
            set { myInvestCount = value; }
        }

        private int difference = 0;
        /// <summary>
        /// 我的邀请排名距离第一名差距
        /// </summary>
        public int Difference
        {
            get { return difference; }
            set { difference = value; }
        }

        private string investUrl = string.Empty;
        /// <summary>
        /// 立即邀请好友
        /// </summary>
        public string InvestUrl
        {
            get { return investUrl; }
            set { investUrl = value; }
        }
    }

    public class UserInvestFlag
    {
        public Guid UserId { get; set; }
        public decimal? TotalInvest { get; set; }
    }

    /// <summary>
    /// 我的邀请人信息
    /// </summary>
    public class InvestModel
    {
        private string telNo = string.Empty;
        /// <summary>
        /// 被邀请的人电话号码
        /// </summary>
        public string TelNo
        {
            get { return telNo; }
            set { telNo = value; }
        }

        private decimal totalInvest = 0;
        /// <summary>
        /// 累计投资金额
        /// </summary>
        public decimal TotalInvest
        {
            get { return totalInvest; }
            set { totalInvest = value; }
        }

        private string addDate = string.Empty;
        /// <summary>
        /// 注册时间
        /// </summary>
        public string AddDate
        {
            get { return addDate; }
            set { addDate = value; }
        }

        private int total = 0;
        /// <summary>
        /// 分页
        /// </summary>
        public int Total
        {
            get { return total; }
            set { total = value; }
        }

        private string isTender = string.Empty;
        /// <summary>
        /// 是否投标
        /// </summary>
        public string IsTender
        {
            get { return isTender; }
            set { isTender = value; }
        }

        private Guid userId = Guid.Empty;

        public Guid UserId
        {
            get { return userId; }
            set { userId = value; }
        }

    }

    /// <summary>
    /// 我的邀请人信息实体
    /// </summary>
    public class InvestInfo
    {
        private List<InvestModel> investList = new List<InvestModel>();
        /// <summary>
        /// 邀请好友列表
        /// </summary>
        public List<InvestModel> InvestList
        {
            get { return investList; }
            set { investList = value; }
        }

        private int total = 0;
        /// <summary>
        /// 总行数
        /// </summary>
        public int Total
        {
            get { return total; }
            set { total = value; }
        }
    }


    public class ExtendEarnRecordInfo
    {
        public Guid ID { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid UserID { get; set; }
        /// <summary>
        /// 一级人脉数量
        /// </summary>
        public int Count_1 { get; set; }
        /// <summary>
        /// 一级人脉待收总额
        /// </summary>
        public decimal DueInAmount_1 { get; set; }
        /// <summary>
        /// 佣金
        /// </summary>
        public decimal EarnMoney { get; set; }
        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime Adddate { get; set; }
        /// <summary>
        /// 处理状态
        /// </summary>
        public int HandleStatus { get; set; }

        public int UserLevel { get; set; }
        /// <summary>
        /// 记录数
        /// </summary>
        public int RecordCount { get; set; }

        ///// <summary>
        ///// 累计佣金
        ///// </summary>
        //public decimal SumEarnMoney { get; set; }

        public int? sendEarnStatus { get; set; }
    }

    public class ExtendEarnRecordSolveInfo
    {

        /// <summary>
        /// 佣金
        /// </summary>
        public decimal EarnMoney { get; set; }
        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime Adddate { get; set; }


    }

    /// <summary>
    ///  
    /// </summary>
    public class ExtenderStatisInfo
    {
        private Guid _userid;
        private string _telno;
        private int? _totalextendnum;
        private decimal? _totaleranmoney;
        private int? _weekextendnum;
        private int? _monthextendnum;
        private DateTime? _upddate;
        private DateTime? _weekupddate;
        private DateTime? _monthupddate;
        /// <summary>
        /// 
        /// </summary>
        public Guid UserId
        {
            set { _userid = value; }
            get { return _userid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string TelNo
        {
            set { _telno = value; }
            get { return _telno; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? TotalExtendNum
        {
            set { _totalextendnum = value; }
            get { return _totalextendnum; }
        }
        /// <summary>
        /// 
        /// </summary>
        public decimal? TotalEranMoney
        {
            set { _totaleranmoney = value; }
            get { return _totaleranmoney; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? WeekExtendNum
        {
            set { _weekextendnum = value; }
            get { return _weekextendnum; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? MonthExtendNum
        {
            set { _monthextendnum = value; }
            get { return _monthextendnum; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? UpdDate
        {
            set { _upddate = value; }
            get { return _upddate; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? WeekUpdDate
        {
            set { _weekupddate = value; }
            get { return _weekupddate; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? MonthUpdDate
        {
            set { _monthupddate = value; }
            get { return _monthupddate; }
        }
        /// <summary>
        /// 记录数
        /// </summary>
        public int RecordCount { get; set; }
        /// <summary>
        /// 名次
        /// </summary>
        public int rowId { get; set; }
    }


    public class ExtenderStatisJavaInfo
    {

    }


    public class RedPacketPrizeInfo
    {
        /// <summary>
        /// 奖品 名称
        /// </summary>
        public string PrizeName { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        public string PrizeValue { get; set; }
        /// <summary>
        /// 获得时间
        /// </summary>
        public DateTime CreateDate { get; set; }

        /// <summary>
        /// 过期时间
        /// </summary>
        public DateTime ExpirationDate { get; set; }
        /// <summary>
        /// 是否使用
        /// </summary>
        public bool IsUsed { get; set; }

        /// <summary>
        /// 被邀请人电话
        /// </summary>
        public string FromTelNo { get; set; }
        /// <summary>
        /// 记录数
        /// </summary>
        public int RecordCount { get; set; }
    }
}