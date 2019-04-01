(function() {
    FastClick.attach(document.body);
    Util.initHeader({
        header: 'header',
    });


    //支付
    var codeInterval;
    $('#goPay').on('click', function() {
        //支付业务逻辑
        //todo

        sendCountDown(10);
        $('#codeDialog').show();

    });

    //关闭弹窗
    $('.masker, .btn-nav').on('click', function() {
        $('#codeDialog').hide();
    });
    //确定支付
    $('.btn-pos').on('click', function() {
        //支付借款
        //todo

        $('#codeDialog').hide();
        //打开支付成功提示弹层
        Util.showResult({
            'result': 1,
            'status': '还款成功',
            'info': '您的额度已恢复至 3,000 元<br>感谢您的使用！',
            'btn': {
                'name': '返回',
                'cb': function() {
                    //返回主页
                    location.href = '../borrow/index.html';
                }
            }
        });
        // $('.success-layer').show();

    });

    //重新获取验证码
    $('body').on('click', '.resend', function() {
        sendCountDown(10);
    });

    //验证码倒计时
    function sendCountDown(count) {
        var _codeTips = $('.code-tips');
        _codeTips.removeClass('resend').html(count + '秒后重新发送');
        codeInterval && clearInterval(codeInterval);
        codeInterval = Util.countdownFun(count, function(time) {
            // console.info('timing---', time);
            _codeTips.removeClass('resend').html(time + '秒后重新发送');
        }, function(time) {
            // console.info('time end---', time);
            _codeTips.addClass('resend').html('重新获取');
            clearInterval(codeInterval);
        });
    }


})();