(function() {
    FastClick.attach(document.body);
    var interval = null;
    // 事件绑定
    // 修改输入密码的input类型
    $('.form-sign').on('click', '.change-type', function(e) {
        changeType(e);
    });
    // 获取注册短信验证码
    $('.sign-up').on('click', '.code-sms', function(e) {
    	getCode(e);
    });
    // 切换注册登录输入
    $('.inup-content').on('click', '#nav li', function(e) {
    	changeSec(e);
    });
    // 注册
    $('.inup-content').on('click', '#btn_signup', function(e) {
    	signUp(e);
    });
    // 登录
    $('.inup-content').on('click', '#btn_signin', function(e) {
    	signIn(e);
    });

    // 对应的事件
    // 修改输入密码的input类型
    function changeType(e) {
        var $target = $(e.currentTarget);
        var $input = $target.prev();
        var type = $input.attr('type'),
            classname = '';
        if (type === 'password') {
            type = 'text';
            classname = 'icon-block icon-i-eye';
        } else {
            type =  'password';
            classname = 'icon-block icon-i-eye-close';
        }
        $input.attr('type', type);
        $target.find('.icon-block')[0].className = classname;
    }

    // 倒计时， 获取短信验证码
    function getCode(e) {
    	var tel = $('#up_tel').val().trim()
    	if(tel.length <= 0) {
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
    // 切换注册登录输入
    function changeSec(e) {
    	var type = $(e.currentTarget).attr('data-type');
    	$('.sign-up,.sign-in').removeClass('active');
    	switch (type) {
    		case '0':
    		$('.sign-up').addClass('active');
    		break;
    		case '1': 
    		$('.sign-in').addClass('active');
    		break;
    	}
    }
    // 验证手机号码
    function valiPhone(tel) {
    	if(!(/^1[0-9]{10}$/.test(tel))){ 
        	return false; 
    	}
    	return true;
    }
    
    // 注册
    function signUp(e) {
    	var tel = $('#up_tel').val().trim(),
    		code = $('#up_code').val().trim(),
    		psw = $('#up_psw').val(),
    		inviter = $('#up_inviter').val().trim();
    	if(tel.length <= 0) {
    		Util.toast('手机号码不能为空');
    		return;
    	}
    	if(code.length <= 0) {
    		Util.toast('验证码不能为空');
    		return;
    	}
    	if(psw.length <= 0) {
    		Util.toast('密码不能为空');
    		return;
    	}
    	if(!valiPhone(tel)) {
    		Util.toast('请输入正确的手机号码');
    		return;
    	}

    	// todo 发送ajax请求注册
    	console.log('sign up')
    }
    // 登录
    function signIn(e) {
    	var tel = $('#in_tel').val().trim(),
    		psw = $('#in_psw').val();
    	if(tel.length <= 0) {
    		Util.toast('手机号码不能为空');
    		return;
    	}
    	if(psw.length <= 0) {
    		Util.toast('密码不能为空');
    		return;
    	}
    	if(!valiPhone(tel)) {
    		Util.toast('请输入正确的手机号码');
    		return;
    	}

    	// todo 发送ajax请求注册
    	window.location.href = '../borrow/index.html';
    }
})();