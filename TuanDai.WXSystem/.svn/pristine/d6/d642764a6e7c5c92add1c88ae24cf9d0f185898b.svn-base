using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class my_debt_carry_list : UserPage
    {
        protected string CurrTab;
        protected void Page_Load(object sender, EventArgs e)
        {
            CurrTab = WEBRequest.GetQueryString("tab");
            if (CurrTab == "")
                CurrTab = "Inprogress";
        }
    }
}