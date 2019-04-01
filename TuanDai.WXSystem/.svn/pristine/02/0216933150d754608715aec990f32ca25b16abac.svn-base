using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 债权转让 --转让列表
    /// Allen 2016-02-22
    /// </summary>
    public partial class my_debt_transferlist : UserPage
    {

      
        protected string CurTabName { get; set; }
        protected string curPageUrl { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            CurTabName = WEBRequest.GetQueryString("tab");
            curPageUrl = BasePage.GetEncodeBackURL("/Member/Repayment/my_debt_transferlist.aspx");
            if (CurTabName == "") {
                CurTabName = "CanTran";
            } 
        }
    }
}