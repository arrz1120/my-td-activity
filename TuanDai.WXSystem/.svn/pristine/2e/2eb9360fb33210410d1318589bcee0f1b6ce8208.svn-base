using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.ThreeYearCeleb
{
    /// <summary>
    /// 三周年庆典活动首页入口
    /// Allen  2015-07-07
    /// </summary>
    public partial class GuidePage : BasePage
    {
        protected string code { get; set; }
        protected string ExtendKey { get; set; }
        protected string HostOpenId { get; set; }
        protected int IsLogin { get; set; }

        //微信SDK
        protected int TimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
        protected string NonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
        protected string Signature;
        protected string AppId;
        protected void Page_Load(object sender, EventArgs e)
        {
            code = WEBRequest.GetQueryString("code");
            ExtendKey = WEBRequest.GetQueryString("ExtendKey");
            IsLogin = WebUserAuth.IsAuthenticated ? 1 : 0;


            if (!IsPostBack)
            {
                WeiXinApi jssdk = new WeiXinApi();
                jssdk.InitApi();
                System.Collections.Hashtable hs = jssdk.getSignPackage();
                AppId = hs["appId"].ToString();
                NonceStr = hs["nonceStr"].ToString();
                TimeStamp = hs["timestamp"].ToInt(0);
                Signature = hs["signature"].ToString();  
            }
            ThirdLoginSDK sdkApi = new ThirdLoginSDK();
            sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            HostOpenId = sdkApi.GetCookieOpenId(code);

            if (!IsPostBack)
            {
                //判断有没帮好友做过，假如有为好友过时，则显示出自已领蛋糕的界面。 Allen 2015-07-13
                if (ExtendKey.IsNotEmpty())
                {
                    //帮好友做蛋糕
                    bool isDoCake = AjaxHandler.CheckUserHasDoCake(ExtendKey, HostOpenId);
                    if (isDoCake)
                    {
                        ExtendKey = "";//清空推广人
                    }
                }
            }
        } 
    }
}