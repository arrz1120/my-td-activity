using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class invest_newHand : AppActivityBasePage
    {
        protected List<WeProductDetailInfo> NewHandProjectList; //新手标
        protected bool IsNewHandNewRule = false;
        protected string type = "";
        protected string NewHandTips = "从未在团贷网进行过投资的新<br />手才能投资新手标！";
        protected void Page_Load(object sender, EventArgs e)
        {
            Context.Response.Redirect("//mvip.tdw.cn/pages/invest/invest_newHand.aspx");
            return;

            WebSettingBLL websetbll = new WebSettingBLL();
            WebSettingInfo setInfo = websetbll.GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1");
            WebSettingInfo NewHandExtSet = websetbll.GetWebSettingInfo("20B98405-633B-4559-95C9-C0E96DD3BD2C");
            int limitRegDay = NewHandExtSet.Param1Value.ToInt(30);

            IsNewHandNewRule = setInfo.Param5Value == "1";
            if (IsNewHandNewRule)
            {
                NewHandTips = "1.限" + DateTime.Today.AddDays(-limitRegDay).ToString("yyyy-MM-dd") + "起新注册用户。<br />2.注册30天内 , 限投"+setInfo.Param4Value+"次新手标。<br />3.新手标累计投资金额为"+int.Parse(setInfo.Param1Value)/10000+"万元。";
            }

            GetNewHandProject();
            type = Tool.WEBRequest.GetString("type");
        }

        /// <summary>
        /// 获取新手标
        /// </summary>
        protected void GetNewHandProject()
        {
            NewHandProjectList = new List<WeProductDetailInfo>();
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                List<string> typeWordArrary = new List<string>() { "NEW03","NEW02", "NEW01" };
                NewHandProjectList = new WeProductBLL().GetWePlanListByRedis(typeWordArrary, TdConfig.ApplicationName);
                if (NewHandProjectList != null && NewHandProjectList.Any())
                {
                    NewHandProjectList = NewHandProjectList.Where(p => p.TypeWord == "NEW03" || p.TypeWord == "NEW02" || p.TypeWord == "NEW01").OrderBy(o => o.StatusId).ThenBy(o => o.DeadType).ThenByDescending(o => o.Deadline).ToList();
                }
            }
            else
            {
                NewHandProjectList = GetNewHandProject_DB();
            }
            if (NewHandProjectList == null || !NewHandProjectList.Any())
            {
                NewHandProjectList = GetNewHandProject_DB();
            }
        }


        protected List<WeProductDetailInfo> GetNewHandProject_DB()
        {
            List<WeProductDetailInfo> list = null;
            string strSQL =
             @"select ROW_NUMBER() over(ORDER BY A.StatusId asc,A.DeadType asc,A.Deadline desc) as rownum, B.ProductId,
	                A.ProductName, A.ProductNumber,
	                A.ProductTypeId, A.PlanAmount, A.YearRate, A.UnitAmount, A.StatusId, A.Deadline,isnull(A.DeadType,1) as DeadType, A.ProjectTypes, A.StartDate, A.EndDate, 
	                A.InvestCompleteDate, A.OrderCompleteDate, B.InvestCount, C.SortOrder,C.TypeWord, B.OrderCount, 
	                B.RealOrderQty as OrderQty, B.TotalQty,ISNULL(A.MinYearRate,0) AS MinYearRate,ISNULL(A.IsWeFQB,0) as IsWeFQB, 
	                isnull(A.TuandaiRedRate,0) as TuandaiRedRate,
	                isnull(a.CashLimitAmount,0) as CashLimitAmount,isnull(a.TuandaiCashRate,0) as TuandaiCashRate,
	                isnull(A.IsFTB,0) as IsFTB,isnull(A.IsPreSell,0) AS IsPreSell, A.PreSellInvestDate,C.MqQueueName
                from dbo.We_Product  A with(nolock)
                inner join dbo.We_ProductDetail B with(nolock) on A.Id=B.ProductId
                INNER JOIN dbo.We_ProductType C WITH (NOLOCK) ON A.Id=C.NewProductId
                where C.TypeWord in('NEW03','NEW02','NEW01') and isnull(a.IsNewHand,0)=1";

            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            list = TuanDai.DB.TuanDaiDB.Query<WeProductDetailInfo>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
            return list;
        }

        /// <summary>
        /// 获取标详情页显示的利率
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public string GetProjectDetailShowRate(WeProductDetailInfo model)
        {
            //<span class='f36px c-fa7d00'>7</span>.5%＋5.5%
            decimal rate = model.YearRate ?? 0;
            string strResult = "";
            strResult = string.Format("<span class='f36px c-fa7d00'>{0}</span>{1}%", CommUtils.GetFloatDivideStr(rate, 1), CommUtils.GetFloatDivideStr(rate, 2));
            if (model.IsNewHand && (model.TuandaiRedRate ?? 0) > 0)
            {
                decimal NewHandRate = StrObj.StrToDecimalDef((model.TuandaiRedRate ?? 0).ToString(), 0);
                strResult += string.Format("＋{0}{1}%", CommUtils.GetFloatDivideStr(NewHandRate, 1), CommUtils.GetFloatDivideStr(NewHandRate, 2));
            }
            else
            {
                strResult += "";
            }
            return strResult;
        }
        /// <summary>
        /// 期限
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public string GetDeadlineString(WeProductDetailInfo model)
        {
            if (model.DeadType == 1)
            {
                return model.Deadline + "个月";
            }
            else
            {
                return model.Deadline + "天";
            }
        }
        /// <summary>
        /// 剩余金额
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public string GetLostMoneyString(WeProductDetailInfo model)
        {
            decimal amount = ((model.TotalQty ?? 0) - (model.OrderQty ?? 0)) * (model.UnitAmount??0);
            if (amount > 10000)
            {
                return ToolStatus.ConvertLowerMoney(amount/10000) + "万";
            }
            else
            {
                return ToolStatus.ConvertLowerMoney(amount) + "元";
            }
        }

        public string GetDetailLink(WeProductDetailInfo item)
        {
            return "/pages/invest/We/WeFtb_detail.aspx?id=" + item.ProductId + "&typeId=" + item.ProductTypeId + "&IsPreSell=0";
        }
    }
}