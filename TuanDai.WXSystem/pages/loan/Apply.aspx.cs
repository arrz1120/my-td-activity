using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXApiWeb.Common;
using Tool;  
using System.Data;
using Dapper;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.pages.loan
{
    public partial class Apply : UserPage
    {
        /// <summary>
        /// 项目类型选项列表.
        /// </summary>
        protected List<Tuple<int, decimal, decimal, int, string>> options { get; set; }

        protected bool IsProjectFreePaidUser=false;
        /// <summary>
        /// 还款期限描述.
        /// </summary>
        protected string deadLineDesc { get; set; }
        protected int maxDeadline = 0;//最大期限（月）
        protected int minDeadlineDay = 0;//最小借款期限(日)
        protected int maxDeadlineDay = 0;//最大借款期限(日)
        protected DateTime endDeadlineDay = DateTime.MaxValue; //免佣金优惠结束日期
        protected decimal creditAmount = 0; //授信额度
        protected decimal tuandaiFeeRate = 0; //团贷网管理费率
        protected int? UserVipLevel;//用户VIP等级
        protected double? ManagerRate;//管理费优惠折扣
        protected int IsRegHasOneMonth = 1;//注册是否满一个月

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/pages/downloadGuide.aspx",true);
            if (!this.IsPostBack)
            {
                var userId = WebUserAuth.UserId.Value;
                if (userId != null && userId != Guid.Empty)
                {
                    GetIsProjectFreePaidUser(userId);
                    GetUserVipMsg(userId);

                    var userBll = new UserBLL();
                    var user = userBll.GetUserBasicInfoModelById(userId);
                    //2016.5.4号注册的加条件： 注册满1个月才能发资产标，即1个月零1天才能发资产标，一个月以内进入发标页面后弹框提示“您好，注册满一个月后才能发布资产标”
                    if (user.AddDate >= DateTime.Parse("2016-05-04 12:00"))
                    {
                        IsRegHasOneMonth = user.AddDate.Value.AddMonths(1) < DateTime.Now ? 1 : 0;
                    }
                    this.options = new List<Tuple<int, decimal, decimal, int, string>>();
                    var result1 = WXInvest.CheckNetIssueConditions(userId);
                    if (result1.Success)
                    {
                        var fund = userBll.GetUserFundAccountInfo(userId);
                        var setting = WXInvest.GetJingSetting();
                        tuandaiFeeRate = user.Level == 1 ? setting.Param1Value.ToDecimal(0) : setting.Param2Value.ToDecimal(0);
                        creditAmount = WXInvest.GetUserJingAvailableAmount(user, fund, setting, out maxDeadline);

                        string text = string.Format("资产标（借款额度{0}元）", ToolStatus.ConvertLowerMoney(creditAmount));
                        this.options.Add(new Tuple<int, decimal, decimal, int, string>(6, creditAmount, tuandaiFeeRate, maxDeadline, text));
                        this.deadLineDesc = string.Format("还款期限最高{0}个月", maxDeadline);
                    }

                  //资产标短期标配置
                    WebSettingBLL setbll = new WebSettingBLL();
                    WebSettingInfo deadlineDay = setbll.GetWebSettingInfo("78A758ED-6D5C-4991-A804-6601E50960AD"); 
                    minDeadlineDay = Tool.SafeConvert.ToInt32(deadlineDay.Param1Value, 15);
                    maxDeadlineDay = Tool.SafeConvert.ToInt32(deadlineDay.Param2Value, 29);
                    endDeadlineDay = deadlineDay.Param3Value.ToDateTime(DateTime.MaxValue);
                    //var result2 = WXInvest.CheckStockIssueConditions(userId);
                    //if (result2.Success)
                    //{
                    //    var setting = WXInvest.GetStockSetting();
                    //    var tuandaiFeeRate = user.Level == 1 ? setting.Param1Value.ToDecimal(0) : setting.Param2Value.ToDecimal(0);
                    //    var amount = user.aviCreditGrantingAmount ?? 0;
                    //    var text = string.Format("资产标-综合授信（授信额度{0}元）", ToolStatus.ConvertLowerMoney(amount));
                    //    this.options.Add(new Tuple<int, decimal, decimal, int, string>(7, amount, tuandaiFeeRate, 24, text));
                    //    if (!result1.Success) this.deadLineDesc = string.Format("还款期限最高{0}个月", 24);
                    //}
                }
            }
        }

        /// <summary>
        /// 是否是免收管理费用户
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public void GetIsProjectFreePaidUser(Guid userid)
        {
            int row = 0;

            var commandText = @"select count(0) from ProjectFreePaidUser with(nolock) where UserId=@UserId"; ;
           
            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@UserId", userid);
            row = PublicConn.QuerySingle<int>(commandText, ref dyParams);

            IsProjectFreePaidUser = row > 0;
        }

        /// <summary>
        /// 获取用户VIP的等级及管理费优惠利率
        /// </summary>
        protected void GetUserVipMsg(Guid userid)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@userId", userid);
            param.Add("@Rate", null, DbType.Double, ParameterDirection.Output);
            param.Add("@Level", null, DbType.Int32, ParameterDirection.Output); 

            PublicConn.ExecuteVip("P_VipProjectZCRate", ref param, CommandType.StoredProcedure); 

            UserVipLevel = param.Get<int?>("@Level");
            if (UserVipLevel == null)
                UserVipLevel = 1;
            ManagerRate = param.Get<double?>("@Rate");
            if (ManagerRate == null)
                ManagerRate = 1;
            if (DateTime.Now < DateTime.Parse("2016/03/12 00:00:00"))
                ManagerRate = 1; 
        }
    }
}