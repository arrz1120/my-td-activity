(function() {
	FastClick.attach(document.body);
	// Util.toast('提示内容');

	//马上注册
	$('#goRegister').on('click', function() {

	});
	//下一步
	$('.cr-next').on('click', function() {
		if ($(this).hasClass('active')) {
			//下一步
		}
	});
	//个人信用报告查询服务协议
	$('.cr-agreement').on('click', function() {
	});
	//点击验证码
	$('.icon-captcha').on('click', function(e) {
		//修改验证码图片
		e.target.src = '../images/242ff125dd7a62ed109431a908641081.png';
	});
})();