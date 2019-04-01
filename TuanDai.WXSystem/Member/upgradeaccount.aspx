﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="upgradeaccount.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.upgradeaccount" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>超级会员</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/myMerber.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body class="bg-f2f4f5">
    <%=GetNavStr() %>
	<section class="bb-e8eaeb bg-fafbfc">
		<div class="clearfix sup-m-top pos-r">
			<div class="avatar lf">
				<img src="<%=headImage %>" alt="">
			</div>
			<div class="lf">
				<p class="f17px c-4d4d4d mt3 text-overflow name">我叫<%=userModel!=null?userModel.NickName:""%></p>
                <% if (userModel.Level != 2)
                   {
                %>
                <p class="f13px c-999 mt5"><i class="ico-star"></i>普通会员</p>
                <%
                   }
                   else
                   {
                       %>
                <!--超级会员时候 显示下面注释的样式-->
				<p class="f13px c-999 mt5"><i class="ico-spm"></i>超级会员</p>
                <%
                   } %>
				
				
			</div>
            <% if (userModel.Level == 2)
               {
                   %>
            <p class="f10px c-999 pos-a data">超级会员到期日<%=userModel.LevelEndDate.HasValue?userModel.LevelEndDate.Value.ToString("yyyy-MM-dd"):"终身"%></p>
            <%
               } %>
			
			<a href="javascript:;" class="f13px c-4d4d4d pos-a upgrade" id="upgrade"><%=userModel.Level == 1?"升级超级会员":"超级会员续期" %></a>
		</div>
	</section>
	<section class="pl30 pr30 bt-fafbfc pt25">
		<div class="swiper-container super-m-slide">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<div class="s-t-con">
						<div class="top-bg"></div>
						<img src="/imgs/member/reduction.png" alt="">
					</div>
					<p class="f20px c-4d4d4d bb-ebebeb">提现费用减至0.05%</p>
					<p class="f13px c-999">普通会员提现手续费为提现金额的0.15%，不封顶；超级会员为0.05%，200元封顶</p>
				</div>
				<div class="swiper-slide">
					<div class="s-t-con">
						<div class="top-bg"></div>
						<img src="/imgs/member/overdue.png" alt="">
					</div>
					<p class="f20px c-4d4d4d bb-ebebeb">逾期垫付本息</p>
				    <p class="f13px c-999"><%=userModel.Level==1?"逾期由担保公司垫付本金":"逾期由担保公司垫付本息" %></p>
				</div>
				<div class="swiper-slide">
					<div class="s-t-con">
						<div class="top-bg"></div>
						<img src="/imgs/member/withdrawals.png" alt="">
					</div>
					<p class="f20px c-4d4d4d bb-ebebeb">单笔提现80万</p>
					<p class="f13px c-999">普通会员单笔提现最高30万；超级会员80万</p>
				</div>
			</div>

		</div>
		<div class="swiper-pagination super-pagination"></div>
	</section>

    <!--直接购买弹窗-->
	<section class="alert buy-wrap hide" id="buy_alert">
		<%--<div class="buy-box pos-f" id="buy_con" style="height:<%= IsInApp?"32%":"40%"%> !important">
			<h3>直接购买</h3>
			<div class="webkit-box">
				
				<div class="box-flex1 buy-but buy1">
					<div class="clearfix">
						<div class="lf">
							<span class="m1"></span>
						</div>
						<div class="rf">
							<p>1个月</p>
							<p>¥30</p>
						</div>
					</div>
				</div>
				<div class="box-flex1 buy-but buy6">
					<div class="clearfix">
						<div class="lf">
							<span class="m6"></span>
						</div>
						<div class="rf">
							<p>6个月</p>
							<p>¥150</p>
						</div>
					</div>
				</div>
				<div class="box-flex1 buy-but buy12">
					<div class="clearfix">
						<div class="lf">
							<span class="m12"></span>
						</div>
						<div class="rf">
							<p>12个月</p>
							<p>¥288</p>
						</div>
					</div>
				</div>
				
			</div>
            <% if (!IsInApp)
               {
                  %>
            <h3>APP连续签到</h3>
			<div class="clearfix qiandao-box" <%=IsInApp?"onclick='javascript:Jsbridge.toAppSignIn();'":"onclick='javascript:window.location.href=\"/pages/downopenapp.aspx\"'" %>>
				<a class="lf f17px c-4d4d4d">连续签到3天即送超级会员</a>
				<span class="ico-spm-more rf"></span>
			</div>
            <% 
               }%>
			
		</div>--%>
        <div class="buy-box bg-fff moveFromTop" id="buy_con">
			<div class="swiper-container swiper-container-horizontal swiper-container-android">
				<div class="swiper-wrapper">
					<div class="swiper-slide swiper-slide-active" style="margin-right: 150px;">
						
					</div>
				</div>
			</div>
			<div class="clearfix buy-tab">
				<div class="w33p lf pt12 pb12 text-center buy-tab-active">
					<p class="f15px br-e6e6e6">签到送会员</p>
				</div>
				<div class="w33p lf pt12 pb12 text-center">
					<p class="f15px br-e6e6e6">团币兑换会员</p>
				</div>
				<div class="w33p lf pt12 pb12 text-center">
					<p class="f15px">购买会员</p>
				</div>
			</div>
			<div class="buy-con-wrap" style="transform: translate3d(0%, 0px, 0px);">
				<div class="buy-con pt15">
					<div class="ico_sign"></div>
					<p class="f12px text-center buy-p1">APP连续签到3天以上，拆开获赠宝箱，即有<br>机会获得超级会员资格。</p>
					<a <%=IsInApp?"onclick='javascript:Jsbridge.toAppSignIn();'":"onclick='javascript:window.location.href=\"/pages/downopenapp.aspx\"'" %> class="buy-btn1">马上去签到</a>
				</div>
				<div class="buy-con pt15">
					<div class="ico_exchange"></div>
					<p class="f12px text-center buy-p1">前往会员商城，使用团币兑换超级会员资格</p>
					<%--<a onclick="JAVASCRIPT:window.location.href='/Member/Mall/mallIndex.aspx';" class="buy-btn1">前往会员商城</a>--%>
				</div>
				<div class="buy-con buy-con3 pt20">
					<p class="f12px text-center buy-p1 mt0">请选择您需要购买的会员套餐：</p>
					<div class="mt20 clearfix">
						<div class="w33p lf buy1">
							<div class="typeBg text-center">
								<img src="/imgs/member/superMember/1month.png">
								<p class="f17px c-4d4d4d mt8">1个月</p>
								<p class="f20px c-fab600 pt30">¥30</p>
							</div>
						</div>
						<div class="w33p lf buy6">
							<div class="typeBg text-center">
								<img src="/imgs/member/superMember/6month.png">
								<p class="f17px c-4d4d4d mt8">6个月</p>
								<p class="f20px c-fab600 pt30">¥150</p>
							</div>
						</div>
						<div class="w33p lf buy12">
							<div class="typeBg text-center">
								<img src="/imgs/member/superMember/12month.png">
								<p class="f17px c-4d4d4d mt8">12个月</p>
								<p class="f20px c-fab600 pt30">¥288</p>
							</div>
						</div>	
					</div>
				</div>
				
			</div>
		</div>
	</section>

	<!--输入交易秘密-->
	<section class="alert webkit-box box-center" id="inp_pas" style="display: none;">
		<div class="alert-con bg-fff text-center comonAni">
			<div class="ml20 mr20">
				<p class="f15px pt10 pb10 c-999 pos-r bb-dashed-e6e6e6">请输入交易密码</p>
				<p class="pt15 f15px c-333">购买金额</p>
				<p class="f30px c-fa7d00 mt3" id="payMoney">30.00</p>
				<div class="inp-box pos-r mt15">
					<input type="password" placeholder="请输入交易密码" id="txtPassword">
					<a href="javascript:;" class="eye-but  webkit-box box-center" id="eye_but"><i class="block eye-close"></i></a>
				</div>
				<div class="clearfix mt10">
					<a href="/Member/safety/ResetPwd.aspx" class="rf f12px c-fa7d00">忘记密码</a>
				</div>
			</div>
			<div class="webkit-box mt15 bt-e6e6e6">
				<div class="box-flex1 c-808080 f17px text-center pt10 pb10 br-e6e6e6" id="cancel">取消</div>
				<div class="box-flex1 c-fcb700 f17px text-center pt10 pb10" id="income-confirm">确定</div>
			</div>
		</div>
	</section>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/icheck.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jsbridge.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        spaceBetween: 150
    });

    //	立即购买弹窗
    function moveToTop() {
        $('#buy_alert').removeClass('hide');
        $('#buy_con').removeClass('moveToTop').addClass('moveFromTop');
    }
    function moveFromTop() {
        $('#buy_con').removeClass('moveFromTop').addClass('moveToTop');
        setTimeout(function () {
            $('#buy_alert').addClass('hide');
        }, 400);
    }
    $("#upgrade").click(function () {
        if ($('#alert').hasClass('hide')) {
            moveFromTop();
        } else {
            moveToTop();
        }
        disableScrolling();

    });
    $("#buy_alert").click(function () {
        moveFromTop();
        enableScrolling();
    });
    $("#buy_con").click(function () {
        return false;
    });
    var buytime = 0;
    function CgtBuyVip(month, money) {
        if (buytime > 0) {
            $("body").showMessage({ message: "正在请求中...", showCancel: false });
            return false;
        }
        buytime = 1;
        setTimeout(function () {
            buytime = 0;
        }, 5000);
        $.ajax({
            url: "/ajaxCross/ajax_cgt.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "VERIFY_DEDUCT", Month: month,Money:money, IType: "1" },
            success: function (json) {
                if (json.result == "1") {
                    window.location.href = unescape(json.msg);
                } else {
                    $("body").showMessage({ message: json.msg, showCancel: false });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("body").showMessage({ message: "网络不给力，请重试", showCancel: false });
            }
        });
    }
    //点击购买1个月
    $(".buy1").click(function () {
        if ("<%= IsOpenCgt%>" == "True") {
            $("body").showMessage({ message: "温馨提示：点击确认购买后您的资金将会被冻结，并跳转至银行页面进行交易密码验证。若验证未完成，冻结资金将会在10分钟后解冻并退回至您的账户。" ,okbtnEvent:function() {
                CgtBuyVip("1", "30");
            }});
            
        } else {
            $(this).addClass('active');
            $("#payMoney").html("30.00");
            $("#income-confirm").attr("data", "1");
            $("#txtPassword").val("");
            showAniFadeIn("#inp_pas");
        }
        
    });
    //点击购买6个月
    $(".buy6").click(function () {
        if ("<%= IsOpenCgt%>" == "True") {
            $("body").showMessage({
                message: "温馨提示：点击确认购买后您的资金将会被冻结，并跳转至银行页面进行交易密码验证。若验证未完成，冻结资金将会在10分钟后解冻并退回至您的账户。", okbtnEvent: function () {
                    CgtBuyVip("6", "150");
                }
            });
            
        } else {
            $(this).addClass('active');
            $("#payMoney").html("150.00");
            $("#income-confirm").attr("data", "6");
            $("#txtPassword").val("");
            showAniFadeIn("#inp_pas");
        }
        
    });
    //点击购买12个月
    $(".buy12").click(function () {
        if ("<%= IsOpenCgt%>" == "True") {
            $("body").showMessage({
                message: "温馨提示：点击确认购买后您的资金将会被冻结，并跳转至银行页面进行交易密码验证。若验证未完成，冻结资金将会在10分钟后解冻并退回至您的账户。", okbtnEvent: function () {
                    CgtBuyVip("12", "288");
                }
            });
            
        } else {
            $(this).addClass('active');
            $("#payMoney").html("288.00");
            $("#income-confirm").attr("data", "12");
            $("#txtPassword").val("");
            showAniFadeIn("#inp_pas");
        }
        
    });

    $("#cancel").click(function () {
        $(".webkit-box").find('.active').removeClass('active');
        hideAniFadeOut("#inp_pas");
    });
    //点击确认购买
    $("#income-confirm").click(function () {
        var curMonth = $(this).attr("data");
        var pwd = $("#txtPassword").val();
        if (pwd.trim().length <= 0) {
            $("body").showMessage({ message: "交易密码不能为空", showCancel: false });
            return false;
        }
        $.ajax({
            url: "/ajaxCross/Login.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "UpgradeUserVip", Month: curMonth, IType: "1", Pwd: pwd },
            success: function (json) {
                if (json.result == "1") {
                    $("body").showMessage({
                        message: "兑换成功！", showCancel: false, okbtnEvent: function () {
                            window.location.href = window.location.href;//兑换成功后刷新页面
                        }
                    });
                } else {
                    $("body").showMessage({ message: json.msg, showCancel: false });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("body").showMessage({ message: "网络不给力，请重试", showCancel: false });
            }
        });
    });
    //	显示隐藏交易密码
    $("#eye_but").click(function () {
        var $txtPassword = $("#inp_pas").find('input');
        var eye = $(this).find('i');
        if ($txtPassword.attr('type') == 'password') {
            eye.removeClass('eye-close').addClass('eye-open');
            $txtPassword.attr('type', 'text');
        } else {
            eye.removeClass('eye-open').addClass('eye-close');
            $txtPassword.attr('type', 'password');
        }
    });
    $(".buy-tab").find('div').each(function(i, item) {
        $(item).click(function() {
            $(".buy-tab").find('.buy-tab-active').removeClass('buy-tab-active');
            $(this).addClass('buy-tab-active');
            $('.buy-con-wrap').css({
                '-webkit-transform': 'translate3d(-' + i + '00%,0,0)',
                'transform': 'translate3d(-' + i + '00%,0,0)'
            });
        });
    });

    //弹窗阻止滚动
    function scrolling(e) {
        preventDefault(e);
    }
    function preventDefault(e) {
        e = e || window.event;
        if (e.preventDefault) {
            e.preventDefault();
        }
        e.returnValue = false;
    }

    function disableScrolling() {
        if (window.addEventListener) {
            window.addEventListener('DOMMouseScroll', scrolling, false);
            window.addEventListener('touchmove', scrolling, false);
            window.onmousewheel = document.onmousewheel = scrolling;
        }
    }

    function enableScrolling() {
        if (window.removeEventListener) {
            window.removeEventListener('DOMMouseScroll', scrolling, false);
            window.removeEventListener('touchmove', scrolling, false);
        }
        window.onmousewheel = document.onmousewheel = null;
    }
</script>
</html>