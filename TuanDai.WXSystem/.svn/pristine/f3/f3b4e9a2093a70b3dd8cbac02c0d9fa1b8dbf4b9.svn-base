<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.inviteGetgift.register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
    <title>邀请有礼</title>
    <meta name="author" content="kevin" />
    <meta name="Copyright" content="东莞团贷网互联网科技服务有限公司"/>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/page.css?v=20160308001">
    <style type="text/css">
        body,html{width: 100%;height: 100%;}
        .error{color:#fff;height:20px;font-size:12px;padding-top: 3px;}
    </style>
</head>
<body class="giftbg">
    <section class="giftBox">
        <!--<div class="text-box">-->
            <!--<img src="imgs/text-box.png"/>-->
        <!--</div>-->
        <div class="wbq-box">
            <img src="imgs/wbp.jpg" alt=""/>
        </div>
        <!--<div class="prompt">-->
            <!--<p><img src="imgs/ico.png"/>已为你备好厚礼，直接领取吧！</p>-->
        <!--</div>-->

        <!--<div class="gift-cn">-->
            <!--<div><img src="imgs/gift.png"/></div>-->
        <!--</div>-->


           <div class="inp-con">
            <img src="imgs/main-bg.png" class="main-bg"/>
            <div class="nub-inp">
                <div class="code-box">
                    <input type="text" placeholder="输入手机号码" id="phone" maxlength="11"  class='pos-num'/>
                    <div class="error" id="dvPhoneError" >&nbsp;</div>


                    <div class="yanzhengma" >
                        <div class="code-cn pos-r" >
                            <input type="text" class="pos-a" placeholder="图形验证码" id="txtValidNumber" maxlength="4"/>
                            <img src="/ValidateCode.ashx?20150911" id="imgVcode" onclick="reloadCode('/ValidateCode.ashx')"/>
                        </div>
                        <div class="error" id="dvValidNumber"  >&nbsp;</div>

                        <div class="code-cn pos-r" style="display: block;">
                            <input type="text" class="pos-a" placeholder="手机验证码" id="messCode" maxlength="6"/>
                            <a href="#" id="btnSendMsg" class="phone_btn">获取验证码</a>
                        </div>
                        <div class="error" id="dvCodeError" style="display: block;">&nbsp;</div>
                    </div>
                    <a href="javascript:;" id="btnReg"><img src="imgs/gift-btn1.png?v=20160308001"></a>
                </div>

                <div class="footer-text">
                    <img src="imgs/footer-text1.png?v=20160308001"/>
                </div>
                <p class="explain fz08">该活动由团贷网提供，与苹果公司无关。</p>

            </div>
        </div>

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
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/reg.js?v=20160121001" type="text/javascript"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150918"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="/scripts/weixinapi.js?v=20160308001"></script>
    <script type="text/javascript"> 
        wxData.isWxJsSDK = true;
        wxData.debug = false;
        wxData.url = "http://m.tuandai.com/Activity/inviteGetgift/register.aspx?ExtendKey=<%=ExtendKey%>";
        wxData.title = '我给你发了10元红包，快领取吧！';
        wxData.desc = "我在团贷网玩理财，年化收益率最高14%，期限灵活，你也玩一下吧！";
        wxData.img_url = "http://m.tuandai.com/Activity/inviteGetgift/imgs/t2.png";
        wxData.ShareCallBack = function (ex) { } 
    </script>

    <script type="text/javascript">
        var tdFrom = "<%=tdFrom %>";
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

        //滑动显示验证码输入框
        var isPhoneNum;
       $(".pos-num").on('focus',function(){
        var _this =  $(this);
        isPhoneNum = setInterval(function(){
            var tel = _this.val();
            var mbTest = /^(13|14|15|17|18)[0-9]{9}$/;
            if (mbTest.test(tel)) {
                $(".yanzhengma").slideDown("slow");
                $(".yanzhengma").show();
           }
        },10);
        });

       $(".pos-num").on('blur',function(){ 
            clearInterval(isPhoneNum);
       });
    </script>

</body>
</html>
