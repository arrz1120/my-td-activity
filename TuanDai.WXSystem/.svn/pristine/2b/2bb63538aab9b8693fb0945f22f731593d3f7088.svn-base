<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.ExperienceGold.Index" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no">
    <title>注册团贷网新用户即送18000元体验金</title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财">
     <meta name="description" content="注册团贷网新用户即送2000元体验金，投资体验金专享标，到期即可获得利息收益红包。另外新用户注册即送388元现金红包加1个月VIP超级会员，资金安全更有保障" />
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20160509001" /><!--base-->
    <link rel="stylesheet" type="text/css" href="css/style.css?v=20160509001" /> 
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>  
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.4"></script> 
    
     <script type="text/javascript">
         var storeNo = "<%=SourceFrom %>";
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
<body class="wrap-bg1"> 
 <!--微信分享时图片-->
 <div style="display:none;"><img src="/imgs/sharelogo.png"></div> 
 
 <section class="wrap">
    <div>
        <img src="imgs/banner1.png?v=201605090001"/>
    </div>
    <section class="form-box pl40 pr40 mt20">
        <div class="inp-cn pos-r mb25">
            <input type="text" name="txtMobileNumber" class="text1" id="txtMobileNumber" placeholder="请输入手机号码"  maxlength="11" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false">
            <a href="javascript:;" class="clear pos-a" id="clear">
                <img src="imgs/clear.png"/>
            </a>
            <span class="pos-a" id="lblMobileNumber" style="display:none;">手机号码不能为空</span>
        </div>
        <div class="inp-cn1 pos-r mb25">
            <input type="text"   name="txtImageCode" id="txtImageCode" class="text2 pos-a"  maxlength="4" placeholder="请输入图形码" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false">
            <div class="imgcode">
                <img src="ImageCode.ashx" title="点击换一个校验码" alt="点击换一个校验码" id="imVcode" onclick="reloadCode('ImageCode.ashx')" />
            </div>
            <span class="pos-a" id="lblImageCode" style="display:none;">图形验证码输入错误</span>
        </div>
        <div class="inp-cn1 pos-r mb25">
            <input type="text" name="txtCode" id="txtCode"  class="text2 pos-a" placeholder="请输入验证码" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false"  maxlength="6" >
            <input type="button" class="but-getcode text-center pl0" value="获取验证码">
            <span class="pos-a" id="lblCode" style="display:none;">验证码输入错误</span>
        </div>
        <div class="inp-cn">
            <input type="button"  class="getnow-but f16px" value="立即领取">
        </div> 
    </section>
</section>

 
<script type="text/javascript" src="js/reg.js?v=201509180052"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150814"></script>  
 
</body>
</html>
