(function() {
	FastClick.attach(document.body);
	//do your thing.
	var sharebtn = $('.shareBtn'),
		menu_btn = $('.menu_btn'),
		arrow = $('.arrow');

	/*menu*/
	var menu = $('#menu'),
		menu_con = $('#menu_con'),
		menu_btn = $('.menu_btn');

	function isBtnShow(index) {
		if (index == 0) {
			sharebtn.hide();
			menu_btn.hide();
		} else {
			sharebtn.show();
			menu_btn.show();
		}


		if (index == 20) {
			arrow.hide();
		} else {
			arrow.show();
		}

	}


	var swiper = new Swiper('.swiper-container', {
		direction: 'vertical',
		lazyLoading: true,
		lazyLoadingInPrevNextAmount: 2,
		onInit: function(swiper) {
			isBtnShow(swiper.activeIndex);
		},
		onTransitionEnd: function(swiper) {
			isBtnShow(swiper.activeIndex);
			menu.find('.cur').removeClass('cur');
			if (swiper.activeIndex > 0 && swiper.activeIndex < 10) {
				menu.find('.list li').eq(0).addClass('cur');
			} else if (swiper.activeIndex >= 10 && swiper.activeIndex < 15) {
				menu.find('.list li').eq(1).addClass('cur');
			} else if (swiper.activeIndex >= 15 && swiper.activeIndex < 16) {
				menu.find('.list li').eq(2).addClass('cur');
			}else if (swiper.activeIndex >= 16 && swiper.activeIndex < 18) {
				menu.find('.list li').eq(3).addClass('cur');
			}else if (swiper.activeIndex >= 18) {
				menu.find('.list li').eq(4).addClass('cur');
			}


		}
	});


	//手机兼容

	var w = $(window).width(),
		h = $(window).height(),
		rate = w / h;
	if (rate > 0.65) {
		$('body').addClass('fixed');
	}

	if (rate > 0.7) {
		$('body').addClass('fixed_1');
	}



	//分享


	$('#back').on('click', function(e) {
		e.preventDefault();
		swiper.slideTo(0, 0, true);

	})

	var shareArr = {
		'wx': {
			'src': 'wxdyh-big.png?v=20161011',
			'name': '团贷网微信订阅号（ tuandaiwang）',
			'txt': '长按并复制微信号查找添加<br>或截屏后在微信端打开识别二维码'
		},
		'wxservice': {
			'src': 'wxfwh-big.png?v=20161011',
			'name': '团贷网微信服务号（tuandaiservice）',
			'txt': '长按并复制微信号查找添加<br>或截屏后在微信端打开识别二维码'
		},
		'wb': {
			'src': 'weibo-big.png?v=20161010',
			'name': '新浪微博@团贷网',
			'txt': '在新浪微博搜索“团贷网”添加关注<br>或截屏后在微信端打开识别二维码'
		}
	}
	$('#ewm-list').find('li').on('touchstart', function() {
		var num = $(this).attr('data-num');
		$('#ewm').attr('src', '../images/share/' + shareArr[num].src);
		$('.ew-name').html(shareArr[num].name);
		$('.ewtxt').html(shareArr[num].txt);
		$('.ewmask').show();
	});

	$('.p-cancle').on('click', function() {
		$('.ewmask').hide();
	});



	function isWeiXin() {
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

	$(".shareBtn").click(function(e) {
		e.preventDefault();
		if (GetQueryString('type') == 'mobileapp') {
			Jsbridge.toAppActivity(6);
		} else {
			if (isWeiXin()) {
				$("#wxAlert").show();
			} else {
				alert('打开app即可分享');
			}
		}

	});

	$("#wxAlert").find('.know').on('click', function(e) {
		e.preventDefault();
		$('#wxAlert').hide();
	});



	$('#menu_mask,#menu_close').on('click', function(e) {
		e.preventDefault();
		menu_con.addClass('menu_con_hide').removeClass('menu_con_show');
		setTimeout(function() {
			menu.hide();
		}, 200)

	});


	menu_btn.on('click', function(e) {
		menu.show();
		setTimeout(function() {

			menu_con.removeClass('menu_con_hide').addClass('menu_con_show');
		}, 100)

	});

	menu_con.find('li').on('click', function(e) {
		e.preventDefault();
		var num = $(this).attr('data-num');
		swiper.slideTo(num, 0, true);

		$(this).addClass('cur');
		$(this).siblings().removeClass('cur');
		menu_con.addClass('menu_con_hide').removeClass('menu_con_show');
		setTimeout(function() {
			menu.hide();
		}, 100)
	});


})();