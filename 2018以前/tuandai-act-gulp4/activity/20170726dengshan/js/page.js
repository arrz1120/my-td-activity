(function() {
	FastClick.attach(document.body);
	//do your thing.

	var mySwiper = new Swiper('#swiper', {
		effect: 'coverflow',
		centeredSlides: true,
		slidesPerView: 'auto',
		autoplay: 2000,
		loop: true,
		speed: 300,
		coverflow: {
			rotate: 0,
			// //每个item间隔
			// //非active item 缩放比例
			stretch: -42,
			depth: 282,
			modifier: 1,
			slideShadows: false
		}
	})

	$("#swiper").find('.swiper-slide').each(function(i, item) {
		$(item).click(function() {
			if($(this).hasClass('swiper-slide-active')){
				var index = mySwiper.realIndex;
	//			location.href = 'result.html';
				console.log(index)
			}
		})
	})

	$(document).on('click touchmove touchstart', function() {
		mySwiper.stopAutoplay();
	})
})();