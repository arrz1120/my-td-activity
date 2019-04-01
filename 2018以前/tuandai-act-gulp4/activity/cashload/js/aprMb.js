(function() {
    FastClick.attach(document.body);
    var interval = null;
    var _history = [];
    // 手机运营商验证
    // step0 
    // 判断用户认证状态，approveStatus 0 -- 不支持虚拟运营商 1--支持虚拟运营商 2 -- 认证中 3 --已认证
    initPage(approveStatus, codeType, codePicUrl);
    // 不支持虚拟运营商
    $('.am-content').on('click', '#btn_step0', function(e) {
        backToApp();
    });

    // 认证第一步 -- 获取短信验证码事件
    $('.am-content').on('click', '.code-sms', function(e) {
        var displayEl = $(e.currentTarget),
            // type：获取短信验证码类型 0——表示登录手机运营商获取的短信验证码 1——表示第二验证的时候，获取短信验证码
            type = displayEl.attr('data-type');
        var cpicEl = displayEl.parent().parent().find('.input-pic');
        console.log(cpicEl.length);
        if (cpicEl.length > 0 && cpicEl.val().length <= 0) {
            Util.toast('图形验证码不能为空!');
            return;
        }
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

        // todo AJAX 发送短信验证码
        if (type === '0') {
            console.log('登录手机运营商，需要获取的短信验证码')
        } else if (type === '1') {
            console.log('某些运营商需要再次验证')
        }
    });

    // 认证第一步 -- 获取图形验证码事件
    $('.am-content').on('click', '.code-pic', function(e) {
        // todo 获取图形验证码，替换img路径
        $(e.currentTarget).find('img').attr('src', 'the url of your image');
        console.log('获取图形验证码，替换img路径')
    });

    // 认证第一步 —— 下一步 按钮事件
    $('.am-content').on('click', '#btn_step0_next', function(e) {
        // 验证数据, 不能为空
        var stepEl = $('.step0');
        var pswEl = $('#spsw'),
            csmsEl = stepEl.find('.input-sms'),
            cpicEl = stepEl.find('.input-pic');
        if (pswEl.val().length <= 0) {
            Util.toast('服务密码不能为空!');
            return;
        }
        if (cpicEl.length > 0 && cpicEl.val().length <= 0) {
            Util.toast('图形验证码不能为空!');
            return;
        }
        if (csmsEl.length > 0 && csmsEl.val().length <= 0) {
            Util.toast('短信验证码不能为空!');
            return;
        }
        // todo 提交数据
        $('.step0').addClass('hidden');

        // 去第一步， 
        showStep1('2', '../images/code-pic.png');

        // 去结果页
        //  showLoading('认证可能需要1～2分钟时间，请耐心等候');

        // // todo 如果认证结果返回，则跳转到认证结果步骤
        // setTimeout(function() {
        //     showResult('1');
        // }, 1500)

    });

    // 认证第二步——开始认证 按钮事件
    $('.am-content').on('click', '#btn_step1_approve', function(e) {
        // 验证数据, 不能为空
        var stepEl = $('.step1');
        csmsEl = stepEl.find('.input-sms'),
            cpicEl = stepEl.find('.input-pic');
        if (cpicEl.length > 0 && cpicEl.val().length <= 0) {
            Util.toast('图形验证码不能为空!');
            return;
        }
        if (csmsEl.length > 0 && csmsEl.val().length <= 0) {
            Util.toast('短信验证码不能为空!');
            return;
        }
        // todo 提交数据
        // window.location.href = './aprMbApring.html';
        // 清空历史
        _history = [];
        // $('.popup-loading').removeClass('hidden');
        showLoading('认证可能需要1～2分钟时间，请耐心等候');

        // todo 如果认证结果返回，则跳转到认证结果步骤
        setTimeout(function() {
            showResult('1');
        }, 1500)

    });

    // 认证最后一步——确认按钮，退出webview， 返回认证资料页
    $('.am-content').on('click', '#btn_apr_ok', function(e) {
        backToApp();
    });

    // 认证最后一步——重新认证 
    $('.am-content').on('click', '.btn-restart', function(e) {
        approveStatus = '1';
        codePicUrl = '';
        _history = [];
        initPage(approveStatus, codeType, codePicUrl);

    });

    /** 页面初始化 
     * status 字符串 :0 -- 不支持虚拟运营商 1--支持虚拟运营商 2 -- 认证中 3 --已认证
     * codeType: 首页验证码类型 '0'--没有验证码 '1' —— 短信验证码， '2' —— 图形验证码， '3' —— 短信验证码 + 图形验证码
     *  imgUrl: 图形验证码url
     */
    function initPage(status, codeType, imgUrl) {
        var bgApproveEl = $('.bg-approve');
        $('.step').addClass('hidden');
        switch (status) {
            case '0':
                bgApproveEl.removeClass('hidden');
                $('.no-suport').removeClass('hidden');
                // 记录浏览历史
                pushHistory('no-suport');
                break;
            case '1':
                bgApproveEl.removeClass('hidden');
                showStep0(codeType, imgUrl ? imgUrl : '');
                break;
            case '2':
                showLoading('认证可能需要1～2分钟时间，请耐心等候');
                break;
            case '3':
                showResult(approveResult);
                break;
        }
    }

    /** 显示step0 
     *  codeType: 验证码类型 '0' -- 没有验证码 ‘1' —— 短信验证码， '2' —— 图形验证码， '3' —— 短信验证码 + 图形验证码
     *  imgUrl: 图形验证码url
     */
    function showStep0(codeType, imgUrl) {
        var stepEl = $('.step0');
        var temp = '<div class="input-wrapper">' +
            '<span>服务密码</span>' +
            '<input type="password" name="" value="" placeholder="请输入运营商服务密码" id="spsw" class="input-spsw">' +
            '</div>'
        stepEl.find('.form').html(temp + getCodeTemp(codeType, '0', imgUrl));
        stepEl.removeClass('hidden');
        // 记录浏览历史
        pushHistory('step0');
    }

    /** 显示下一页 
     *  codeType: 首页验证码类型 '0' -- 没有验证码 ‘1' —— 短信验证码， '2' —— 图形验证码， '3' —— 短信验证码 + 图形验证码
     *  imgUrl: 图形验证码url
     */
    function showStep1(codeType, imgUrl) {
        // 清除上一步的倒计时
        clearInterval(interval);
        var stepEl = $('.step1');
        stepEl.find('.form').html(getCodeTemp(codeType, '1', imgUrl));
        stepEl.removeClass('hidden');
        // 记录浏览历史
        pushHistory('step1');
    }
    /** 获得验证码模版 
     *  codeType: 首页验证码类型 '0' -- 没有验证码 ‘1' —— 短信验证码， '2' —— 图形验证码， '3' —— 短信验证码 + 图形验证码
     *  codeSmsVal: 短信验证码类型 '0' -- 登录运营商登录的验证码，'1' -- 手机运行商第二次验证码
     *  imgUrl: 图片验证码url
     */
    function getCodeTemp(codeType, codeSmsVal, imgUrl) {
        console.log(codeType)
        // 验证码模版
        var codeSmsTemp = '<div class="input-wrapper with-code">' +
            '<span>验证码</span>' +
            '<input type="text" name="" value="" placeholder="请输入短信验证码" class="input-sms"><a class="code-sms" data-type="' + codeSmsVal + '">获取验证码</a>' +
            '</div>',
            codePicTemp = '<div class="input-wrapper with-code">' +
            '<span>验证码</span>' +
            '<input type="text" name="" value="" placeholder="请输入验证码" class="input-pic"><a class="code-pic"><img src="' + (imgUrl ? imgUrl : '') + '" alt=""></a>' +
            '</div>';
        switch (codeType) {
            case '0':
                return '';
            case '1':
                return codeSmsTemp;
            case '2':
                return codePicTemp;
            case '3':
                return codePicTemp + codeSmsTemp;
        }
        // if (codeType === '0') {
        //     return codeSmsTemp;
        // } else if (codeType === '1') {
        //     return codePicTemp;
        // } else if (codeType === '2') {
        //     return codeSmsTemp + codePicTemp;
        // }
    }
    /** 显示loading 认证中
     *  info: 信息
     */

    function showLoading(info) {
        $('body').append('<div class="popup pop-loading">' +
            '<section class="wrapper-approving">' +
            '<div class="wrapper-loading">' +
            '<i class="icon-inline-block icon-loading"></i><span>正在认证中</span>' +
            '</div>' +
            '<p>' + info + '</p>' +
            '</section>' +
            '</div>');
    }

    function hideLoading() {
        $('.pop-loading').remove();
    }

    /** 显示结果项 
     *  result: 验证结果 0 -- 认证失败 1 -- 认证成功
     */
    function showResult(result) {
        // 清除上一步的倒计时
        clearInterval(interval);
        var resultInfo = '',
            resultBtnsTemp = '';
        var stepEl = $('.step2');
        if (result === '1') {
            resultInfo = '<i class="icon-inline-block icon-success"></i> 您已完成手机运营商认证！';
            resultBtnsTemp = '<div class="btn btn-full" id="btn_apr_ok">确定</div><a href="#" class="link-yellow btn-restart">重新认证</a>';
        } else {
            resultInfo = '<i class="icon-inline-block icon-fail"></i> 认证失败，请重试！';
            resultBtnsTemp = '<div class="btn btn-full btn-restart">马上重试</div>';
        }
        stepEl.find('.result-info').html(resultInfo);
        stepEl.find('.btns').html(resultBtnsTemp);

        $('.bg-approve, .step').addClass('hidden');
        hideLoading();
        stepEl.removeClass('hidden');
    }

    function pushHistory(his) {
        _history.push(his);
        console.log(_history);
    }

    function back() {
        _history.pop();
        var _length = _history.length;
        if (_length <= 0) {
            window.history.back();
        } else {
            $('.step').addClass('hidden');
            $('.' + _history[_length - 1]).removeClass('hidden');
        }
    }

    // 调用原声插件，退出webview
    function backToApp() {
        console.log('backToApp')
        Jsbridge.exec('CloseWebView', function(result) {
            console.info('closeWebView----', result);
        }, {});
    }

})();