using System;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class mobile_change : BasePage
    {
        protected string TelNo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
                return;
                //Response.Redirect(GlobalUtils.WebURL + "/Member/safety/mobile_change.aspx");
                UserBLL bll = new UserBLL();
                var userModel = bll.GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
                if (userModel == null)
                {
                    Response.Redirect("~/Member/my_account.aspx");
                    return;
                }
                TelNo = BusinessDll.StringHandler.MaskTelNo(userModel.TelNo);
                if (string.IsNullOrEmpty(TelNo))
                {
                    Response.Redirect("~/Member/safety/BindMobile.aspx");
                }
            }
        }
    }
}