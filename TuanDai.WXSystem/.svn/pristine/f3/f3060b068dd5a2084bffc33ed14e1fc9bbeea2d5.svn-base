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
using System.IO;
using Dapper;

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class jiaxiquan : UserPage
    {
        private int pagesize = 10;
        private int totalItemCount = 0;
        Guid UserId = WebUserAuth.UserId.Value;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect(GlobalUtils.WebURL + "/Member/UserPrize/jiaxiquan.aspx");
        }
    }
    /// <summary>
    /// 加息券实体
    /// </summary>
    public class RateCoupon
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
        /// 团宝箱名称
        /// </summary>
        public string PrizeName;
        /// <summary>
        /// 描述
        /// </summary>
        public string Description;
        /// <summary>
        /// 来源
        /// </summary>
        public string SourceFrom;
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
        /// 是否使用 为了json转换
        /// </summary>
        public bool isReceive { get; set; }

        private int? isreceive;
        /// <summary>
        /// 是否接收
        /// </summary>
        public int? IsReceive
        {
            get { return isreceive ?? (isReceive ? 1 : 0); }
            set { isreceive = value; }
        }

        /// <summary>
        /// 价值
        /// </summary>
        public decimal PrizeValue;
        public DateTime? ReceiveEndDate { get; set; }
        /// <summary>
        /// 过期时间
        /// </summary>
        public DateTime? ExpirationDate { get; set; }
        public DateTime? ReceiveDate { get; set; }

        public DateTime CreateDate { get; set; }
    }
}