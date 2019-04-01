<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prize.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.Minions2.Prize" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="HandheldFriendly" content="true">
    <title>小黄人电影抢票活动</title>
    <link rel="stylesheet" type="text/css" href="./css/lottery.css?v=20151009001">
    <script src="./scripts/lib/zepto-1.1.6.min.js"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="/scripts/weixinapi.js?v=4.1"></script>

    <script type="text/javascript">
        wxData.jsticketurl = "<%= GlobalUtils.WebURL %>";
        wxData.isWxJsSDK = true;
        wxData.debug = false;
        wxData.url = "<%= GlobalUtils.WebURL %>/Activity/Minions2/Index.aspx";
        wxData.title = "小黄人想见你，约么？";
        wxData.desc = "banana！小黄人带来一大波电影折扣券，今天你抢了吗？";
        wxData.img_url = "<%= GlobalUtils.WebURL %>/Activity/Minions2/images/pic/share.png";
        wxData.ShareCallBack = function (ex) { }
    </script>
    <script type="text/javascript">
        //动态算rem
        (function (doc, win) {
            var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    // if (docEl.style.fontSize) return;
                    clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 20 * (clientWidth / 320) + 'px';
                    if (document.body) {
                        document.body.style.fontSize = docEl.style.fontSize;
                    }
                };
            recalc();
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
    </script>
</head>
<body>
    <div class="content">
        <div class="sprite-icon-top"></div>
        <div class="sprite-icon-lottery-bg lot-bg">
            <div class="sprite-icon-handle icon-handle "></div>
            <div class="minions minion-left">
                <div class="sprite-icon-minion-1 "></div>
                <div class="sprite-icon-minion-2 "></div>
                <div class="sprite-icon-minion-3 "></div>
            </div>
            <div class="minions minion-middle">
                <div class="sprite-icon-minion-1 "></div>
                <div class="sprite-icon-minion-2 "></div>
                <div class="sprite-icon-minion-3 "></div>
            </div>
            <div class="minions minion-right">
                <div class="sprite-icon-minion-1 "></div>
                <div class="sprite-icon-minion-2 "></div>
                <div class="sprite-icon-minion-3 "></div>
            </div>
           <%-- <div class="sprite-icon-button-5 button-5"></div>--%>
            <div class="button-5"><img src="images/pic/btn-grey.png" /></div>
            <div class="scroll-title">
                <div>中奖用户</div>
                <div>奖品</div>
            </div>
            <div class="scroll-content">
                <div class="wrap <%= this.awards.Count > 3 ? "anit": "" %>">
                    <% foreach (var award in this.awards)
                       { %>
                    <div class='scroll-row'>
                        <div><%= award.NickName %></div>
                        <div><%= award.PrizeName %></div>
                    </div>
                    <% } %>
                    <% foreach (var award in this.awards)
                       { %>
                    <div class='scroll-row'>
                        <div><%= award.NickName %></div>
                        <div><%= award.PrizeName %></div>
                    </div>
                    <% } %>
                </div>
            </div>
            <div id="showGift">
                <div class="gifts">
                    <div>我的奖品：</div>
                    <div id="gift"><%= this.myPrizes %></div>
                </div>
                <div class="sprite-icon-button-4 button-4"></div>
            </div>
        </div>
        <div class="txt-title">如何参与<i class="sprite-icon-arrow arrow "></i></div>
        <div class="icon-rule hidden">
            <div class="rule-row">
                <div>(1)</div>
                <div>活动期间，首次在微信服务号绑定团贷网账号，可获得一次抽奖机会；</div>
            </div>
            <div class="rule-row">
                <div>(2)</div>
                <div>已绑定团贷网账号的用户，活动期间在微信服务号单笔投资满188元，可获得一次抽奖机会；</div>
            </div>
            <div class="rule-row">
                <div>(3)</div>
                <div>每位用户最多可获得两次抽奖机会，将本活动页面分享至朋友圈再抽奖，可提高中奖概率；</div>
            </div>
            <div class="rule-row">
                <div>(4)</div>
                <div>活动前已绑定团贷网账户的用户，解绑后再绑定不视作首次绑定；</div>
            </div>
            <div class="rule-row">
                <div>(5)</div>
                <div>所有奖励将发至个人团宝箱，领取有效期1个月，过期视作放弃奖励。</div>
            </div>
            <div class="rule-row">
                <div>(6)</div>
                <div>电影折扣券兑换方式：登录卖座网（www.maizuo.com）或卖座电影手机APP或手机登录（m.maizuo.com），选择任意电影和影院等订票信息，结算时，获取10元或20元折扣券选择”现金券抵用“，获取3D通兑券选择”电子卖座卡“，输入团宝箱中奖品”兑换码”即可成功下单，如在兑换中遇到问题请致电卖座网客服电话400-1808-400。</div>
            </div>
            <div class="rule-row">
                <div>(7)</div>
                <div>活动有效期：2015年9月7日起，奖品送完即止，先到先得。</div>
            </div>
        </div>
        <div class="bottom">
            <div class="bottom-txt">轻理财，更自在，更多福利等着你</div>
            <div class=" icon-ewm">
                <img src="images/pic/ewm.png" class="ewm-img" />
            </div>
            <div class="sprite-icon-scan-text scan-txt"></div>
            <div class="sprite-icon-bottom-bg bottom-bg"></div>
        </div>
    </div>
    <div class="mask">
    </div>
    <div class="pop1">
        <div class="sprite-icon-popup-1 popup-1">
            <div class="popup-text1">
                <div id="msg">送您一张3D电影兑换劵哦！</div>
                <div>记得来电影院见我哦~</div>
            </div>
            <div class="sprite-icon-button-1 button-1"></div>
            <div class="close-pop1"></div>
        </div>
    </div>
    <div class="pop2">
        <div class="sprite-icon-popup-2 popup-2">
            <div class="btn-group">
                <div class="sprite-icon-button-2 button-2"></div>
                <div class="sprite-icon-button-3 button-3"></div>
            </div>
            <div class="close-pop2"></div>
        </div>
    </div>
    <div class="pop3">
        <div class="sprite-icon-popup-3 popup-3">
            <div class="close-pop3"></div>
        </div>
    </div>
    <div class="pop4">
        <div class="popup-4">
            <div class="close-pop4"></div>
        </div>
    </div>
    <div class="pop5">
        <div class="popup-5">
            <div class="sprite-icon-button-1 button-1 btn-5"></div>
            <div class="close-pop5 close"></div>
        </div>
    </div>

    <input type="hidden" id="isSubscribed" value="<%= this.isSubscribed %>" />
    <input type="hidden" id="isLogin" value="<%= this.isLogin %>" />
    <input type="hidden" id="isEverBind" value="<%= this.isEverBind %>" />
    <input type="hidden" id="totalChances" value="<%= this.totalChances %>" />
    <input type="hidden" id="chances" value="<%= this.chances %>" />
</body>

<!-- <script src="./scripts/lib/zepto.min.js"></script> -->
<script type="text/javascript" src="../../scripts/base.js"></script>
<script src="./scripts/lottery.js?v=20151009001"></script>

</html>

