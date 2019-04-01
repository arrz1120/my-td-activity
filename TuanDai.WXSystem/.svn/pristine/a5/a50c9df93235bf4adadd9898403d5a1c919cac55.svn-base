<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.Invitation.index" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="author" content="m.tuandai.com" />
    <meta name="copyright" content="Copyright &copy;m.tuandai.com 版权所有" />
    <title>邀请好友-四重大奖等您拿</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/style.css?v=20150721" />
    <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1.0"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.5"></script>
    <script type="text/jscript">
        var isLogin = "<%=this.isAuthenticated %>";
        wxData.isWxJsSDK = true;
        //wxData.debug = true;
        wxData.url = "<%= this.inviteUrl %>";
        wxData.title = "请接受好友邀请，一起拿大奖";
        wxData.desc = "388元礼包，2000元体验金，1个月VIP，邀请好友更有四重大奖！";
        if (isLogin.toLowerCase() == "true") {
            wxData.ishideshare = false;
        }
        else {
            wxData.ishideshare = true;
        }
        wxData.img_url = "http://m.tuandai.com/imgs/sharelogo.png";
        wxData.HideShareBtnCallBack = function (res) {
            alert("对不起，您还未登录！");
            window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href;
        }
    </script>
</head>
<body>
    <div class="wrapper">
        <%if (type == "wx")
          {%>
        <header class="header-box pos-a">
            <div class="headerMain">
                <div class="header border-b0 bg-none">
                    <div class="back Arrow1" onclick="javascript:history.go(-1);"></div>
                </div>
                <div class="none"></div>
            </div>
        </header>
        <%}%>
        <section>
            <div class="pic-box p11">
                <img src="imgs/bg.jpg" alt="" /></div>
            <div class="pic-box p11">
                <img src="imgs/p11.png" alt="" /></div>
            <div class="pic-box p11">
                <img src="imgs/p12.png" alt="" /></div>
            <div class="pic-box p11">
                <img src="imgs/p13.png" alt="" /></div>
        </section>
        <section class="content-b pos-a">
            <%if (type == "wx")
              {%>
            <div class="link-box">
                <a href="rule.html" class="f13 c-8c1c2f border-l1">活动规则</a>
                <%if (type == "wx")
                  {%>
                <a href="InvitationHistory.aspx" class="f13 c-8c1c2f">邀请记录</a>
                <%}
                  else
                  {%>
                <%if (isAuthenticated)
                  {%>
                <a href="InvitationHistory.aspx" class="f13 c-8c1c2f">邀请记录</a>
                <%}
                  else
                  {%>
                <a href="ToAppLogin" class="f13 c-8c1c2f">邀请记录</a>
                <%}%>
                <%}%>
            </div>
            <%}%>

            <%if (type == "wx")
              {%>
            <a href="javascript:;" class="invite-now f14 mt18" id="invite">立即邀请</a>
            <%}
              else
              {%>
            <div class="link-box">
                <a href="ruleApp.html" class="f13 c-8c1c2f border-l1">活动规则</a>
                <a href="InvitationHistoryApp.aspx?type=<%=type %>" class="f13 c-8c1c2f">邀请记录</a>
            </div>
            <%if (isAuthenticated)
              {%>
            <a href="ToAppInviteFriend" class="invite-now f14 mt18">立即邀请</a>
            <%}
              else
              {%>
            <a href="ToAppLogin" class="invite-now f14 mt18">立即邀请</a>
            <%}%>
            <%}%>
        </section>
    </div>

    <script type="text/javascript">
        //复制分享
        $(function () {
            var initNavSuccess = false;
            var isLogin = "<%=this.isAuthenticated %>";
            var type = "<%=type %>";
            function show() {
                if (initNavSuccess) {
                    return;
                }
                if (isLogin != "False") {

                    var html =
                    '<div class="share-bg" ></div>' +
                    '<div class="share-url">' +
                    '<input type="text" id="d_clip_button" value="<%= this.inviteUrl %>"/>' +
                    '<p>请点击网址复制链接</p>'
                    '</div>';
                }
                else {
                    var html =
                    '<div class="share-bg" ></div>' +
                    '<div class="share-url">' +
                    '<a href="/user/login.aspx?ReturnUrl=/activity/Invitation/index.aspx?type=wx" class="share-but">立即登录</a>' +
                    '</div>';
                }

                $('.invite-now').before(html);

                var isOpen = false;

                $('#invite').click(function () {
                    if (isOpen) {
                        $('.share-url').animate({
                            'bottom': '-150px'
                        });
                        $('.share-bg').hide();
                        $('.share-bg').animate({
                            opacity: 0
                        });
                        $('.share-bg').hide();
                        isOpen = false;
                    } else {
                        $('.share-url').animate({
                            'bottom': '0px'
                        });

                        $('.share-bg').show();
                        $('.share-bg').css({
                            opacity: 1
                        });
                        isOpen = true;
                    }

                });

                $('.share-bg').bind('touchstart', function (e) {
                    e.preventDefault();

                    $('.share-url').animate({
                        'bottom': '-150px'
                    });

                    $('.share-bg').hide();
                    $('.share-bg').animate({
                        opacity: 0
                    });
                    $('.share-bg').hide();
                    isOpen = false;
                });
                initNavSuccess = true;
            }
            show();

        });
    </script>
</body>
</html>
