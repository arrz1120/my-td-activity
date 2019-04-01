using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXSystem.Core.Common;

namespace TuanDai.WXApiWeb.Member.jiaxitequan.html
{
    public partial class jiaxitequan : UserPage
    {
        protected List<FifthTDLoveAPPListData> List;
        protected decimal totalRate=0;
        protected void Page_Load(object sender, EventArgs e)
        {
            List =
                new TuanDai.WXSystem.Core.Common.Activity20171218Helper().GetRateListByUserId(
                    WebUserAuth.UserId.ToString());
            if (List != null && List.Any())
                totalRate = List.Sum(o => o.RedRate);
        }
    }
}