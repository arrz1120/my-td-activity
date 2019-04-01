(function() {
    FastClick.attach(document.body);
	
	var $body = $('body'),
		$content = $("#content");
	// 轮播图
	var initSwiper = function() {
	    var bannerSwiper = new Swiper('.swiper-container', {
	        autoplay: 3000, //可选选项，自动滑动
	        slidesPerView: 'auto',
	        spaceBeteewn: 0,
	        // centeredSlides: true,
	        pagination: '.swiper-pagination',
	        loop: true
	          /*,
	                  onInit: function(swiper) {

	                  },
	                  onSlideChangeStart: function(swiper) {


	                  },
	                  onSlideChangeEnd: function(swiper) {

	                  }*/

      	});
    }
	// 事件绑定
	function bindEvent() {
		// 下载app按钮
		$body.on('click', '#download_btn', function () {
		})
		// 下载关闭按钮
		$body.on('click', '#download_cls_btn', function () {
			$("#download_con").hide();
		})
		// 标题'我的页面'按钮
		$body.on('click', '#my_page_btn', function () {
			// 未登录状态下显示“登录字样”，点击跳转登录页；2、登录状态下显示“我的”字样，点击跳转"我的"页"我的"页
		})
		// 热线电话
		$body.on('click', '#hotline', function () {
			Util.popup({
				'msg': '400-641-0888'
			});
		})
		// 在线理财师
		$body.on('click', '#hotline', function () {
			//判断是否登录确定是否跳转在线理财师
		})
		// $content.scroll(function () {
  //           //已经滚动到的页面高度
  //           var scrollTop = $content.scrollTop();
            
  //       })
	}
	function init() {
		// 轮播图
	    if($(".swiper-container li").length){
	        initSwiper();
	    }
		bindEvent();
	}
	init();
})();