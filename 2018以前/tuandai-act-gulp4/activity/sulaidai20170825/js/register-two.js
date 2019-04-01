 //校验手机号码
function checkPhoneNum(phoneNum) {
  var reg = /^1[3|4|5|7|8]\d{9}$/;
  return reg.test(phoneNum);
}

function checkPwdNum(pwd) {
  var reg = /(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,16}$/;
  return reg.test(pwd);
}

 //绑定 pageshow事件
 function onPageShow(callback) {
 	var showCount = 0;
 	window.addEventListener("pageshow", function() {
 		showCount++;
 		if (callback) {
 			callback(showCount);
 		}
 	});
 }

 //去掉firefox和safari的往返缓存（bfcache）
 function pageShowReload() {
 	onPageShow(function(showcount) {
 		if (showcount > 1) {
 			window.location.reload();
 		}
 	})
 }

$(function() {
    FastClick.attach(document.body);
    var myScroll,
		stickyEl = $(".sticky-footer"),
		contentEl = $(".content");
		
	// 获取注册区域的el
	var phoneEl = contentEl.find(".phone-input"),
	pwdEl = contentEl.find(".pwd-input"),
	imgcodeEl = contentEl.find(".img-code-input"),
	msgcodeEl = contentEl.find(".msg-code-input"),
	registeBtnEl = contentEl.find(".btn-registe");

	+ function reset() {	//重置页面状态
 		phoneEl.val("");
 		pwdEl.val("");
 		imgcodeEl.val("");
 		msgcodeEl.val("");
 		contentEl.find(".icon-checkbox").addClass('checked');
 		contentEl.find(".hidden").hide();
 	}()

	var headerHeight = contentEl.find(".header").height();

	// 监听手机号码的输入
	contentEl.on("input", ".phone-input", function() {
		var $this = $(this);
		if(checkPhoneNum($this.val())) {
			contentEl.find(".phone .tips-error").hide();	//手机号码错误提示隐藏
			contentEl.find(".hidden").show();

			// 刷新页面的状态
			headerHeight = contentEl.find(".header").height();
		}
	});

	// 点击图形验证码
	contentEl.on("click", ".img-code-img", function() {
		console.log("更换图形验证码")
	});
		
	// 发送短信验证码
	contentEl.on("click", ".get-msg-code", function() {
		var phone = phoneEl.val(),	//手机号码
		phoneTips = contentEl.find(".phone .tips-error");	//手机号码错误提示
		if(phone.length === 0) {
			phoneTips.html("手机号码不能为空！").show();
			return;
		} 

		if(!checkPhoneNum(phone)) {
		phoneTips.html("输入手机号码格式不正确！").show();
			return;
		}
		phoneTips.hide();

		var $this = $(this);
		if($this.hasClass("couting")) {	//倒数中
			return;
		}
		$this.addClass("couting");
		var time = 60;
		$this.html(time + "s");
		var si = setInterval(function countDown() {
			if(time >= 0) {
				time--;
				$this.html(time + "s");
			} else {
				$this.html("重新获取").removeClass("couting");
				clearInterval(si)
			}
		}, 1000);
	});
	
	// 点击是否接受协议
	contentEl.on("click", ".icon-checkbox", function() {
		var $this = $(this);
		$this.toggleClass("checked");
	});


	// 点击底部立即拿钱，滑动至注册区域
	var bannerHeight = contentEl.find(".banner").height();
	var registeAreaHeight = parseInt(contentEl.find(".registe-wrapper").css("margin-top"))

    $("body").on("click", ".btn-scroll", function() {
    	var scrollTop = bannerHeight + registeAreaHeight;
 		contentEl.animate({'scrollTop': scrollTop+ 'px'});
    });

    // 点击立即拿钱
    contentEl.on("click", ".btn-registe", function() {
			var phone = phoneEl.val(),	//手机号码
			phoneTips = contentEl.find(".phone .tips-error");	//手机号码错误提示
			if(phone.length === 0) {
				phoneTips.html("手机号码不能为空！").show();
				return;
			} 

			if(!checkPhoneNum(phone)) {
			phoneTips.html("输入手机号码格式不正确！").show();
				return;
			}
			phoneTips.hide();
			
			var pwd = pwdEl.val(),	//密码
			pwdTips = contentEl.find(".pwd .tips-error");	//密码错误提示
			if(pwd.length === 0) {
				pwdTips.html("密码不能为空！").show();
				return;
			} 

			if(!checkPwdNum(pwd)) {
				pwdTips.html("密码格式错误，必须为6-16个字符（包含字母+数字）").show();
				return;
			}
			pwdTips.hide();

			var imgcode = imgcodeEl.val(),	//图形验证码
			imgcodeTips = contentEl.find(".img-code .tips-error");	//图形验证码错误提示
			if(imgcode.length === 0) {
				imgcodeTips.html("图形验证码不能为空！").show();
				return;
			} 

			if(imgcode !== "图形验证码") {
				imgcodeTips.html("图形验证码错误！").show();
			}
			imgcodeTips.hide();

			var msgcode = msgcodeEl.val(),	//短信验证码
			msgcodeTips = contentEl.find(".msg-code .tips-error");	//短信验证码错误提示
			if(msgcode.length === 0) {
				msgcodeTips.html("验证码不能为空！").show();
				return;
			} 

			if(msgcode !== "短信验证码") {
				msgcodeTips.html("验证码错误！").show();
			}
			msgcodeTips.hide();

			if(!contentEl.find(".icon-checkbox").hasClass("checked")) {
				alert("请阅读速来贷注册协议");
				return;
			}
		
			//TODO:提交成功
			window.location.href = './done-two.html';
    });
	
	// 监听页面的滑动
 	contentEl.scroll(function() {
 		if (contentEl.scrollTop() > headerHeight) { //置顶条件
			registeBtnEl.css("visibility", "hidden");
			stickyEl.show();
		} else {
			stickyEl.hide();
			registeBtnEl.css("visibility", "visible");
		}     
    })

});