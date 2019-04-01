(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	var videoSwiper = new Swiper("#videoSwiper", {
		autoplay : 5000,
		autoplayDisableOnInteraction : false,
		onSlideChangeStart:function(swiper){
			var index = swiper.activeIndex;
			$(".videoTab").find('.tab-item').removeClass('tab-item-cur');
			$(".videoTab").find('.tab-item').eq(index).addClass('tab-item-cur');
			switch(index) {
				case 0:
					resetVideo.videoA();
					resetVideo.video2();
					resetVideo.video3();
					resetVideo.video4();
					break;
				case 1:
					resetVideo.videoA();
					resetVideo.video1();
					resetVideo.video3();
					resetVideo.video4();
					break;
				case 2:
					resetVideo.videoA();
					resetVideo.video1();
					resetVideo.video2();
					resetVideo.video4();
					break;
				case 3:
					resetVideo.videoA();
					resetVideo.video1();
					resetVideo.video2();
					resetVideo.video3();
					break;
				default:
					break;
			}
		}
	})
	
	$(".videoTab").find('.tab-item').each(function(i,item){
		$(item).click(function(){
			$(this).siblings().removeClass('tab-item-cur');
			$(this).addClass('tab-item-cur');
			videoSwiper.slideTo(i,300,true);
		})
	})

	$(".text-input").find('textarea').on('input', function() {
		var val = $(this).val();
		if($(this).val() == '') {
			$("#inputTips").show();
		} else {
			$("#inputTips").hide();
		}
	})
	
	var resetVideo = {
		videoA: function() {
			$("#video_a").html('');
			$("#videoA").show();
		},
		video1: function() {
			$("#videoCover1").show();
			$("#video1").html('');
		},
		video2: function() {
			$("#videoCover2").show();
			$("#video2").html('');
		},
		video3: function() {
			$("#videoCover3").show();
			$("#video3").html('');
		},
		video4: function() {
			$("#videoCover4").show();
			$("#video4").html('');
		}
	}
	
	
	function showVideo(domid,vid,obj){
		if(Jsbridge.isCorrectVersion('5.1.1', true)) {
		    var webUrl = 'http://10.100.11.110:9200/201709/20170901zhibo/weixin/html/';
			var videoUrl = webUrl + 'video.html?vid=' + vid;
			Jsbridge.toAppViedoWebView(1, videoUrl);
		}else{
			obj.hide();
			var player = new YKU.Player(domid, {
				client_id: '52b3fa57e9fe17cf',
				vid: vid,
				show_related: false,
				newPlayer: true,
				autoplay: true
			});
		}
	}

	$("#videoA").on('click', function () {
	    nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), '20170901zhibo_Activity201709', '视频点击量', '深入了解车易贷业务流程', 1, '', '', shebei);
		resetVideo.video1();
		resetVideo.video2();
		resetVideo.video3();
		resetVideo.video4();
		showVideo('video_a', 'XMzAxMDcwMTUyOA==',$(this));
	})
	
	//高管访谈
	$("#videoCover1").on('click', function () {
	    nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), '20170901zhibo_Activity201709', '视频点击量', '高管访谈', 1, '', '', shebei);
	    videoSwiper.stopAutoplay();
		resetVideo.videoA();
		resetVideo.video2();
		resetVideo.video3();
		resetVideo.video4();
		showVideo('video1', 'XMzAwOTg3NzUwNA==',$(this));
	})
	
	//小π讲堂
	$("#videoCover2").on('click', function () {
	    nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), '20170901zhibo_Activity201709', '视频点击量', '小π讲堂', 1, '', '', shebei);
	    videoSwiper.stopAutoplay();
		resetVideo.videoA();
		resetVideo.video1();
		resetVideo.video3();
		resetVideo.video4();
		showVideo('video2', 'XMjkxODU1MDMwOA==',$(this));
	})
	
	//街坊说财经
	$("#videoCover3").on('click', function () {
	    nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), '20170901zhibo_Activity201709', '视频点击量', '街坊说财经', 1, '', '', shebei);
	    videoSwiper.stopAutoplay();
		resetVideo.videoA();
		resetVideo.video1();
		resetVideo.video2();
		resetVideo.video4();
		showVideo('video3', 'XMjk5NTEzNjI4MA==',$(this));
	})
	
	//小π娱乐
	$("#videoCover4").on('click', function () {
	    nwbi_api.nwbi_logWebEvent('', getNowFormatDate(), '20170901zhibo_Activity201709', '视频点击量', '小π娱乐', 1, '', '', shebei);
	    videoSwiper.stopAutoplay();
		resetVideo.videoA();
		resetVideo.video1();
		resetVideo.video2();
		resetVideo.video3();
		showVideo('video4', 'XMjg0NDk1MzE3Ng==',$(this));
	})
	
	$(".close,#ok").click(function () {
		$(this).parent().parent().hide();
	})
	
	$(window).on('scroll touchmove',function(){
		if($('body').scrollTop()>=$("#showMove").offset().top){
			$(".txt2").find('div').show();
		}
	})

})();