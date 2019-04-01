<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexApp.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.Invitation.IndexApp" %>

<!DOCTYPE html>
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
</head>
<body>
    <div class="wrapper">
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
            <div class="link-box">
                <a href="ruleApp.html" class="f13 c-8c1c2f border-l1">活动规则</a>
                <a href="InvitationHistoryApp.aspx?type=APP" class="f13 c-8c1c2f">邀请记录</a>
            </div>
            <%if (isAuthenticated)
              {%>
            <a href="ToAppInviteFriend" class="invite-now f14 mt18">立即邀请</a>
            <%}
              else
              {%>
            <a href="ToAppLogin" class="invite-now f14 mt18">立即邀请</a>
            <%}%>
        </section>
    </div>

   
</body>
</html>