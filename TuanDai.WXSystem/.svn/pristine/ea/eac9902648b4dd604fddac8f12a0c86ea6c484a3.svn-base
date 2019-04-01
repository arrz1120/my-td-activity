using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class Weftb_project : UserPage
    {
        protected Guid? weOrderId = Guid.Empty;
        protected WXInvestWeFQBDetail_Info model;
        protected decimal DueInterestAmount = 0; //预期收益
        protected decimal RewardInterest = 0; //加息奖励利息
        protected decimal RewardRate = 0; //奖励加息利率
        protected string tab;
        protected void Page_Load(object sender, EventArgs e)
        {
            weOrderId = WEBRequest.GetGuid("weorderid");
            tab = WEBRequest.GetQueryString("tab");
            if (!IsPostBack)
            {
                if (weOrderId == null || weOrderId == Guid.Empty)
                {
                    Response.Redirect("/Member/my_account.aspx");
                    return;
                }
                Guid? userId = WebUserAuth.UserId;
                WeOrderBLL webll = new WeOrderBLL();
                model = webll.GetMyInvestWeFQBBaseDetail(userId.Value, weOrderId.Value);
                RewardRate = model.TuandaiRedRate;
                RewardInterest = GetInterest(model.AmountInvestment, model.Deadline,model.DeadType, RewardRate);
                DueInterestAmount = model.DueInterestAmount + RewardInterest;
            }
        }

        protected string GetWeFQBStatus()
        {
            switch (model.WeStatusId)
            {
                case -1:
                    return "未购买";
                case -2:
                    return "付款中";
                case 0:
                    return "项目匹配中";
                case 1:
                case 2:
                    return "服务中";
                case 3:
                    return "结束服务中";
                case 4:
                    return "已完成";
                case 5:
                    return "到期退出中";

            } 
            return "投资中";
        }

        protected decimal GetInterest(decimal investAmount, int deadLine,int deadType, decimal yearRate)
        {
            if (investAmount == 0)
                return 0;
            if(deadType == 1)
                return decimal.Round(investAmount * yearRate * decimal.Parse("0.01") * deadLine / 12,2);
            else
                return decimal.Round(investAmount * yearRate * decimal.Parse("0.01") * deadLine / 365, 2);
        } 
    }
}