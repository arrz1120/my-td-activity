(function() {
	FastClick.attach(document.body);
	//do your thing.



	//手机兼容

	var w = $(window).width(),
		h = $(window).height(),
		rate = w / h;

	if (rate > 0.65) {
		$('body').addClass('fixed');
	}

	if (rate > 0.686) {
		$('body').addClass('fixed_1');

	}


	



})();