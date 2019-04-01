(function() {
	FastClick.attach(document.body);
	//do your thing.

	var cmmentScroller = new CommentScroller('#name-list', {
		showSlides: 5,
		autoplay: true,
		delay: 3000
	})

	//开
	$("#open").on('click', function() {
		$("#hb1").hide();
		$("#hb2").show();
	})

	$(".ruleBtn").on('click', function() {
		$("#ruleAlert").show();
	})

	$("#telInput").on('input', function() {
		var val = $(this).val();
		if(val.length == 11) {
			$("#inputTab").show();
		}
	})

	$(".alert_bg").on('click', function() {
		$(this).parent().hide();
	}).on('touchmove', function(e) {
		e.preventDefault();
	})

	$(".chacha,.iKnow").on('click', function() {
		$(this).parent().parent().hide();
	})

	function isAndroidPlatform() {
		if(navigator.userAgent.match(/(Android)/) ) {
			return true;
		} else {
			return false;
		}
	}

	$('input').on('focus', function(e) {
		if(isAndroidPlatform()) {
			$('.index').css('transform', 'translateY(-5rem)');
		}
	})

	$('input').on('blur', function(e) {
		if(isAndroidPlatform()) {
			$('.index').css('transform', 'translateY(0)');
		}
	})

})();