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
    /// 答题结果页面
    /// Allen 2015-06-12
    /// </summary>
    public partial class ExamResult : BasePage
    {
        protected int RightNum { get; set; }
        //微信SDK
        protected int TimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
        protected string NonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
        protected string Signature;
        protected string AppId;

        protected void Page_Load(object sender, EventArgs e)
        {
            RightNum = Tool.WEBRequest.GetFormInt("jsondata", 0);
            if (!IsPostBack)
            {
                WeiXinApi jssdk = new WeiXinApi();
                jssdk.InitApi();
                System.Collections.Hashtable hs = jssdk.getSignPackage();
                AppId = hs["appId"].ToString();
                NonceStr = hs["nonceStr"].ToString();
                TimeStamp = hs["timestamp"].ToInt(0);
                Signature = hs["signature"].ToString(); 

                //判断答题星星数是否正确
                if (RightNum < 0 || RightNum > 3)
                {
                    Response.Redirect("/Activity/HighSpeedGame/GameIndex.aspx");
                }
            }
        }
    }
}