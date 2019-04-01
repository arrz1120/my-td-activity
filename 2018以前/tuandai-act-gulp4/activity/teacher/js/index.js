(function() {
	FastClick.attach(document.body);
	//do your thing.


	// 基础分2分

	var score = 2;



	$('.choice').find('.btn').on('click', function(e) {
		var _this = $(this);

		var data_num = _this.attr('data-num');
		var cur_scene = _this.parents('.scene_wraper');

		cur_scene.find('.choice_box').hide();

		cur_scene.find('.choice_' + data_num).show();

		if (data_num == 2) {
			score++;
		}


		setTimeout(function() {
			if (cur_scene.next('.scene_wraper').length != 0) {

				if (cur_scene.next('.scene_wraper').hasClass('last_scene')) {

					setResult(score)
				}

				cur_scene.fadeOut('1000');
				cur_scene.next('.scene_wraper').fadeIn('1000');


			} else {

				//最后一屏幕
			}

		}, 1300);


		console.log(score);


	});


	var result_img = $('#result_img');

	function setResult(score) {
		switch (score) {
			case 2:
				result_img.attr('src', '../images/r_1.png');
				break;
			case 3:
				result_img.attr('src', '../images/r_2.png');
				break;
			case 4:
				result_img.attr('src', '../images/r_3.png');
				break;
			case 5:
				result_img.attr('src', '../images/r_4.png');
				break;
			default:
				break;

		}
	}


	$('#word_val').on('focus', function() {
		$('#tips').hide();
	});



	//手机兼容

	var w = $(window).width(),
		h = $(window).height(),
		rate = w / h;
	if (rate > 0.65) {
		$('body').addClass('fixed');
	}

	if (rate > 0.686) {
		$('body').addClass('fixed_1');

	}


    //是否微信访问
    function isWeiXin() {
        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == 'micromessenger') {
            return true;
        } else {
            return false;
        }
    }

	function autoPlayAudio1() {
		wx.config({
			// 配置信息, 即使不正确也能使用 wx.ready
			debug: false,
			appId: '',
			timestamp: 1,
			nonceStr: '',
			signature: '',
			jsApiList: []
		});
		wx.ready(function() {

			audio[0].play();


		});
	}

	autoPlayAudio1();



	//音乐播放
	var audio = $("#media");
	//app需要放音乐的绝对路径
	var vHdUrl = "https://at.tuandai.com";

	function autoPlay() {
		if (Jsbridge.isApp()) {
			Jsbridge.appPlayMusic(vHdUrl + '/201708/qixi/music/music.mp3');
		} else {
			if (isWeiXin()) {
				document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
					WeixinJSBridge.invoke('getNetworkType', {}, function(e) {
						audio.get(0).play();
					});
				});
			} else {
				document.addEventListener('touchstart', function() {
					audio.get(0).play();
				});
			}
		}
	}

	function musicPlay() {
		if (Jsbridge.isApp()) {
			Jsbridge.appPlayMusic(vHdUrl + '/201708/qixi/music/music.mp3');
		} else {
			audio.get(0).play();
		}
	}

	function musicPause() {
		if (Jsbridge.isApp()) {
			Jsbridge.appStopMusic();
		} else {
			audio.get(0).pause();
		}
	}
	autoPlay();
	Jsbridge.appLifeHook(null, function() {
		autoPlay();
	}, function() {
		musicPause();
	}, null, null);



})();