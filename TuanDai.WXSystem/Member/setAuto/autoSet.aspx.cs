using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Member.setAuto
{
    public partial class autoSet : UserPage
    {
        protected string perAmountLimit;
        protected string type;
        protected string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            perAmountLimit = WEBRequest.GetString("perAmountLimit", "");
            type = WEBRequest.GetString("type", "");
            id = WEBRequest.GetString("id", "");
        }
    }
}