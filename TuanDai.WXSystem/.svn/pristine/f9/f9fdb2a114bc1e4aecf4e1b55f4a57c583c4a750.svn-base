using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class myzx_borrow_list : UserPage
    {
        protected string CurTabName { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            CurTabName = WEBRequest.GetQueryString("tab");
            if (string.IsNullOrEmpty(CurTabName))
            {
                CurTabName = "Traning";
            }
        }
    }
}