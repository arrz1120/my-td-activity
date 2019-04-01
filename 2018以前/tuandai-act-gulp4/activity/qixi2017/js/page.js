;
(function() {
	FastClick.attach(document.body);
	//do your thing.

	//音乐播放
	var audio = $("#media");
	var audio2 = $("#media2");
	var vHdUrl = "http://10.100.1.100:3000";

	function isAndroid() {
		var useragent = navigator.userAgent;
		if(useragent.indexOf("tuandaiapp_android") != -1) {
			return true;
		} else {
			return false;
		}
	}

	function isWeiXin() {
		var ua = navigator.userAgent.toLowerCase();
		if(ua.match(/MicroMessenger/i) == 'micromessenger') {
			return true;
		} else {
			return false;
		}
	}

	function autoPlay() {
		if(isAndroid()) {
			Jsbridge.appPlayMusic(vHdUrl + '/201708/qixi/music/music.mp3');
		} else {
			if(isWeiXin()) {
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

	function musicPlay(type) {
		if(isAndroid()) {
			Jsbridge.appPlayMusic(vHdUrl + '/music/music.mp3');
		} else {
			audio.get(0).play();
			if(type == 'beat') {
				audio2.get(0).play();
			}
		}
	}

	function musicPause() {
		if(isAndroid()) {
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

	function touchLeft(page, callback) {
		var slider = $(page);
		slider.on('touchstart', function(e) {
			var touch = e.originalEvent,
				startX = touch.changedTouches[0].pageX;
			startY = touch.changedTouches[0].pageY;
			slider.on('touchmove', function(e) {
				e.preventDefault();
				touch = e.originalEvent.touches[0] ||
					e.originalEvent.changedTouches[0];
				if(touch.pageX - startX < -10) {
					console.log("左划");
					slider.off('touchmove');
					callback();
				};
			});
			return false;

		}).on('touchend', function() {
			slider.off('touchmove');
		});
		return false;
	}

	function biaobai() {
		if($(".heart").hasClass('heart-shake')) {
			setTimeout(function() {
				$(".heart").removeClass('heart-shake').addClass('heart-move');
			}, 500)
			setTimeout(function() {
				$(".goodMan").show();
			}, 2500)
			setTimeout(function() {
				$(".heart").removeClass('heart-move').css('background-image', 'url(images/heartBreak.png)');
			}, 3200)
			setTimeout(function() {
				pageSwiper.slideTo(1, 500, true);
			}, 5000)
		}
	}

	function fahongbao() {
		$(".fahongbao").hide();
		$(".talk7").css('opacity', 1).addClass('talk-show');
		setTimeout(function() {
			$(".wxBg").html('').removeClass('box-center');
			var answer =
				'<div class="answer1 talk-show"><img src="images/talk7.png" /></div>' +
				'<div class="answer2 talk-show"><img src="images/linhongbao.png" /></div>' +
				'<div class="answer3 talk-show"><img src="images/answer3.png" /></div>';
			$(".wxBg").append(answer);
		}, 1000)
		setTimeout(function() {
			$(".viewBreak").show().addClass('flash');
		}, 3500)
		setTimeout(function() {
			pageSwiper.slideTo(3, 500, true);
		}, 5000)
	}

	function zipai() {
		$(".huaixiao").show();
		setTimeout(function() {
			pageSwiper.slideTo(5, 500, true);
		}, 1000);
	}

	var pageSwiper = new Swiper("#pageSwiper", {
		initialSlide: 0,
		noSwiping: true,
		direction: 'vertical',
		allowSwipeToPrev: false,
		lazyLoading: true,
		lazyLoadingInPrevNextAmount: 2,
		onInit: function(swiper) {
			setTimeout(function() {
				$(".hand").show().addClass('hand-move');
				touchLeft('.page1', biaobai);
			}, 5200);
		},
		onSlideChangeEnd: function(swiper) {
			if(swiper.activeIndex == 2) {
				setTimeout(function() {
					$(".hand").show().addClass('hand-move');
					touchLeft('.wxBg', fahongbao);
				}, 5200);
			}
			if(swiper.activeIndex == 4) {
				setTimeout(function() {
					touchLeft('.page5', zipai);
				}, 1000);
			}
			if(swiper.activeIndex == 6) {
				setTimeout(function() {
					musicPlay('beat');
				}, 2000);
			}
		}
	})

	$("#mask").find('textarea').on('input', function() {
		var val = $(this).val();
		if($(this).val() == '') {
			$(".textareaTips").show();
		} else {
			$(".textareaTips").hide();
		}
		if(val.length >= 30) {
			$(".inputTips").html('最多输入30个字').fadeIn();
		} else {
			$(".inputTips").fadeOut();
		}
	})

	$(".textareaTips").click(function() {
		$("#mask").find('textarea').focus();
	})

	$(".btn-close").click(function() {
		$("#mask").hide();
	})

	$(".page-btn1").click(function() {
		$("#mask").show();
		nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), 'qixilaxin_Activity201708', '评论', '打开文本框', 1, '', '', 'TDW_WX');
	})
	$(".page-btn2").click(function() {
		window.sessionStorage['isBack'] = "isBack";
		nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), 'qixilaxin_Activity201708', '广告', '广告', 1, '', '', 'TDW_WX');
		location.href = "https://hd.tuandai.com/weixin/newhand/welfarenew.aspx";
	})

	$("#wxAlert").click(function() {
		$(this).hide();
	})

	function setStorage() {
		if(window.sessionStorage['isBack'] != "" && window.sessionStorage['isBack'] == "isBack") {
			window.sessionStorage['isBack'] = "";
			pageSwiper.slideTo(7, 1, true);
		}
	}

	window.onload = function() {
		setStorage();
	}
})();