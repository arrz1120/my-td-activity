using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.user.user
{
    public partial class change_msg : BasePage
    {

        public string returnUrl { get; set; }
        protected string extenderkey { get; set; }//推广人Key
        protected string telno { get; set; }

        protected TuanDai.PortalSystem.Model.UserBasicInfoInfo userMode { get; set; }

        protected override void OnInitComplete(EventArgs e)
        {
            base.OnInitComplete(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {           
            this.returnUrl = WEBRequest.GetString("ReturnUrl");
            this.extenderkey = WEBRequest.GetString("extendkey");
            this.telno = WEBRequest.GetServerString("telno");

            if (this.returnUrl.IsNotEmpty())
            {
                string isEncry = WEBRequest.GetString("isencry");
                if (isEncry == "1")
                {
                    this.returnUrl = BasePage.GetDecodeBackUrl(this.returnUrl);
                }
            }
            if (!IsPostBack)
            {
                string IsSaveData = WEBRequest.GetString("issave");
                this.IsShowRightBar = false;

                if (WebUserAuth.UserId != null)
                {
                    userMode = new TuanDai.PortalSystem.BLL.UserBLL().GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
                }

                if (IsSaveData.ToText() == "1")
                {
                    //记录帐户
                    string openId = WEBRequest.GetString("openid");
                    GlobalUtils.WriteOpenIdToCookie(openId);
                }
                //从微信菜单中点击“登录注册”后判断 Allen 2015-06-30
                if (WEBRequest.GetString("ischecklogin") == "1")
                {
                    bool isLogin = WebUserAuth.IsAuthenticated;
                    if (isLogin)
                        Response.Redirect("/Member/my_account.aspx");
                    else
                    {
                        this.returnUrl = "/Member/my_account.aspx";
                    }
                }
            }
        }
    }
}