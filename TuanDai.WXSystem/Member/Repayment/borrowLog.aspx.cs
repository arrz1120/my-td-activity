using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 用户借款记录
    /// Allen 2015-05-28
    /// </summary>
    public partial class borrowLog : UserPage
    {
        protected int pageCount { get; set; }
        protected WXMyLoanList_Info myLoanModel = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //this.GetData();
            }
        }
        private void GetData()
        {
            Guid userId = WebUserAuth.UserId.Value;
            ProjectBLL bll = new ProjectBLL();
            int recordCount = 0;
            myLoanModel = bll.WXGetMyLoanList(userId, 0, 1, GlobalUtils.PageSize, out recordCount);

            double divide = recordCount / GlobalUtils.PageSize;
            double floor = System.Math.Floor(divide);
            if (recordCount % GlobalUtils.PageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
        }

        public static string GetDeadlineStr(WXSubMyLoanList_Info item)
        {
            if (item.DeadType == 1)
            {
                return item.Deadline + "个月";
            }
            else
            {
                return item.Deadline + "天";
            }
        }
        public static string GetMonthsStr(WXSubMyLoanList_Info item)
        {
            if (item.IsOverdue)
            {
                return "<div class='rf pr15 f12px loadState2'><i></i>逾期中（" + item.RefundedMonths + "/" + item.TotalRefundMonths + "）</div>";
            }
            else
            {
                switch (item.Status)
                {
                    case 0:
                        return "<div class='rf pr15 f12px loadState4'><i></i>申请中</div>";
                    case 1:
                        return "<div class='rf pr15 f12px loadState2'><i></i>不通过</div>";
                    case 2: //投标中
                        return "<div class='rf pr15 f12px loadState4'><i></i>借入中（" + item.Progress + "%）</div>";
                    case 3: //还款中
                        return "<div class='rf pr15 f12px loadState1'><i></i>结清中（" + item.RefundedMonths + "/" + item.TotalRefundMonths + "）</div>";
                    case 4:
                        return "<div class='rf pr15 f12px loadState2'><i></i>已流标</div>";
                    case 7:
                        //供应链没有流标说法
                        if (item.Type == 20 && item.CastedShares == 0 && item.BuybackShares != 0)
                        {
                            return "<div class='rf pr15 f12px loadState3'><i></i>已完成（" + item.TotalRefundMonths + "/" + item.TotalRefundMonths + "）</div>";
                        }
                        else
                        {
                            return "<div class='rf pr15 f12px loadState2'><i></i>已流标</div>";
                        }
                    case 6:
                        return "<div class='rf pr15 f12px loadState3'><i></i>已完成（" + item.TotalRefundMonths + "/" + item.TotalRefundMonths + "）</div>";
                }
                return "<div class='rf pr15 f12px loadState4'><i></i>借入中（" + item.Progress + "%）</div>";
            }
        }
        //显示百分比   0:未完成 1:未通过审核  2:投标中 3:还款中 4:已流标  6:完成（完成还款）7:完成（下架） 
        public static string GetProcessStr(WXSubMyLoanList_Info item)
        {
            if (item.IsOverdue)
            {
                return item.Progress;
            }
            else
            {
                switch (item.Status)
                {
                    case 0:
                    case 1:
                        return "0";
                    case 2:
                        return item.Progress;
                    case 3:
                        return WebFormHandler.ProcessBar(item.RefundedMonths, item.TotalRefundMonths, 1);
                    case 4:
                    case 7: 
                        return item.Progress;
                    case 6:
                        return item.Progress;
                }
                return "0";
            }
        }
        public static string GetCircleCss(WXSubMyLoanList_Info item)
        {
            if (item.IsOverdue)
            {
                return "circle6";
            }
            else
            {
                switch (item.Status)
                {
                    case 0:
                        return "circle1";
                    case 1:
                        return "circle5";
                    case 2: //投标中
                        return "circle2";
                    case 3: //还款中
                        return "circle4";
                    case 4:
                    case 7:
                        //供应链没有流标说法
                        if (item.Type == 20 && item.CastedShares == 0 && item.BuybackShares != 0)
                        {
                            return "circle2";
                        }
                        else
                        {
                            return "circle3";
                        }
                    case 6:
                        return "circle2";
                }
                return "circle";
            }
        }

        //获取点击详情地址
        public static string GetLinkUrl(WXSubMyLoanList_Info item)
        {
            /// 1:商友贷 2:商贸联保贷(del) 3:零售贷
            ///4:部分担保贷(del) 5:团贷宝 6:净值标
            ///7:股权抵押标 8:信用贷款标(del) 9:车贷
            ///10:消费贷 11:房贷 12:房宝宝
            ///13:新手投资 14:担保贷（你我金融）(del) 15:分期宝
            ///16:股票质押 17:股票配资  20:供应链

            //项目标、微团贷、净股标
            if (item.Type.ToString().IsIn("1", "3", "6", "7", "9", "10", "11", "20","22","23","19"))
            {
                return "/Member/Repayment/borrowInvestShow.aspx?id=" + item.ProjectId;
            }
            //股票配资
            else if (item.Type.ToString().IsIn("16", "17"))
            {
                return "/Member/Repayment/borrowShow.aspx?id=" + item.ProjectId;
            }
            //分期宝
            else if (item.Type.ToString() == "15")
            {
                return "/Member/Repayment/borrowInvestShow.aspx?id=" + item.ProjectId;
            }
            return "#";
        }

    }
}