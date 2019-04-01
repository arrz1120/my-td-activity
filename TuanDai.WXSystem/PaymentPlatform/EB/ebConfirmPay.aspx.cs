using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;

namespace TuanDai.WXApiWeb.PaymentPlatform.EB
{
    public partial class ebConfirmPay : UserPage
    {
        public UserBasicInfoInfo model = null;
        protected string IsBindCard = "0";
        protected string OrderId { get; set; }
        protected string RequestId { get; set; }
        protected string Amount { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            IsBindCard = WEBRequest.GetQueryString("isbind");
            OrderId = WEBRequest.GetQueryString("OrderId");
            RequestId = WEBRequest.GetQueryString("RequestId");
            Amount = WEBRequest.GetQueryString("amount");
            Guid userId = WebUserAuth.UserId.Value;
            if (userId != null)
            {
                model = new UserBLL().GetUserBasicInfoModelById(userId);
            }
            else
            {
                Response.Redirect("/user/Login.aspx");
            } 
        }
    }
}