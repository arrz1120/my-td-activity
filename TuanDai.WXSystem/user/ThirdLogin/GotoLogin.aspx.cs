using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXApiWeb.Common;
using TuanDai.PortalSystem.BLL;
using System.Data.SqlClient;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.user.ThirdLogin
{
    /// <summary>
    /// 第三方登录验证成功后，自动登录处理
    /// Allen 2015-07-04
    /// </summary>
    public partial class GotoLogin : BasePage
    {
        public string returnUrl { get; set; }
        //获取第三方响应后的code参数值
        protected string code { get; set; }
        private ThirdLoginSDK.ThirdLoginType LoginType = ThirdLoginSDK.ThirdLoginType.None;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.returnUrl = WEBRequest.GetQueryString("ReturnUrl");
            LoginType = ThirdLoginSDK.GetLoginType(CookieHelper.GetCookie("WXLoginType"));
            code = WEBRequest.GetQueryString("code");

            if (this.returnUrl.IsEmpty()) {
                this.returnUrl = "/Member/my_account.aspx";
            }
            ThirdLoginSDK shareSdk = new ThirdLoginSDK();
            UserBLL userbll = new UserBLL();
            //初始化SDK
            shareSdk.InitSDK(LoginType); 

            //根据code获取第三方用户信息
            ThirdLoginSDK.ThirdUserInfo mUserInfo = shareSdk.GetCacheUserInfo();
            string strUId = shareSdk.GetCacheUId();

            SqlParameter[] paramData = new SqlParameter[] { new SqlParameter("@ThirdPartyId", strUId) };
            UserBasicInfoInfo model = userbll.WXGetUserBasicInfo("ThirdPartyId=@ThirdPartyId", paramData);
            if (model != null)
            {
                //当已存在时直接登录，并跳转
                WXRegister.UserLogin(model);
                Response.Redirect(this.returnUrl);
                return;
            }
            else
            {
                //用第三登录信息注册一新帐号
                Guid userid = Guid.NewGuid();
                var userbasicEntity = WXRegister.AddUserInfo(userid, "tuandai_weixin", "", "", "", mUserInfo.NickName, mUserInfo.HeadImg, mUserInfo.UId, (int)LoginType);
                if (userbasicEntity != null)
                {
                    model = userbll.GetUserBasicInfoModelById(userid);
                    WXRegister.UserLogin(model);
                    Response.Redirect(this.returnUrl);
                    return;
                } 
            }

            Response.Redirect("/user/Login.aspx?ReturnUrl="+this.returnUrl); 
        }
        
    }
}