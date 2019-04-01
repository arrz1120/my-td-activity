(function() {
    FastClick.attach(document.body);
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
        Jsbridge.setTitleComponent({
            titleContent: '我参与的公益项目',
            rightbuttonVisible: false,
            rightbuttonContent: '',
            rightbuttonTyppe: 1
        });
    }, null, null, null);
    function init() {
    }
    init();
})();
