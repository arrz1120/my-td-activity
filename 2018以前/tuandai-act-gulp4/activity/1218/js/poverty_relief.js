(function() {
	FastClick.attach(document.body);
	//do your thing.


	var swiper_msg = new Swiper('#swiper-container-msg', {
		// scrollbar: '.swiper-scrollbar',
		direction: 'vertical',
		slidesPerView: 'auto',
		mousewheelControl: true,
		freeMode: true,
		onInit: function() {
			var height = $('.swiper-slide-msg').height();
		}

	});

	var containerTop = $('#swiper-container-msg')[0].getBoundingClientRect().top;


	$('.arrow_more').on('click', function(e) {

		if ($(this).hasClass('arrow_more_up')) {
			swiper_msg.setWrapperTranslate(0);

		} else {
			var txt_top = $('#next')[0].getBoundingClientRect().top - containerTop;
			swiper_msg.setWrapperTranslate(swiper_msg.getWrapperTranslate() - txt_top);
		}

		$(this).toggleClass('arrow_more_up');
	})


	//video


	var player;

	function showVideo(domid, vid) {
		player = new YKU.Player(domid, {
			client_id: '52b3fa57e9fe17cf',
			autoplay: true,
			vid: vid,
			show_related: false
		});
	}
		showVideo('video1', 'XMzIxNTMwODk3Ng==');



	// $('#v1').on('click', function() {
	// 	$('.video_img').show();
	// 	$(this).hide();
	// 	showVideo('video1', 'XMzIxNTMwODk3Ng==');
	// });



  // var ykVideo = new YkVideo({
  //   el: 'video1',
  //   videoId: 'XMzIxNTMwODk3Ng==', // 优酷视频ID
  //   posterClass: 'video_bg', // 背景样式
  //   onPlayStart: function() {},
  //   onPlayEnd: function() {},
  //   onPlayInit: function(e) {
  //     $(e.playerCon).find('.i_fscreen');
  //     if (navigator.userAgent.match(/(OPPO);?[\s\/]+([\d.]+)?/)) {
  //       $(e.playerCon).find('.i_fscreen').hide();
  //     }
  //   },

  // });


		showVideo('video1', 'XMzIxNTMwODk3Ng==');
  

	function isWeiXin() {
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) == 'micromessenger') {
			return true;
		} else {
			return false;
		}
	}


	$('.comp-share-btn').on('click', function() {
		if (isWeiXin()) {
			$("#video1").hide();
		}
		setTimeout(function() {
			$('.prc-share').one('click', function() {
			$("#video1").show();


			})

		}, 0)

	})

})();