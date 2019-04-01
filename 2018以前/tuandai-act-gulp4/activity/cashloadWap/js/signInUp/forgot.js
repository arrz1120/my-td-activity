(function() {
    FastClick.attach(document.body);
    var interval = null;
    var _history = [];
    // 初始化header
    Util.initHeader({
        'header': 'header',
        'leftFun': backStep
    });
    pushHistory('step1');
    // 获取短信验证码
    $('.forgot-content').on('click', '.code-sms', function(e) {
        getCode(e);
    });
    // 第一步按钮事件绑定
    $('.forgot-content').on('click', '#btn_step1', function(e) {
        goStep2(e);
    });
    // 第二步按钮事件绑定
    $('.forgot-content').on('click', '#btn_step2', function(e) {
        goStep3(e);
    });
    // 第三步按钮事件绑定
    $('.forgot-content').on('click', '#btn_step3', function(e) {
        goBack(e);
    });
    // 倒计时， 获取短信验证码
    function getCode(e) {
        var tel = $('#forgot_tel').val().trim()
        if (tel.length <= 0) {
            Util.toast('请输入手机号码');
            return
        }
        var displayEl = $(e.currentTarget);
        var time = 60;
        // Util.getCodeCountdown(60, displayEl);
        if (displayEl.hasClass('counting')) {
            return;
        }
        displayEl.html(time + 's');
        displayEl.addClass('counting');
        if (interval) {
            clearInterval(interval);
        }

        interval = Util.countdownFun(time, function(t) {
            displayEl.html(t + 's');
        }, function(t) {
            displayEl.removeClass('counting');
            displayEl.html('获取验证码');
        });
    }
    // 进入第二步 
    function goStep2(e) {
        var tel = $('#forgot_tel').val().trim(),
            code = $('#code_sms').val().trim();

        if (tel.length <= 0) {
            Util.toast('手机号码不能为空');
            return;
        }
        if (code.length <= 0) {
            Util.toast('验证码不能为空');
            return;
        }

        // todo ajax
        console.log('next');
        // $('.forgot-content').attr('data-step', '2');
        pushHistory('step2');
        $('.step1').addClass('hidden');
        $('.step2').removeClass('hidden');
    }
    // 进入第三步 
    function goStep3(e) {
        var psw = $('#new_psw').val();

        if (psw.length <= 0) {
            Util.toast('密码不能为空');
            return;
        }

        // todo ajax
        console.log('next');
        // $('.forgot-content').attr('data-step', '1');
        // $('.step2').addClass('hidden');
        // $('.step3').removeClass('hidden');
        _history = [];
        Util.showResult({
            result: 1,
            status: '修改成功',
            btn: {
                name: '返回',
                cb: function(result) {
                    goBack();
                }
            }
        });
    }
    // 返回上一步
    function backStep() {
        _history.pop();
        var _length = _history.length;
        if (_length <= 0) {
            goBack();
        } else {
            $('.step').addClass('hidden');
            $('.' + _history[_length - 1]).removeClass('hidden');
        }
    }
    // 返回到登录页面
    function goBack() {
        window.history.back();
    }

    function pushHistory(his) {
        _history.push(his);
        console.log(_history);
    }
})();