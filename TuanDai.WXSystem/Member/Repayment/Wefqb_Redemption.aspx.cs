using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using Tool;
using TuanDai.PortalSystem.BLL;
using Kamsoft.Data.Dapper;
using System.Data;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// We计划申请赎回界面
    /// Allen 2016-04-08
    /// </summary>
    public partial class Wefqb_Redemption : UserPage
    {
        protected Guid? weOrderId = Guid.Empty;
        protected WXInvestWeFQBDetail_Info model;
        protected string HoldDayStr="0天";
        protected WeRansomFeeInfo feeInfo = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            weOrderId = WEBRequest.GetGuid("orderid");
            if (!IsPostBack)
            {
                if (weOrderId == null || weOrderId == Guid.Empty)
                {
                    Response.Redirect("/Member/my_account.aspx");
                    return;
                }
                GetData();
            }
        }

        private void GetData()
        {
            Guid? userId = WebUserAuth.UserId;
            WeOrderBLL webll = new WeOrderBLL();
            model = webll.GetMyInvestWeFQBBaseDetail(userId.Value, weOrderId.Value); 

            feeInfo = webll.GetWeFqbRansomManageFee(weOrderId.Value);
            if (feeInfo == null)
                feeInfo = new WeRansomFeeInfo();
            HoldDayStr = feeInfo.HoldDayStr;
        }
    }
}