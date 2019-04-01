(function() {
    FastClick.attach(document.body);
    var $content = $('.content'),
        $swiperWrapper = $content.find(".swiper-wrapper"); //页面滑动

    function init() {
        swiper = new Swiper('.swiper-container', {
            direction: 'vertical',
            noSwiping: true,
            // effect : 'fade',
            // fade: {
            //   crossFade: true,
            // },
            onSlideChangeEnd: function(swiper) {
                var index = swiper.activeIndex;

                // // 最后一页轮播图隐藏页面箭头
                // index === swiper.slides.length - 1 ? $content.find('.page-down').hide() : $content.find('.page-down').show();
                // // 划到第一页 & 点击过导航隐藏导航高亮
                // if (index === 0 && navIndex !== -1) $navWrapper.find(".nav-item").removeClass('act');
            }
        })
    }
    init();
})();