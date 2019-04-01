(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	var u = navigator.userAgent;
	if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {
		//安卓手机
    	$(".mask-div").find('input').on('focus',function(){
    		$(".mask-div .pop-container").css({
    			'top':'10px',
    			'-webkit-transform':'translate(-50%,0)'
    		});
    	})
	}
	
	//toast调用示例: toast('手机号码不能为空！');
    function toast(msg, duration) {
        duration = duration || 1500;
        var _toast = $("<div/>").addClass('toast').html(msg);
        $('body').append(_toast);
        setTimeout(function() {
            _toast.remove();
        }, duration);
    }

	var pageSwiper = new Swiper("#pageSwiper", {
		initialSlide: 0,
		direction: 'vertical',
		lazyLoading: true,
		resistanceRatio: 0
	})

	var swiper1 = new Swiper("#swiper1", {
		effect: 'coverflow',
		centeredSlides: true,
		slidesPerView: 'auto',
		//		autoplay: 2000,
		loop: true,
		speed: 300,
		coverflow: {
			rotate: 0,
			// //每个item间隔
			// //非active item 缩放比例
			stretch: $(window).width() * 180 / 750,
			depth: 290,
			modifier: 1,
			slideShadows: false
		},
		pagination: '#page1',
		onTransitionEnd: function(swiper) {
			var ind = swiper.realIndex;

		}
	})

	var fkText = [
		'',
		'',
		'',
		'接入外部大数据，沉淀自有数据，<br />开启智能化识别体系',
		'房价市场波动监控，抵押人经营状<br />况监控，后期保全策略机制',
		'流程化、专业化、系统化风险管理'
	]

	var swiper2 = new Swiper("#swiper2", {
		effect: 'coverflow',
		centeredSlides: true,
		slidesPerView: 'auto',
		//		autoplay: 2000,
		loop: true,
		speed: 300,
		coverflow: {
			rotate: 0,
			// //每个item间隔
			// //非active item 缩放比例
			stretch: $(window).width() * 210 / 750,
			depth: 200,
			modifier: 1,
			slideShadows: false
		},
		pagination: '#page2',
		onTransitionEnd: function(swiper) {
			var ind = swiper.realIndex;
			$(".fk-text").html(fkText[ind]);
		}
	})
	
	$(".text-bot").click(function(){
		if($(this).hasClass('text-hide')){
			$(this).removeClass('text-hide');
			$(this).find('i').css('-webkit-transform','rotateZ(180deg)');
		}else{
			$(this).addClass('text-hide');
			$(this).find('i').css('-webkit-transform','rotateZ(0)');
		}
	})
	
	$(".watchMore").click(function(){
		$("#jianjie").fadeIn();
	})
	
	$("#jianjie").click(function(){
		$(this).fadeOut();
	})

})();