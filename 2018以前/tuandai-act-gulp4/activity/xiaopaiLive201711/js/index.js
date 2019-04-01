(function() {
    FastClick.attach(document.body);
	    //do your thing.
	var $body = $('body'),
		$redPackWrapper = $body.find('.red-pack-wrapper'),
		$quesWrapper = $redPackWrapper.find('.ques-wrapper'),
		$commentWrapper = $body.find('.comment-wrapper'),
		$commentInput = $commentWrapper.find('.comment-input'),
		$commentList = $commentWrapper.find('.comment-list'),
		$commentItem = $commentList.find('.comment-item'),
		like = [], //是否点过赞
		isLogin = Util.isLogined(),
		quesChance = 1, //答题机会
		commentChance = 5; //评论机会
	like.length = $commentItem.length; //点赞数组长度与评论条数数组长度一致

    // 评论滚动
	function commentSlider(target) {
		if(!target.length || target.find('li').length < 3) return; //不存在target或li元素小于3个返回
		var commentLi = target.find('li'),
			commentLiH = parseFloat(commentLi.css('height'));

		setInterval(function () {
			target.animate({
				marginTop: -commentLiH
			}, 500, function () {
              target.css({
              	marginTop: 0
              }).find("li:first").appendTo(target);
            });
		}, 3000)
	}

    //	微信分享
	function share() {
		var vtitle = '资产标的拿下分期风控实录', //分享标题
			// viconUrl = "../images/share-pic.png", //分享图片
			viconUrl = "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png", //分享图片

			vcontent = '看拿下分期实地考察纪录片，拿下丰厚红包！', //分享内容
			vshareUrl = 'https://www.baidu.com/',
			// 分享参数
			params = {
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
		if(Util.isApp()){
    		// APP环境调用分享工具，限定微信及微信朋友圈
		    Jsbridge.toAppWebViewShare(params, function (result) {});
		}else{
			Util.popup({
				"type": "share",
	            "conClassName": "share-con",
	            "btns": [{
		                "txt": "",
		                "cb": function() {
		                }
		            }]
	        })
		}
	}

	//未登录
	function unLogin() {
		if(!isLogin){
			Util.popup({
	            "content": '<p class="alert-msg">请先登录团贷网哦！</p>',
	            "btns": [{
	                "txt": "登 录",
	                "cb": function() {
	                	//ToDo: 登录回调
	                	Util.openLogin();
	                }
	            }]
	        })
	        return;
		}
	}

    // 事件绑定
    function bindEvent() {
		var $fixedBtn = $('.fixed-btn'),
			headerH = $('.header').height(),
			commentWrapperTop = $commentWrapper.offset().top - $commentWrapper.height()/2;

    	$(window).on('scroll touchmove', function () {
    		var scrollTop = $body.scrollTop();
    		// 在头部和评论区隐藏悬浮按钮
    		scrollTop >= headerH && scrollTop <= commentWrapperTop ? $fixedBtn.show() : $fixedBtn.hide();
    	})
    	// 悬浮按钮
    	$body.on('click', ".fixed-app-btn", function () {
    		Util.popup({
		            "conClassName": "fixed",
		            "content": '<i class="app-icon"></i>' + 
					    		'<p class="alert-msg">' +
					    			'下载映客直播App<br/>' +
									'关注直播号<span class="orange">165102644</span><br/>' +
									'于11月30日15:00观看直播' +
					    		'</p>' +
								'<span class="tip-txt">此方式可直接参与互动</span>',
		            "btns": ''
		        })
    	})
    	$body.on('click', ".fixed-wx-btn", function () {
    		Util.popup({
		        "conClassName": "fixed",
		        "content": '<i class="wx-icon"></i>' + 
				    		'<p class="alert-msg">' +
				    			'点击二维码<br/>' +
								'关注“团贷网”订阅号<br/>' +
								'于11月30日15:00回复<span class="orange">“小派直播”</span><br/>' +
								'获取链接观看直播' +
				    		'</p>' +
							'<span class="tip-txt">此方式需根据提示下载App参与互动</span>',
	            "btns": ''
	        })
    	})

    	// 分享
    	$body.on('click', ".share-btn", function () {
    		share();
    	})

    	// 看直播领红包模块切换
    	var $redPackTab = $redPackWrapper.find('.red-pack-tab'),
			$redPackCon = $redPackWrapper.find('.red-pack-con');
    	$redPackWrapper.on('click', ".red-pack-tab", function(){
    		var $this = $(this);
			if(!$this.hasClass('act')){
				$redPackTab.removeClass('act');
				$this.addClass('act');
				$redPackCon.hide();
				$this.next().show();
			}
    	})

    	// 直播互动领红包二维码点击
    	$redPackWrapper.on('click', ".live-interact-wx", function(){
    		Util.popup({
		        "conClassName": "interact",
		        "content": '<i class="wx-icon"></i>' + 
				    		'<p class="alert-msg">' +
				    			'长按并复制微信号查找添加<br/>' +
								'或截屏后在微信端打开识别二维码' +
				    		'</p>',
	            "btns": ''
	        })
    	})

    	// 领红包规则
    	$quesWrapper.on('click', ".rule-btn", function () {
    		$("#rule_alert").show();
    	})
    	$body.on('click', "#rule_alert .mask", function () {
    		$("#rule_alert").hide();
    	})

    	// 提交答题
    	$quesWrapper.on('click', ".submit-btn", function () {
    		unLogin(); //未登录

    		//没选择选项
    		Util.popup({
		        "content": '<p class="alert-msg">题目选项不能为空</p>',
		        "btns": [{
		            "txt": "知道了"
		        }]
		    })
    		return;
    		// 答题机会用完
        	if(!quesChance){
    			Util.popup({
    		        "content": '<p class="alert-msg">您的答题机会已用完！</p>',
    		        "btns": [{
    		            "txt": "知道了"
    		        }]
    		    })
        		return;
        	}
	        quesChance--;
    	})

    	// 点赞
    	$commentWrapper.on('click', '.comment-like i', function () {
    		var $this = $(this),
    			likeIndex = +$this.attr('data-index');

    		if(!like[likeIndex]){
	    		var	$likeNum = $this.next(),
	    			likeNum = parseInt($likeNum.html());
	    		$this.addClass('act');
	    		$likeNum.html((likeNum+1) + '+');
	    		like[likeIndex] = true;
    		}
    	})

    	// 输入评论
    	$commentWrapper.on('focus', '.comment-input', function () {
    		if(Util.isAndroid() && Util.isApp()){
				$('.content').css('transform', 'translateY(-8rem)');
			}

    	})
    	$commentWrapper.on('blur', 'comment-input', function (e) {
			if(Util.isAndroid() && Util.isApp()){
				$('.content').css('transform', 'translateY(0)');
			}
		})
		$commentWrapper.on('click', '.comment-input', function () {
    		unLogin(); //未登录

    		if($commentInput.attr('readonly') === 'readonly'){ //登录状态下,去掉输入框只读属性
    			$commentInput.removeAttr('readonly');
    		}
    	})

    	// 输入评论限制
    	$commentWrapper.on('input', '.comment-input', function () {
    		var $this = $commentInput,
    		 	commentNum = $this.val().length,
    		 	$commentLeftNum = $("#comment_left_num"),
    		 	limitNum = 40,
    		 	leftNum = parseInt(limitNum - commentNum);
			
			if(leftNum >= 0 ){
				$commentLeftNum.html(leftNum);
			}else{
				$commentLeftNum.html('0');
				$this.val($this.val().substring(0, limitNum));
				Util.toast('输入字符长度超限！');
			}
    	})

    	// 提交问题
    	$commentWrapper.on('click', '.submit-btn', function () {
    		var comment = $commentInput.val().trim();
    		// 评论机会已满
    		if(!commentChance){
    			Util.popup({
		            "content": '<p class="alert-msg">您今天评论已满5次，<br />请明天再来哦！</p>',
		            "btns": [{
		                "txt": "改天再来"
		            }]
		        })
    			return;
    		}
    		//未输入内容
    		if(!comment){
    			Util.popup({
		            "content": '<p class="alert-msg">您尚未输入评论内容，<br />请完善后再提交。</p>',
		            "btns": [{
		                "txt": "知道了"
		            }]
		        })
    			return;
    		}
    		$commentLeftNum.html('40');
    		commentChance--;
    	})
    }

    function init() {
    	commentSlider($commentList);
    	bindEvent();
    }
    init();
})();