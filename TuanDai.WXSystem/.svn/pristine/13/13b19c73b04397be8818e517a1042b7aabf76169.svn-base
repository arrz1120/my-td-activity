using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest.WE
{
    /// <summary>
    /// 复投宝详情页
    /// Allen 2016-08-29
    /// </summary>
    public partial class WeFtb_detail :  BasePage
    {

        protected Guid? projectId { get; set; }
        private WeProductBLL bll = null;
        protected WeProductDetailInfo model = null;
        protected bool IsWeFinish = false;
        protected bool IsApp = false;
        protected List<WeProductFTBRateInfo> FTBRateList = null;
        protected decimal PreInterestRate = 0; //投资1W预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益 
        protected decimal FXRate = 0;

        protected decimal limitInvest = 30000;//新手标限制投资金额
        protected string limitInvestStr = string.Empty;
        protected int limitInvestNum = 3;//限投次数
        protected WebSettingInfo curSellSet; //1218当天配置
        protected WebSettingInfo preSellSet; //1218预售项目
        protected WebSettingInfo sellSet518;//518活动加息
        protected string IsPreView1218 = "0";//可预览1218配置 
        protected int TypeId = 0;
        protected bool IsPreSell = false;
        protected bool IsNewHandNewRule = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            projectId = WEBRequest.GetGuid("id");        
            var type = WEBRequest.GetString("type");
            this.TypeId = WEBRequest.GetInt("typeId", 0);
            this.IsPreSell = WEBRequest.GetInt("IsPreSell", 0) == 1;

            if (type == "mobileapp")
            {
                IsApp = true;
                IsShowRightBar = false;
            } 
            if (!IsPostBack)
            {
                bll = new WeProductBLL();
                if (this.projectId != null && this.projectId != Guid.Empty)
                {
                    if (!this.GetData())
                        return;
                }
                else
                {
                    Response.Redirect(GlobalUtils.MTuanDaiURL + "/pages/invest/WE/WE_list.aspx");
                }
            } 
        }
        private bool GetData()
        {
            //获取项目信息
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                this.model = new WeProductBLL().GetWePlanByRedis(TypeId, projectId.Value, IsPreSell,TdConfig.ApplicationName);
            }
            else
            {
                this.model = bll.GetWeProductInfo(projectId.Value);
            } 
            if (model == null || model.IsFTB == false)
                return false;

            #region 判断满标
            if (model.StartDate > DateTime.Now && model.StatusId == 1)
            {
                IsWeFinish = false;
            }
            else if (model.StartDate < DateTime.Now && model.OrderQty != model.TotalQty)
            {
                IsWeFinish = false;
            }
            else
            {
                IsWeFinish = true;
            }
            #endregion

            #region 判断新手标
            if (!model.IsNewHand)
            {
                WeFTBBLL ftbll = new WeFTBBLL();
                FTBRateList = this.GetWeFTBRateList(model.ProductTypeId ?? 0, model.StartDate ?? DateTime.Today);
                if (FTBRateList == null)
                    FTBRateList = new List<WeProductFTBRateInfo>();

                //补充提前退出前几个月的数据
                if (FTBRateList.Any())
                {
                    WeProductFTBRateInfo firstRate = FTBRateList[0];
                    List<WeProductFTBRateInfo> tmpList = new List<WeProductFTBRateInfo>();
                    for (int i = 1; i < model.ExitLockMonth; i++)
                    {
                        tmpList.Add(new WeProductFTBRateInfo() { MonthType = i, ProductTypeId = model.ProductTypeId ?? 0, YearRate = firstRate.YearRate });
                    }
                    if (tmpList.Any())
                        FTBRateList.InsertRange(0, tmpList);
                }
                FTBRateList = FTBRateList.OrderByDescending(p => p.MonthType).ToList();
            }
            #endregion

            decimal deadLineType = model.DeadType == 1 ? 12 : 365;
            PreInterestRate = decimal.Parse("10000") * (model.Deadline ?? 0) * ((model.YearRate ?? 0) + (model.TuandaiRedRate ?? 0)) * decimal.Parse("0.01") / deadLineType;
            EbaoMultiple = int.Parse(Math.Ceiling(model.YearRate.Value / decimal.Parse("2.5")).ToString());
            EbaoInterest = GetEbaoMultipleInterest(10000);

            GetLimitInvestMoney();

            WebSettingBLL webSettingBll = new WebSettingBLL();

            preSellSet = webSettingBll.GetWebSettingInfo("6F9D3B77-C15C-4A5A-B883-21004E10BE29");
            curSellSet = webSettingBll.GetWebSettingInfo("B11558CB-3C6B-4DAD-9D2F-D6D2DE13CCF7");
            sellSet518 = webSettingBll.GetWebSettingInfo("5E02F517-E6FC-4451-8232-378377837EC1");
            IsPreView1218 = System.Configuration.ConfigurationManager.AppSettings["IsPreView1218"];
            if (IsPreView1218 == "1")
            {
                preSellSet.Param1Value = DateTime.Today.ToString("yyyy-MM-dd");
                preSellSet.Param2Value = DateTime.Today.ToString("yyyy-MM-dd 23:59:59");
            }
            else if (IsPreView1218 == "2")
            {
                preSellSet.Param1Value = DateTime.Today.AddDays(-1).ToString("yyyy-MM-dd");
                preSellSet.Param2Value = DateTime.Today.AddDays(-1).ToString("yyyy-MM-dd 23:59:59");

                curSellSet.Param1Value = DateTime.Today.ToString("yyyy-MM-dd");
                curSellSet.Param2Value = DateTime.Today.ToString("yyyy-MM-dd 23:59:59");
            }
            return true;
        }

        /// <summary>
        /// 获取某类复投宝的利率设置
        /// </summary>
        /// <param name="productTypeId">产品类型Id</param>
        /// <returns></returns>
        public List<WeProductFTBRateInfo> GetWeFTBRateList(int productTypeId, DateTime publisherDate)
        {
            string strSQL = "select * from We_ProductFTBRate where ProductTypeId=@typeId and ( (@publisherDate between StartDate and EndDate) or  StartDate is null) order by MonthType";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@typeId", productTypeId);
            dyParams.Add("@publisherDate", publisherDate);
            return PublicConn.QueryBySql<WeProductFTBRateInfo>(strSQL, ref dyParams);
        }

        /// <summary>
        /// 获取新手标限制金额
        /// </summary>
        private void GetLimitInvestMoney()
        {
         
            WebSettingInfo setInfo = new WebSettingBLL().GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1");
            limitInvest = decimal.Parse(setInfo.Param1Value); 
            limitInvestNum = setInfo.Param4Value.ToInt(3);
            IsNewHandNewRule = setInfo.Param5Value == "1";
            if (limitInvest >= 10000)
            {
                limitInvestStr = ToolStatus.DeleteZero(Math.Floor(limitInvest / 10000)) + "万";
            }
            else if (limitInvest >= 1000 && limitInvest < 10000)
            {
                limitInvestStr = ToolStatus.DeleteZero(Math.Floor(limitInvest / 1000)) + "千";
            }
            else
            {
                limitInvestStr = Math.Floor(limitInvest).ToString();
            }
        }


        /// <summary>
        /// 获取余额宝收益
        /// </summary>
        /// <param name="model"></param>
        /// <param name="investAmount"></param>
        /// <returns></returns>
        protected   decimal GetEbaoMultipleInterest(decimal investAmount)
        {
            decimal interestAmount = 0;
            decimal deadLineType = model.DeadType == 1 ? 12 : 365;
            interestAmount = investAmount * decimal.Parse("0.025") * model.Deadline.Value / deadLineType;
            return interestAmount;
        }
        protected string GetWePlanYearRate()
        {
            //<span>+2</span><span>%</span>
            //string strFormat = "{0}<span>{1}</span>";
            //return string.Format(strFormat, CommUtils.GetFloatDivideStr(model.YearRate ?? 0, 1), CommUtils.GetFloatDivideStr(model.YearRate ?? 0, 2));
            string strFormat = "{0}<span>{1}%</span>";
            string addRateStr = "";
            if (!model.IsNewHand)
            {
                if (DateTime.Parse(preSellSet.Param1Value) <= model.StartDate && model.StartDate < DateTime.Parse(curSellSet.Param2Value) && model.IsPreSell)
                {
                    strFormat = "{0}<span style='font-size:18px;'>{1}%</span>";
                    addRateStr = "+至少1.5";
                }
                
            }
            return string.Format(strFormat, CommUtils.GetFloatDivideStr(model.YearRate ?? 0, 1), CommUtils.GetFloatDivideStr(model.YearRate ?? 0, 2) + addRateStr);
        }
        protected string GetMonthExitRate(int month)
        {
            WeProductFTBRateInfo rateInfo = FTBRateList.Where(p => p.MonthType == month).FirstOrDefault();
            if (rateInfo != null)
            {
                return ToolStatus.DeleteZero(rateInfo.YearRate) + "%";
            }
            return "0%";
        }
        protected string ProductTypes(string types, object MinYearRate)
        {
            var result = string.Empty;
            types.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                    .ToList()
                    .ForEach(x =>
                    {
                        if (x == "1")
                        {
                            result += "小微企业,";
                        }
                        if (x == "9")
                        {
                            result = result + "微团贷,";
                        }
                        if (x == "6")
                        {
                            result = result + "净值标,";
                        }
                        if (x == "17")
                        {
                            result = result + "证券宝,";
                        }
                        if (x == "15")
                        {
                            result = result + "分期宝,";
                        }
                        if (x == "22")
                        {
                            result = result + "项目宝B,";
                        }
                        if (x == "18")
                        {
                            if (Tool.SafeConvert.ToDecimal(MinYearRate, 0) > 0)
                            {
                                result = result + "私募宝A,";
                            }
                            else
                            {
                                result = result + "私募宝B,";
                            }

                        }
                        if (x == "24")
                        {
                            result = result + "分期宝,";
                        }
                    });

            return result;
        } 

        #region  返现,加息标签
        /// <summary>
        /// We返现标签
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        protected string ShowWePubCach(WeProductDetailInfo model)
        {
            string pic = "";
            //发标时就设置返现
            if ((model.TuandaiCashRate ?? 0) > 0)
            {
                WebSettingBLL webSettingBll = new WebSettingBLL();
                WebSettingInfo AllWeCachSet = webSettingBll.GetWebSettingInfo("421DBE8C-6435-4A9A-852A-EC51F0B0DDA8");

                string cashFormat = AllWeCachSet.Param2Value;
                if ((model.CashLimitAmount ?? 0) > 0)
                    cashFormat = AllWeCachSet.Param1Value;
                if (cashFormat.ToText() == "")
                {
                    cashFormat = ((model.CashLimitAmount ?? 0) > 0 ? "起投{Amount}元，" : "") + "返现{Rate}%";
                }
                decimal limitAmount = model.CashLimitAmount ?? 0;
                string strLimitAmount = limitAmount >= 10000 ? ToolStatus.DeleteZero(limitAmount / 10000) + "万" : ToolStatus.DeleteZero(limitAmount / 1000) + "千"; 
                pic += "<div class=\"rect_r f11px c-ffffff text-center\" style=\"width: auto;padding: 0px 10px;\">" + cashFormat.Replace("{Rate}", ToolStatus.DeleteZero(model.TuandaiCashRate)).Replace("{Amount}", strLimitAmount) + "</div>";
            }
            return pic;
        }

        /// <summary>
        /// 显示加息标签
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        protected string ShowWeRank(WeProductDetailInfo model)
        {
            string pic = "";
            

            //发标时就设置奖励
            if ((model.TuandaiRedRate ?? 0) > 0)
            {
                if (string.IsNullOrEmpty(model.TuanDaiRedTitle))
                {
                    model.TuanDaiRedTitle = "加息";
                }

                pic = "<div class=\"rect_r f11px c-ffffff text-center\" style=\"width: auto;padding: 0px 10px;\">" + model.TuanDaiRedTitle + ToolStatus.DeleteZero(model.TuandaiRedRate) + "%</div>";
            } 
            return pic;
        }
        #endregion

    }
}