﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;
using Tool;

namespace TuanDai.WXApiWeb
{
    /// <summary>
    /// 用于关注服务号后推送消息
    /// Allen 2016-08-27
    /// </summary>
    public partial class WXMessage : System.Web.UI.Page
    {
        protected int IsInWeiXin = 0; 
        protected void Page_Load(object sender, EventArgs e)
        {

            IsInWeiXin = GlobalUtils.IsWeiXinBrowser ? 1 : 0; 
            try
            {
                string postString = string.Empty;
                string action = Tool.WEBRequest.GetQueryString("action").ToLower();

               string strValidatePass = Tool.WEBRequest.GetQueryString("validatePass");
               if (strValidatePass == "tuandaiisgood")
               {
                   string openId = WEBRequest.GetQueryString("openid");
                   if (openId.IsEmpty()) {
                       openId = GlobalUtils.OpenId;
                   }
                   string weburl = GlobalUtils.MTuanDaiURL;
                   if (action == "newhand")
                   {
                       List<WeiXinApi.PicTextArticleItemInfo> newsList = new List<WeiXinApi.PicTextArticleItemInfo>();
                       newsList.Add(new WeiXinApi.PicTextArticleItemInfo { title = "新手福利-518红包，体验金等好礼", description = "新手福利-518红包，体验金等好礼", picurl = weburl + "/imgs/push/banner_newhand.png?v=20160831003", url = "https://mvip.tdw.cn/pages/invest/invest_newHand.aspx" });
                       newsList.Add(new WeiXinApi.PicTextArticleItemInfo { title = "平台的安全保障", description = "平台的安全保障", picurl = weburl + "/imgs/push/icon_safety.png?v=20160831003", url = "http://info.tdw.cn/wap/help/second-question.html?cid=20" });
                       newsList.Add(new WeiXinApi.PicTextArticleItemInfo { title = "如何投资", description = "如何投资", picurl = weburl + "/imgs/push/icon_invest.png?v=20160831003", url = "http://info.tdw.cn/wap/help/second-question.html?cid=15" });
                       newsList.Add(new WeiXinApi.PicTextArticleItemInfo { title = "关于提现和管理费", description = "关于提现和管理费", picurl = weburl + "/imgs/push/icon_withdraw.png?v=20160831003", url = "http://info.tdw.cn/wap/help/second-question.html?cid=16" });
                       WeiXinApi.SendPicTextMessageToUser(openId, newsList);
                   }
                   else if (action == "hotrecommend") {
                       List<WeiXinApi.PicTextArticleItemInfo> newsList = new List<WeiXinApi.PicTextArticleItemInfo>();
                       newsList.Add(new WeiXinApi.PicTextArticleItemInfo { title = "智能投标-We计划", description = "智能投标-We计划", picurl = weburl + "/imgs/push/banner_we.png?v=20160831003", url = weburl + "/pages/invest/WE/WE_list.aspx" });
                       newsList.Add(new WeiXinApi.PicTextArticleItemInfo { title = "邀请有礼", description = "邀请有礼", picurl = weburl + "/imgs/push/icon_gift.png?v=20160831003", url = "https://hd.tdw.cn/weixin/Invite/InviteIndex.aspx" });
                       WeiXinApi.SendPicTextMessageToUser(openId, newsList);
                   }
               }
            }
            catch (Exception ex) {
                SysLogHelper.WriteErrorLog("微信关注推送图文消息失败", "错误详细信息：" + ex.Message + "|" + ex.StackTrace); 
            }
        }
    }
}