using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXApiWeb.Common;
using System.Data.SqlClient;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.user.ThirdLogin
{
    /// <summary>
    /// 第三方登录授权成功页
    /// Allen 2015-07-04
    /// </summary>
    public partial class AuthorizeSuccess : BasePage
    {
        public string returnUrl { get; set; }
        //获取第三方响应后的code参数值
        protected string code { get; set; }
        protected string LoginType = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            this.returnUrl = WEBRequest.GetQueryString("ReturnUrl");
            LoginType = CookieHelper.GetCookie("WXLoginType");
            code = WEBRequest.GetQueryString("code");
            //微信登录时从cookie中没法取到
            if (LoginType.ToText().IsEmpty())
            {
                LoginType = WEBRequest.GetQueryString("state");
                CookieHelper.WriteCookie("WXLoginType", LoginType);
            }

            if (returnUrl.ToText().IsEmpty())
            {
                returnUrl = "/Member/my_account.aspx";
            }
            if (code.ToText() == "")
            {
                //授权失败时返回到登录框
                Response.Redirect("/user/Login.aspx?ReturnUrl=" + returnUrl);
                return;
            }

            //判断当前第三方帐号是否有绑定过，若有绑定过直接登录。
            ThirdLoginSDK shareSdk = new ThirdLoginSDK();
            shareSdk.InitSDK(ThirdLoginSDK.GetLoginType(LoginType.ToString()));
            //根据code获取第三方用户信息
            ThirdLoginSDK.ThirdUserInfo mUserInfo = shareSdk.GetUserSampleInfo(code);

            if (LoginType.ToInt(0) == (int)ThirdLoginSDK.ThirdLoginType.QQ)
            {
                CookieHelper.WriteCookie("OpenId", Tool.Cryptography.TripleDESEncrypt(mUserInfo.UId));
            }
            else if (LoginType.ToInt(0) == (int)ThirdLoginSDK.ThirdLoginType.Sina)
            {
                CookieHelper.WriteCookie("weiboUserId", mUserInfo.UId);
            }
            else if (LoginType.ToInt(0) == (int)ThirdLoginSDK.ThirdLoginType.WeiXin)
            {
                CookieHelper.WriteCookie("weixinUserId", mUserInfo.UId);
            }
            CookieHelper.WriteCookie("ThirdLoginUserInfo", JsonHelper.ToJson(mUserInfo));

            UserBLL userbll = new UserBLL();
            SqlParameter[] paramData = new SqlParameter[] { new SqlParameter("@ThirdPartyId", mUserInfo.UId) };
            UserBasicInfoInfo model = userbll.WXGetUserBasicInfo("ThirdPartyId=@ThirdPartyId", paramData);
            if (model != null) { 
               //先前已绑定过，就直接登录
                WXRegister.UserLogin(model);
                Response.Redirect(this.returnUrl);
                return;
            } 
        }

        //输出脚本
        protected void ShowMessage(string responseJS)
        {
            this.ClientScript.RegisterStartupScript(this.GetType(), "message", "<script language=\"javascript\" defer>" + responseJS + "</script>");
        }
    }
}