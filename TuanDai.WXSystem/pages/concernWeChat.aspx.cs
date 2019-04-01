using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.pages
{
    public partial class concernWeChat : AppActivityBasePage
    {
        protected bool isAppLink = false;//是否是app链接过来的
        protected void Page_Load(object sender, EventArgs e)
        {
            var type = Tool.WEBRequest.GetQueryString("type");
            if (type == "mobileapp")
                isAppLink = true;
        }
    }
}