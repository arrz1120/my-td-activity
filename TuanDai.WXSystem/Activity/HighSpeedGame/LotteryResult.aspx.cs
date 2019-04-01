using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.ajaxCross;
using Tool;
using TuanDai.WXSystem.Core;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.HighSpeedGame
{
    /// <summary>
    /// 高铁广告游戏--中奖结果
    /// Allen 2015-06-13
    /// </summary>
    public partial class LotteryResult :BasePage
    {
        protected string PrizeURL = "";
        protected GamePrizeResultInfor model = new GamePrizeResultInfor();

        //微信SDK
        protected int TimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
        protected string NonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
        protected string Signature;
        protected string AppId;

        protected void Page_Load(object sender, EventArgs e)
        {
            PrizeURL = GlobalUtils.TuanDaiURL + "/member/UserPrize/Index.aspx";
            if (!IsPostBack) {

                WeiXinApi jssdk = new WeiXinApi();
                jssdk.InitApi();
                System.Collections.Hashtable hs = jssdk.getSignPackage();
                AppId = hs["appId"].ToString();
                NonceStr = hs["nonceStr"].ToString();
                TimeStamp = hs["timestamp"].ToInt(0);
                Signature = hs["signature"].ToString(); 

                string jsonData = WEBRequest.GetFormString("jsondata");
                if (jsonData.IsNotEmpty())
                {
                    model = JsonHelper.ToObject<GamePrizeResultInfor>(jsonData);
                }
            }
        }
    }
}