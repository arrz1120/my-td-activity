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
    /// <summary>
    /// 高铁游戏--抽奖界面
    /// Allen 2015-06-12
    /// </summary>
    public partial class LotteryDraw : BasePage
    {
        protected bool IsLogin = false;
        protected string returnUrl = "";
        protected int StarNum = 0;

        //微信SDK
        protected int TimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
        protected string NonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
        protected string Signature;
        protected string AppId;

        protected void Page_Load(object sender, EventArgs e)
        {
          
            StarNum = WEBRequest.GetFormInt("jsondata", 0);
            if (WEBRequest.GetFormString("jsondata") == "")
            {
                StarNum = WEBRequest.GetQueryInt("StarNum", 0);
            }
            returnUrl = "/Activity/HighSpeedGame/LotteryDraw.aspx?StarNum=" + StarNum;
            if (!IsPostBack) {

                WeiXinApi jssdk = new WeiXinApi();
                jssdk.InitApi();
                System.Collections.Hashtable hs = jssdk.getSignPackage();
                AppId = hs["appId"].ToString();
                NonceStr = hs["nonceStr"].ToString();
                TimeStamp = hs["timestamp"].ToInt(0);
                Signature = hs["signature"].ToString(); 

                Guid? userId = WebUserAuth.UserId;
                if (userId != null && userId.Value != Guid.Empty)
                    IsLogin = true;
                //判断答题星星数是否正确
                if (StarNum < 1 || StarNum > 3) {
                    Response.Redirect("/Activity/HighSpeedGame/GameIndex.aspx");
                }
            }
        } 
    }
}