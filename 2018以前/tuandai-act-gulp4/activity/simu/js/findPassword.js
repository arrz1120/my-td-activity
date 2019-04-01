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
	
	//校验输入框是否为空
	var telInput = $("#telInput"),
		telCode = $("#telCode"),
		passwordInput = $("#password");
	
	telInput.on('input',function(){
		if($(this).val().length==11 && telCode.val()!='' && passwordInput.val()!=''){
			lightSubmit();
		}
	})
	
	telCode.on('input',function(){
		if(telInput.val()!='' && passwordInput.val()!=''){
			lightSubmit();
		}
	})
	
	passwordInput.on('input',function(){
		var valLen = $(this).val().length;
		if(valLen>=6 && valLen<=16 && telCode.val()!='' && telCode.val()!=''){
			lightSubmit();
		}
	})
	
	function lightSubmit(){
		$(".find-btn").removeClass('btn-ban').addClass('btn-on');
		submitEvent();
	}
	
	//提交事件绑定
	function submitEvent(){
		$(".btn-on").unbind();
		$(".btn-on").on('click',function(){
			//点击校验手机号、密码
		
			var phoneResult = checkPhone(telInput.val());
			var passResult = checkPassword(passwordInput.val());
		
			if(phoneResult == false){
				Util.toast('手机号格式有误！');
			}else{
				if(passResult == false){
					Util.toast('密码格式有误！');
				}else{
					//校验完成
				}
			}
		
		})
	}
	
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