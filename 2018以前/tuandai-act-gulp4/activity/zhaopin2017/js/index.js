(function() {
    FastClick.attach(document.body);
	    //do your thing.
	var $body = $('body'),
		$tabContent = $(".tab-content");
	// 轮播图
	var initSwiper = function() {
	    var bannerSwiper = new Swiper('.swiper-container', {
	        autoplay: 2000, //可选选项，自动滑动
	        slidesPerView: 'auto',
	        spaceBeteewn: 0,
	        autoplayDisableOnInteraction: false,
	        pagination: '.swiper-pagination',
	        loop: true
      	});
    }

    // 事件绑定
	function bindEvent() {
		// 切换tab
		$body.on('click', '.tab', function(){
			var $this = $(this),
				index = $('.tab').index($this);
			if(!$this.hasClass('act')){
				$this.addClass('act').siblings().removeClass('act');
				$tabContent.eq(index).show().siblings(".tab-content").hide();
			}
		})
	}
	function init() {
		// 轮播图
        initSwiper();
		bindEvent();
	}
	init();
})();