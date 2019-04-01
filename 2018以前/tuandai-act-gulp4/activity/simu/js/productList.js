(function() {
    FastClick.attach(document.body);
    var $body = $('body'),
        isLoaded = false, //页面是否加载完
        $content = $("#content"),
        $page = $('#page'),
        scrollHeight = $page.height(), //页面高度
        windowHeight = $content.height();//可视区域高度
    // 事件绑定
    function bindEvent() {
        $body.on('click', '#back_btn', function () {
            window.history.back();
        })
        // 分页加载
        $content.scroll(function () {
            if(!isLoaded){
                //已经滚动到上面的页面高度
                var scrollTop = $content.scrollTop();
                //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作, 浏览器偶尔有计算误差因此减5
                if (scrollTop + windowHeight >= scrollHeight - 5) {
                    //分页加载重新获取页面高度
                    scrollHeight = $page.height();
                    //接口请求数据,页面内容每次加载15条
                }
            }
        })
    }
    function init() {
        bindEvent();
    }
    init();
})();
