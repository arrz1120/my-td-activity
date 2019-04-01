using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model; 
using System.Data;
using Dapper; 

namespace TuanDai.WXApiWeb.Member
{
    public partial class my_wealth : UserPage
    {
        protected WXFundAccountInfo_Info accountInfo;
        protected decimal totalamount = 0;
        protected decimal? weWaitInvestment = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/my_account.aspx", true);
            var userId = WebUserAuth.UserId.Value;
            if (!IsPostBack)
            {
                if (userId != null && userId != Guid.Empty)
                {
                    GetAccountInfo(userId);

                    totalamount = (accountInfo.AviMoney) + (accountInfo.DueInPAndI) 
                    + (accountInfo.BorrowerOut) + (accountInfo.DueConfirmWithdrawDeposit) + (accountInfo.RewardMoney) + (accountInfo.FreezeAcount);
                    totalamount += GetWePlanWaitInvestment(userId);
                }
                    
            }
        }

        private void GetAccountInfo(Guid userid)
        {
            var commandText = @"SELECT * from dbo.FundAccountInfo with(nolock) WHERE UserId =@UserId"; ;
            DynamicParameters para = new DynamicParameters();
            para.Add("@UserId", userid); 
            accountInfo = PublicConn.QuerySingle<WXFundAccountInfo_Info>(commandText, ref para);  
        }

        public decimal GetWePlanWaitInvestment(Guid userId)
        {
            var param = new DynamicParameters();
            param.Add("@userId", userId); 
            string sql = @"SELECT  isnull(SUM(a.OrderAviAmount),0)
                            FROM We_Order a with(nolock) 
                            where a.UserId=@userId and a.IsRefund=0";

            decimal weWaitInvestment = PublicConn.QuerySingle<decimal>(sql, ref param);
            return weWaitInvestment; 
        }
    }
}