(function() {
    FastClick.attach(document.body);

    // 点击header icon 跳转到首页
    Util.initHeader();
    // 打开app
    Util.initFooter();

    // 点击问题展开答案
    $(".list-problems").on('click', 'li .ques', function(e) {
        var $target = $(e.currentTarget),
            $li = $target.parent(),
            $answer = $target.next();
        if ($li.hasClass('open')) {
            $li.removeClass('open')
            $answer.hide();
        } else {
            $li.addClass('open')
            $answer.show();
        }
    });

})();
