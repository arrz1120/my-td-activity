(function() {
    FastClick.attach(document.body);
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
    	Jsbridge.setTitleComponent({
    		titleContent: '我要参加',
    		rightbuttonVisible: false,
    		rightbuttonContent: '',
    		rightbuttonTyppe: 1
    	});
    }, null, null, null);
    // 事件绑定
    function bindEvent(){
        $(".join-btn").on('click',function () {
        	$(".letter-con").show();
        	setTimeout(function () {
        		window.location = 'welfareDiary.html';
        	}, 3000)
        })
    }

    function init() {
        bindEvent();
    }
    init();
})();
