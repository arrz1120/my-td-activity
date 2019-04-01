(function() {
	FastClick.attach(document.body);
	Util.initHeader({
		'header': 'header'
	});
	var info = {};
	var status = {
		cardNumber: false,
		phone: false
	}; //按钮是否可点击
	$('input').on('input', function() {
		var _info = {
			name: $('#name').val().trim(),
			idNumber: $('#idNumber').val().trim(),
			cardNumber: $('#cardNumber').val(),
			phone: $('#phone').val().trim()
		}
		_info.cardNumber = _info.cardNumber.replace(/\ +/g, "");
		if (_info.name.length > 1 && _info.idNumber.length > 1 && (_info.cardNumber.length >= 16 && _info.cardNumber.length <= 19) && _info.phone.length == 11) {
			validatInput(_info);
		} else {
			!$('#goBind').hasClass('disabled') && $('#goBind').addClass('disabled');
		}

	});

	function validatInput(data) {
		if (/^[0-9]*$/.test(data.cardNumber)) {
			status.cardNumber = true;
		} else {
			status.cardNumber = false;
		}
		if (Util.valiPhone(data.phone)) {
			status.phone = true;
		} else {
			status.phone = false;
		}

		if (status.cardNumber && status.phone) {
			$('#goBind').removeClass('disabled');
		} else {
			$('#goBind').addClass('disabled');
		}
	}


	$('#goBind').on('click', function() {
		info = {
			name: $('#name').val().trim(),
			idNumber: $('#idNumber').val().trim(),
			cardNumber: $('#cardNumber').val().trim(),
			phone: $('#phone').val().trim()
		}
		info.cardNumber = info.cardNumber.replace(/\ +/g, "");
		console.info('info---', info);
		if (info.name.length < 1) {
			Util.toast('请输入您的真实姓名');
			return;
		}
		if (info.idNumber.length < 1) {
			Util.toast('请输入您的证件号码');
			return;
		}
		// if (info.cardNumber.length < 1) {
		// 	Util.toast('请输入您的银行卡号');
		// 	return;
		// }
		// if (info.phone.length < 1) {
		// 	Util.toast('请输入您的银行预留手机号');
		// 	return;
		// }
		if (info.cardNumber.length < 16 || info.cardNumber.length > 19 || !/^[0-9]*$/.test(info.cardNumber)) {
			Util.toast('请输入正确的银行卡号');
			return;
		}
		if (info.phone.length < 11 || !Util.valiPhone(info.phone)) {
			Util.toast('请输入正确的手机号');
			return;
		}
		//绑定银行存管
		//todo
		Util.showResult({
			'result': 1,
			'status': '您的存管账户开通成功',
			'info': '已成功开通厦门银行资产存管服务',
			'btn': {
				'name': '返回',
				'cb': function() {
					history.back();
				}
			}
		})
	});

})();