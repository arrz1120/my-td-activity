(function() {
    FastClick.attach(document.body);
	    //do your thing.
	var $scroll = $('.scroll'),
		$fareRemainNum = $scroll.find('.fare-remain-num'),
		$formWrapper = $("#form_wrapper"),
		$phoneInput = $formWrapper.find('input[name="phone"]'), //手机号输入框
		$startBtn = $formWrapper.find('.start-btn'), //话费开抢按钮
		userType = 0, //1--新用户, 2--白名单, 3--黑名单, 0--初始化未查询用户类型
		isEnd = 1; //活动是否结束, 0--已结束, 1--未结束, -1--人为干扰关闭活动
		
	/*动画
		fareRemain: 剩余话费总额
	*/
	function ain(fareRemain) {
		var fareRemainNumLen = $fareRemainNum.length,
			numTotal = 0, //动画话费值
			t;

		// 标题动画
		$scroll.find('.title').addClass('zoomIn');
		$scroll.find('.fare-remain-wrapper').addClass('flipInX');

		// 话费剩余动画
		setTimeout(function () {
			t = setInterval(function () {
				numTotal = fareRemain - numTotal < 99 ? numTotal + (fareRemain - numTotal) : numTotal + 99;
				var _numTotal = numTotal;
				for (var i = 0; i < fareRemainNumLen; i++) {
					var numBase = Math.pow(10,fareRemainNumLen - i - 1),
						num = parseInt(_numTotal / numBase);
					if(num < 1) num = 0;
					$fareRemainNum.eq(i).html(num);
					_numTotal = _numTotal - num * numBase;
				}
				if(numTotal === fareRemain) {
					clearInterval(t);
				}
			}, 5)
		},1500)
	}

	// 倒计时
	function countdown (second, callback) {
		var nowTime = +new Date(),
			endTime = nowTime + second*1000;

		var t = setInterval(function () {
			nowTime = +new Date();
			// 剩余时间
			var leftTime = Math.round((endTime - nowTime) / 1000);
			// 剩余时间小于0清除倒计时
			leftTime < 0 && clearInterval(t);
			callback(leftTime);
		}, 1000)
	}

    // 事件绑定
	function bindEvent() {
		// 输入框聚焦失焦事件
		$scroll.on('focus', 'input', function (e) {
			if(Util.isAndroid()){
				$scroll.css('transform', 'translateY(-8rem)');
			}
		})
		$scroll.on('blur', 'input', function (e) {
			if(Util.isAndroid()){
				$scroll.css('transform', 'translateY(0)');
			}
		})

		$scroll.on('click', 'input', function (e) {
			console.log(1);
		})

		// 点击活动规则
		$scroll.on('click', '.rule-btn', function() {
			Util.popup({
				"content": '<img class="rule" src="../images/rule.png">',
				"btns": [{
	                "txt": "",
	                "className": "cancel-btn",
	                "cb": function() {}
	            }]
			})
		})

		var $verifyCodeCon = $formWrapper.find('.verify-code-con'),
			$sendMsgBtn = $verifyCodeCon.find('.send-msg-btn'); //发送短信
		// 点击发送短信
		$formWrapper.on('click', '.send-msg-btn', function() {
			// 活动结束
			if (!isEnd && isEnd === -1) {
				Util.popup({
					"title": '活动已结束',
					"conClassName": "alert-bg",
					"content":  '<p>啊哦，剩余话费不足啦，</p>' +
								'<p>去试试团贷网的其他活动吧~</p>',
					"btns": [{
					    "txt": "", //取消按钮
					    "cb": function() {}
					}, {
					    "txt": "我知道了", //确定按钮
					    "cb": function() {}
					}]
				})
				return;
			}

			if(!$sendMsgBtn.hasClass('retry')){
				var countdownTime = 180; //倒计时时间(单位秒)

				// 重新发送验证码倒计时
				countdown (countdownTime, function (leftTime) {
					leftTime >= 0 ? $sendMsgBtn.html('重新发送'+ leftTime +'s') : $sendMsgBtn.removeClass('retry').html('发送短信');
				});
				$sendMsgBtn.addClass('retry').html('重新发送'+ countdownTime +'s');

				//ToDo: 发送验证码接口
				console.log('发送验证码接口');
			}
		})

		var $phoneMsg = $formWrapper.find('.phone-msg'), //手机号错误提示
			phoneReg = /^1[3|4|5|7|8]\d{9}$/,
			//验证码模块
			$verifyCodeInput = $verifyCodeCon.find('input'), //验证码输入框
			$verifyCodeMsg = $verifyCodeCon.find('.input-msg'); //验证码错误提示
		// 点击话费开抢
		$formWrapper.on('click', '.start-btn', function() {
			// 活动结束
			if(isEnd === 0 || isEnd ===-1) return;

			var phone = $phoneInput.val(), //手机号
				verifyCode = $verifyCodeInput.val(); //验证码

			// 如果显示错误提示则隐藏
    		!$phoneMsg.hasClass('hide') && $phoneMsg.html('').addClass('hide');
    		!$verifyCodeMsg.hasClass('hide') && $verifyCodeMsg.html('').addClass('hide');

			// 手机号为空
			if(!phone){
				$phoneMsg.html('手机号不能为空，请填写！').removeClass('hide');
				return;
			}
			// 手机号格式不对
        	if(!phoneReg.test(phone)){
				$phoneMsg.html('手机号格式不对，请修改！').removeClass('hide');
	        	return;
        	};

        	// 新用户显示验证码模块
        	if(!$verifyCodeCon.hasClass('hide')){
	        	// 验证码为空
	        	if(!verifyCode){
					$verifyCodeMsg.html('验证码不能为空，请填写！').removeClass('hide');
					return;
				}
				//验证码错误
				//ToDo: 判断验证码是否正确接口
				// if(验证码错误条件){
				// 	$verifyCodeMsg.html('验证码错误，请修改！').css('opacity', '1');
				// 	return;
				// }
        		//ToDo: 注册
        	}

        	//ToDo: 请求接口判断用户类型
        	userType = 1; //1--新用户, 2--白名单, 3--黑名单, 0--初始化未查询用户类型
        	switch(userType) {
        		case 1: //新用户
		        	var isInvited = false; //是否通过好友邀请
		        	// 未通过好友邀请
		    		if($startBtn.hasClass('invited') && !isInvited){
		        		Util.toast('请通过好友的邀请参与本活动，谢谢～');
		        		return;
		    		}
	        		// 通过好友邀请
	        		$verifyCodeCon.removeClass('hide'); //显示验证码模块
	        		$startBtn.addClass('invited'); //新用户按钮
        			break;
        		case 2: //白名单
		        	if($startBtn.hasClass('login')){
		        		// 跳转登录
		        		console.log('登录');
		        		window.location.href = 'invite.html'
		        		return;
		        	}
	        		$startBtn.addClass('login').html('登录抢话费'); //登录按钮
	        		//ToDo: 登录请求
	        		// 1、APP环境，点击调用原生登录界面；
	        		// 2、非APP环境，打开触屏版登录界面

        			break;
    			case 3: //黑名单
	        		Util.toast('您暂无资格参与本活动，谢谢关注！');
        			break;
        		default: //所有类型都不是
	        		Util.toast('用户类型不正确');
        			break;
        	}
		})
	}
	function init() {
    	//ToDo: 请求接口获取剩余话费
		var fareRemain = 25050; //剩余话费
		
    	//ToDo: 请求接口判断活动是否结束
		isEnd = 1; //0--已结束, 1--未结束, -1--人为干扰关闭活动
		// 活动结束
		switch(isEnd) {
			case 0: //0--已结束
				// 话费奖品池金额为0
				$phoneInput.attr('disabled', 'disabled').css('background', '#cfcfcf')
				$startBtn.html('活动已结束');
				$fareRemainNum.html(0);
				break;
			case 1: //1--未结束
				//动画
				ain(fareRemain);
				break;
			case -1: //-1--人为干扰关闭活动
				// 显示真实话费剩余数
				//动画
				ain(fareRemain);
				$phoneInput.attr('disabled', 'disabled').css('background', '#cfcfcf')
				$startBtn.html('活动已结束');
				break;
		}

		// ios系统下显示footer
		if(Util.isIOS()) $scroll.find('.footer').show();

		bindEvent();
	}
	init();
})();