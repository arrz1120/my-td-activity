using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Activity
{
    public partial class FinanceDrawActivity :Page
    {
        protected string userName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Guid? userId = WebUserAuth.UserId;
                if (userId == Guid.Empty)
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Activity/20150613/DrawGuid.aspx?ReturnUrl=" + HttpContext.Current.Request.RawUrl);
                }
                else
                {
                    UserBasicInfoInfo userInfo = new UserBLL().GetUserBasicInfoModelById(userId.Value);
                    userName = userInfo.UserName;
                }
            }
        }
    }
}