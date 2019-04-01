(function() {
    FastClick.attach(document.body);
	
	//手机号校验
	function checkPhone(value) {
		if(!(/^1[34578]\d{9}$/.test(value))) {
			return false;
		}else{
			return true
		}
	}
	
	//密码校验  
	function checkPassword(value) {
		if(!(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/.test(value))) {
			return false;
		}else{
			return true
		}
	}
	
	$(".login-btn").click(function(){
		var tel = $("#telInput").val();
		var pass = $("#password").val();
		var telCode = $("#telCode").val();
		if(tel == ''){
			Util.toast('手机号不能为空！');
			return false;
		}
		else if(pass == ''){
			Util.toast('密码不能为空！');
			return false;
		}
		else if(telCode == ''){
			Util.toast('手机验证码不能为空！');
			return false;
		}
		else if(!checkPhone(tel)){
			Util.toast('手机号格式有误！');
			return false;
		}
		else if(!checkPassword(pass)){
			Util.toast('密码格式有误！');
			return false;
		}
		else{
			//校验完毕
		}
	})
	
	//获取验证码事件
	function getCodeEvent(){
		$("#getCode").click(function(){
			$(this).unbind();
			$(this).html('60s后可重发');
			codeInterval();
		})
	}
	
	//验证码倒计时
	function codeInterval(){
		var time = 60;
		var timer = setInterval(function(){
			time--;
			if(time == 0){
				$("#getCode").html('重新发送');
				clearInterval(timer);
				getCodeEvent();
			}else{
				$("#getCode").html(time+'s后可重发');
			}
		},1000);
	}
	getCodeEvent();
	
})();