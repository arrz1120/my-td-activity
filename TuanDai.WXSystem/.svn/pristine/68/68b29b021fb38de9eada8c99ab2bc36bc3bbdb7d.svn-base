using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 复投宝提前退出申请
    /// Allen 2016-12-27
    /// </summary>
    public partial class Weftb_Ransom : UserPage
    {
        protected Guid? weOrderId = Guid.Empty;
        protected WXInvestWeFQBDetail_Info model;
        protected string HoldDayStr = "0天";
        protected WeFTBRansomInfo feeInfo = null;
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

            feeInfo = new WeFTBRansomInfo();
            feeInfo.result = 0;

            var param = new Dapper.DynamicParameters();
            param.Add("@OrderId", weOrderId);
            param.Add("@ApplyAmount", model.AmountInvestment);
            param.Add("@ExitRate", 0, System.Data.DbType.Decimal, System.Data.ParameterDirection.Output, 18, null, 2);
            param.Add("@RewardRate", 0, System.Data.DbType.Decimal, System.Data.ParameterDirection.Output, 18, null, 2);
            param.Add("@HoldMonth", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@HoldDay", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@DueInAmount", 0, System.Data.DbType.Decimal, System.Data.ParameterDirection.Output, 18, null, 2);
            param.Add("@OutStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@ErrorMsg", 0, System.Data.DbType.String, System.Data.ParameterDirection.Output, 100);

            int outStatus = 0;
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBSubscribeWrite, "P_WeFTBAdvanceManageFee", ref param, CommandType.StoredProcedure);
            outStatus = param.Get<int>("@OutStatus");
            if (outStatus == 1)
            {
                feeInfo.result = 1;
                feeInfo.ExitRate = param.Get<decimal?>("@ExitRate") ?? 0;
                feeInfo.RewardRate = param.Get<decimal?>("@RewardRate") ?? 0;
                feeInfo.HoldMonth = param.Get<int?>("@HoldMonth") ?? 0;
                feeInfo.HoldDay = param.Get<int?>("@HoldDay") ?? 0;
                feeInfo.HoldDayStr = string.Format("{0}月{1}天", feeInfo.HoldMonth, feeInfo.HoldDay);
                feeInfo.DueInAmount = param.Get<decimal?>("@DueInAmount") ?? 0;
                feeInfo.msg = param.Get<string>("@ErrorMsg").ToText();
                feeInfo.ApplyAmount = model.AmountInvestment;
            }
            else
            {
                feeInfo.result = outStatus;
                feeInfo.msg = param.Get<string>("@ErrorMsg").ToText();
            }
        }

        /// <summary>
        /// 复投宝赎回时各项费用计算
        /// </summary>
        public class WeFTBRansomInfo
        {
            /// <summary>
            /// 计算状态 1:计算成功 0:计算失败
            /// </summary>
            public int result { get; set; }
            /// <summary>
            /// 输出错误信息
            /// </summary>
            public string msg { get; set; }
            /// <summary>
            /// 退出时利率
            /// </summary>
            public decimal ExitRate { get; set; }
            /// <summary>
            /// 加息利率
            /// </summary>
            public decimal RewardRate { get; set; }
            /// <summary>
            /// 持有天数 XX月XX天
            /// </summary>
            public string HoldDayStr { get; set; }
            /// <summary>
            /// 预期到账金额:本息+奖励
            /// </summary>
            public decimal DueInAmount { get; set; }
            /// <summary>
            /// 申请退出本金
            /// </summary>
            public decimal ApplyAmount { get; set; }
            /// <summary>
            /// 持有月数
            /// </summary>
            public int HoldMonth { get; set; }
            /// <summary>
            /// 持有天数
            /// </summary>
            public int HoldDay { get; set; }
        }
    }
}