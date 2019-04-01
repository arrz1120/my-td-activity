(function() {
	FastClick.attach(document.body);



	$('.close').on('click', function() {
		$(this).parents('.alert').hide();
	});



	//切换密码输入框

	$('.show').on('click', function() {
		var _this = $(this);
		if (_this.hasClass('eyes_open')) {
			$('.password').attr('type', 'password')
		} else {
			$('.password').attr('type', 'text')
		}
		_this.toggleClass('eyes_open')
	})

})();