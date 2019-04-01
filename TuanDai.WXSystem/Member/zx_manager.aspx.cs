using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.ZXSystem.BLL;
using TuanDai.ZXSystem.Model;

namespace TuanDai.WXApiWeb.Member
{
    public partial class zx_manager : UserPage
    {
        protected FundAccountInfoInfo fundModel;
        protected decimal ZxDueOutAmount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            fundModel = new FundAccountBLL().GetFundAccountInfoById(WebUserAuth.UserId.Value);
            if(fundModel == null)
                fundModel = new FundAccountInfoInfo();
            
            TuanDai.ZXSystem.Model.FundStatisticsInfo zxFund =
                new FundStatisticsBLL().GetFundStatisticsInfoByUserId(WebUserAuth.UserId.Value);
            if (zxFund == null)
            {
                zxFund = new FundStatisticsInfo();
            }
            ZxDueOutAmount = (zxFund.DueOutAmount_DQ ?? 0) + (zxFund.DueOutAmount_P2P ?? 0) + (zxFund.DueOutInterest_DQ ?? 0) +
                          (zxFund.DueOutInterest_P2P ?? 0);
            fundModel.DueOutPAndI = fundModel.DueOutPAndI - (zxFund.DueOutAmount_P2P??0 )- (zxFund.DueOutInterest_P2P ?? 0);
            if (fundModel.DueOutPAndI < 0)
                fundModel.DueOutPAndI = 0;
        }
    }
}