using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Member.withdrawal
{
    public partial class withdrawal_question : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var type = Tool.WEBRequest.GetQueryString("type");
            if (type == "mobileapp")
            {
                IsShowRightBar = false;
            }
        }
    }
}