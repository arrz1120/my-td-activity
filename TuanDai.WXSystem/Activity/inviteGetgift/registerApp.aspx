<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registerApp.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.inviteGetgift.registerApp" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <title>招募团贷网合伙人</title>
    <meta name="author" content="kevin" />
    <meta name="Copyright" content="东莞团贷网互联网科技服务有限公司"/>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/page.css?v=2015092501">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=2015092102901"></script>
    <script src="js/regApp.js?v=2015092102901" type="text/javascript"></script>
    <style type="text/css">
        body,html{width: 100%;height: 100%;}
       .error{color:Red;height:20px;font-size:12px;padding-top: 3px;}
    </style>
</head>
<body class="giftbg">
    <section class="giftBox">
        <div class="text-box">
            <img src="imgs/text-box.png"/>
        </div>

        <div class="prompt">
            <p><img src="imgs/ico.png"/>已为你备好厚礼，直接领取吧！</p>
        </div>

        <div class="gift-cn">
            <div><img src="imgs/gift.png"/></div>
        </div>

        <div class="nub-inp" style="margin-top: 4%;">
            <div class="code-box">
                <div class="error" id="dvPhoneError" style="font-size: 15px;height: 33px;">&nbsp;</div>
                <input type="text" placeholder="输入手机号码" id="phone" maxlength="11" onkeydown="checkPhone()"/>
                <div class="error">&nbsp;</div>
                <div class="code-cn pos-r"  style="display:none;">
                    <input type="text" class="pos-a" placeholder="图形验证码" id="txtValidNumber" maxlength="4"/>
                    <img src="../../ValidateCode.ashx?20150911" id="imgVcode" onclick="reloadCode('/ValidateCode.ashx')"/>
                </div>
                <div class="error" id="dvValidNumber"  style="display:none;">&nbsp;</div>
                <div class="code-cn pos-r"  style="display:none;">
                    <input type="text" class="pos-a" placeholder="手机验证码" id="messCode" maxlength="6"/>
                    <input type="button" value="获取验证码" id="btnSendMsg">
                </div>
                <div class="error" id="dvCodeError"  style="display:none;">&nbsp;</div>
                 <a href="javascript:;" id="btnReg">马上领取</a>
            </div>

        </div>

        <div class="footer-text">
            <img src="imgs/footer-text.png"/>
        </div>

         <p class="explain fz08">该活动由团贷网提供，与苹果公司无关。</p>

        <!--已经领取-->
        <section class="popup-wrap" id="loginWrap" style='display:none;'>
            <div class="nologin animated pos-a">
                <p class="p">您输入的号码已领取！</p>
                <a href="javascript:;" class="pos-a close-but"></a>
                <div class="confirm">
                    <a href="" class="c-fd5f61">确定</a>
                </div>
            </div>
        </section>
    </section>
    <script type="text/javascript">
        var isMobile = 0;
        var browser = {
            versions: function () {
                var u = navigator.userAgent, app = navigator.appVersion;
                return {
                    trident: u.indexOf('Trident') > -1, //IE内核 
                    presto: u.indexOf('Presto') > -1, //opera内核 
                    webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核 
                    gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核 
                    mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端 
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端 
                    android: u.indexOf('Android') > -1, //android终端或者uc浏览器 
                    iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器 
                    iPad: u.indexOf('iPad') > -1, //是否iPad 
                    webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部 
                };
            }()
        };
        if (browser.versions.ios == true || browser.versions.android == true) {
            isMobile = 1;
        }
        var extendKey = "<%=ExtendKey %>";
        $(".close-but").click(function () {
            $(".popup-wrap").fadeOut(400);
            $('.nologin').addClass('fadeOutDown').removeClass('fadeInUp');
        });
        $(".c-fd5f61").click(function () {
            $(".popup-wrap").fadeOut(400);
            $('.nologin').addClass('fadeOutDown').removeClass('fadeInUp');
        });

        function reloadCode(urlString) {
            $("#imgVcode").attr("src", urlString + "?id=" + Math.random());
        }
    </script>

</body>
</html>
