using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class my_take : UserPage
    {
        protected Guid UserId;
        protected UserBasicInfoInfo userModel;
        protected void Page_Load(object sender, EventArgs e)
        {
            UserId = WebUserAuth.UserId.Value;
            if (!this.IsPostBack)
            {
                userModel = new UserBLL().GetUserBasicInfoModelById(UserId);
            }
        }
    }
}