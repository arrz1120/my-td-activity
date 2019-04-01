(function() {
    FastClick.attach(document.body);
    var joinLoaded = false, //参与情况是否加载完毕
        latestLoaded = false; //最新进展分页加载是否加载完毕
   
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
        Jsbridge.setTitleComponent({
            titleContent: '简单公益',
            rightbuttonVisible: false,
            rightbuttonContent: '',
            rightbuttonTyppe: 1
        });
    }, null, null, null);
    $('.content').on('click', function () {
        window.history.back();
    })
})();
