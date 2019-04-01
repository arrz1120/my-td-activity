(function() {
	FastClick.attach(document.body);
	// 初始化footer
	Util.initFooter('footer');

	// $('.uc-borrow-cont').on('click', function() {
	// 	//跳转到我的借款
	// });
	//查看借款详情
	$('#checkDetail').on('click', function() {
		location.href = './myLoan.html';
	});

	$('.uc-tr').on('click', function() {
		var type = $(this).attr('data-type');
		switch (type) {
			case '0':
				//邀请有礼
				break;
			case '1':
				//优惠券
				location.href = './myCoupon.html';
				break;
			case '2':
				//信用管理
				location.href = './credit.html';
				break;
			case '3':
				//修改登录密码
				location.href = '../signInUp/forgot.html';
				break;
			case '4':
				//帮助中心
				location.href = './helpCenter.html';
				break;
		}
	});
	//退出登录
	$('.btn-logout').on('click', function() {
		//todo
	});
	

})();