using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.DB;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using BusinessDll;
using Tool;
using System.Data;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member
{
    public partial class myaccount_p2pmore : UserPage
    {
        protected string NextReturnDay = "";
        protected FundAccountInfoInfo fundModel;
        protected PageMoneyModel pageModel = null;
        protected MUserVipInfo vipInfo = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                InitFormData();
            }
        }
        

        protected void InitFormData()
        {
            Guid userId = WebUserAuth.UserId.Value;
            vipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
            if (vipInfo == null)
            {
                vipInfo = new MUserVipInfo();
                vipInfo.Level = 1;
            }

            NextReturnDay = GetNextReturnMoneyDay(userId);

            fundModel = new FundAccountBLL().GetFundAccountInfoById(userId);
              
            //待收本息加上复投宝的
            Tuple<decimal, decimal> ftbDueIn = GetFTBDueInAmountInterest(userId);
            fundModel.DueInPAndI = (fundModel.DueInPAndI ?? 0) + ftbDueIn.Item1 + ftbDueIn.Item2;
            fundModel.DueOutPAndI = (fundModel.DueOutPAndI ?? 0) + fundModel.CurrentPreAdvance;

            #region 减去智享计划部分
            string sql = @"SELECT  
                         sum(sd.Amount )+
                         sum(sd.InterestAmout )+
                         sum(ISNULL(sd.TuandaiRedPacket,0) )+
                        sum(ISNULL(sd.PublisherRedPacket,0))  
                        FROM dbo.SubscribeDetail sd with(nolock) 
                        inner join Project p with(nolock) on sd.ProjectId = p.Id
                        WHERE isnull(sd.InvestType,0)!=1 and sd.SubscribeUserId=@UserId  and sd.CycDate>getdate() and p.Type=37 ";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userId);
            decimal p2pZxDueInAndI = TuanDaiDB.QuerySingle<decimal>(TdConfig.ApplicationName, "/BD/zxread", sql, ref dyParams);
            fundModel.DueInPAndI = fundModel.DueInPAndI - p2pZxDueInAndI;
            sql = @"SELECT  
                         sum(sd.Amount )+
                         sum(sd.InterestAmout )+
                         sum(ISNULL(sd.TuandaiRedPacket,0) )+
                        sum(ISNULL(sd.PublisherRedPacket,0))  
                        FROM dbo.SubscribeDetail sd with(nolock) 
                        inner join Project p with(nolock) on sd.ProjectId = p.Id
                        WHERE isnull(sd.InvestType,0)!=1 and sd.BorrowerUserId=@UserId  and sd.CycDate>getdate() and p.Type=37 ";
            decimal p2pZxDueOutPAndI = TuanDaiDB.QuerySingle<decimal>(TdConfig.ApplicationName, "/BD/zxread", sql, ref dyParams);
            fundModel.DueOutPAndI = fundModel.DueOutPAndI - p2pZxDueOutPAndI;
            #endregion

            decimal weWaitInvestAmount = GetWePlanWaitInvestment(userId);
            fundModel.FreezeAcount = fundModel.FreezeAcount + weWaitInvestAmount;  //冻结资金加上We待投  

            pageModel = new PageMoneyModel();
            if (fundModel != null)
                pageModel.P2PSumAmount = (fundModel.AviMoney ?? 0) + (fundModel.DueInPAndI ?? 0)
                              + (fundModel.BorrowerOut ?? 0) + (fundModel.DueConfirmWithdrawDeposit ?? 0)
                              + (fundModel.RewardMoney ?? 0) + (fundModel.FreezeAcount ?? 0);

            pageModel.P2PAviAmount = fundModel.AviMoney ?? 0;
            pageModel.P2PDueIn = fundModel.DueInPAndI ?? 0;
        }


        //获取复投宝的待收本息
        public Tuple<decimal, decimal> GetFTBDueInAmountInterest(Guid userId)
        {
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@UserId", userId);
            dyParams.Add("@totalAmount", 0, DbType.Decimal, ParameterDirection.Output, 18, null, 2);
            dyParams.Add("@totalInterest", 0, DbType.Decimal, ParameterDirection.Output, 18, null, 2);

            string strSQL = "select @totalAmount=RecoverBorrowOut, @totalInterest=DueComeInterest from We_FundAccountInfo where UserId=@UserId";
            PublicConn.ExecuteTD(PublicConn.DBWriteType.Read, strSQL, ref dyParams);
            Tuple<decimal, decimal> result = new Tuple<decimal, decimal>(dyParams.Get<decimal?>("@totalAmount") ?? 0, dyParams.Get<decimal?>("@totalInterest") ?? 0);
            return result;
        }
        /// <summary>
        /// 获取we计划可用金额
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public decimal GetWePlanWaitInvestment(Guid userId)
        {
            decimal weWaitInvestment;
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@userId", userId);
            string strSQL = @"SELECT SUM(a.OrderAviAmount)
                            FROM We_Order a with(nolock) 
                     where a.UserId=@userId and a.StatusId in (0,1,2,4) and a.IsRefund=0";
            weWaitInvestment = PublicConn.QuerySingle<decimal?>(strSQL, ref dyParams) ?? 0;

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

        protected string GetNextReturnMoneyDay(Guid userId)
        {
            string sql = @"SELECT TOP 1  Convert (VARCHAR(10),CycDate,120) AS CycDate,
                        SUM(ISNULL(Amount,0)+ISNULL(InterestAmout,0)+ISNULL(TuandaiRedPacket,0) +ISNULL(PublisherRedPacket,0) ) AS TotalAmount FROM (
                        SELECT  sd.CycDate,
                        CASE WHEN sd.InvestType IN(3,2) THEN 0 ELSE  sd.Amount END AS Amount,
                        CASE WHEN   sd.InvestType = 3 THEN 0 ELSE sd.InterestAmout END AS InterestAmout, 
                        CASE WHEN   sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.TuandaiRedPacket,0) END AS TuandaiRedPacket, 
                        CASE WHEN   sd.InvestType = 3 THEN 0 ELSE ISNULL(sd.PublisherRedPacket,0) END AS PublisherRedPacket  
                        FROM dbo.SubscribeDetail sd with(nolock) 
                        WHERE isnull(sd.InvestType,0)!=1 and sd.SubscribeUserId=@UserId  and sd.CycDate>getdate()
                         union all
                         select we.CycDate, we.Amount, we.InterestAmount,we.TuanDaiRedPacket, we.PublisherRedPacket  from dbo.We_OrderDetail we
                         where  we.IsHandle=0 and we.UserId=@UserId and we.CycDate>getdate() )a 
                        GROUP BY Convert (VARCHAR(10),CycDate,120) 
                           having sum(isnull(Amount, 0) + isnull(InterestAmout, 0)+ isnull(TuandaiRedPacket, 0) + isnull(PublisherRedPacket, 0))>0  
                        ORDER BY CycDate ASC";
            var para = new Dapper.DynamicParameters();
            para.Add("@UserId", userId);

            var item = PublicConn.QuerySingle<NextReturnMoneyDay>(sql, ref para);
            if (item != null)
            {
                return "<span>" + item.CycDate.ToString("yyyy-MM-dd") + "<b>" + ToolStatus.ConvertLowerMoney(item.TotalAmount) + "</b>元</span>";
            }
            else
            {
                return "<span>无回款日</span>";
            }
        }

        #region 内部Model
        protected class NextReturnMoneyDay
        {
            public DateTime CycDate { get; set; }

            public decimal TotalAmount { get; set; }
        }
        public class PageMoneyModel
        { 
  
            public decimal P2PSumAmount { get; set; }
            /// <summary>
            /// P2P帐号待收本息
            /// </summary>
            public decimal P2PDueIn { get; set; }
            public decimal P2PAviAmount { get; set; } 
        }
        #endregion
    }
}