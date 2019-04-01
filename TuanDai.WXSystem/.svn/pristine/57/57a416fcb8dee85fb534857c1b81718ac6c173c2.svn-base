using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using NetDimension.Json;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 我的账单
    /// Allen 2015-06-29
    /// </summary>
    public partial class my_bills : UserPage
    {
        protected int pageCount { get; set; }
        protected WXMyBillsInfo model { get; set; }
        protected IList<ProjectAdImageInfo> BannerList;   //首页头部广告图

        protected static WebSettingInfo webset = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            webset = new WebSettingBLL().GetWebSettingInfo("71E1B58D-449F-4C61-85A6-115C10630554");
            if (webset == null)
            {
                webset = new WebSettingInfo();
                webset.Param1Value = "2018-05-01";
            }
            if (!IsPostBack)
            {
                this.GetData();
            }
        }

        private void GetData()
        {
            var webset = new WebSettingBLL().GetWebSettingInfo("42E7BF6F-74F0-4375-A614-00AD81A4638E");
            if (webset == null)
            {
                webset = new WebSettingInfo();
                webset.Param1Value = "6";
            }

            Guid userId = WebUserAuth.UserId.Value;
            model = WXGetMyBills(userId, 1, 10,DateTime.Now.AddDays(-int.Parse(webset.Param1Value)).ToDateString());
            int recordCount = model.TotalCount;

            int firstPageSize = 10;
            if (recordCount < 10)
            {
                firstPageSize = 10 - recordCount;
            }

            var bigModel = WXGetMyBillsFromBigData(userId, DateTime.Now.AddMonths(-2), DateTime.Now.AddDays(-int.Parse(webset.Param1Value)), 1, 10, firstPageSize);
            if (firstPageSize < 10 && bigModel.List != null)
            {
                model.List.AddRange(bigModel.List);
            }

            recordCount += bigModel.TotalCount;

            double divide = recordCount / 10;
            double floor = System.Math.Floor(divide);
            if (recordCount % 10 != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
            BannerList = new AdImageBLL().GetTuanDaiHot((int)ConstString.AdImageType.WEBImage, 1);
        } 

        //获取标题
        public static string GetBillTitle(WXMyBillDetialInfo item)
        {
            if (item.BillType == 4)
            {
                if (item.BillDesc == "申购借出")
                {
                    if (!item.Title.IsEmpty())
                        return item.Title.ToText();
                    else
                        return item.BillDesc;
                }
                else
                {
                    return item.BillDesc; 
                }
            }
            else if (item.BillType == 45)
            {
                if (item.PayOutAmount.HasValue && item.PayOutAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "投资智享转让";
                    }
                    return "投资智享计划";
                }
                else if (item.InAmount.HasValue && item.InAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让回款";
                    }
                    return "智享计划回款";
                }
                else
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让相关";
                    }
                    return "智享计划相关";
                }
            }
            else if (item.BillType == 46)
            {
                if (item.PayOutAmount.HasValue && item.PayOutAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让回购";
                    }
                    return "智享计划回购";
                }
                else if (item.InAmount.HasValue && item.InAmount.Value > 0)
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让";
                    }
                    return "智享计划转让";
                }
                else
                {
                    if (item.BillDate > DateTime.Parse(webset.Param1Value))
                    {
                        return "智享转让相关";
                    }
                    return "智享计划相关";
                }
            }
            else
                return item.BillDesc;
        }

        //获取交易类型
        public static string GetBillType(WXMyBillDetialInfo item)
        {
            
            string billType = Tool.EnumHelper.GetDescriptionFromEnumValue(typeof (ConstString.FundDetailType1),
                item.BillType);
            if (item.BillDate > DateTime.Parse(webset.Param1Value))
            {
                if (billType.Contains("We计划相关"))
                {
                    billType = "We自动服务相关";
                }
                if (billType.Contains("复投宝"))
                {
                    billType = "We+自动服务";
                }
                if (billType.Contains("智享计划"))
                {
                    billType = "智享转让";
                }
            }
            return billType;
        }
        #region 我的账单
        /// <summary>
        /// 获取我的账单数据
        /// </summary>
        /// <param name="userId">用户id</param>
        /// <param name="pageIndex">当前页码</param>
        /// <param name="pageSize">每页笔数</param>
        /// <returns></returns>
        public WXMyBillsInfo WXGetMyBills(Guid userId, int pageIndex, int pageSize,string startTime)
        {
            WXMyBillsInfo billResponse = new WXMyBillsInfo();

            string sql = @"SELECT @total=COUNT(1) FROM(
						SELECT 1 AS cnt
						FROM dbo.FundDetail A with(nolock,index=IDX_FundDetail_UserID)
						WHERE A.UserId=@UserId and adddate >@st
						) AS main;
						WITH oa AS(
						SELECT  ROW_NUMBER() OVER( ORDER BY A.AddDate DESC) AS RowNumber,  
							A.Amount,A.Id,A.[Desc] as BillDesc,
							A.UserId, A.[Type] as BillType, A.AddDate as BillDate, A.PayOutAmount, A.InAmount
						FROM  FundDetail A with(nolock,index=IDX_FundDetail_UserID)
						WHERE A.UserId=@UserId and a.adddate >@st)
						SELECT * FROM oa WHERE RowNumber  between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize";

            DynamicParameters paras = new DynamicParameters();
            paras.Add("@UserId", userId);
            paras.Add("@pageSize", pageSize);
            paras.Add("@pageIndex", pageIndex);
            paras.Add("@st",startTime);
            paras.Add("@total", 0, DbType.Int32, ParameterDirection.Output);

            List<WXMyBillDetialInfo> list = DB.TuanDaiDB.Query<WXMyBillDetialInfo>(TdConfig.ApplicationName, TdConfig.DBRead, sql, ref paras);
            //string err = "";
            //List<WXMyBillDetialInfo> list = DB.TuanDaiDB.Query<WXMyBillDetialInfo>(TdConfig.DBRead, sql, ref paras,ref err);
            billResponse.List = list;
            billResponse.TotalCount = paras.Get<int?>("@total")??0;
            if (billResponse.TotalCount > 0)
                billResponse.result = "1";
            else
                billResponse.result = "2";
            return billResponse;
        }
        #endregion


        public WXMyBillsInfo WXGetMyBillsFromBigData(Guid userId, DateTime st,DateTime et,int pageIndex,int pageSize, int firstPageSize)
        {
            WXMyBillsInfo info = new WXMyBillsInfo();
            string getUrl = ConfigHelper.getConfigString("GetFtbTranListServerUrl") + "/member/master/queryUserTransactionRecords?userId=" + userId + "&startDate=" + st.ToString("yyyy-MM-dd 00:00:00") + "&endDate=" + et.ToString("yyyy-MM-dd 00:00:00") + "&type=-1&type1=-1&pageIndex="+pageIndex+"&pageSize="+pageSize+"&firstPageSize="+firstPageSize;
            string err = "";
            string resp = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName, getUrl, "", out err);
            if (!string.IsNullOrEmpty(resp))
            {
                ResponseBaseBills responseBase = JsonConvert.DeserializeObject<ResponseBaseBills>(resp);
                if (responseBase != null && responseBase.content != null && responseBase.content.Any())
                {
                    info.TotalCount = responseBase.totalElements;
                    info.List = new List<WXMyBillDetialInfo>();
                    foreach (var item in responseBase.content)
                    {
                        WXMyBillDetialInfo detail = new WXMyBillDetialInfo();
                        detail.Amount = item.amount;
                        detail.BillDate = item.adddate;
                        detail.BillDesc = item.desc;
                        detail.BillType = item.type;
                        detail.FundProjectId = item.fundprojectid;
                        detail.Id = item.id;
                        detail.InAmount = item.inamount;
                        detail.PayOutAmount = item.payoutamount;
                        info.List.Add(detail);
                    }
                }
            }
            return info;
        }
        public class ResponseBills
        {
            public Guid id { get; set; }
            public Guid userid { get; set; }
            public int type { get; set; }

            public decimal amount { get; set; }

            public DateTime adddate { get; set; }

            public string desc { get; set; }

            public Guid? fundprojectid { get; set; }

            public decimal? payoutamount { get; set; }

            public decimal? inamount { get; set; }

            public int? type2 { get; set; }
        }

        public class ResponseBaseBills
        {
            public int page { get; set; }

            public int pageSize { get; set; }

            public int totalPages { get; set; }

            public int totalElements { get; set; }

            public string status { get; set; }

            public List<ResponseBills> content { get; set; } 
            
        } 
    }
}