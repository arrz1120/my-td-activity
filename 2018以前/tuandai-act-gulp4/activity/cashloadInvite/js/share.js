(function() {
	FastClick.attach(document.body);

	window.onload = function() {
		$('.content').addClass('anit');
	}
	$('#phone').on('input', function() {
		var phoneNo = $(this).val().trim();
		if (phoneNo.length > 0) {
			$('.input-reset').show();
		} else {
			$('.input-reset').hide();
		}
	});

	$('.input-reset').on('click', function() {
		$('input[name="phone"]').val('');
	});
	//发送验证码
	$('#sendCode').on('click', function() {
		var _elem = $(this);
		if (_elem.hasClass('btn-counting')) return;
		var phoneNo = $('#phone').val().trim();
		if (!Util.valiPhone(phoneNo)) {
			Util.toast('输入有误，请重新输入');
			return;
		}
		//发送验证码
		//todo
		//开始倒计时
		var countTime = 10;
		_elem.html(countTime + 's后可重发');
		_elem.addClass('btn-counting');
		var codeInterval = Util.countdownFun(countTime, function(time) {
			_elem.html(time + 's后可重发');
		}, function() {
			_elem.html('发送验证码');
			_elem.removeClass('btn-counting');
			clearInterval(codeInterval);
		});
	});
	// 修改输入密码的input类型
	var btnElem = $('.icon-psw')
	$('.icon-psw').on('click', function(e) {
		var _target = $(e.currentTarget);
		var _input = _target.prev();
		var type = _input.attr('type');
		if (type === 'password') {
			type = 'text';
			_target.removeClass('psw-hide').addClass('psw-show');
		} else {
			type = 'password';
			_target.removeClass('psw-show').addClass('psw-hide')
		}
		_input.attr('type', type);
	});

	//马上注册
	$('.btn-register').on('click', function() {
		var data = {
			phone: $('#phone').val().trim(),
			code: $('#code').val().trim(),
			password: $('#psw').val().trim()
		};
		if (!Util.valiPhone(data.phone)) {
			Util.toast('输入有误，请重新输入');
			return;
		}
		if (data.code.length === 0) {
			Util.toast('请输入验证码');
			return;
		}
		if (data.password.length === 0) {
			Util.toast('请输入密码');
			return;
		}
		if (!/(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,16}$/.test(data.password) || /[^\w\.\/]/.test(data.password) ) {
			Util.toast('输入有误，请重新输入');
			$('.icon-psw').removeClass('psw-hide').addClass('psw-show');
			$('.icon-psw').prev().attr('type', 'text');
			return;
		}

		console.info('data---', data);
		$('.r-mask').show();
	});

	$('.masker').on('click', function() {
		$('.r-mask').hide();
	});
	//取消
	$('.r-btn-negative').on('click', function() {
		$('.r-mask').hide();
	});
	//前往下载APP
	$('.r-btn-active').on('click', function() {
		//前往下载APP
		//todo

		$('.r-mask').hide();
	});



})();