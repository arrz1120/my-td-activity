(function() {
	FastClick.attach(document.body);
	//do your thing.

	function checkPhone(tel) {
		var reg = /^((\+?[0-9]{1,4})|(\(\+86\)))?(13[0-9]|14[057]|16[6]|19[9]|15[012356789]|17[03678]|18[0-9])\d{8}$/;
		if(reg.test(tel)) {
			return true;
		} else {
			return false;
		}
	}

	function showTips(txt) {
		$(".error").html(txt).fadeIn();
		setTimeout(function() {
			$(".error").fadeOut();
		}, 2000);
	}

	$("#telInput").on('input', function() {
		var val = $(this).val();
		if(val.length == 11) {
			if(checkPhone(val)) {
				$(".code-box").show();
			} else {
				showTips('您输入的手机号码格式有误');
			}
		}
	})

	function isAndroidPlatform() {
		if(navigator.userAgent.match(/(Android)/)) {
			return true;
		} else {
			return false;
		}
	}

	$('input').on('focus', function(e) {
		if(isAndroidPlatform()) {
			$('.login').css('transform', 'translateY(-5.5rem)');
		}
	})

	$('input').on('blur', function(e) {
		if(isAndroidPlatform()) {
			$('.login').css('transform', 'translateY(0)');
		}
	})

})();