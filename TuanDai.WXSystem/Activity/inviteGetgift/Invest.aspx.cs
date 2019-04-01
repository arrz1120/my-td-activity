using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL; 
namespace TuanDai.WXApiWeb.Activity.inviteGetgift
{
    public partial class Invest : BasePage
    {
        protected bool IsValidRealName = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (WebUserAuth.IsAuthenticated)
            {

                UserBasicInfoInfo model = new UserBLL().GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
                if (model != null && !string.IsNullOrEmpty(model.RealName) && model.IsValidateIdentity)
                {
                    IsValidRealName = true;
                }
            }
        }
    }
}