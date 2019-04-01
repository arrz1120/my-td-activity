using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class binding_card_suc :UserPage
    {
        protected UserBasicInfoInfo userModel;
        protected Guid userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            userId = WebUserAuth.UserId.Value;
            userModel = new UserBLL().GetUserBasicInfoModelById(userId);
        }
    }
}