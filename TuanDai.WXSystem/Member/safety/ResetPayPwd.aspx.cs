using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TuanDai.WXApiWeb.Member.safety
{
    /// <summary>
    /// 忘记交易密码
    /// </summary>
    public partial class ResetPayPwd : BasePage
    {
        public string TelNo = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid? userId = WebUserAuth.UserId;
            if (userId != Guid.Empty && userId != null)
            {
                TuanDai.PortalSystem.BLL.UserBLL bll = new TuanDai.PortalSystem.BLL.UserBLL();
                var userInfo = bll.GetUserBasicInfoModelById(userId.Value);
                if (userInfo.IsValidateMobile)
                    TelNo = userInfo.TelNo;
                else
                    Response.Redirect("/Member/my_account.aspx");
            }
            else
            {
                Response.Redirect("/user/Login.aspx");
            }
        }
    }
}