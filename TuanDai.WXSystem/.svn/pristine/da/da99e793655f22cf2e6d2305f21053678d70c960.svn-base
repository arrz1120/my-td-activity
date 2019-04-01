using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.pages.aboutus
{
    public partial class InternetInfo : BasePage
    {
        public bool IsApp = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            //移动APP端屏蔽功能按钮
            if (Tool.WEBRequest.GetQueryString("type").ToLower() == "mobileapp")
            {
                this.IsShowRightBar = false;
                IsApp = true;
            }
        }
    }
}