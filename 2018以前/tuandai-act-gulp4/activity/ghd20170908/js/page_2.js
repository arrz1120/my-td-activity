(function() {
	FastClick.attach(document.body);
	//do your thing.


	var audio = $("#media"),
		talk = $('.talk'),
		mys = $('.mys'),
		open_door = $('.open_door');

	function autoPlayAudio1() {
		wx.config({
			debug: false,
			appId: '',
			timestamp: 1,
			nonceStr: '',
			signature: '',
			jsApiList: []
		});
		wx.ready(function() {
			audio[0].play();
			audio[0].pause();
		});
	}

	autoPlayAudio1();



	var timer = 2200;

	setTimeout(function() {
		audio[0].play();
		// page_1 打字
		var page_2 = new Input_type($(".txt_val"), $(".txt"), function() {
			//打字结束，暂停音乐
			audio[0].pause();
			// 明月石显示
			setTimeout(function() {
				talk.hide();
				mys.fadeIn();
			}, 500)
		});
		page_2.pri()();
	}, timer);


	$('.skip').on('click', function() {
		talk.hide();
		mys.fadeIn();
		audio[0].pause();
	});


	$('.mys_img').on('click', function() {
		mys.hide();
		open_door.show();
		open_door.addClass('opening');

		setTimeout(function() {
				window.location.href='game.html'
		}, 1000);
	});


})();