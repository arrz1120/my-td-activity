(function() {
	FastClick.attach(document.body);
	var questionId = Util.getParam('id');
	console.info('id-----', questionId);

	$('.qd-btn').on('click', function() {
		var type = $(this).attr('data-type');
		if (+type) {
			//有帮助
			console.info('有帮助');
		} else {
			//没有帮助
			console.info('没有帮助');
		}

	})
})();