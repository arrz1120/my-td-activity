using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member
{
    public partial class yesterdayIncome : UserPage
    {
        protected decimal YesterdayIncome = 0;
        protected SimpleAccount sa ;
        protected UserBasicInfoInfo ubi;
        protected ShowModel model;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetData();
        }
        /// <summary>
        /// 获取昨日收益及待收冠军
        /// </summary>
        private void GetData()
        {
            var value = TuanDai.PortalSystem.Redis.mRedis.GetYesterdayIncome(WebUserAuth.UserId.Value);
            if (value != null && value.HasValue)
            {
                YesterdayIncome = value.Value;
            }
            else
            {
                YesterdayIncome = new UserYesterdayIncomeBLL().GetYesterdayIncome(WebUserAuth.UserId.Value);
            }

            string isql = "select DueComeInterest,UserId from FundAccountInfo with(nolock) where userid='4B18182D-EA61-4A9C-9DCE-1CEC86C12213'";
            var par = new Dapper.DynamicParameters();
            sa = PublicConn.QuerySingle<SimpleAccount>(isql, ref par);

            if(sa != null)
                ubi = new UserBLL().GetUserBasicInfoModelById(sa.UserId);
            else
            {
                sa = new SimpleAccount();
                ubi = new UserBasicInfoInfo();
            }

            if (model == null)
                model = GetWeModel();
            if (model == null)
                model = GetModel();
        }

        protected string SubStringTelNo(string telNo)
        {
            if (string.IsNullOrWhiteSpace(telNo))
            {
                return "1**";
            }
            else
            {
                return "**" + telNo.Substring(7, 4);
            }
        }
        /// <summary>
        /// We计划
        /// </summary>
        /// <returns></returns>
        private ShowModel GetWeModel()
        {
            var para = new Dapper.DynamicParameters();
            string sql = string.Empty;
            //We计划
            sql = @"SELECT TOP 1 wp.Id, wp.ProductName,wp.IsWeFQB,isnull(wp.IsFTB,0) as IsFTB, wp.YearRate,wp.Deadline,wp.PlanAmount AS Amount,
                        wpd.RealOrderQty AS CastedShares,LowerUnit,wpd.TotalQty AS TotalShares,wpd.OrderCount,isnull(wp.TuandaiRedRate,0) as TuandaiRedRate,
                        isnull(wp.DeadType,1) as DeadType
                    FROM dbo.We_Product wp WITH(NOLOCK) 
                    INNER JOIN dbo.We_ProductDetail wpd WITH(NOLOCK) ON wp.Id = wpd.ProductId 
                    INNER JOIN dbo.We_ProductType wpt WITH(NOLOCK) ON wp.ProductTypeId = wpt.Id 
                    WHERE wp.StartDate<=getdate() and  wp.StatusId=1 and isnull(wp.IsNewHand,0)!=1 and  wpd.TotalQty > wpd.RealOrderQty  AND wpt.TypeWord NOT IN('D','E','F','R','Q','P','X','Y7','Z7'{0}) 
                    ORDER BY case when wp.IsFTB=1 then 0 else 1 end, YearRate DESC";
            var isOpenFTB = ConfigHelper.getConfigString("IsOpenFTB", "0");
            if (isOpenFTB == "0")
            {
                sql = string.Format(sql, ",'18','24'");
            }
            else
            {
                sql = string.Format(sql, "");
            }
            ShowModel model = PublicConn.QuerySingle<ShowModel>(sql, ref para);
            if (model != null)
            {
                model.ProductName = model.ProductName.GetCharLeft("(");

                if (model.IsWeFQB)
                    model.DetailUrl = "/pages/invest/WE/WeFqb_detail.aspx?id=" + model.Id;
                else if (model.IsFTB)
                    model.DetailUrl = "/pages/invest/WE/WeFtb_detail.aspx?id=" + model.Id;
                else
                    model.DetailUrl = "/pages/invest/WE/WE_detail.aspx?id=" + model.Id;
            }
            return model;
        }
        /// <summary>
        /// 普通标
        /// </summary>
        /// <returns></returns>
        private ShowModel GetModel()
        {
            var para = new Dapper.DynamicParameters();
            string sql = string.Empty;
            //普通标
            sql = @"select top 1 Id,0 AS IsWeFQB,InterestRate AS YearRate,Deadline,DeadType,Amount,CastedShares,LowerUnit,TotalShares,Type as TypeId from project with(nolock) where IsNewHand!=1 and type != 15  AND AddDate>dateadd(day,-15,getdate()) and Status =2 order by InterestRate desc";
            ShowModel model = PublicConn.QuerySingle<ShowModel>(sql, ref para);
            if (model != null)
            {
                model.ProductName = invest_list.GetTypeName(model.TypeId, 1);
                model.DetailUrl = "/pages/invest/detail.aspx?id=" + model.Id;
                model.OrderCount = CommUtils.GetSubscribeUserCount(model.Id);
            }

            return model;
        }
        public string GetYearRate(decimal rate)
        {
            string formatStr = "<span class='f22px c-f77b00'>{0}</span>{1}%";
            string yearRate = "";
            yearRate += ToolStatus.DeleteZero(rate);
            if (yearRate.IndexOf(".") > -1)
            {
                return string.Format(formatStr, CommUtils.GetFloatDivideStr(decimal.Parse(yearRate), 1), CommUtils.GetFloatDivideStr(decimal.Parse(yearRate), 2));
            }
            else
            {
                return string.Format(formatStr, yearRate,"");
            }
        }
        protected class SimpleAccount
        {
            public decimal DueComeInterest { get; set; }

            public Guid UserId { get; set; }
        }
        #region 实体对象
        /// <summary>
        /// 首页推荐标实体
        /// </summary>
        protected class ShowModel
        {
            /// <summary>
            /// 产品名称
            /// </summary>
            public string ProductName { get; set; }
            /// <summary>
            /// 是否分期宝
            /// </summary>
            public bool IsWeFQB { get; set; }
            /// <summary>
            /// 年化利率
            /// </summary>
            public decimal YearRate { get; set; }
            /// <summary>
            /// 期限
            /// </summary>
            public int Deadline { get; set; }
            /// <summary>
            /// 期限类型1月2天
            /// </summary>
            public int DeadType { get; set; }
            /// <summary>
            /// 总金额
            /// </summary>
            public decimal Amount { get; set; }
            /// <summary>
            /// 已投资份数
            /// </summary>
            public int CastedShares { get; set; }
            /// <summary>
            /// 投资单位
            /// </summary>
            public decimal LowerUnit { get; set; }
            /// <summary>
            /// 详情链接
            /// </summary>
            public string DetailUrl { get; set; }
            /// <summary>
            /// 总份数
            /// </summary>
            public int TotalShares { get; set; }
            /// <summary>
            /// 已加入人数
            /// </summary>
            public int OrderCount { get; set; }

            public Guid Id { get; set; }

            public int TypeId { get; set; }
            public bool IsFTB { get; set; }
            /// <summary>
            /// 团贷加息利率
            /// </summary>
            public decimal TuandaiRedRate { get; set; }
        }
        #endregion
    }
}