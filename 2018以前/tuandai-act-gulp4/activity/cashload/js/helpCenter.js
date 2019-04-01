(function() {
	FastClick.attach(document.body);

	$('.service-item').on('click', function() {
		var type = $(this).attr('data-type');
		if (+type) {
			console.info('电话客服');
			var params = {
				'methodName': 'CallService',
				'params': {}
			};
			Jsbridge.exec('GoToView', function() {}, params);
		} else {
			console.info('在线客服');
			var params = {
				'methodName': 'OnLineService',
				'params': {}
			};
			Jsbridge.exec('GoToView', function() {}, params);

		}
	});

	//点击问题
	$('.mh-qlist>li').on('click', function() {
		var id = $(this).attr('data-id');
		console.info('question id--', id);
		location.href = './questionDetail.html?id=' + id;
	});

	// $('.mh-icon').on('click', function() {
	// 	var type = $(this).attr('data-type');
	// 	switch (+type) {
	// 		case 0:
	// 			console.info('个人账户');
	// 			break;
	// 		case 1:
	// 			console.info('身份认证');
	// 			break;
	// 		case 2:
	// 			console.info('刷脸认证');
	// 			break;
	// 		case 3:
	// 			console.info('手机运营商');
	// 			break;
	// 		case 4:
	// 			console.info('贷款还款');
	// 			break;
	// 		case 5:
	// 			console.info('银行存管');
	// 			break;
	// 	}
	// });
})();