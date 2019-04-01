﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="downOpenApp.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.downOpenApp" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/download.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <title>团贷网APP官方下载页面</title>
</head>
<body>
    <div class="pos-r pageContent">
        <div class="bg" id="top_bg"></div>
        <div class="logo"></div>
        <h2 class="f18px text-center pt17">团贷网</h2>
        <p class="c-999999 text-center pt20 app_version">
            <i></i>官方应用
				
            <%--<span></span>V4.6.0&nbsp;(8月12日更新)--%>
			
        </p>
        <div class="btnWrap pl15 pr15 clearfix">
            <div class="w50p pr15 lf">
                <a class="btn btnWhite f17px c-fab600" id="callApp">打开APP</a>
            </div>
            <div class="w50p pl15 lf">
                <div class="btn btnYellow f17px c-fff" id="downloadApp">下载APP</div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="f_bg" style="padding-bottom:10px;"onclick="JAVASCRIPT:window.location.href='https://hd.tuandai.com/weixin/newhand/welfarenew.aspx?tdsource=wxindex';">
            <div class="f_r1 text-center c-999 f15px">
                <span></span>新&nbsp;手&nbsp;专&nbsp;享
					
                <span></span>
            </div>
            <div class="f_r2"><i class="comma_l"></i>518红包<span>+</span>2888体验金<i class="comma_r"></i></div>
        </div>
        <div class="f_r3" style="margin-top:-10px;height: 30px;line-height: 30px;">2010-<%=DateTime.Now.ToString("yyyy") %> 版权所有 © 团贷网</div>
        <div class="f_r3" style="margin-top:-20px;">粤ICP备12043601号-1 东莞团贷网互联网科技服务有限公司</div>
    </div>

    <div class="alert webkit-box box-center hide" id="downloadAlert">
        <div class="downloadAlert">
            <p class="p_tit text-center f17px fb">无法打开？</p>
            <p class="p_con text-center f15px c-808080">当前应用无法打开团贷网APP，建议您返回桌面手动打开团贷网APP。</p>
            <div class="btn c-fab600 bt-e6e6e6" id="iKnow">我知道了</div>
        </div>
    </div>
</body>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">

			//判断链接如果是注册成功跳过来是添加注册成功的字样
			function GetQueryString(name) {
				var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
				var r = window.location.search.substr(1).match(reg);
				if (r != null) return unescape(r[2]);
				return null;
			}
			
			if (GetQueryString('type') == 'formreg') {
				$("#top_bg").css({"background-image":"url(/imgs/images/bg/reg-download.png)","background-repeat":"no-repeat"});
			}

    function dealHeight() {
        var footer = $(".footer");
        var conHeight = $(".pageContent").outerHeight() + footer.outerHeight() + 20;
        var winHeight = $(window).height();
        if (winHeight > conHeight) {
            footer.css({
                'position': 'absolute',
                'bottom': '0',
                'left': '0'
            });
        }
    }

    //动画显示弹框
    function alertShow(alertId) {
        var $alert = $(alertId);
        $alert.removeClass('hide').removeClass('aniFadeOut').addClass('aniFadeIn');
        $alert.find('.downloadAlert').removeClass('aniHide').addClass('aniShow');
    }

    //动画隐藏弹框
    function alertHide(alertObj) {
        alertObj.removeClass('aniFadeIn').addClass('aniFadeOut');
        alertObj.find('.downloadAlert').removeClass('aniShow').addClass('aniHide');
        setTimeout(function () {
            alertObj.addClass('hide');
        }, 400);
    }

    function applink() {
        var clickedAt = new Date();
        setTimeout(function () {
            if (new Date() - clickedAt < 2000) {
                alertShow('#downloadAlert');
            }
        }, 500);
    }

    var browser = {
        versions: function() {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                //移动终端浏览器版本信息
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1 //是否iPad
            };
        }()
    };
    function callApp() {
        //var ua = navigator.userAgent.toLowerCase();
        var dom_a = $('#callApp');
        if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            dom_a.attr('href', 'tuandai://');
        } else {
            dom_a.attr('href', 'market://tuandai.com');
        }
    }

    $(function () {
        callApp();
        dealHeight();
        $('#callApp').click(function () {
            applink();
        });
        $("#iKnow").click(function () {
            alertHide($(this).parent().parent());
        });
    });
    $("#downloadApp").click(function() {
        if ("<%= TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser%>" == "True") {
            window.location.href = 'https://www.tuandai.com/app/install.aspx';
        } else {
            if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
                window.location.href = "http://www.tuandai.com/app/install.aspx";
            } else {
                window.location.href = "http://image.tuandai.com/tuandaiapp/tuandai.apk";
            }
        }

    });
		</script>

</html>
