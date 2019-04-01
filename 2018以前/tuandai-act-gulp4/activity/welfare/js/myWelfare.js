(function() {
    FastClick.attach(document.body);
    
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
        Jsbridge.setTitleComponent({
            titleContent: '我的公益',
            rightbuttonVisible: false,
            rightbuttonContent: '',
            rightbuttonTyppe: 1
        });
    }, null, null, null);

    function init() {
    }
    init();
})();
