using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.CunGuanTong.Model;
using TuanDai.CunGuanTong.Client;
using System.Collections;

namespace TuanDai.WXApiWeb.user.user
{
    public partial class seccessful : BasePage
    {               
        public string returnUrl { get; set; }
        protected string extenderkey { get; set; }//推广人Key

        public string operType = string.Empty;

        protected override void OnInitComplete(EventArgs e)
        {
            base.OnInitComplete(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {           
            SortedList table = Cgt_WebPost.Param(Request.InputStream);
            var Result = 0;
            if (table == null)
                return;
            operType = table["serviceName"].ToString();
            switch (table["serviceName"].ToString())
            {
                case "USER_AUTHORIZATION":
                    {
                        USER_AUTHORIZATION_Response dataJson = null;
                        string ErrorMessage = "";
                        Result = UserClient.USER_AUTHORIZATION_Res(table, ref dataJson, ref ErrorMessage);
                        break;
                    }
                default:
                    break;
            }

            this.returnUrl = WEBRequest.GetString("ReturnUrl");
            this.extenderkey = WEBRequest.GetString("extendkey");
            if (this.returnUrl.IsNotEmpty()) {
                string isEncry = WEBRequest.GetString("isencry");
                if (isEncry == "1") {
                    this.returnUrl = BasePage.GetDecodeBackUrl(this.returnUrl);
                }
            }
            if (!IsPostBack)
            {
                string IsSaveData = WEBRequest.GetString("issave");
                this.IsShowRightBar = false;

                if (IsSaveData.ToText() == "1")
                {
                    //记录帐户
                    string openId=WEBRequest.GetString("openid");
                    GlobalUtils.WriteOpenIdToCookie(openId); 
                }
                //从微信菜单中点击“登录注册”后判断 Allen 2015-06-30
                if (WEBRequest.GetString("ischecklogin") == "1") {
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