using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;
using Tool;

namespace TuanDai.WXApiWeb.Activity.HighSpeedGame
{
    /// <summary>
    /// 高铁广告游戏
    /// Allen 2015-06-12
    /// </summary>
    public partial class GameIndex : BasePage
    {
        protected ExamSubjectInfor personModel = null;
        protected ExamSubjectInfor arithModel = null;
        protected ExamSubjectInfor logoModel = null;

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


                BindData();
            }
        }
        protected void BindData() {
            personModel = GameHelper.Instance.RandomOneSubject(1);
            arithModel = GameHelper.Instance.RandomOneSubject(2);
            logoModel = GameHelper.Instance.RandomOneSubject(3);
        }
    }
}