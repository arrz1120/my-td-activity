<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvitationHistory.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.Invitation.InvitationHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>邀请好友-邀请记录</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
    <div class="wrapper">
        <header class="header-box pos-a">
            <div class="headerMain">
                <div class="header border-b0 bg-none">
                    <div class="back Arrow2" onclick="javascript:history.go(-1);"></div>
                    <h1 class="title c-212121">邀请记录</h1>
                </div>
                <div class="none"></div>
            </div>
        </header>
        <section class="number-box pos-a">
            <p>已成功邀请<span><%= this.invitedUsers %></span>人</p>
        </section>
        <section>
            <div class="full-pos p2-bg"></div>
            <div class="pic-box p21">
                <img src="imgs/p21.png" alt="" /></div>
        </section>
        <section class="prize-box pos-a">
            <div class="prize-cn pos-r">
                <p class="prize1 pos-a f10 c-fff">获得π币</br><span class="c-fff f11"><%= this.coinCount %></span>个</p>
                <p class="prize2 pos-a f10 c-fff">获得VIP会员</br><span class="c-fff f11"><%= this.gotVipMonths %></span>个月</p>
            </div>
        </section>

        <div class="log-wrap">
            <h3></h3>
            <section class="log-box pos-a">
                <div class="log-roll">
                    <div class="bd">
                        <div class="log-cn">
                            <% foreach (var prize in this.prizes)
                               { %>
                            <div class="log clearfix">
                                <div class="fl data">
                                    <p class="name c-fff f09"><%= BusinessDll.StringHandler.MaskStarPre1(prize.Name) %></p>
                                    <p class="c-fff f11"><%= prize.Date.ToString("yyyy/MM/dd") %></p>
                                </div>
                                <span class="fr c-fff f13">￥<%= prize.Amount.ToString("F") %></span>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </section>
        </div>


    </div>
    <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1.0"></script>
    <script type="text/javascript">
        $(".log-roll").slide({ mainCell: ".bd .log-cn", autoPlay: true, effect: "topMarquee", vis: 5, interTime: 50 });
    </script>
</body>
</html>
