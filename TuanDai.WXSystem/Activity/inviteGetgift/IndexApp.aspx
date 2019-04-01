<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexApp.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.inviteGetgift.IndexApp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=640,target-densitydpi=device-dpi,user-scalable=no" />
    <title></title>
    <meta name="author" content="kevin" />
    <meta name="Copyright" content="东莞团贷网互联网科技服务有限公司" />
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/style.css?v=201512020001">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.5"></script>
</head>
<body class="bg-fad467">
    <div id="wraper" class="main-wraper">
        <!--首页-->
        <div id="main">
            <section class="sec sec01">
                <div class="hb-text-1">
                    <div class="num numanimation"></div>
                </div>

                <div class="hb-text-2">
                    <div class="num"></div>
                </div>

                <div class="hb-text-3">
                    <div class="num"></div>
                </div>
                <a href="javascript:;" class="ruleText">活动详细规则</a>
                <%if (IsLogin)
                  {%>
                       <a href="ToAppInviteFriend" class="invite-now" id="butShare">
                    <img src="imgs/btn.png" alt="" />
                </a>
                  <%}else{%>
                   <a href="ToAppLogin" class="invite-now" id="butShare">
                    <img src="imgs/btn.png" alt="" />
                </a>
                  <%} %>
               
            </section>
        </div>

        <!--规则-->
        <div id="rule">
            <a href="javascript:;" class="back close"></a>
            <a href="javascript:;" class="back">回到顶部</a>
        </div>
        <!--未登录-->
        <section class="popup-wrap" id="loginWrap" style="display: none;">
            <div class="popup animated pos-a">
                <p>您还没有登录哦！</p>
                <a href="javascript:;" class="pos-a close-but style-but"></a>
                <div class="login-cn">
                    <a href="ToAppLogin" class="c-fd5f61">登录</a>
                    <a href="ToAppRegister" class="c-2aadf1">注册</a>
                </div>
            </div>
        </section>

        <!--活动停止提示-->
        <section class="popup-wrap" id="tishiWrap">
            <div class="tishi animated pos-a">
                <p>该邀请方式已停止!</br>其他邀请方式请登录官网查看</p>
                <a href="javascript:;" class="pos-a close-but style-but"></a>
                <div class="ti-cn">
                    <a href="javascript:;" class="c-fd5f61 close-but">确定</a>
                </div>
            </div>
        </section>


        <!--手机浏览器弹窗-->
       <%-- <section class="popup-wrap-share" id="browserShare">
            <div class="share-box  pos-a">
                <p class="c-2aadf1">关注团贷网微信服务号：</p>
                <p class="c-fff3b4"><span>tuandaiservice</span>，点击“热门活动”栏目即可参与“招募团贷网合伙人”活动。</p>
                <a href="javascript:;" class="closeShare" id="closeShare">X</a>
            </div>
        </section>--%>

        <!--显示附则-->
        <section class="fuze-wrap-share" id="fuzeShow">
            <div class="fuze-box  pos-a">
                <p class="c-fff3b4">1、	本次活动所发放的投资红包使用杠杆为1:100，使用期限自领取之日起30天内有效。</p>
                <p class="c-fff3b4">2、	活动期间，若发现参与者邀请的用户超过50%无任何有效投资行为，且邀请总人数达50人以上时，则视为利用活动规则不当获利，团贷网有权终止其活动参与资格，并罚没相关活动奖励。</p>
                <p class="c-fff3b4">3、	本活动最终解释权在法律允许范围内归团贷网所有。</p>
                <a href="javascript:;" class="closeShare" id="closeFuze">关闭</a>
            </div>
        </section>
    </div>
</body>
<script type="text/javascript" src="/scripts/base.js?v=20150918"></script>
<script type="text/javascript">
    window.document.title = '<%=IsLogin?"我给你发了10元红包，马上领取吧!":"招募团贷网合伙人"%>';
    wxData.isWxJsSDK = true;
    //wxData.debug = true;
    wxData.url = location.href;
    wxData.title = '<%=IsLogin?"我给你发了10元红包,快领取吧!":"招募团贷网合伙人"%>';
    wxData.desc = "要理财，就上团贷网！年化收益10~18%，期限7天~24个月任选！";
    wxData.img_url = "http://m.tuandai.com/Activity/inviteGetgift/imgs/t2.png";
    wxData.ShareCallBack = function (ex) { }

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

    $(function () {
        if (browser.versions.ios == true) {
            $("#prompt").css("display", "block");
        }
        $(".ruleText").on("click", function () {
            $("#main").addClass('visited');
            $("#rule").addClass('current');
            $('#wraper').removeClass('main-wraper').addClass('rule-wraper');
            $(window).scrollTop(0)
        });
        $(".back").on("click", function () {
            $(window).scrollTop(0);
        });

        $("#fuze").on("click", function () {
            $("#fuzeShow").fadeIn();
        });


        $("#closeFuze").on("click", function () {
            $("#fuzeShow").fadeOut();
        });

        $(".close").on("click", function () {
            $("#main").removeClass('visited');
            $("#rule").removeClass('current');
            $('#wraper').addClass('main-wraper').removeClass('rule-wraper');
            setTimeout(function () {
                $(window).scrollTop(820);

            }, 300)
        });



    });
    $(".close-but").click(function () {
        $(".popup-wrap").fadeOut(400);
        $('.popup').addClass('fadeOutDown').removeClass('fadeInUp');
    });


    //分享
    var isWeiXin = navigator.userAgent.toLowerCase().indexOf("micromessenger") != -1;
    var bd = document.body;
    var shareBut = document.getElementById("butShare");

    var sharePopup = function (e) {
       <%-- if ("<%=IsLogin?"1":"0"%>" == "0" && isWeiXin) {
            $("#loginWrap").css("display", "block");
            return;
        }--%>
        if (isWeiXin) {
            if (!document.getElementById("shareTip")) {
                window.scrollTo(0, 0);
                var dom = document.createElement("div");
                dom.className = "modal-backdrop";
                dom.id = "shareTip";
                dom.innerHTML = '<div class="shareTip-box"><div class="shareTip"></div></div>';
                bd.appendChild(dom);
                dom.addEventListener("touchstart", clearShareTip, false);
            }
            return false;
        } 
        //else {
        //    $("#browserShare").fadeIn();
        //}
    };

    //$("#closeShare").click(function () {
    //    $("#browserShare").fadeOut();
    //});

    function clearShareTip() {
        var hintTip = document.getElementById("shareTip");
        hintTip.removeEventListener("touchstart", clearShareTip, false);
        bd.removeChild(hintTip);
    }
    shareBut.onclick = sharePopup;


    //向下滚动动画
    $(window).scroll(function () {
        var top = $(window).scrollTop();
        if (top > 150) {
            $('.hb-text-2 .num').addClass('numanimation');
        }

        if (top > 350) {
            $('.hb-text-3 .num').addClass('numanimation');
        }
    });
</script>
</html>