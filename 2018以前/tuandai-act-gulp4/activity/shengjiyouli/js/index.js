(function() {
	FastClick.attach(document.body);
	//do your thing.
	function aniShow(ele, toShow) {
		var toShow = $(toShow);
		$(ele).on('click', function() {
			toShow.removeClass('hide');
			toShow.find('.alert_bg').removeClass('aniFadeOut').addClass('aniFadeIn');
			toShow.find('.alert_con').removeClass('aniHide').addClass('aniShow');
		})
	}

	function aniHide(parent) {
		parent.find('.alert_bg').removeClass('aniFadeIn').addClass('aniFadeOut');
		parent.find('.alert_con').removeClass('aniShow').addClass('aniHide');
		setTimeout(function() {
			parent.addClass('hide');
		}, 400);
	}
	$(".alert").on('touchmove', function(e) {
		e.preventDefault();
	})
	$(".alert_bg").on('click', function(e) {
		aniHide($(this).parent());
	})
	$(".ico_close").on('click', function(e) {
		aniHide($(this).parent().parent());
	})
	aniShow('#ruleBtn', '#alert');
})();