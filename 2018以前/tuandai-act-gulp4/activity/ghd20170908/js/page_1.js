(function() {
	FastClick.attach(document.body);
	//do your thing.



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



	//打字效果

	var input_type = {
		init: function($obj, $objCon, callBack) {
			this.name = $obj.html().split("")
			this.length = this.name.length;
			this.i = 0;
			this.box = $objCon;
			this.callBack = callBack;
		},
		pri: function() {
			var $this = this
				//在此处只能使用闭包，因为windown.settimeout使函数的this指向object windown，而非原型链的this对象。而此时我需要递归，所以只能将this对象传到闭包内，递归匿名的闭包函数。
			return (function() {
				if ($this.i > $this.length) {
					window.clearTimeout(Go);



					$this.callBack && $this.callBack();
					return false;
				}
				var char = $this.name
				$this.box.append(char[$this.i])
				$this.i++
					var Go = window.setTimeout(arguments.callee, 100) //在这里arguments.callee妙用因为是匿名闭包，调用函数本身。
			})
		}
	}


	//建立class类
	function Input_type() {
		this.init.apply(this, arguments)
	}

	Input_type.prototype = input_type

	//创建实例




   // 打字

	var page_1 = new Input_type($("#txt_box"), $("#show_box"), function() {
		//打字结束，暂停音乐
		musicPause();
	})
	page_1.pri()();





})();