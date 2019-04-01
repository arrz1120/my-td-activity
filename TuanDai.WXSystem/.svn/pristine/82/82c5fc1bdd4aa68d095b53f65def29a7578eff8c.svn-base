using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;
using Dapper;
using TuanDai.DB;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 申购记录
    /// Allen 2015-07-21
    /// </summary>
    public partial class SubscribeUser : BasePage
    {
        public List<SubscribeUserInfo> dataList = null;
        protected int pageCount = 0;
        private int pageSize = 15;
        protected Guid projectId = Guid.Empty;
        protected string strType = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            projectId = WEBRequest.GetGuid("id");
            if (!IsPostBack)
            {
                GetData();
            }
        }

        private void GetData()
        {
            strType = Tool.WEBRequest.GetQueryString("type");
            if (strType.ToLower() == "weplan")
            {
                //We计划
                GetWeSubscribelist(projectId);
            }
            else if (strType.ToLower() == "zqzr")
            {
                //债权转让
                GetZQZRSubscribelist(projectId);
            }
            else
            {
                int totalcount = 0;
                dataList = new List<SubscribeUserInfo>();
                List<TuanDai.WXApiWeb.Common.WXSubscribeRecord_Bak> tempList = TuanDai.WXApiWeb.Common.WXInvest.WXGetSubscribeList(projectId, pageSize, 1, out totalcount);
                pageCount = GetPageCount(totalcount);
                foreach (TuanDai.WXApiWeb.Common.WXSubscribeRecord_Bak weInfo in tempList)
                {
                    SubscribeUserInfo subInfo = new SubscribeUserInfo()
                    {
                        UserName = weInfo.UserName,
                        NickName = weInfo.NickName,
                        OrderDate = weInfo.AddDate,
                        OrderType = "网站",
                        Amount = weInfo.Amount ?? 0,
                        IsAuto = weInfo.IsAuto
                    };
                    subInfo.OrderType = GetProjectTenderName(weInfo.TenderMode);
                    dataList.Add(subInfo);
                }
            }
        }

        #region 获取投资列表
        //获取We计划加入人员
        protected void GetWeSubscribelist(Guid projectId)
        {
            WeOrderBLL webll = new WeOrderBLL();
            int totalcount = GetOrderCount(projectId);
            List<WeOrderInfo> welist = GetOrderList(projectId, 1, 15);
            dataList = new List<SubscribeUserInfo>();
            if (welist != null && welist.Count > 0)
            {
                foreach (WeOrderInfo weInfo in welist)
                {
                    SubscribeUserInfo subInfo = new SubscribeUserInfo()
                    {
                        UserName = weInfo.UserName,
                        NickName = weInfo.TelNo,
                        OrderDate = weInfo.OrderDate,
                        OrderType = GetWeTenderName(weInfo.DeviceType),
                        Amount = weInfo.Amount ?? 0,
                        IsAuto = false

                    };
                    dataList.Add(subInfo);
                }
            }
            
            pageCount = GetPageCount(totalcount);
        }
        public int GetOrderCount(Guid productid)
        {
            int result = 0;
            var args = new Dapper.DynamicParameters();
            args.Add("@productId", productid);
            string sqlText = "select Count(0) from We_Order with(nolock) where statusid in (0,1,2,4) and ProductId=@productId";
            result = TuanDaiDB.ExecuteScalar<int>(TdConfig.ApplicationName, TdConfig.DBRead, sqlText, ref args);
            return result;
        }
        /// <summary>
        /// 获取订单记录 GetOrderList
        /// </summary>
        /// <param name="productid">产品Id</param>
        /// <param name="pageIndex">当前页数</param>
        /// <param name="pageSize">页大小</param>
        /// <returns>返回订单列表</returns>
        public List<WeOrderInfo> GetOrderList(Guid productid, int pageIndex, int pageSize)
        {
            var args = new Dapper.DynamicParameters();
            args.Add("@productId", productid);
            args.Add("@pageIndex", pageIndex);
            args.Add("@pageSize", pageSize);
            string sqlText = @"select UserName,NickName,TelNo,Amount,OrderDate,RepeatInvestType,DeviceType from (
                        select u.UserName,u.NickName,u.TelNo,o.Amount,o.OrderDate,ROW_NUMBER() over(order by o.OrderDate desc) as rownum,
                        isnull(RepeatInvestType,0) as RepeatInvestType,o.DeviceType,o.statusid
                        from We_Order o with(nolock) 
                        left join UserBasicInfo u with(nolock) on o.UserId=u.Id  where  o.productId=@productId) t 
                        where t.statusid in (0,1,2,4) and t.rownum>(@pageIndex-1)*@pageSize  and t.rownum<=@pageIndex*@pageSize";
            List<WeOrderInfo> list = TuanDaiDB.Query<WeOrderInfo>(TdConfig.ApplicationName, TdConfig.DBRead, sqlText, ref args);
            return list;
        }
        //债权转让
        protected void GetZQZRSubscribelist(Guid projectId)
        {
            var commandText = @"select UserName,NickName,Amount, TenderMode as OrderType,TenderMode,
                                SubscribeShares,TotalShares,LowerUnit,InterestRate,AddDate as OrderDate,TelNo
								from
								(
								select ROW_NUMBER() over(order by S.AddDate desc) as num_,C.UserName,C.TelNo as NickName,isnull(S.ReceiveAmount,0)+isnull(s.ReceiveInterest,0) as Amount,S.TenderMode,S.TranDate as AddDate
								,S.SubscribeShares,S.TotalShares,(isnull(D.m_TotalAmount,0)+dbo.f_TransferPriceCal(S.Id,isnull(D.m_TotalShares,0)))/isnull(D.m_TotalShares,0) as LowerUnit,
								isnull(dbo.f_TransferProjectRate(D.m_Id),0) as  InterestRate,isnull(S.IsAuto,0) as IsAuto,C.TelNo
								from 
								dbo.Subscribe S with(nolock)
								inner join UserBasicInfo C 
								on S.SubscribeUserId=C.Id
								inner join t_SubScribeTransfer as D 
								on D.m_id=S.TranId
								where s.tranid=@ProjectId
								) T where T.num_>@PageSize*(@PageIndex-1) and T.num_<=@PageSize*@PageIndex";

            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", projectId);
            dyParams.Add("@PageIndex", 1);
            dyParams.Add("@PageSize", 15);
            dataList = PublicConn.QueryBySql<SubscribeUserInfo>(commandText, ref dyParams);
            if (dataList.Any())
               dataList.ForEach(o => o.OrderType = GetProjectTenderName(o.OrderType.ToInt(1)));

            var commandTotalText = @"select COUNT(0)
									from dbo.Subscribe S with(nolock)
									--inner join dbo.Project P on S.ProjectId=P.Id
									inner join UserBasicInfo C on S.SubscribeUserId=C.Id 
									inner join t_SubScribeTransfer as D 
									on D.m_id=S.TranId
									where s.tranid=@ProjectId";

            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", projectId);
            int count = PublicConn.QuerySingle<int>(commandTotalText, ref dyParams);


            pageCount = GetPageCount(count);
        }        
        private int GetPageCount(int recordCount)
        {
            double divide = recordCount / pageSize;
            double floor = System.Math.Floor(divide);
            if (recordCount % pageSize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数
            return pageCount;
        }
        #endregion

        #region 解析设备类型
        public static string GetWeTenderName(int deviceType)
        {
            string OrderType = "网站";
            switch (deviceType)
            {
                case 1:
                    OrderType = "网站";
                    break;
                case 2:
                    OrderType = "安卓";
                    break;
                case 3:
                    OrderType = "IOS";
                    break;
                case 4:
                    OrderType = "触屏版";
                    break;
                case 5:
                    OrderType = "微信";
                    break;
            }
            return OrderType;
        }
        public static string GetProjectTenderName(int? tenderMode)
        {
            tenderMode = tenderMode ?? 1;
            string deviceType = "网站";
            switch (tenderMode.Value) { 
                case 1:
                    deviceType = "网站";
                    break;
                case 4:
                    deviceType = "自动";
                    break;
                case 5:
                    deviceType = "智能投资";
                    break;
                case 6:
                    deviceType = "触屏版";
                    break;
                case 7:
                    deviceType = "IOS";
                    break;
                case 8:
                    deviceType = "安卓";
                    break;
                case 9:
                    deviceType = "微信";
                    break;
            }
            return deviceType;
        }

        #endregion

        public static string SubStringName(string str)
        {
            if (string.IsNullOrWhiteSpace(str))
            {
                return "*****";
            }
            if (str.Length > 12)
                return str.Substring(0, 1) + "***********";
            else
            {
                var temp = "";
                for (int i = 0; i < str.Length; i++)
                {
                    temp += "*";
                }
                return str.Substring(0, 1) + temp;
            }
        }

        public static string SubStringTelNo(string telNo)
        {
            if (string.IsNullOrWhiteSpace(telNo) || telNo.Length < 11)
            {
                return "1**";
            }
            else
            {
                return "**" + telNo.Substring(7, 4);
            }
        }

        #region 内部Model
        public class SubscribeUserInfo
        {
            /// <summary>
            /// 用户名
            /// </summary>
            public string UserName { get; set; }
            /// <summary>
            /// 用户昵称
            /// </summary>
            public string NickName { get; set; }
            /// <summary>
            /// 订购金额
            /// </summary>
            public decimal Amount { get; set; }
            /// <summary>
            /// 订单时间
            /// </summary>
            public DateTime? OrderDate { get; set; }
            /// <summary>
            /// 申购类型(投标设备)
            /// </summary>
            public string OrderType { get; set; }
            /// <summary>
            /// 是否自动投标
            /// </summary>
            public bool IsAuto { get; set; }
        }
        #endregion

    }
}