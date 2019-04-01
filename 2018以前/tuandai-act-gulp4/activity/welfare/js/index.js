(function() {
  FastClick.attach(document.body);
  var $content = $("#content"),
    $all = $("#all"),
    isLoaded = false;
  var uiShowAppTitle = function() {
    // 设置webview显示标题，防止从活动详情回来，没标题
    Jsbridge && Jsbridge.appLifeHook(null, function() {
      Jsbridge.setTitleComponent({
        titleContent: '简单公益',
        rightbuttonVisible: false,
        rightbuttonContent: '',
        rightbuttonTyppe: 1
      });
    }, null, null, null);
  }

  var initBannerSwiper = function() {
    var bannerSwiper = new Swiper('.swiper-container', {
      autoplay: 3000, //可选选项，自动滑动
      slidesPerView: 'auto',
      spaceBeteewn: 0,
      // centeredSlides: true,
      autoplayDisableOnInteraction: false,
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

  // 设置webview标题显示
  uiShowAppTitle();
  // 初始化banner
  initBannerSwiper();
  // 分页加载
  //页面高度
  var scrollHeight = $all.height();
  //可视区域高度
  var windowHeight = $content.height();
  $content.scroll(function() {
    if (!isLoaded) {
      //已经滚动到上面的页面高度
      var scrollTop = $content.scrollTop();
      //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作, 浏览器偶尔有计算误差因此减5
      if (scrollTop + windowHeight >= scrollHeight - 5) {
        // 分页加载时重新获取页面高度
        scrollHeight = $all.height();
        console.log(1);
      }
    }
  })

})();