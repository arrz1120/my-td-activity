(function () {
	FastClick.attach(document.body);
	//do your thing.

	function isWeiXin() {
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) == 'micromessenger') {
			return true;
		} else {
			return false;
		}
	}




	//音乐

	// var audio = $("#media");




	// //微信初始化配置
	function weixiRready() {
		wx.config({
			// 配置信息, 即使不正确也能使用 wx.ready
			debug: false,
			appId: '',
			timestamp: 1,
			nonceStr: '',
			signature: '',
			jsApiList: []
		});
		wx.ready(function () {

			audio[0].play();

			var mql = window.matchMedia("(orientation: portrait)");
			// 如果有匹配，则我们处于垂直视角
			if (mql.matches) {
				// 竖屏
				wx_tips.show();
				audio[0].pause();
			} else {
				//横屏
				wx_tips.hide();

			}

		});
	}









	weixiRready();




	//微信端手机横竖屏幕切换的


	var wx_tips = $('#wx_tips');


	var mql = window.matchMedia("(orientation: portrait)");
	function onMatchMeidaChange(mql) {
		if (mql.matches) {
			// 竖屏
			wx_tips.show();
		} else {
			// 横屏
			wx_tips.hide();
		}
	}
	onMatchMeidaChange(mql);
	mql.addListener(onMatchMeidaChange);






	$(".music_btn").on('click', function (e) {
		if ($(this).hasClass("pause_btn")) {
			$(this).removeClass("pause_btn");
			audio[0].play();
		} else {
			$(this).addClass("pause_btn");
			audio[0].pause();
		}
	});


	// 首页开始游戏


	$('#btn_start').on('click', function () {


		if (Jsbridge.isApp()) {
			//放绝对地址
			Jsbridge.toAppViedoWebView(1, 'http://10.100.99.175:3002/html/game.html');
		} else {
			window.location.href = '../html/game.html';
		}
	});



	var rule_alert = $('#rule_alert');


	rule_alert.find('nav div').on('click', function () {
		$(this).siblings().removeClass('cur');
		$(this).addClass('cur');
		var index = $(this).index();
		rule_alert.find('.content').removeClass('cur_con');
		rule_alert.find('.content').eq(index).addClass('cur_con');
	});



	$('.close').on('click', function (e) {
		e.preventDefault();
		$(this).parents('.alert').hide();


		// 押注弹窗的关闭按钮，关闭时,需要开启,“开始游戏”按钮开关

		if ($(this).hasClass('yz_close')) {
			$('#start_game').addClass('can_play');
		}
	})



	$('.rule_btn').on('click', function () {
		rule_alert.show();
	})



	//分享

	if (Jsbridge.isApp()) {
		$('#btn_quit').show();
	}

	$('#btn_quit').on('click', function (e) {
		e.preventDefault();
		$('#quit_alert').show();
	});


	// 退出游戏后清除项目所有session内的数据
	$('#quit_btn').on('click', function (e) {
		e.preventDefault();
		Jsbridge.toAppMainPage();
	})






})();