<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSWealth.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.PSWealth" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
		<meta name="format-detection" content="telephone=no">
		<title>资产总额</title>
		<link rel="stylesheet" href="/wap/css/zichanzonge.css?v=<%=GlobalUtils.Version %>">
		<script>
		    //动态算rem
		    (function (doc, win) {
		        var docEl = doc.documentElement,
		            resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
		            recalc = function () {
		                // if (docEl.style.fontSize) return;
		                clientWidth = docEl.clientWidth;
		                if (!clientWidth) return;
		                docEl.style.fontSize = 20 * (clientWidth / 320) + "px";
		                if (document.body) {
		                    document.body.style.fontSize = docEl.style.fontSize;
		                }
		            };
		        recalc();
		        if (!doc.addEventListener) return;
		        win.addEventListener(resizeEvt, recalc, false);
		        doc.addEventListener("DOMContentLoaded", recalc, false);
		    })(document, window);
		</script>
	</head>
	<body>
		<div class="wrapper">
			<div class="top-box">
				<p class="txt">迅辉财富总资产</p>
				<p class="money"><% var total = DqFundModel.TotalAmount - (ZxFundModelFromDq.DueInAmount ?? 0) - (ZxFundModelFromDq.DueInInterest ?? 0) - DqFundModel.FreezeAcount;
	       if (total < 0)
	       {
	           total = 0;
	       } %>
		    <%= ToolStatus.ConvertLowerMoney(total).Split('.')[0]%>.<span><%= ToolStatus.ConvertLowerMoney(total).Split('.')[1]%></span></p>
			</div>
			<div class="main">
				<div class="tb-border">
					<i></i>
					<div class="lr-border">
						<p>迅辉财富管理有限公司于2013年在东莞成立，2017年总部入驻深圳，注册资本1亿元。</p>						 
					</div>
				</div>
				<div class="main-con">
					<p class="title title1">个性化财富管理</p>
					<p>迅辉财富自创立以来，迅辉财富始终坚持规范运作、稳健经营，以多元化的资产管理工具和创新模式服务于高净值客户，并在其类固收增值咨询服务、家庭保障、财富传承等方面逐渐形成了自己独特的核心竞争力。</p>
					<!-- <img src="/wap/images/zichan/pic1.png" alt=""> -->
					<p class="title title2">信赖之选</p>
					<p>迅辉财富依托科学、严谨、立体的业务架构，凭借强大的风控体系与优质产品遴选能力，使得迅辉财富可根据客户的财务状况、家庭结构、风险偏好等因素，为其打造个性化、全方位、前瞻性财富咨询管理方案，并通过各类金融产品配置将财富管理方案深度专业实现。</p>
				</div>

				<%--<div class="webkit-box icon-con">
					<div class="box-flex1">
						<i class="icon1"></i>
						证监会核准<br />
						基金销售机构
					</div>
					<div class="box-flex1">
						<i class="icon2"></i>
						合规基金发行<br/>
						服务平台
					</div>
				</div>--%>
<!-- 
				<div class="b-txt">
					派生财富，值得托付
				</div> -->

			</div>
			<div class="btn-box">
				<div class="webkit-box btn-con">
					<div class="box-flex1">
						<a id="callApp" class="open">打开迅辉财富APP</a>
					</div>
					<div class="box-flex1">
						<a id="downPSApp" class="dl">下载迅辉财富APP</a>
					</div>
				</div>
			</div>
		</div>

		<!--无法打开弹窗-->
		<div class="alert webkit-box box-center" style="display: none" id="downloadAlert">
			<div class="alert-con">
				<div class="alert-txt">
					<span>无法打开？</span>
 					当前应用无法打开迅辉财富APP，
					<br />
 					建议您返回桌面手动打开迅辉财富APP。
				</div>
				<div class="btn-t-border">
					<a id="iKnow" class="btn">知道了</a>
				</div>
			</div>
		</div>
	</body>
	<script src="/wap/js/lib/fastclick-jquery.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript">
    var browser = {
        versions: function () {
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
    $("#downPSApp").click(function() {
        //if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
        //    window.location.href = "https://itunes.apple.com/us/app/id1274873923?mt=8";
        //} else {
        //    window.location.href = "https://static.paisheng.com/upload/client/android/latest/paisheng.apk";
        //}
        window.location.href = "https://psjs.tdw.cn/app-h5/html/app-h5/downloadApp.html";
    });
    
    function callApp() {
        var dom_a = $('#callApp');
        if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            dom_a.attr('href', 'paisheng://');
        } else {
            dom_a.attr('href', 'market://paisheng.com');
        }
    }
    $(function () {
        callApp();
        $('#callApp').click(function () {
            applink();
        });
        $("#iKnow").click(function () {
            $('#downloadAlert').hide();
        });
    });
    function applink() {
        var clickedAt = new Date();
        setTimeout(function () {
            if (new Date() - clickedAt < 2000) {
                alertShow('#downloadAlert');
            }
        }, 500);
    }
    //动画显示弹框
    function alertShow(alertId) {
        var $alert = $(alertId);
        $alert.show();
        setTimeout(function () {
            $('#downloadAlert').hide();
        }, 4000);
    }
    </script>
</html>
