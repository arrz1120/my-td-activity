(function() {
	FastClick.attach(document.body);
	//do your thing.
	var investSwiper = new Swiper("#investSwiper", {
		autoplay: 3000,
		autoplayDisableOnInteraction: false,
		loop: true,
		pagination: '#paging'
	})

	var cpSwiper = new Swiper("#picSwiper", {
		effect: 'coverflow',
		centeredSlides: true,
		slidesPerView: 'auto',
//		autoplay: 3000,
		autoplayDisableOnInteraction: false,
		loop: true,
		speed: 300,
		coverflow: {
			rotate: 0,
			// //每个item间隔
			// //非active item 缩放比例
			stretch: $(window).width() * 163 / 750,
			depth: 190,
			modifier: 1,
			slideShadows: false
		},
		pagination: '#paging2'
	})

	$("#telInput").on('input', function() {
		if($(this).val().length == 11) {
			$("#input-wrapper").removeClass('hide');
		}
	})
})();