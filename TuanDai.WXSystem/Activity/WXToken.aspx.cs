﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXApiWeb.Common;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.Activity
{
    public partial class WXToken : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "text/plain";
            string code = WEBRequest.GetQueryString("code");
            string requestUrl = WEBRequest.GetQueryString("url");

            WeiXinApi jssdk = new WeiXinApi();
            jssdk.InitApi();
            jssdk.WXCode = code;
            jssdk.RequestURL = requestUrl;
            System.Collections.Hashtable hs = jssdk.getSignPackage();
            WeiXinSignInfo signInfo = new WeiXinSignInfo();
            signInfo.appid = hs["appId"].ToString();
            signInfo.nonceStr = hs["nonceStr"].ToString();
            signInfo.timeStamp = hs["timestamp"].ToInt(0);
            signInfo.signature = hs["signature"].ToString();
            string callBackFunc = WEBRequest.GetQueryString("callback");
            if (callBackFunc.IsNotEmpty())
            {
                string jsonStr = callBackFunc + "(" + JsonHelper.ToJson(signInfo) + ");";
                Response.Write(jsonStr);
            }
            else
            {
                string jsonStr = JsonHelper.ToJson(signInfo);
                Response.Write(jsonStr);
            }
            Response.End();
        }

        public class WeiXinSignInfo
        {
            public string appid { get; set; }
            public int timeStamp { get; set; }
            public string nonceStr { get; set; }
            public string signature { get; set; }
        } 


    }
}