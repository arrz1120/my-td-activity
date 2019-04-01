using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class reset_password : UserPage
    {
        protected string IsUpdatePayPwd = "0";
        protected UserBasicInfoInfo UserInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserBLL bll = new UserBLL();
                Guid userid = WebUserAuth.UserId.Value;
                UserInfo = bll.GetUserBasicInfoModelById(userid);
                if (UserInfo != null)
                {
                    if (UserInfo.Pwd != UserInfo.PayPwd)
                    {
                        IsUpdatePayPwd = "1";
                    }
                }
            }
        }
    }
}