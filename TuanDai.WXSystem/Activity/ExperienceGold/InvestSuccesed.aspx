<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvestSuccesed.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.ExperienceGold.InvestSuccesed" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>注册团贷网新用户即送18000元体验金</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20160509001" /><!--base-->
    <link rel="stylesheet" type="text/css" href="css/style.css?v=20160509001" />
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>  
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script> 
    
     <script type="text/javascript">
         wxData.isWxJsSDK = true;
         //wxData.debug = true;
         wxData.url = "http://m.tuandai.com/Activity/ExperienceGold/Index.aspx";
         wxData.title = "注册团贷网新用户即送18000元体验金";
         wxData.desc = "投资体验金专享标，到期即可获得利息收益红包!";
         wxData.img_url = "http://m.tuandai.com/Activity/ExperienceGold/imgs/banner1.png";
         wxData.ShareCallBack = function (ex) {
             // alert(ex == "success" ? "分享成功" : "取消分享");
         }
    </script>   
</head>
<body class="wrap-bg2">
<section class="wrap">
    <div>
        <img src="imgs/banner3.png?v=201605090001"/>
    </div>
    <section class="main-box pl40 pr40 mt15">
        <div class="main-cn text-center">
            <p class="c-d97b0b mt15 f15px">恭喜您  计息开始</p>
            <p class="c-d97b0b mt15 f15px p1">预计收益：<span class="f24px">5元</span></p>
            <img src="imgs/code.png?v=1.3" class="weixin-code mt15"/>
            <p class="text-center f13px mt15 p2">长按二维码识别，输入账号密码登陆领取收益及红包</p>   
        </div>
    </section>
</section>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>