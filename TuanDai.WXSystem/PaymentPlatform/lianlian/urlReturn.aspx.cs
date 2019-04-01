using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessDll; 
using Tool;
using Dapper;
using TuanDai.WXApiWeb;
/// <summary>
/// 功能：支付结束后返回页面
/// </summary>
/// 

public partial class urlReturn : TuanDai.WXApiWeb.BasePage
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
        if (!IsPostBack)
        {
            if (TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated)
            {
             
                Guid userid = TuanDai.WXApiWeb.WebUserAuth.UserId.Value; 
                string strSQL = "select count(1) from AccountRechare with(nolock) where UserId=@userId and Status=2 and [type] in( 2, 3, 4, 6, 8, 12 )";
                DynamicParameters dyParams = new DynamicParameters();
                dyParams.Add("@userId", userid);
                int iCount = PublicConn.QuerySingleWrite<int>(strSQL, ref dyParams);
                if (iCount>0)
                {
                    TuanDai.PortalSystem.BLL.VipGetWorthBLL.AddGetWorth(userid, (int)ConstString.UserGrowthType.FirstReCharge, null, 0);
                }
            }
        }
    }
}