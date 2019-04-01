using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.DAL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.setAuto
{
    public partial class automatic_rules : UserPage
    {
        protected string limitPercent = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                WebSettingDAL webSettingDal = new WebSettingDAL();
                WebSettingInfo autoSetInfo = webSettingDal.GetWebSettingInfo("17191362-568A-4F46-8D7D-5C23D80C9D8B");
                if (autoSetInfo != null)
                    limitPercent = autoSetInfo.Param3Value;
            }
        }
    }
}