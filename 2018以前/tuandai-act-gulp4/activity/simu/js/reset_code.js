(function() {
	FastClick.attach(document.body);

	//密码校验  
	function checkPassword(value) {
		if(!(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/.test(value))) {
			return false;
		}else{
			return true
		}
	}
	
	$("#confirm").click(function(){
		var oldPassword = $("#oldPassword").val();
		var newPassword = $("#newPassword").val();
		if( oldPassword == ''){
			Util.toast('原密码不能为空！');
			return false;
		}
		else if(checkPassword(oldPassword)){
			Util.toast('原密码格式有误！');
			return false;
		}
		else if( newPassword == ''){
			Util.toast('新密码不能为空！');
			return false;
		}
		else if(checkPassword(newPassword)){
			Util.toast('新密码格式有误！');
			return false;
		}
		else{
			//校验完成
		}
	})

})();