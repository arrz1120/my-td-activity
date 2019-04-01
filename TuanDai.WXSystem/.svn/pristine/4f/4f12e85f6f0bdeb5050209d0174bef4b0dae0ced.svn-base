using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using BusinessDll;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class binding_bannkcardconfirm :UserPage
    {
        public string province = string.Empty;
        public string account = string.Empty;
        public string cityName = string.Empty;
        public string bankName = string.Empty;
        public string bankType = string.Empty;
        public string otherBankName = string.Empty;
        public UserBasicInfoInfo model = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            Guid userId = WebUserAuth.UserId.Value;
            if (userId != null)
            {
                model = new UserBLL().GetUserBasicInfoModelById(userId);
            }
            else
            {
                Response.Redirect("/user/Login.aspx");
            }

            province = Request.QueryString["province"];
            account = Request.QueryString["account"];
            cityName = Request.QueryString["cityName"];
            bankName = Request.QueryString["bankName"];
            bankType = Request.QueryString["bankType"];
            otherBankName = Request.QueryString["otherBankName"];
            if (string.IsNullOrEmpty(account) || string.IsNullOrEmpty(bankName))
            {
                Response.Redirect("/Member/safety/binding_bannkcard.aspx");
            }
        }
    }
}