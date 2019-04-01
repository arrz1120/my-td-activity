(function() {
	FastClick.attach(document.body);
	//do your thing.

	var mySwiper = new Swiper('.swiper-container', {
		direction: 'vertical',
		freeMode: true,
		freeModeSticky : true,
		slidesPerView: 'auto',
		// 如果需要滚动条
		scrollbar: '.swiper-scrollbar',
		scrollbarHide:false,
	})

})();