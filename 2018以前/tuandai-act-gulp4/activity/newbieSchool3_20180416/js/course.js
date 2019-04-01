(function() {
    FastClick.attach(document.body);


	//手机兼容
	var w = $(window).width(),
		h = $(window).height(),
		rate = w / h;
	if (rate > 0.65) {
		$('body').addClass('fixed');
	}

	var nav_box_main = $('#nav_box_main');

	nav_box_main.find('.arrow').on('click',function(e){
		nav_box_main.hide();
	});


	$('#nav_btn').on('click',function(e){
		nav_box_main.show();
	});



})();