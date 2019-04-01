(function() {
    FastClick.attach(document.body);
    var $all = $("#all"),
        $content = $("#content"),
        scrollHeight = $all.height(), //页面高度
        windowHeight = $content.height(), //可视区域高度
        isLoaded = false;
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
        Jsbridge.setTitleComponent({
            titleContent: '公益日记',
            rightbuttonVisible: false,
            rightbuttonContent: '',
            rightbuttonTyppe: 1
        });
    }, null, null, null);
    // 事件绑定
    function bindEvent(){
        // 分页加载
        $content.scroll(function () {
            if(!isLoaded){
                //已经滚动到上面的页面高度
                var scrollTop = $content.scrollTop();
                
                //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作, 浏览器偶尔有计算误差因此减5
                if (scrollTop + windowHeight >= scrollHeight - 5) {
                    //分页加载时重新获取页面高度
                    scrollHeight = $all.height();
                    console.log(1);
                }
            }
        })
    }

    function init() {
        bindEvent();
    }
    init();
})();
