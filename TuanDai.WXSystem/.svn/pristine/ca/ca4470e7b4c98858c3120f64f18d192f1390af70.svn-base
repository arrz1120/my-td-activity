using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.Minions
{
    public partial class MinionsPage : System.Web.UI.Page
    {
        protected string HeadImg = "";
        protected string NickName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string code = Tool.WEBRequest.GetQueryString("code");
            ThirdLoginSDK sdk = new ThirdLoginSDK();
            sdk.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            //获取微信上用户信息
            TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuthUser wxUserInfo = sdk.GetWXUserSubscribeInfor(code);
            if (wxUserInfo != null)
            {
                HeadImg = wxUserInfo.headimgurl;
                NickName = wxUserInfo.nickname;
            }
            else {
                HeadImg = "images/tx1.png";
                NickName = "我是团粉";
            }
        }
    }
}