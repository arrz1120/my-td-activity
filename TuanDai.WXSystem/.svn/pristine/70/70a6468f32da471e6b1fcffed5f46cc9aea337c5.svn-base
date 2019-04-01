using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using Tool;
using Dapper;

namespace TuanDai.WXApiWeb.PaymentPlatform.EB
{
    public partial class ebReturn : TuanDai.WXApiWeb.UserPage
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
                List<int> typeList = new List<int>() {11 };
                string strSQL = "select count(1) from AccountRechare where UserId=@userId and Status=2 and type=11";
                DynamicParameters dyParams = new DynamicParameters();
                dyParams.Add("@userId", userid);
                int iCount = PublicConn.QuerySingle<int>(strSQL,ref  dyParams);
                if (iCount > 0)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.FirstReCharge, null, 0);
                }
            }
        }
    }
}