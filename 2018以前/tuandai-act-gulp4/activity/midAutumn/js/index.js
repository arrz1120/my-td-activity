(function() {
	FastClick.attach(document.body);
	//do your thing.


	//屏蔽ios下上下弹性
	$(window).on('scroll.elasticity', function(e) {
		e.preventDefault();
	}).on('touchmove.elasticity', function(e) {
		e.preventDefault();
	});



	$('.share').on('click', function() {
		window.appShare.set({
			iconUrl: '',
			title: '',
			content: '',
			shareUrl: '',
			wxShareImg: {
				url: '../images/share_img.png',
				style: {
					width: '100%',
				}
			},
			callback: function(result) {
				var status;
				//status:
				//成功:'onComplete'，失败:'onError'，取消:'onCancel'
				if (isIOS()) {
					status = result;
				} else {
					status = JSON.parse(result).ShareResult;
				}
			}
		})
	});



	//音乐
	var loadAudio = new LoadAudio('http://10.100.65.169:3000/music/bg.mp3', {});
	window.loadAudio = loadAudio;


})();