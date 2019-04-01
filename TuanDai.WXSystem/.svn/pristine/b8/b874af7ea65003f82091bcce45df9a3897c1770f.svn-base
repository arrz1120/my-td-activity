<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity._20150626_GZGold.Index" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>团贷网金交会 - 百万豪礼免费领</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <link rel="stylesheet" href="css/main.css?v=11111" />
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" />
</head>
<body>
    <section class="wrapper">

    <div class="wrap">
        <div class="top-cn">
            <p class="name">用户：<%=userName %></p>
            <a class="rule-but" href="javascript:;"></a>
        </div>
        <div class="full-pos bg"></div>
        <div class="full-pos p21"></div>
        <div class="full-pos p22"></div>
        <div class="full-pos p23"></div>
        <div class="full-pos p24"></div>
        <a class="drawbut" href="javascript:;" id="draw-but"></a>
        <div class="getprize-box pos-a">
                <ul id="prize_list">
          
                </ul>
            <a href="javascript:;" id="show_prize">点击查看我的奖品</a>
        </div>

        <div class="dl-box">
            <div class="dl-link">
                <a href="http://a.app.qq.com/o/simple.jsp?pkgname=com.junte&g_f=991653" class="td">下载团贷网APP</a>
                <a href="http://a.app.qq.com/o/simple.jsp?pkgname=com.junte.onlinefinance" class="nw">下载你我金融APP</a>
            </div>
        </div>

         <audio id="sound_bg" preload="auto">
            <source src="audio/bg.mp3"></source>
        </audio>
        <!--显示规则-->

        <div class="Popup-wrap rulePopupBox">
            <div class="popup-box">
                <div class="popup-rule">
                    <a href="javascript:;" class="close-rule"></a>
                </div>
            </div>
            <div class="mask"></div>
        </div>

    </div>
</section>
    <!--弹窗-->
    <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 60%;padding-right: 10px;">
         <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>
    </span>
  </div>
</section>
    <!--遮罩层-->
    <div class="maskLayer hide">
    </div>

    <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/twitter.slider.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
    <script type="text/javascript">
        $(".top-cn").find(".rule-but").click(function () {
            $(".rulePopupBox").fadeIn(500);
        });

        $(".popup-rule").find(".close-rule").click(function () {
            $(".rulePopupBox").fadeOut(500);
        });

    </script>
</body>
</html>
