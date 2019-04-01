(function() {
    FastClick.attach(document.body);
	    //do your thing.
	var $scroll = $('.scroll'),
		$shareCon = $('.share-con'),
		$fareRemainNum = $scroll.find('.fare-remain-num'),
		$inviteWrapper = $scroll.find('.invite-wrapper'),
		$getFareWrapper  = $scroll.find('.get-fare-wrapper'),
		$investWrapper  = $scroll.find('.invest-wrapper'),
		fare = 0, //获得话费金额
		isNewUser = false,  //是否是新用户
		isAllInvite = false, //是否完成邀请任务
		isApp = Jsbridge.isApp(), //是否在app内
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

	// 邀请好友回调
	function invite() {
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

		if(isApp){
			// APP环境调用分享工具，限定微信及微信朋友圈
		    Jsbridge.toAppWebViewShare(params, function (result) { });
			
		}else if(Util.isWeiXin()){
			//微信弹出分享引导层
			$shareCon.show();
		}else{ 
			//非微信/app环境Toast提示
			Util.toast('请使用团贷APP或微信打开');
		}
	}

    //	App分享
	var vtitle = '邀请送话费';
	var viconUrl = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png";
	var vcontent = '邀请送话费';
	var vshareUrl = 'https://www.baidu.com/';

	var params = {
	    "shareTypeList": [{
	        "ShareToolType": 1,
	        "ShareToolName": "微信",
	        "IconUrl": viconUrl,
	        "Title": vtitle,
	        "ShareContent": vcontent,
	        "ShareUrl": vshareUrl + "&ShareToolType=1",
	        "IsEnabled": true
	    }, {
	        "ShareToolType": 5,
	        "ShareToolName": "朋友圈",
	        "IconUrl": viconUrl,
	        "Title": vtitle,
	        "ShareContent": vcontent,
	        "ShareUrl": vshareUrl + "&ShareToolType=5",
	        "IsEnabled": true
	    }]
	};

	//完成邀请任务回调
	function invitedCb() {
		if(!isNewUser){
			// 老用户做完邀请任务显示获得话费券
			$getFareWrapper.show().siblings('.box-wrapper').hide();
			$getFareWrapper.find('.fare').html(fare);
			// 老用户只提供查看我的好友按钮，点击打开H5邀请有礼首页
			$getFareWrapper.find('.show-friend-btn').attr('href', 'https://at.tuandai.com/201708/invite/weixin/index.aspx');
			Util.popup({
				"title": '话费已到手！',
				"conClassName": "alert-bg",
				"content":  '<p>真厉害，已有3位好友帮您助力！</p>' +
							'<p>恭喜您获得'+ fare +'元话费，话费将在5个工作日</p>' +
							'<p>内充值到账，请查收~ </p>',
				"btns": [{
				    "txt": "", //取消按钮
				    "cb": function() {}
				}, {
				    "txt": "我知道了", //确定按钮
				    "cb": function() {}
				}]
			})
		}else{
			// 新用户做完邀请任务显示投资任务
			$investWrapper.show().siblings('.box-wrapper').hide();

			// 提示完成投资任务
			Util.popup({
				"title": '投资领取'+ fare +'元话费！',
				"conClassName": "alert-bg",
				"content":  '<p>真厉害，已有3位好友帮你助力！</p>' +
							'<p>恭喜开启'+ fare +'元话费礼包资格，离领取话费</p>' +
							'<p>仅剩最后一步，快去投资吧~ </p>',
				"btns": [{
				    "txt": "", //取消按钮
				    "cb": function() {}
				}, {
				    "txt": "去投资", //确定按钮
				    "cb": function() {}
				}]
			})

			var investFare = 30; //投资任务对应得到的话费
			// 完成某投资任务时，提示用户话费到帐
			Util.popup({
				"title": '话费已到手！',
				"conClassName": "alert-bg",
				"content":  '<p>真厉害，恭喜您出色完成投资任务，</p>' +
							'<p>获得'+ investFare +'元话费，话费将在24个小时内自动</p>' +
							'<p>到账,请查收~ </p>',
				"btns": [{
				    "txt": "", //取消按钮
				    "cb": function() {}
				}, {
				    "txt": "我知道了", //确定按钮
				    "cb": function() {}
				}]
			})
		}
	}

    // 事件绑定
	function bindEvent() {
		// 点击活动规则
		$scroll.on('click', '.rule-btn', function() {
			Util.popup({
				"content": '<img class="rule" src="../images/rule.png">',
				"btns": [{
	                "txt": "",
	                "cb": function() {}
	            }]
			})
		})

		/*邀请任务*/
		// 点击立即邀请
		$inviteWrapper.on('click', '.invite-btn', function() {
			invite();
		})

		// 点击我的好友头像
		$inviteWrapper.on('click', '.friend-invite-btn', function() {
			$this = $(this);
			if (!$this.find('img').length) {
				invite();
				
				// 邀请好友后添加相应头像&昵称
				/*$this.find('.pic-bg-right').html('<img src="../images/my-friend-pic.png">');
				$this.find('.grey-font').html('137****7769');
				isAllInvite = $inviteWrapper.find('.friend-invite-btn img').length === 3 ? true : false;
				isAllInvite && invitedCb();*/
			}
		})

		// 点击分享返回按钮
		$shareCon.on('click','.share-back-btn', function () {
			$shareCon.hide();
		})

		/*投资任务*/
		// 点击去投资
		$investWrapper.on('click', '.voucher-invest-btn', function () {
			var $investItem = $(this).parent().parent(),
				noInvest = $investItem.hasClass('overtime') || $investItem.hasClass('received'); //话费券已过期或者已领取
			if(!noInvest){
				// app环境前往投资原生页,非app环境打开触屏版投资页
				window.location.href = isApp ? '投资原生页' : '触屏版投资页';
			}
			
		})

	}

	// 初始化
	function init() {
    	//ToDo: 请求接口获取剩余话费
		var fareRemain = numTotal = 25050; //剩余话费
		
		//ToDo: 请求接口判断活动是否结束
		isEnd = 1; //0--已结束, 1--未结束, -1--人为干扰关闭活动
		
		// 动画
		ain(fareRemain);

		// ios系统下显示footer
		if(Util.isIOS()) $scroll.find('.footer').show();

    	//ToDo: 请求接口判断用户是否是新用户及是否完成邀请任务
		isNewUser = false; //是否是新用户
		isAllInvite = $inviteWrapper.find('.friend-invite-btn img').length === 3 ? true : false; //是否完成邀请任务
		fare = isNewUser ? 40 : 20; //老用户可获得20元话费资格，新用户可获得40元话费资格
		if(!isAllInvite){ //邀请任务没做完显示邀请任务模块
			$inviteWrapper.show();
			// 老用户可获得20元话费资格，新用户可获得40元话费资格，
			$inviteWrapper.find(".fare").html(fare); //初始化金额
			
			// 用户成功邀请1～2名好友时,打开邀请页面弹出弹窗
			var alertTxt = isNewUser ? '开启' + fare : '赢' + fare; //弹窗文案
			Util.popup({
				"title": '邀请好友' + alertTxt + '话费',
				"conClassName": "alert-bg",
				"content":  '<p>加油吧，话费马上要到手了！</p>' +
							'<p>快点击转发好友或朋友圈，邀请三位好友帮</p>' +
							'<p>你' + alertTxt + '话费礼包～</p>',
				"btns": [{
				    "txt": "", //取消按钮
				    "cb": function() {}
				}, {
				    "txt": "邀请好友", //确定按钮
				    "cb": function() {}
				}]
			})
		}else{ 
			invitedCb();
		}

		bindEvent();
	}
	init();
})();