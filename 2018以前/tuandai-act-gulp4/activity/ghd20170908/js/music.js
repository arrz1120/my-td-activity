//是否微信访问
function isWeiXin() {
	var ua = navigator.userAgent.toLowerCase();
	if (ua.match(/MicroMessenger/i) == 'micromessenger') {
		return true;
	} else {
		return false;
	}
}


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

		audio[0].play();

	}
}

function musicPause() {
	if (Jsbridge.isApp()) {
		Jsbridge.appStopMusic();
	} else {
		audio[0].pause();

	}
}


Jsbridge.appLifeHook(null, function() {
	autoPlay();
}, function() {
	musicPause();
}, null, null);
