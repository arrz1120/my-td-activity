using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.HighSpeedGame
{
    public partial class LotteryNone : System.Web.UI.Page
    {
        //微信SDK
        protected int TimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
        protected string NonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
        protected string Signature;
        protected string AppId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                WeiXinApi jssdk = new WeiXinApi();
                jssdk.InitApi();
                System.Collections.Hashtable hs = jssdk.getSignPackage();
                AppId = hs["appId"].ToString();
                NonceStr = hs["nonceStr"].ToString();
                TimeStamp = hs["timestamp"].ToInt(0);
                Signature = hs["signature"].ToString(); 
            }
        }
    }
}