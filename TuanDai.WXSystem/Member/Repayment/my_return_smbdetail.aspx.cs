using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Data;
using Kamsoft.Data.Dapper;
using TuanDai.PortalSystem.DAL;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class my_return_smbdetail :UserPage
    {
        protected Guid UserId = WebUserAuth.UserId.Value;
        protected Guid SubscribeId;//申购ID
        protected Guid ProjectId;//项目ID
        protected ProjectDetailInfo projectInfo;//项目实体
        protected WXSubscribeInfo subscribeInfo;//申购实体
        ProjectBLL projectBll = new ProjectBLL();
        protected string TenderMode = string.Empty;//投标方法
        protected string Status = string.Empty;//状态
        protected List<SubscribeInfo> listtable = new List<SubscribeInfo>();
        protected WXFQUserApplyInfo FQUserApplyInfo;
        protected SMBProjectInfo projectSmb;//私募宝
        protected SimubaoCurve simubaoCurve;//用户购买了的私募宝
        protected XMBDetailInfo_Return xmbReturn;
        protected decimal xmbDSInterest = 0; //项目宝待收利息
        protected int xmbHoldDay = 0;//项目宝持有天数
        protected decimal xmbDeadRate = 0;//项目宝当前利率
        /// <summary>
        /// 浮动利率对照信息
        /// </summary>
        protected List<ProjectRateContrastInfo> rateRangeList;

        protected string tab;
        protected void Page_Load(object sender, EventArgs e)
        {
            SubscribeId = WEBRequest.GetGuid("SubscribeId", "");
            ProjectId = WEBRequest.GetGuid("ProjectId", "");
            tab = WEBRequest.GetQueryString("tab");
            if (!IsPostBack)
            {
                projectInfo = projectBll.GetProjectDetailInfo(ProjectId);
                if (projectInfo.Type == 18)
                {
                    //私募宝
                    ProjectSMBLL projectSmbll = new ProjectSMBLL();
                    projectSmb = projectSmbll.GetProjectSMModel(projectInfo.Id);
                    simubaoCurve = projectBll.GetSimubaoCurve(UserId, SubscribeId);
                }
                subscribeInfo = projectBll.WXGetSubscribeInfo(SubscribeId);
                TenderMode = WXConverter.GetTenderModeString(subscribeInfo.TenderMode);

                if (projectInfo.Type == 23)
                {
                    ProjectXMBBLL xmbbll = new ProjectXMBBLL();
                    if (subscribeInfo.Status.Value.ToString().IsIn("3", "4"))
                    {
                        xmbReturn = xmbbll.GetXMBReturnDetail(subscribeInfo.SubscribeId);
                        xmbDSInterest = xmbReturn.ReturnAmount - xmbReturn.Amount;
                        xmbHoldDay = xmbReturn.HoldDay;
                        xmbDeadRate = xmbReturn.InterestRate;
                    }
                    else
                    {
                        Tuple<int, decimal, decimal, string> tupleObj = BusinessDll.Invest.GetXMBProjectFloatRate(ProjectId, subscribeInfo.AddDate.Value, subscribeInfo.Amount ?? 0);
                        xmbHoldDay = tupleObj.Item1;
                        xmbDeadRate = tupleObj.Item2;
                        xmbDSInterest = tupleObj.Item3;
                    }
                    rateRangeList = xmbbll.GetXMBRateContrastInfo(ProjectId);
                }

                Status = WXConverter.GetSubscribeStatusString(projectInfo.Type, subscribeInfo.Status, subscribeInfo.IsBorrow);
                BindList();
                //当为分期宝时
                if (projectInfo != null && (projectInfo.Type ?? 0) == 15)
                    FQUserApplyInfo = projectBll.WXGetFQUserApplyInfo(ProjectId.ToString());
            }
        }

        protected string GetInvestFeeRate(decimal investFeeRate, int ProfitTypeId)
        {
            if (investFeeRate == 0)
            {
                return "0%";
            }
            if (ProfitTypeId == 1)//浮动
            {

                return "收益超过年化10%，收取超出部分的" + investFeeRate.ToString("0.0") + "%";
            }
            else
            {
                return "收益部分的" + investFeeRate.ToString("0.0") + "%";
            }
        }
        /// <summary>
        /// 项目详情
        /// </summary>
        /// <returns></returns>
        public string GetUrl()
        {
            int SubTypeId = 0;
            if ((projectInfo.Type ?? 0) == 15)
            {
                if (FQUserApplyInfo.OrgTypeId != null && FQUserApplyInfo.OrgTypeId != 5)
                    SubTypeId = 1;
                else
                    SubTypeId = 2;
            }
            string strLinkUrl = invest_list.GetClickUrl(projectInfo.Type ?? 0, SubTypeId, projectInfo.Id);
            if (strLinkUrl != "#" && strLinkUrl.IndexOf("backurl") == -1)
            {
                strLinkUrl += "&backurl=" + BasePage.GetEncodeBackURL();
            }
            return strLinkUrl;
        }
        /// <summary>
        /// 列表
        /// </summary>
        protected void BindList()
        {
            if (!(projectInfo.Status == 2 && (projectInfo.Type == 15 || projectInfo.Type == 17)))//分期宝，股票配资未满标
            {
                listtable = GetSubscribeDetailList(SubscribeId);

                foreach (SubscribeInfo item in listtable)
                {
                    if (item.IsBorrow != null && item.IsBorrow == false)
                    {
                        item.Desc = "已逾期";
                        DateTime tEnd = DateTime.Now.ToShortDate();
                        DateTime tBegin = Convert.ToDateTime(item.OverDueDate).ToShortDate();
                        item.OverDueDay = Math.Abs(((TimeSpan)(tEnd - tBegin)).Days + 1);//逾期天数
                        //item.PenaltyAmount=
                    }
                    if (item.CycDate < DateTime.Now && item.Desc.IndexOf("待") >= 0)
                    {
                        item.Desc = "已逾期";
                        DateTime tEnd = DateTime.Now.ToShortDate();
                        DateTime tBegin = Convert.ToDateTime(item.CycDate).ToShortDate();
                        item.OverDueDay = Math.Abs(((TimeSpan)(tEnd - tBegin)).Days + 1);//逾期天数
                    }
                }
            }
        }

        /// <summary>
        /// 获取回款记录明细
        /// </summary>
        /// <param name="subscribeId">申购Id</param>
        /// <returns></returns>
        protected List<SubscribeInfo> GetSubscribeDetailList(Guid subscribeId)
        {
            List<SubscribeInfo> list = null;
            
            string sqlText = @"SELECT ISNULL(Amount,0) Amount,ISNULL(InterestAmout,0) InterestAmout,ISNULL(InvestCommission,0) Commssion,
                            ISNULL(TuandaiRedPacket,0) TuandaiRedPacket,Periods,CycDate,[Desc],PenaltyAmount,IsBorrow,AddDate as OverDueDate,isnull(PublisherRedPacket,0) as PublisherRedPacket,InvestDate
                            FROM
                            (
                                SELECT a.Amount,a.InterestAmout,a.InvestCommission,a.BorrorCommission,a.TuandaiRedPacket,a.Periods,a.CycDate,'待回款' as [Desc],
                                CASE c.IsVip WHEN 0 THEN 0 WHEN 1 THEN (b.PrePenalty/2+(b.PenaltyAmount-b.PrePenalty)*2/3) ELSE 0 END AS PenaltyAmount,b.IsBorrow,b.AddDate,
                                a.PublisherRedPacket, c.AddDate as InvestDate
                                FROM SubscribeDetail a 
                                LEFT JOIN OverDueRecord b ON a.SubscribeId=b.SubscribeId AND a.Periods=b.periods
                                INNER JOIN Subscribe c ON a.SubscribeId=c.Id
                                WHERE a.SubscribeId=@SubscribeId
                                UNION 
                                SELECT a.RealAmount Amount,a.RealInterestAmout InterestAmout,a.InvestCommission,a.BorrorCommission,
                                a.TuandaiRedPacket,a.Periods,ISNULL(a.RepayAdvanceDate,a.CycDate) CycDate,'已回款' as [Desc],
                                CASE c.IsVip WHEN 0 THEN 0 WHEN 1 THEN (b.PrePenalty/2+(b.PenaltyAmount-b.PrePenalty)*2/3) ELSE 0 END AS PenaltyAmount,b.IsBorrow,b.AddDate,
                                a.PublisherRedPacket, c.AddDate as InvestDate  
                                FROM td_SubDetailHis.dbo.SubscribeDetailHistory_h1 a 
                                LEFT JOIN OverDueRecord b ON a.SubscribeId=b.SubscribeId AND a.Periods=b.periods
                                INNER JOIN Subscribe c ON a.SubscribeId=c.Id
                                WHERE a.SubscribeId=@SubscribeId
                            )t ORDER BY Periods ASC";
                var para = new Dapper.DynamicParameters();
                para.Add("@SubscribeId", subscribeId);
                list = PublicConn.QueryBySql<SubscribeInfo>(sqlText, ref para);
            
            return list;
        }

        /// <summary>
        /// 回款明细
        /// </summary>
        public class SubscribeInfo
        {
            /// <summary>
            /// 回款时间
            /// </summary>
            public DateTime CycDate { get; set; }
            /// <summary>
            /// 本金
            /// </summary>
            public decimal Amount { get; set; }
            /// <summary>
            /// 利息
            /// </summary>
            public decimal InterestAmout { get; set; }
            /// <summary>
            /// 投资佣金
            /// </summary>
            public decimal Commssion { get; set; }
            /// <summary>
            /// 当期期数
            /// </summary>
            public int Periods { get; set; }
            /// <summary>
            /// 说明
            /// </summary>
            public string Desc { get; set; }
            /// <summary>
            /// 团贷奖励
            /// </summary>
            public decimal TuandaiRedPacket { get; set; }
            /// <summary>
            /// 滞纳金
            /// </summary>
            public decimal PenaltyAmount { get; set; }
            /// <summary>
            /// 是否逾期
            /// </summary>
            public bool? IsBorrow { get; set; }
            /// <summary>
            /// 逾期日期
            /// </summary>
            public DateTime? OverDueDate { get; set; }
            /// <summary>
            /// 逾期天数
            /// </summary>
            public int? OverDueDay { get; set; }
            /// <summary>
            /// 发标人红包
            /// </summary>
            public decimal PublisherRedPacket { get; set; }
            /// <summary>
            /// 申购日期
            /// </summary>
            public DateTime InvestDate { get; set; }
            /// <summary>
            /// 浮动项目宝持有天数
            /// </summary>
            public int HoldDay
            {
                get
                {
                    System.TimeSpan TS = new System.TimeSpan(DateTime.Today.Ticks - DateTime.Parse(InvestDate.ToString("yyyy-MM-dd")).Ticks);
                    return TS.Days;
                }
            }
            /// <summary>
            /// 浮动项目宝当前利率
            /// </summary>
            public int HoldRate
            {
                get;
                set;
            }
        }
    }
}