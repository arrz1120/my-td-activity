using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.LogSystem.LogClient;
using TuanDai.PortalSystem.Model; 
using System.Data; 
using Tool;
using Dapper;
using NetDimension.Json.Converters;
using NetDimension.Json; 

namespace TuanDai.WXApiWeb.Member
{
    /// <summary>
    /// 个人中心--资金统计
    /// Allen 2016-06-13
    /// </summary>
    public partial class incomeCount : AppActivityBasePage
    {
        
        protected ProfitStatistics profitmodel;
        protected decimal totalamount = 0;//资产总计
        protected FundAccountInfoInfo fundAccountInfo;
        protected decimal weWaitInvestment = 0; 
        protected UserBasicInfoInfo userModel;
        protected int JoinTDDay = 0;
        protected decimal totalPayAmount = 0; //累计支出
        protected decimal totalInAmount = 0; //累计收入
        protected PayOutStatistics paymodel;

        protected decimal DueComeInterest = 0;//待收收益
        protected decimal NetEarningsInterest = 0;//已收收益
        protected List<EChartData1Info> chartDatas1;
        protected decimal TotalRecharge = 0;//累计充值
        protected decimal TotalWithDrawal = 0;//累计提现
        protected string action = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/fundStatistics/incomeCount.aspx",true);
            action = WEBRequest.GetQueryString("action").ToText();
            if (action == "getchart1data")
            {
                Guid userId = WebUserAuth.UserId.Value;
                //获取图表1数据
                GetEChartData1(userId); 
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadData();
                }
            }
        }

        protected void LoadData()
        {
            Guid userId = WebUserAuth.UserId.Value;
            TuanDai.PortalSystem.BLL.UserBLL bll = new TuanDai.PortalSystem.BLL.UserBLL();
            userModel = bll.GetUserBasicInfoModelById(userId);
            if (userModel == null)
            {
                Response.Redirect("/Member/my_account.aspx");
                return;
            }

            GetProfitStatistics(userId);
            GetAccountInfo(userId);
            GetPayStatistics(userId);

            JoinTDDay = Tool.DateHelper.GetDateDiffDay(DateTime.Parse(userModel.AddDate.Value.ToString("yyyy-MM-dd")), DateTime.Today.AddDays(1));
            if (JoinTDDay <= 0)
                JoinTDDay = 1;

            totalPayAmount = paymodel.RepayedInterest + (fundAccountInfo.TotalPayOutMember ?? 0) + (fundAccountInfo.TotalWithdrawDepositHandRecharge ?? 0)
                + (fundAccountInfo.TotalPayOutAvalidate ?? 0) + (fundAccountInfo.TotalInvestCommission ?? 0) + (fundAccountInfo.BorrowCommission ?? 0);
            //计算累计收入 待收不算累计  =逾期收益+已收利息+活动奖励+红包收益
            if (profitmodel != null)
                totalInAmount = profitmodel.overDueAmount + profitmodel.recAmount + (fundAccountInfo.RewardMoney ?? 0) + profitmodel.prizeAmount+profitmodel.extenderMoney;
             
            GetTotalWithDrawal();
        }

        #region 统计数据
        //获取资产统计
        private void GetAccountInfo(Guid userid)
        {
            //获取We待投
            weWaitInvestment = GetWePlanWaitInvestment(userid);

            Tuple<decimal, decimal> ftbDueIn = GetFTBDueInAmountInterest(userid);


            var commandText = @"SELECT * from dbo.FundAccountInfo with(nolock) WHERE UserId =@UserId"; ;
            DynamicParameters para = new DynamicParameters();
            para.Add("@UserId", userid);
            fundAccountInfo = PublicConn.QuerySingle<FundAccountInfoInfo>(commandText, ref para);

            //待收利息加上复投宝的利息
            fundAccountInfo.DueInPAndI = (fundAccountInfo.DueInPAndI ?? 0) + ftbDueIn.Item1 + ftbDueIn.Item2;
            fundAccountInfo.DueComeInterest = (fundAccountInfo.DueComeInterest ?? 0) + ftbDueIn.Item2;
            fundAccountInfo.FreezeAcount = (fundAccountInfo.FreezeAcount ?? 0) + weWaitInvestment;  //冻结资金加上We待投 
            fundAccountInfo.TotalInvest += GetWeFtbTotalInvest(userid);

            TotalRecharge = fundAccountInfo.TotalRecharge??0;
           
            totalamount = (fundAccountInfo.AviMoney ?? 0) + (fundAccountInfo.DueInPAndI ?? 0)
               + (fundAccountInfo.BorrowerOut ?? 0) + (fundAccountInfo.DueConfirmWithdrawDeposit ?? 0) + (fundAccountInfo.RewardMoney ?? 0) + (fundAccountInfo.FreezeAcount ?? 0);
        }
        /// <summary>
        /// 获取复投宝累计投资金额
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        private decimal GetWeFtbTotalInvest(Guid userid)
        {
            var commandText = @"SELECT isnull(TotalInvest,0) from dbo.We_FundAccountInfo with(nolock) WHERE UserId =@UserId"; ;
            DynamicParameters para = new DynamicParameters();
            para.Add("@UserId", userid);
            return PublicConn.QuerySingle<decimal?>(commandText, ref para) ?? 0;
        }

        /// <summary>
        /// 收益统计
        /// </summary>
        protected void GetProfitStatistics(Guid userId)
        {
            string sqlText = @"SELECT SUM(A1) AS dueAmount,SUM(A2) AS recAmount,SUM(A3) AS overDueAmount,SUM(A4) AS prizeAmount FROM (
                            SELECT  ISNULL(a.InterestAmout,0)+ISNULL(a.TuandaiRedPacket,0)+ISNULL(a.PublisherRedPacket,0) A1,0 AS A2,0 AS A3,0 AS A4 
                            FROM SubscribeDetail a WITH(NOLOCK)
                            left join SubscribeExtend b with(nolock) on b.SubscribeId=a.SubscribeId
                            WHERE  a.SubscribeUserId=@UserId 
                            UNION ALL
							SELECT 0 AS A1,0 A2 , case when s.isvip = 1 then ISNULL(SUM(ISNULL(B.OverDueInterest,0)),0)+ISNULL(SUM(ISNULL(B.PenaltyAmount,0)),0)/3*2 when s.isvip = 0 then ISNULL(SUM(ISNULL(B.OverDueInterest,0)),0) else 0 end A3,0 AS A4
							FROM  OverDueRecord B WITH(NOLOCK)   
                            join Subscribe s with(nolock) on b.SubscribeId = s.Id 
                            left join SubscribeExtend ex with(nolock) on ex.SubscribeId=s.Id
							WHERE s.SubscribeUserId=@UserId AND B.IsBorrow=1 and isnull(ex.IsFTB,0)!=1
							GROUP BY s.IsVip
							UNION ALL 
							SELECT 0 AS A1,ISNULL(RealInterestAmout,0)+ISNULL(TuandaiRedPacket,0)+ISNULL(PublisherRedPacket,0)-ISNULL(InvestCommission,0) A2,0 AS A3,0 AS A4 
                            FROM SubscribeDetailHistory_h1 a WITH(NOLOCK)  
                            left join SubscribeExtend ex with(nolock) on ex.SubscribeId=a.SubscribeId
							WHERE  isnull(ex.IsFTB,0)!=1 and  NOT EXISTS (SELECT b.SubscribeId,b.periods FROM dbo.OverDueRecord b WITH(NOLOCK)  WHERE b.SubscribeId = a.SubscribeId AND b.periods = a.Periods 
							AND b.SubscribeUserId=@UserID AND b.IsBorrow=0 ) 
							 AND a.SubscribeUserId=@UserId 
                            UNION ALL
                            SELECT 0 AS A1,0 AS A2,0 AS A3,ISNULL(SUM(ISNULL(PrizeValue,0)),0) AS A4 FROM UserPrize WITH(NOLOCK) 
                            WHERE (TypeId IN (4,11,13,14) AND IsReceive=1 and ReceiveDate>=@usePrizeDate or TypeId=3 and  IsUsed=1 and UseDate>=@usePrizeDate )AND UserId=@UserID  
                            UNION ALL
                            SELECT isnull(DueComeInterest,0) as A1,isnull(NetEarningsInterest,0) + isnull(TuanDaiRedPacket,0) AS A2,0 AS A3, 0 AS A4 
                            FROM We_FundAccountInfo a WITH(NOLOCK) where UserId=@UserId 
                            ) T"; 
          
            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@UserId", userId);
            if (IsExistsInDBHistory(DateTime.Parse(DateTime.Today.AddMonths(-2).ToString("yyyy-MM-01")), DateTime.Parse(DateTime.Today.AddMonths(-1).ToString("yyyy-MM-01")).AddSeconds(-1), userId))
            {
                dyParams.Add("@usePrizeDate", DateTime.Today.AddMonths(-1).ToString("yyyy-MM-01"));
            }
            else
            {
                dyParams.Add("@usePrizeDate", DateTime.Today.AddMonths(-2).ToString("yyyy-MM-01"));
            }
            dyParams.Add("@extenderMoney",0,DbType.Decimal,ParameterDirection.Output,18,null,2);

            profitmodel = PublicConn.QuerySingle<ProfitStatistics>(sqlText, ref dyParams);
            if (profitmodel == null)
            {
                profitmodel = new ProfitStatistics();
            }
            string rsql = @"SELECT ISNULL(SUM(EarnMoney),0) FROM dbo.ExtendEarnRecord WITH(NOLOCK) WHERE UserID =@UserID and HandleStatus = 1";
            profitmodel.extenderMoney = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal>(TdConfig.ApplicationName,
                TdConfig.DBReportWrite, rsql, ref dyParams);
            NetEarningsInterest = decimal.Parse(ToolStatus.ConvertLowerMoney(profitmodel.recAmount));
            DueComeInterest = decimal.Parse(ToolStatus.ConvertLowerMoney(profitmodel.dueAmount));
            //从历史库中查询红包金额
            string sqlText2 = @"SELECT  ISNULL(SUM(ISNULL(PrizeValue,0)),0)  FROM UserPrize WITH(NOLOCK) 
                               WHERE (TypeId IN (4,11,13,14) AND IsReceive=1 or TypeId=3 and  IsUsed=1) AND UserId=@UserID ";
            dyParams = new DynamicParameters();
            dyParams.Add("@UserId", userId);
            decimal dHistoryPrizeValue = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal>(TdConfig.ApplicationName, TdConfig.DBHistoryRead, sqlText2, ref dyParams);
            profitmodel.prizeAmount += dHistoryPrizeValue;
        }
        /// <summary>
        /// 检查历史库是否存在数据
        /// </summary>
        /// <returns></returns>
        protected bool IsExistsInDBHistory(DateTime bTime,DateTime eTime,Guid userId)
        {
            string sql = @"SELECT  count(0)  FROM UserPrize WITH(NOLOCK) 
                               WHERE (TypeId IN (4,11,13,14) AND IsReceive=1 and ReceiveDate between @btime and @etime or TypeId=3 and  IsUsed=1 and UseDate between @btime and @etime) AND UserId=@UserID";
            var para = new Dapper.DynamicParameters();
            para.Add("@btime",bTime);
            para.Add("@etime", eTime);
            para.Add("@UserID", userId);

            return
                TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBHistoryRead, sql,
                    ref para) > 0;
        }
        /// <summary>
        /// 支出统计
        /// </summary>
        /// <param name="UserId"></param>
        protected void GetPayStatistics(Guid UserId)
        {
            string sql = @"
                SELECT SUM(sd.RealInterestAmout) AS RepayedInterest
                FROM SubscribeDetailHistory_h1 sd with(nolock)
                INNER JOIN dbo.Project p with(nolock) ON sd.ProjectId = p.Id where p.UserId = @UserId "; 
            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@UserId", UserId);
            paymodel = PublicConn.QuerySingle<PayOutStatistics>(sql, ref dyParams);
        }

        //所有We冻结资金
        public decimal GetWePlanWaitInvestment(Guid userId)
        {
            decimal weWaitInvestment;
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@userId", userId);
            string strSQL = @"SELECT SUM(a.OrderAviAmount)
                     FROM We_Order a with(nolock) 
                     where a.UserId=@userId and a.StatusId in (0,1,2,4) and a.IsRefund=0";
            weWaitInvestment =PublicConn.QuerySingle<decimal?>(strSQL, ref dyParams) ?? 0;

            //We计划分期宝已回款待投冻结金额
            string sql = @"SELECT isnull(SUM(OrderAviAmount),0) FROM(
                    SELECT ISNULL(B.OrderAviAmount,0) AS OrderAviAmount
                    FROM dbo.We_Order a WITH(NOLOCK)
                    left JOIN We_OrderExtFQB b WITH(NOLOCK) on b.OrderId=a.Id AND b.UserId=a.UserId and b.StatusId=0
                    WHERE  a.StatusId in (0,1,2,4) and a.UserId=@userId and isnull(a.IsWeFQB,0)=1 
                    ) AS main";
            weWaitInvestment += TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal>(TdConfig.ApplicationName, TdConfig.DBRead, sql,
                ref dyParams);

            return weWaitInvestment;
        }
        //获取复投宝的待收本金,利息
        public Tuple<decimal, decimal> GetFTBDueInAmountInterest(Guid userId)
        {
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userId);
            dyParams.Add("@totalInterest", 0, DbType.Decimal, ParameterDirection.Output, 18, null, 2);
            dyParams.Add("@totalAmount", 0, DbType.Decimal, ParameterDirection.Output, 18, null, 2);

            string strSQL = "select @totalAmount=RecoverBorrowOut, @totalInterest=DueComeInterest from We_FundAccountInfo where UserId=@UserId";
            PublicConn.ExecuteTD(PublicConn.DBWriteType.Read, strSQL, ref dyParams);
            Tuple<decimal, decimal> result = new Tuple<decimal, decimal>(dyParams.Get<decimal?>("@totalAmount") ?? 0, dyParams.Get<decimal?>("@totalInterest") ?? 0);
            return result;
        }
        #endregion


        #region 获取图表1数据
        protected void GetEChartData1(Guid userId)
        {
            Response.ContentType = "application/json";
            decimal dTotalInAmount = WEBRequest.GetQueryString("TotalInAmount").ToDecimal(0);
            decimal dTotalPayAmount = WEBRequest.GetQueryString("TotalPayAmount").ToDecimal(0);
            try
            {
                var param = new Dapper.DynamicParameters();
                param.Add("@userId", userId);
                param.Add("@startDate", DateTime.Today.AddDays(-7));
                param.Add("@endDate", DateTime.Today.AddDays(1).AddSeconds(-1));
                //这里要加上复投宝的数据
                string sql = @" select a.id,a.value as CalcDay, isnull(b.InterestAmout_2,0)+isnull(O.InterestAmout_3,0)+isnull(ftb.InterestAmout_4,0) as TotalIn, isnull(m.InterestAmout_2,0)+isnull(pb.todayCommission,0)  as TotalOut from dbo.SplitToTable('{0}',',') a
                            left join (
                                    SELECT convert(varchar(10),ISNULL(a.RepayAdvanceDate,A.CycDate),23) CalcDay,
                                ISNULL(SUM(ISNULL(a.RealInterestAmout,0)),0)+ISNULL(SUM(ISNULL(a.TuandaiRedPacket,0)),0)+ISNULL(SUM(ISNULL(a.PublisherRedPacket,0)),0)  AS InterestAmout_2 --已赚利息
                                FROM SubscribeDetailHistory_h1 A WITH(NOLOCK)
                                INNER JOIN dbo.Subscribe s WITH(NOLOCK) ON a.SubscribeId = s.Id
								LEFT JOIN dbo.We_Order wo WITH(NOLOCK) ON s.WeOrderId = wo.Id
                                WHERE   ( s.WeOrderId IS NULL OR (ISNULL(wo.IsWeFQB,0)=1 AND ISNULL(wo.RepeatInvestType,0) =2) OR (ISNULL(wo.IsWeFQB,0)=0 and ISNULL(wo.IsFTB,0)=0)) and  NOT EXISTS (SELECT b.SubscribeId,b.periods FROM dbo.OverDueRecord b WITH(NOLOCK) where b.SubscribeId = a.SubscribeId AND b.Periods = a.periods 
                                and b.SubscribeUserId=@userId AND b.IsBorrow=0  ) AND a.SubscribeUserId=@userId AND ISNULL(a.RepayAdvanceDate,A.CycDate)>=@startDate
                                AND ISNULL(a.RepayAdvanceDate,A.CycDate)<=@endDate  
                                group by convert(varchar(10),ISNULL(a.RepayAdvanceDate,A.CycDate),23)
                                ) b on b.CalcDay=cast(a.value as datetime)
                             LEFT JOIN
                                    (select convert(varchar(10),B.AddDate,23) CalcDay, 
                                    isnull(sum(B.Interest),0) InterestAmout_3 --逾期利息
                                    from  OverDueRecord B WITH(NOLOCK)  
                                     INNER JOIN dbo.Subscribe s ON b.SubscribeId = s.Id
                                    LEFT JOIN we_order wo ON s.WeOrderId = wo.Id
                                    WHERE   ( s.WeOrderId IS NULL OR (ISNULL(wo.IsWeFQB,0)=1 AND ISNULL(wo.RepeatInvestType,0) =2) OR (ISNULL(wo.IsWeFQB,0)=0 and ISNULL(wo.IsFTB,0)=0)) and  B.SubscribeUserId=@userId and B.IsBorrow=0 AND B.AddDate>=@startDate and B.AddDate<=@endDate
                                    GROUP by convert(varchar(10),B.AddDate,23) 
                                    ) O ON O.CalcDay=cast(a.value as datetime)
                            left join (
                                    select isnull(sum(BorrowPayoutCommission),0) as todayCommission,convert(varchar(10),AddDate,23)as CalcDay from dbo.Project with(nolock) where UserId=@UserId and AddDate >=@startDate and Status <>6
                                    group by convert(varchar(10),AddDate,23)
                                    )pb on pb.CalcDay=cast(a.value as datetime)
                            left join (
                                select convert(varchar(10),ISNULL(A.RepayAdvanceDate,A.CycDate),23) CalcDay   
                                ,sum(A.RealInterestAmout-isnull(B.Interest,0)) InterestAmout_2  --已赚利息
                                from dbo.SubscribeDetailHistory_h1 A  
                                left join OverDueRecord B on A.SubscribeId=B.SubscribeId and B.IsBorrow=0 and A.Periods =B.periods    
                                inner join Project C on A.ProjectId=C.Id  and C.UserId=@userId
                                left join dbo.SubscribeExtend ex on ex.SubscribeID=A.SubscribeId
                                where isnull(ex.IsFTB,0)!=1 and  ISNULL(A.RepayAdvanceDate,A.CycDate)>=@startDate and  ISNULL(A.RepayAdvanceDate,A.CycDate)<=@endDate  
                                group by convert(varchar(10),ISNULL(A.RepayAdvanceDate,A.CycDate),23)
                            ) m on m.CalcDay=cast(a.value as datetime)  
                            left join( --复投宝已收
                                 select  convert(varchar(10),CycDate,23) CalcDay, ISNULL(SUM(ISNULL(InterestAmount,0)),0)+ISNULL(SUM(ISNULL(TuandaiRedPacket,0)),0)+ISNULL(SUM(ISNULL(PublisherRedPacket,0)),0) InterestAmout_4 --申购利息汇总
                                FROM We_OrderDetail WHERE CycDate>=@startDate and CycDate<=@endDate
                                and UserId=@UserID and IsHandle=1 GROUP by convert(varchar(10),CycDate,23)
                             ) FTB on FTB.CalcDay=cast(a.value as datetime)
                            order by a.value";
                string dayStr = "";
                for (int i = 7; i >= 0; i--)
                {
                    dayStr += DateTime.Today.AddDays(-1 * i).ToString("yyyy.MM.dd") + ",";
                }
                dayStr = dayStr.Substring(0, dayStr.Length - 1);
                sql = string.Format(sql, dayStr);

                chartDatas1 = PublicConn.QueryBySql<EChartData1Info>(sql, ref param);

                //从后往前倒推数据
                if (chartDatas1 != null && chartDatas1.Any())
                {
                    decimal calcInAmount = chartDatas1.Sum(p => p.TotalIn);
                    decimal calcOutAmount = chartDatas1.Sum(p => p.TotalOut);
                    if (calcInAmount < dTotalInAmount)
                    {
                        decimal firstInCalc = dTotalInAmount - calcInAmount + chartDatas1[0].TotalIn;//减去总和再加第一天的收益
                        for (int i = 0; i < chartDatas1.Count; i++)
                        {
                            if (i == 0)
                            {
                                chartDatas1[i].TotalIn = firstInCalc;
                            }
                            else if (i == 7)
                            {
                                chartDatas1[i].TotalIn = dTotalInAmount;
                            }
                            else
                            {
                                chartDatas1[i].TotalIn += chartDatas1[i - 1].TotalIn;
                            }
                        }
                    }
                    if (calcOutAmount < dTotalPayAmount)
                    {
                        decimal firstOutCalc = dTotalPayAmount - calcOutAmount + chartDatas1[0].TotalOut ;//减去总和再加第一天的支出
                        for (int i = 0; i < chartDatas1.Count; i++)
                        {
                            if (i == 0)
                            {
                                chartDatas1[i].TotalOut = firstOutCalc;
                            }
                            else if (i == 7)
                            {
                                chartDatas1[i].TotalOut = dTotalPayAmount;
                            }
                            else
                            {
                                chartDatas1[i].TotalOut += chartDatas1[i - 1].TotalOut;
                            }
                        }
                    }
                }
                string jsonStr = ToJson(chartDatas1);
                PrintJson("1", jsonStr);
            }
            catch (Exception ex)
            {
                PrintJson("0", "获取数据失败");
            }
            finally
            {
                Response.End();
            }
        }
        private static string ToJson(Object obj)
        {
            String jsonString;
            if (obj is String || obj is Char)
            {
                jsonString = obj.ToString();
            }
            else
            {
                IsoDateTimeConverter timeConverter = new IsoDateTimeConverter();
                timeConverter.DateTimeFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss";
                return JsonConvert.SerializeObject(obj, timeConverter);
            }
            return jsonString;
        }
        protected void PrintJson(string strstate, string strmsg)
        {
            var objData = new { result = strstate, msg = strmsg };
            var jsonStr = ToJson(objData);
            Response.ClearContent();
            Response.Write(jsonStr);
        }
        #endregion


       
        /// <summary>
        /// 获取累计提现
        /// </summary>
        protected void GetTotalWithDrawal()
        {
            string strSQL = "select isnull(Sum(Amount),0) as TotalWithDrawal from AppWithdrewFund with(nolock) where UserId=@userId and Type=1 and Status =2";

            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@userId", WebUserAuth.UserId.Value);
            TotalWithDrawal = PublicConn.QuerySingle<decimal>(strSQL, ref dyParams);
        }

        #region 内部对像
        public class ProfitStatistics
        {
            public decimal recAmount { get; set; }
            public decimal dueAmount { get; set; }
            public decimal overDueAmount { get; set; } 
            /// <summary>
            /// 活动奖励
            /// </summary>
            public decimal actAmount { get; set; }
            /// <summary>
            /// 红包奖励
            /// </summary>
            public decimal prizeAmount { get; set; }
            /// <summary>
            /// 推广收益
            /// </summary>
            public decimal extenderMoney { get; set; }
        }
        public class PayOutStatistics
        {
            /// <summary>
            /// 已付本息
            /// </summary>
            public decimal RepayedCapitalInterest { get; set; }
            /// <summary>
            /// 逾期本息
            /// </summary>
            public decimal DueCapitalInterest { get; set; }
            /// <summary>
            /// 已付利息
            /// </summary>
            public decimal RepayedInterest { get; set; }
        }
        public class EChartData1Info {
            /// <summary>
            /// 日期
            /// </summary>
            public string CalcDay { get; set; }
            /// <summary>
            /// 累计收益
            /// </summary>
            public decimal TotalIn { get; set; }
            /// <summary>
            /// 累计支出
            /// </summary>
            public decimal TotalOut { get; set; }
           
        }
        #endregion
    }
}