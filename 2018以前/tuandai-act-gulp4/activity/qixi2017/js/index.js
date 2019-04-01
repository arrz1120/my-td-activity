;
(function() {
	FastClick.attach(document.body);
	//do your thing.

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

	//音乐播放
	var audio = $("#media");
//	var vHdUrl = "https://at.tuandai.com";
	var vHdUrl = "http://10.100.1.100:3000";

	function autoPlay() {
		if(isAndroid()) {
			Jsbridge.appPlayMusic(vHdUrl + '/music/music.mp3');
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

	function musicPlay() {
		if(isAndroid()) {
			Jsbridge.appPlayMusic(vHdUrl + '/201708/qixi/music/music.mp3');
		} else {
			audio.get(0).play();
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
})();