using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb
{
    public partial class ApplyStock : UserPage
    {
        protected decimal AviMoney;
        protected WebSettingInfo amountSet;
        protected WebSettingInfo Set;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Set = new WebSettingBLL().GetWebSettingInfo("5724A794-A380-45E8-837D-5326487E9C48");
                amountSet = new WebSettingBLL().GetWebSettingInfo("f65b7518-e60f-4cd4-b895-895e40a84609");
                Guid userid = WebUserAuth.UserId.Value;
                if (userid != Guid.Empty)
                {
                    AviMoney = new UserBLL().GetUserAviMoney(userid);
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/user/Login.aspx?ReturnUrl=" + HttpContext.Current.Request.RawUrl);
                }
            }
        }
    }
}