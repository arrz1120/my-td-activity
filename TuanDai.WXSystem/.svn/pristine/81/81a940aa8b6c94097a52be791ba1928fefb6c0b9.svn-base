using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest.WE
{
    public partial class We_FQBTradeDetail:UserPage
    {
        protected Guid? weOrderId = Guid.Empty;
        protected WeOrderInfo model = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            weOrderId = SafeConvert.ToGuid(WEBRequest.GetQueryString("OrderId"));
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == null || userid == Guid.Empty)
            {
                Response.Redirect("/user/login.aspx?ReturnUrl=" + Request.Url.AbsolutePath);
                return;
            }

            WeOrderBLL webll = new WeOrderBLL();
            model = webll.GetWeOrderInfoById(weOrderId.Value); 
        }

    } 
}