(function() {
	FastClick.attach(document.body);
	var pageSwiper = new Swiper('#pageSwiper', {
		initialSlide: 0,
		direction: 'vertical',
		lazyLoading: true,
		lazyLoadingInPrevNextAmount: 2,
		resistanceRatio: 0
	})
	var tabSwiper = new Swiper('#tabSwiper', {
		noSwiping : true,
		onSlideChangeStart:function(swiper){
			var index = swiper.activeIndex;
			$(".tab-item-cur").removeClass('tab-item-cur');
			$(".tab-item").eq(index).addClass('tab-item-cur');
		}
	})
	var txtSwiper = new Swiper('#txtSwiper1', {
		noSwiping : false,
		direction: 'vertical',
		slidesPerView: 'auto',
		freeMode: true,
		nested: true,
		resistanceRatio: 0,
		scrollbar: '#bar1',
		scrollbarHide: false
	})
	var txtSwiper = new Swiper('#txtSwiper2', {
		noSwiping : false,
		direction: 'vertical',
		slidesPerView: 'auto',
		freeMode: true,
		nested: true,
		resistanceRatio: 0,
		scrollbar: '#bar2',
		scrollbarHide: false
	})

	$(".tab-item").each(function(i,item){
		$(item).click(function(){
			tabSwiper.slideTo(i,300,true);
		})
	})

	$(".text-bot").click(function() {
		if($(this).hasClass('text-hide')) {
			$(this).removeClass('text-hide');
			$(this).find('i').css('-webkit-transform', 'rotateZ(180deg)');
		} else {
			$(this).addClass('text-hide');
			$(this).find('i').css('-webkit-transform', 'rotateZ(0)');
		}
	})

})();