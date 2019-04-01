(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	window.onload = function(){
		$(".hb-p1").css('opacity','1');
	}

	var investSwiper = new Swiper("#investSwiper", {
		pagination: '#paging',
		loop: true,
		autoplay: 3000,
		autoplayDisableOnInteraction: false
	})
	var imgSwiper = new Swiper("#imgSwiper", {
		effect: 'coverflow',
		centeredSlides: true,
		slidesPerView: 'auto',
		autoplay: 3000,
		autoplayDisableOnInteraction: false,
		loop: true,
		speed: 300,
		coverflow: {
			rotate: 0,
			// //每个item间隔
			// //非active item 缩放比例
			//stretch: $(window).width() * 163 / 750,
			stretch: 52,
			depth: 200,
			modifier: 1,
			slideShadows: false
		},
		pagination: '#imgPaging',
		onTransitionEnd: function(swiper) {
			
		}
	})
	
	//立即投资
	$(".invest-btn").on('click',function(){
		if(Jsbridge.isApp()){
			Jsbridge.toAppP2p();
		}else{
			window.location.href = 'https://m.tuandai.com/pages/invest/WE/WE_list.aspx';
		}
	})

})();