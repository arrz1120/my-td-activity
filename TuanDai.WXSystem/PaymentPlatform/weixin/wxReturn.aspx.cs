using Dapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.PaymentPlatform.weixin
{
    /// <summary>
    /// 微信支付处理成功客户端显示页
    /// Allen 2015-1216
    /// </summary>
    public partial class wxReturn : TuanDai.WXApiWeb.BasePage
    {
        protected string GoReturnUrl = "/Member/my_account.aspx";
        protected void Page_Load(object sender, EventArgs e)
        {
            string cookieUrl = Tool.CookieHelper.GetCookie("InvestUrl").ToText();
            if (cookieUrl.Trim().IsNotEmpty())
            {
                GoReturnUrl = cookieUrl;
                Tool.CookieHelper.ClearCookie("InvestUrl");
            }
            if (TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated)
            {
             
                Guid userid = TuanDai.WXApiWeb.WebUserAuth.UserId.Value; 

                string strSQL = "select count(1) from AccountRechare with(nolock) where UserId=@userId and Status=2 and [type] in(9)";
                DynamicParameters dyParams = new DynamicParameters();
                dyParams.Add("@userId", userid);
                int iCount = PublicConn.QuerySingleWrite<int>(strSQL, ref dyParams);
                if (iCount > 0)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.FirstReCharge, null, 0);
                } 
            }
        }
    }
}