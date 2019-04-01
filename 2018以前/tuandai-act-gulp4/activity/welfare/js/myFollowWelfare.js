(function() {
    FastClick.attach(document.body);
    var $body = $("body"),
        $alertWrapper = $("#alert_wrapper"),
        $joinCon = $("#join_con"),
        joinItemIndex = -1; //.join-item索引值
    // 设置app标题
    Jsbridge.appLifeHook(null, function() {
        Jsbridge.setTitleComponent({
            titleContent: '我关注的公益项目',
            rightbuttonVisible: false,
            rightbuttonContent: '',
            rightbuttonTyppe: 1
        });
    }, null, null, null);
    // 绑定事件
    function bindEvent() {
        // 取消关注
        $body.on('click', '.follow-btn', function (e) {
            e.preventDefault();
            $alertWrapper.show();
            joinItemIndex = $(this).parents('.join-item').index();
            console.log($(this).parents('.join-item').index());
        })
        // 取消关注弹窗取消按钮
        $body.on('click', '.cancel-btn', function () {
             $alertWrapper.hide();
        })
        // 取消关注弹窗确定按钮
        $body.on('click', '.confirm-btn', function () {
            $alertWrapper.hide();
            Utils.toast('取消关注!');
            $joinCon.find('li.join-item').eq(joinItemIndex).remove();
        })
    }
    function init() {
        bindEvent();
    }
    init();
})();
