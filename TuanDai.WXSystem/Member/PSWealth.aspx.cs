using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using TuanDai.DQSystemAPI.Client;
using TuanDai.DQSystemAPI.Contract;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member
{
    public partial class PSWealth : UserPage
    {
        protected WXFundStatistModel DqFundModel;//定期理财
        protected FundAccountInfo_Zx ZxFundModelFromDq;//定期库统计智享数据
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!WebUserAuth.IsAuthenticated)
            {
                Response.Redirect("//passport.tuandai.com/2login?ret=" + HttpUtility.UrlEncode(HttpContext.Current.Request.RawUrl));
                return;
            }

            var xiajia = new WebSettingBLL().GetWebSettingInfo("D3E0C6CC-30A0-4E5B-8A83-446269F8C96F");
            if (xiajia == null)
            {
                xiajia = new WebSettingInfo();
                xiajia.Param1Value = "2018-04-17";
            }   
            var userId = WebUserAuth.UserId.Value;
            var userModel = new UserBLL().GetUserBasicInfoModelById(userId);
            if ((GetDQDueInMoney(userId) <= 0 && new GlobalUtils().GetNewVipUserInfo(userId).Level < 5 )|| userModel.AddDate >= DateTime.Parse(xiajia.Param1Value))
            {
                Response.Redirect("/Member/My_account.aspx");
            }
            DqFundModel = GetDQFundModel(userId);
            if (DqFundModel == null)
                DqFundModel = new WXFundStatistModel();
            if (DqFundModel.DueComeInterest >= decimal.Parse("-0.03") && DqFundModel.DueComeInterest < 0)
                DqFundModel.DueComeInterest = 0;
            GetZxFundModelFromDQ(userId);
        }
        /// <summary>
        /// 定期待收
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        private decimal GetDQDueInMoney(Guid userId)
        {
            string sql = "select sum(isnull(Amount,0))+sum(ISNULL(InterestAmout,0)) from SubscribeDetail with(nolock) where SubscribeUserId=@userid; ";
            var para = new Dapper.DynamicParameters();
            para.Add("@userid", userId);
            decimal dueInMoney =
                TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal?>(TdConfig.ApplicationName, "/BD/dqread", sql, ref para) ??
                0;
            sql =
                "select sum(isnull(cost,0))+sum(isnull(interest,0)) from OverDueRecord where SubscribeUserId=@userid and IsBorrow=0;";
            dueInMoney +=
                TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal?>(TdConfig.ApplicationName, "/BD/dqread", sql, ref para) ??
                0;
            return dueInMoney;
        }
        /// <summary>
        /// 获取定期理财的数据
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        protected WXFundStatistModel GetDQFundModel(Guid userId)
        {
            //return WXFundClient.GetFundStatistData(userId);
            string strSQL = @"select isnull(AviMoney,0) as AviMoney,isnull(DueInPAndI,0) as DueInPAndI, 
                                isnull(AviMoney,0)+isnull(DueInPAndI,0)+isnull(DueConfirmWithdrawDeposit,0)+isnull(RewardMoney,0)+isnull(FreezeAcount,0)+isnull(BorrowerOut,0)+isnull(WithdrawDepositProgress,0)  as TotalAmount,
                                isnull(DueComeInterest,0) as DueComeInterest,isnull(FreezeAcount,0) as FreezeAcount, isnull(TotalInvest,0) as TotalInvest, isnull(TotalBorrow,0) as TotalBorrow,
                                isnull(BorrowerOut,0)+isnull(DueConfirmWithdrawDeposit,0)+isnull(WithdrawDepositProgress,0) as OnWayAmount,isnull(TotalWithdrawDepositHandRecharge,0) as WithdrawFee,
                                isnull(TotalRecharge,0) as TotalRecharge,isnull(TotalWithdrawDeposit,0) as TotalWithDrawal,isnull(TotalPenaltyOfInvest,0) as TotalPenaltyOfInvest
                             from FundAccountInfo with(nolock) where UserId=@userId";
            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@userId", userId);
            WXFundStatistModel fundInfo = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<WXFundStatistModel>(TdConfig.ApplicationName, "/BD/dqread", strSQL, ref dyParams);
            if (fundInfo == null)
                fundInfo = new WXFundStatistModel();
            //decimal waitWeAmount = GetWePlanWaitInvestment(userId);
            fundInfo.FreezeAcount += 0;
            fundInfo.TotalAmount = fundInfo.TotalAmount + 0;
            
            //累计已收收益
            strSQL = @" SELECT SUM(recAmount) recAmount FROM (
                        SELECT SUM(ISNULL(RealInterestAmout,0)+ISNULL(TuandaiRedPacket,0)+ISNULL(PublisherRedPacket,0)-ISNULL(InvestCommission,0)) recAmount
                        FROM SubscribeDetailHistory_h1 a WITH(NOLOCK) 
                        WHERE  a.SubscribeUserId=@UserID  and NOT EXISTS (
                          SELECT b.SubscribeId,b.periods FROM dbo.OverDueRecord b WITH(NOLOCK)  
                          WHERE b.SubscribeId = a.SubscribeId AND b.periods = a.Periods 
                        AND b.SubscribeUserId=@UserID AND b.IsBorrow=0) 
                       ) T";
            dyParams = new DynamicParameters();
            dyParams.Add("@UserID", userId);
            decimal recAmount = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal?>(TdConfig.ApplicationName, "/BD/dqread", strSQL, ref dyParams) ?? 0;
            fundInfo.TotaltEarnInterest = recAmount;

            string sql = @"select sum(isnull(a3,0)) from (
                         SELECT  case when s.isvip = 1 then ISNULL(SUM(ISNULL(B.OverDueInterest,0)),0)+ISNULL(SUM(ISNULL(B.PenaltyAmount,0)),0)/3*2 when s.isvip = 0 then ISNULL(SUM(ISNULL(B.OverDueInterest,0)),0) else 0 end A3
                              FROM  OverDueRecord B WITH(NOLOCK)   
                                  join Subscribe s with(nolock) on b.SubscribeId = s.Id   
                                WHERE s.SubscribeUserId=@UserId
                         AND B.IsBorrow=1 AND isnull(b.isHide,0)=0
                                GROUP BY s.IsVip )a";
            var para = new DynamicParameters();
            para.Add("@UserId", userId);
            fundInfo.TotalPenaltyOfInvest = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<decimal?>(TdConfig.ApplicationName, "/BD/dqread", sql,
                ref para) ?? 0;
            return fundInfo;
        }
        protected void GetZxFundModelFromDQ(Guid userId)
        {
            string sql = @"select * from FundAccountInfo_ZX with(nolock) where UserId=@UserId";
            var para = new DynamicParameters();
            para.Add("@UserId", userId);

            ZxFundModelFromDq = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<FundAccountInfo_Zx>(TdConfig.ApplicationName, "/BD/dqread", sql,
                ref para);
            if (ZxFundModelFromDq == null)
                ZxFundModelFromDq = new FundAccountInfo_Zx();
        }
        protected class FundAccountInfo_Zx
        {
            public decimal? DueInAmount { get; set; }

            public decimal? DueInInterest { get; set; }

            public decimal? DueOutAmount { get; set; }

            public decimal? DueOutInterest { get; set; }

            public decimal? ReceivedInterest { get; set; }
        }
    }
}