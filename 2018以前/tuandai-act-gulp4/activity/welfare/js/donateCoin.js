(function() {
    FastClick.attach(document.body);
    var coin = 0,//团币数
        $coinInput = $('.coin-input'), 
        $coinNum = $('#coin_num'); 
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
    	Jsbridge.setTitleComponent({
    		titleContent: '我要捐币',
    		rightbuttonVisible: false,
    		rightbuttonContent: '',
    		rightbuttonTyppe: 1
    	});
    }, null, null, null);
    // 事件绑定
    function bindEvent(){
        $coinInput.on('input', function () {
            coin = +$(this).val();
            $coinNum.html(isNaN(coin) ? 0 : coin);
        })
        $(".bottom-btn").on('click',function () {
            if(!coin){
                Utils.toast('请输入支持团币数');
                return;
            }
        	$(".letter-con").show();
        	setTimeout(function () {
        		window.location = 'welfareDiary.html';
        	}, 3000)
        })
    }

    function init() {
        coin = +$coinInput.val();
        $coinNum.html(isNaN(coin) ? 0 : coin);
        bindEvent();
    }
    init();
})();
