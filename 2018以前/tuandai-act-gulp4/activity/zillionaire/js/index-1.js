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

	// function GetQueryString(name) {
	// 	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	// 	var r = window.location.search.substr(1).match(reg);
	// 	if (r != null) return unescape(r[2]);
	// 	return null;
	// }






	//音乐

	// var audio = $("#media");


	//app需要放音乐的绝对路径
	// var vHdUrl = "https://at.tuandai.com";


	//微信初始化配置
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

			// audio[0].play();

			var mql = window.matchMedia("(orientation: portrait)");
			// 如果有匹配，则我们处于垂直视角
			if (mql.matches) {
				// 竖屏
				wx_tips.show();
				// audio[0].pause();
			} else {
				//横屏
				wx_tips.hide();

			}

		});
	}





	// function musicPlay() {
	// 	if (Jsbridge.isApp()) {
	// 		Jsbridge.appPlayMusic(vHdUrl + '/201708/qixi/music/music.mp3');
	// 	} else {
	// 		audio[0].play();
	// 	}
	// }

	// function musicPause() {
	// 	if (Jsbridge.isApp()) {
	// 		Jsbridge.appStopMusic();
	// 	} else {
	// 		audio[0].pause();
	// 	}
	// }

	//app 生命周期里 调用音乐接口

	Jsbridge.appLifeHook(null, function () {
		// autoPlay();
		// Jsbridge.appPlayMusic(vHdUrl + '/201708/qixi/music/music.mp3');
		alert(1);
		Jsbridge.toAppMainPage();
	}, function () {
		// musicPause();
		// Jsbridge.appStopMusic();

	}, null, null);




	weixiRready();



	$(".music_btn").on('click', function (e) {
		if ($(this).hasClass("pause_btn")) {
			$(this).removeClass("pause_btn");
			musicPlay();
		} else {
			$(this).addClass("pause_btn");
			musicPause();
		}
	});



	//微信端手机横竖屏幕切换的


	var wx_tips = $('#wx_tips');


	// if (isWeiXin()) {



	// } else {
	// 	alert('打开app即可分享');
	// }




	var mql = window.matchMedia("(orientation: portrait)");
	function onMatchMeidaChange(mql) {
		if (mql.matches) {
			// 竖屏
			wx_tips.show();
			// audio[0].pause();

		} else {
			// 横屏
			wx_tips.hide();
			// audio[0].play();
		}
	}
	onMatchMeidaChange(mql);
	mql.addListener(onMatchMeidaChange);



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

	if(Jsbridge.isApp()){
    $('#btn_quit').show();







	}

	$('#btn_quit').on('click', function(e) {
		e.preventDefault();
		$('#quit_alert').show();

	});


	    // 退出游戏后清除项目所有session内的数据
			$('#quit_btn').on('click', function(e) {
				e.preventDefault();
				// clearSessionData();
				// alert(1);
				Jsbridge.toAppLogin();
			})


	$('#share_btn').on('click', function () {
		window.appShare.set({
			iconUrl: '',
			title: '',
			content: '',
			shareUrl: '',
			wxShareImg: {
				url: '../images/share-shade.png',
				style: {
					width: '90%',
					right:'-10%',
					'position':'absolute'
				}
			},
			custom: []
		})
	});

})();