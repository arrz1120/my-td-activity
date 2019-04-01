(function() {
    FastClick.attach(document.body);
	    //do your thing.
	    
	var swiper_banner = new Swiper('#swiper-banner', {
		onInit: function() {
			$('#swiper-banner').find('img').show();
		},
		autoplay: 5000,
		disableOnInteraction:false,
		direction: 'horizontal',
		loop: true,
		pagination: '#nav-mark'
	});
	
	if($(".comment-list-item").length>1){
		var cmmentScroller = new CommentScroller('#notice-list', {
			showSlides: 1, //显示的条数
			autoplay: true, //autoplay:true 开启滚动
			delay: 3000, //轮播间隔时间
		})
	}
	
})();