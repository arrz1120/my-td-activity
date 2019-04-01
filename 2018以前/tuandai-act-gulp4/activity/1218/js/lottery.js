(function() {
	FastClick.attach(document.body);
	//do your thing.



	//规则弹窗索引

	$('#tab').find('span').eq(2).click();


	//swiper


	var rem = (20 * ($(window).width() / 320)),
		stretch_rem = -70 / 23.4375 / 2 * rem,
		depth_rem = 90 / 23.4375 / 2 * rem,
		list_1 = $('#list_0'),
		list_2 = $('#list_1'),
		prize_wraper_list = $('.prize_wraper_list');


	var prize_swiper_1 = new Swiper('#swiper-ph-prize', {
		autoplay: 3000,
		loop: true,
		autoplayDisableOnInteraction: false,
		nextButton: '#swiper-button-next-1',
		prevButton: '#swiper-button-prev-1',

	});


	var prize_swiper_2 = new Swiper('#swiper-sh-prize', {
		autoplay: 3000,
		loop: true,
		autoplayDisableOnInteraction: false,
		nextButton: '#swiper-button-next-2',
		prevButton: '#swiper-button-prev-2'
	});



	var swiper = new Swiper('#swiper-container', {
		pagination: '.swiper-pagination',
		effect: 'coverflow',
		grabCursor: true,
		centeredSlides: true,
		slidesPerView: 'auto',
		coverflow: {
			rotate: 0,
			stretch: stretch_rem,
			depth: depth_rem,
			modifier: 1,
			slideShadows: false
		},
		observer:true,
observeParents:true,
		onTransitionEnd: function(swiper) {
			var actIndex = swiper.activeIndex;
			prize_wraper_list.removeClass('prize_wraper_list_show');
			$('#list_' + actIndex).addClass('prize_wraper_list_show');
			if (actIndex == 0) {
				prize_swiper_1.slideTo(1, 0, true);
			} else if (actIndex == 1) {
				prize_swiper_2.slideTo(1, 0, true);
			};
		}
	});


	swiper.slideTo(1, 0, true);



	//开宝箱

	$('.box').on('click', function() {
		var _this = $(this);
		_this.find('.box_close').hide();
		_this.find('.hand_wraper').hide();
		_this.find('.box_open').show();
		_this.find('.box_open img').addClass('img_show');

	});



	//查看更多奖品

	var all_prize = $('#all_prize');


	$('.more_link').on('click', function() {
		var curId = $(this).attr('data-id');
		all_prize.find('.prize_wraper').hide();
		all_prize.removeClass('hide');

		if (curId == 'ph') {
			all_prize.find('.comp-modal-title').html('普惠礼盒奖品');
			all_prize.find('.prize_ph_wraper').show();
		} else if (curId == 'sh') {
			all_prize.find('.comp-modal-title').html('奢华礼盒奖品');
			all_prize.find('.prize_sh_wraper').show();
		}

	});


	$('.comp-modal-close').on('click', function() {
		$(this).parents('.comp-modal').addClass('hide');
	});



	//	奖品名单滚动
	var Marquee = function(id) {
		var container = document.getElementById(id),
			original = container.getElementsByTagName("dt")[0],
			clone = container.getElementsByTagName("dd")[0],
			speed = arguments[1] || 10;
		clone.innerHTML = original.innerHTML;
		var rolling = function() {
			if (container.scrollTop == clone.offsetTop) {
				container.scrollTop = 0;
			} else {
				container.scrollTop++;
			}
		}
		var timer = setInterval(rolling, 30) //设置定时器
	}



	// 初始化滚动元素

	if ($('#marquee').length) {
		Marquee("marquee");
	}


	$('.no_remind').on('click',function(){

		 $(this).toggleClass('checkde');
	});



})();