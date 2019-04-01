using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;
using System.Text;
using Dapper; 

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class RedPacket : UserPage
    {
        protected string type = string.Empty;
        private int pagesize = 10;
        private int totalItemCount = 0;
        UserBLL bll = new UserBLL();
        Guid UserId = WebUserAuth.UserId.Value;
        protected string ShowTitle = "红包";
        protected bool IsInvestNewUser = false;//是否投资新手
        //UserBLL bll = new UserBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            type = WEBRequest.GetString("type", "");
            //Response.Redirect(GlobalUtils.WebURL + "/Member/UserPrize/RedPacket.aspx?type="+type);
            SetPageTitle();

            if (!IsPostBack)
            {
                //判断当前用户是否投资新手
                WXFundAccountInfo accountModel = bll.GetWXFundAccountInfo(WebUserAuth.UserId.Value);
                if (accountModel != null && (accountModel.TotalInvest ?? 0) == 0)
                    IsInvestNewUser = true;
            }
        }
        protected void SetPageTitle()
        {
            if (type == "1")
            {
                ShowTitle = "现金红包";
            }
            else if (type == "2")
            {
                ShowTitle = "奖金红包";
            }
            else if (type == "3")
            {
                ShowTitle = "投资红包";
            }
            else if (type == "4")
            {
                ShowTitle = "投资抵扣券";
            }
            else if (type == "5")
            {
                ShowTitle = "加息券";
            }
            else if (type == "6")
            {
                ShowTitle = "提现券";
            }
            else if (type == "7")
            {
                ShowTitle = "签到卡";
            }
            else if (type == "8")
            {
                ShowTitle = "精美礼品";
            }
            else if (type == "9")
            {
                ShowTitle = "投资体验金";
            }
        }
    }

    /// <summary>
    /// 团宝箱详细(当前页面内部使用)
    /// </summary>
    public class WXUserPrizeListInfoNB
    {
        /// <summary>
        /// ID
        /// </summary>
        public Guid Id { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public Guid UserId { get; set; }
        /// <summary>
        /// 类型
        /// </summary>
        public int TypeId { get; set; }
        /// <summary>
        /// 子类型
        /// </summary>
        public int? SubTypeId { get; set; }
        /// <summary>
        /// 活动编号
        /// </summary>
        public string ActivityCode { get; set; }
        /// <summary>
        /// 名称
        /// </summary>
        public string PrizeName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Guid? TargetProductId { get; set; }
        /// <summary>
        /// 奖励值
        /// </summary>
        public decimal PrizeValue { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 是否领取
        /// </summary>
        public bool IsReceive { get; set; }
        /// <summary>
        /// 领取日期
        /// </summary>
        public DateTime? ReceiveDate { get; set; }
        /// <summary>
        /// 是否使用 为了json转换
        /// </summary>
        public bool isUsed { get; set; }

        private int? isused;
        /// <summary>
        /// 用于页面赋值 0:未使用 1:已使用  2:已过期
        /// </summary>
        public int? IsUsed
        {
            get { return isused ?? (isUsed ? 1 : 0); }
            set { isused = value; }
        }
        /// <summary>
        /// 使用日期
        /// </summary>
        public DateTime? UseDate { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateUser { get; set; }
        /// <summary>
        /// 创建日期
        /// </summary>
        public DateTime CreateDate { get; set; }
        /// <summary>
        /// 过期时间(未用)
        /// </summary>
        public DateTime? ExpirationDate { get; set; }
        /// <summary>
        ///来源哪个活动
        /// </summary>
        public string SourceFrom { get; set; }
        /// <summary>
        /// 领取开始时间
        /// </summary>
        public DateTime? ReceiveBeginDate { get; set; }
        /// <summary>
        /// 领取过期时间
        /// </summary>
        public DateTime? ReceiveEndDate { get; set; }
        /// <summary>
        /// 使用开始时间
        /// </summary>
        public DateTime? UseBeginDate { get; set; }
        /// <summary>
        /// 活动规则ID
        /// </summary>
        public Guid? RuleId { get; set; }
        /// <summary>
        /// 领取方式(0-pc,1-移动端,2-触屏版)
        /// </summary>
        public int? ReceiveType { get; set; }
        /// <summary>
        /// 需投资额
        /// </summary>
        public decimal? InvestMoney { get; set; }
    }
}