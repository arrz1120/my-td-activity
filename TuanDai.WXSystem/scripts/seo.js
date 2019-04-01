var bigDiv = $("#bigDiv");
var isIscroll = false;
try{
	if (typeof(eval(banTouchmove)) == "function") {
        isIscroll = true;
    }else{
    	isIscroll = false;
    }
}catch(e){
	isIscroll = false;
}

function isWeiXin_Func(){
    var ua = navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == 'micromessenger') {
        return true;
    } else {
        return false;
    }
}
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

function buildTop(){
	if(document.URL.indexOf("Index.aspx")!=-1 || document.URL.indexOf("_list.aspx")!=-1 || $('#noSeoTop').length>0){
		return
	}else{
		var top = '<div class="bkTop bb-e6e6e6">'+
			'<a href="https://m.tuandai.com" class="logo"><img src="/imgs/baikedaohang/logo.png?v=124" alt="团贷网"></a>'+
			'<div class="top_right clearfix">'+
				'<a href="javascript:void(0);" class="top_a2 rf webkit-box box-center box-vertical">'+
					'<span></span><span></span><span></span>'+
				'</a>'+
			'</div>'+
		'</div>';
		if (document.URL.indexOf("Register.aspx") != -1 || document.URL.indexOf("register.aspx") != -1 || document.URL.indexOf("Login.aspx") != -1) {
			bigDiv.find('.log-alert').prepend(top)
		}else{
			bigDiv.prepend(top);
		}
	}
}

function buildBottom(){
    if (document.URL.indexOf("Register.aspx") != -1 || document.URL.indexOf("register.aspx") != -1 || document.URL.indexOf("Login.aspx") != -1 || document.URL.indexOf("login.aspx") != -1) {
		return
	}else{
    	var footer = '<footer>' + 
		    '<div class="clearfix bot_nav bg-fff ">' + 
				'<a href="https://m.tuandai.com" class="block w25p text-center pt25 pb20 lf">' + 
					'<div class="ico_bot ico_bot1 margin-auto"></div>' + 
					'<p class="f13px mt8">首页</p>' + 
				'</a>' + 
				'<a href="http://wap.tuandai.com/" class="block w25p text-center pt25 pb20 lf">' +
					'<div class="ico_bot ico_bot2 margin-auto"></div>' + 
					'<p class="f13px mt8">资讯</p>' +
				'</a>' +
				'<a href="http://bk.tuandai.com/" class="block w25p text-center pt25 pb20 lf">' +
					'<div class="ico_bot ico_bot4 margin-auto"></div>' + 
					'<p class="f13px mt8">百科</p>' + 
				'</a>' +
				'<a href="http://ask.tuandai.com/" class="block w25p text-center pt25 pb20 lf">' +
					'<div class="ico_bot ico_bot3 margin-auto"></div>' +
					'<p class="f13px mt8">问答</p>' +
				'</a>' + 
			'</div>' +
			'<div class="bottom ">' + 
				'<div class="clearfix bot_link">' + 
					'<a href="javascript:void(0);" class="c-999999 f13px text-center lf w33p" id="callUs">联系我们</a>' + 
					'<a href="https://m.tuandai.com/user/login.aspx?tdfrom=tdbk-P1608" class="c-999999 f13px text-center lf w33p" rel="nofollow">用户登录</a>' + 
					'<a href="https://www.tuandai.com/default.aspx?devicetype=tuandaicp" class="c-999999 f13px text-center lf w33p" rel="nofollow">电脑版</a>' + 
				'</div>' + 
				'<p class="copyright c-ababab f11px text-center mt13">2010-' + new Date().getFullYear() + ' 版权所有 © 团贷网 粤ICP备12043601号-1</p>' +
    	     '<p class="copyright c-ababab f11px text-center">东莞团贷网互联网科技服务有限公司</p>' +
			'</div>' +
		'</footer>';
		
		if(isIscroll){
			if($('#pullUp').css('display') == 'none' || document.URL.indexOf("noticelist.aspx")!=-1){
				$('#scroller').append(footer);
			}else{
				$('#pullUp').before(footer);
			}
		}else{
			var pageContainer = bigDiv.find('.pageContainer')
			if(pageContainer && pageContainer.html()!= undefined && pageContainer.html()!= ''){
				pageContainer.append(footer);
			}else{
				bigDiv.append(footer);
			}
		}
		
		if(document.URL.indexOf("noticelist.aspx")!=-1 ||  document.URL.indexOf("noticedetails.aspx")!=-1 || document.URL.indexOf("invest_newHand.aspx")!=-1 ||  document.URL.indexOf("BigData.aspx")!=-1 || document.URL.indexOf("WeFtb_detail.aspx")!=-1){
			$('footer').addClass('mt0');
		}
		if(document.URL.indexOf("invest_newHand.aspx")!=-1){
			$('footer').addClass('bt-e6e6e6');
		}
	}
}

function buildNav(){
	var nav = '<div class="normalAlert moveToLeft hide" id="glAlert">'+
			'<header class="bkTop bb-e6e6e6">'+
				'<h1 class="logo"><img src="/imgs/baikedaohang/logo.png?v=124" alt="团贷网"></h1>' +
				'<div class="top_right clearfix">'+
					'<a href="javascript:void(0);" class="alertClose1 rf"></a>'+
				'</div>'+
			'</header>'+
			'<div class="gl_detail">'+
			  /*
				'<div class="mt22 pb20">'+
					'<div class="clearfix">'+
						'<a href="https://m.tuandai.com" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico1"></div>'+
							'<p class="f14px c-333333 mt6">团贷首页</p>'+
						'</a>'+
						'<a href="https://m.tuandai.com/pages/invest/WE/WE_list.aspx" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico2"></div>'+
							'<p class="f14px c-333333 mt6">我要投资</p>'+
						'</a>'+
						'<a href="https://m.tuandai.com/Member/my_account.aspx" rel="nofollow" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico3"></div>'+
							'<p class="f14px c-333333 mt6">个人中心</p>'+
						'</a>'+
					'</div>'+
				'</div>'+
				
				'<div class="pl30 pr30">'+
					'<div class="bb-e6e6e6"></div>'+
				'</div>'+
				*/
				'<div class="pt25">'+
					'<div class="clearfix">'+
						'<a href="http://wap.tuandai.com" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico4"></div>'+
							'<p class="f14px c-333333 mt6">资讯</p>'+
						'</a>'+
						'<a href="http://bk.tuandai.com/" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico5"></div>'+
							'<p class="f14px c-333333 mt6">百科</p>'+
						'</a>'+
						'<a href="http://ask.tuandai.com/" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico6"></div>'+
							'<p class="f14px c-333333 mt6">问答</p>'+
						'</a>'+
					'</div>'+
					'<div class="clearfix pt20">'+
						'<a href="https://m.tuandai.com/user/Register.aspx" rel="nofollow" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico7"></div>'+
							'<p class="f14px c-333333 mt6">注册</p>'+
						'</a>'+
						'<a href="https://m.tuandai.com/user/Login.aspx" rel="nofollow" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico8"></div>'+
							'<p class="f14px c-333333 mt6">登录</p>'+
						'</a>'+
						'<a href="https://m.tuandai.com/pages/invest/WE/WE_list.aspx" class="block w33p lf text-center">'+
							'<div class="seo_ico seo_ico2"></div>'+
							'<p class="f14px c-333333 mt6">我要投资</p>'+
						'</a>'+
					'</div>'+
				'</div>'+
			'</div>'+
		'</div>';
	
	$('body').append(nav);
}

function buildContactUs(){
	if(document.URL.indexOf("Register.aspx")!=-1 || document.URL.indexOf("Login.aspx")!=-1 ){
		return
	}else{
		var contactUs = '<div class="normalAlert hide" id="callUsAlert">'+
				'<div class="callUsCon">'+
					'<p class="c-999999 f15px pt15 text-center">电话：1010-1218</p>' +
					'<p class="c-999999 f15px pt15 text-center">微信服务号：团贷网服务平台</p>'+
					'<p class="c-999999 f15px pt15 text-center">微信订阅号：团贷网</p>'+
				'</div>'+
				'<div class="ico_bot ico_close2"></div>'+
			'</div>';
		$('body').append(contactUs);
	}
}

//攻略弹窗标签显示隐藏切换
function lableTab() {
	$(".gl_tit").each(function(i, item) {
		$(item).click(function() {
			var gl_lableBox = $(this).next();
			var arrow = $(this).find('i');
			if(gl_lableBox.css('display') == 'none') {
				arrow.css('-webkit-transform', 'rotateZ(-90deg)');
				gl_lableBox.slideDown(300);
			} else {
				arrow.css('-webkit-transform', 'rotateZ(90deg)');
				gl_lableBox.slideUp(300);
			}
		})
	})
}

//攻略弹窗
function dealAlert() {
	var bigDiv = $('#bigDiv');
	var glAlert = $('#glAlert');
	var callUsAlert = $('#callUsAlert');
	glAlert.unbind();
	callUsAlert.unbind();
	var scrollT = 0;
	$(".top_a2").click(function() {
		if(isIscroll){
			$(document).unbind('touchmove');
		}
		glAlert.removeClass('moveToRight').removeClass('hide').addClass('moveToLeft');
		setTimeout(function() {
			bigDiv.addClass('hide');
		}, 300);
	});
	$(".alertClose1").click(function() {
		bigDiv.removeClass('hide');
		glAlert.removeClass('moveToLeft').addClass('moveToRight');
		if(isIscroll){
			banTouchmove();
		}
		setTimeout(function() {
			glAlert.addClass('hide');
		}, 300);
	})
	$("#callUs").click(function() {
		scrollT = $(window).scrollTop();
		if(isIscroll){
			$(document).unbind('touchmove');
		}
		$(window).scrollTop(0);
		callUsAlert.removeClass('moveToRight').removeClass('hide').addClass('moveToLeft');
		setTimeout(function() {
			bigDiv.addClass('hide');
		}, 300);
	});
	$(".ico_close2").click(function() {
		bigDiv.removeClass('hide');
		$(window).scrollTop(scrollT);
		callUsAlert.removeClass('moveToLeft').addClass('moveToRight');
		if(isIscroll){
			banTouchmove();
		}
		setTimeout(function() {
			callUsAlert.addClass('hide');
		}, 300);
	})
}

function init(){
	var weixin = isWeiXin_Func();
	if(GetQueryString('type') == 'mobileapp' || weixin == true){
		return;
	}else{
		buildTop();
		buildBottom();
		buildNav();
		buildContactUs();
		dealAlert();
		lableTab();
	}
}

$(function(){
	init();
})
