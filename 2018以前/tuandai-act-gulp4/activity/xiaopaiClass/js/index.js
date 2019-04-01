(function() {
    FastClick.attach(document.body);
	    //do your thing.
	var $body = $('body'),
		$quesWrapper = $body.find('.ques-wrapper'),
		$commentWrapper = $body.find('.comment-wrapper'),
		$commentInput = $commentWrapper.find('.comment-input'),
		$commentList = $commentWrapper.find('.comment-list'),
		$commentItem = $commentList.find('.comment-item'),
		like = [], //是否点过赞
		isLogin = false,
		allRight = false, //全答对了
		isShare = true, //是否分享过
		quesChance = 1, //答题机会
		commentChance = 5, //评论机会
		t;

	like.length = $commentItem.length; //点赞数组长度与评论条数数组长度一致

    // 轮播图
	var initSwiper = function() {
	    var bannerSwiper = new Swiper('#slider', {
	        autoplay: 5000, //可选选项，自动滑动
	        slidesPerView: 'auto',
	        // centeredSlides: true,
	        pagination: '.swiper-pagination',
	        effect : 'flip',
	        // loop: true,
	        flip: {
                slideShadows : false
            },
	        prevButton:'.swiper-button-prev',
			nextButton:'.swiper-button-next'
      	});
    }
   /* var initCommentSlider = function() {
    	var mySwiper = new Swiper('.comment-box',{
	        autoplay: 3000, //可选选项，自动滑动
	        direction : 'vertical',
	        loop: true,
			slidesPerView : 3,
			slidesPerGroup : 1,
			autoplayDisableOnInteraction : false
		})
    }*/
    // 评论滚动
	function commentSlider(target) {
		var commentLiH = parseFloat(target.find('li:first').css('height'));

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

    // 播放视频
    function showVideo(dom_id, vid){
        player = new YKU.Player(dom_id, {
            // styleid: '0',
            client_id: '52b3fa57e9fe17cf',
            vid: vid, //优酷视频id
            show_related: false
            // newPlayer: true
        });
    }
    
    //	微信分享
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
	function share() {
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
    // 事件绑定
    function bindEvent() {
    	// 分享
    	$body.on('click', ".share-btn", function () {
    		share();
    	})

    	// 领红包规则
    	$quesWrapper.on('click', ".rule-btn", function () {
    		$("#rule_alert").show();
    	})
    	$body.on('click', "#rule_alert .confirm-btn", function () {
    		$("#rule_alert").hide();
    	})

    	// 提交答题
    	$quesWrapper.on('click', ".submit-btn", function () {
    		//未登录
    		if(!isLogin){
    			Util.popup({
		            "content": '<p class="alert-msg">请先登录团贷网哦！</p>',
		            "btns": [{
		                "txt": "登 录",
		                "cb": function() {
		                	//ToDo: 登录回调
		                }
		            }]
		        })
		        return;
    		}
    		//没选择选项
    		Util.popup({
		        "content": '<p class="alert-msg">题目选项不能为空</p>',
		        "btns": [{
		            "txt": "知道了"
		        }]
		    })
    		// 答题机会用完
        	if(!quesChance){
        		if(isShare){
        			// 分享过
        			Util.popup({
	    		        "content": '<p class="alert-msg">您的答题机会已用完！</p>',
	    		        "btns": [{
	    		            "txt": "知道了"
	    		        }]
	    		    })
        		}else{
        			// 未分享过
	    			Util.popup({
	    		        "content": '<p class="alert-msg">分享页面可再获得1次答题机会！</p>',
	    		        "btns": [{
	    		            "txt": "分享",
	    		            "cb": function() {
	    		            	share();
	    		            }
	    		        }, {
	    		            "txt": "不分享"
	    		        }]
	    		    })
        		}
        		return;
        	}
	        quesChance--;
    		// 答对了
    		if(allRight){
    			Util.popup({
		            "content": '<p class="alert-msg">恭喜您！全答对了！</p>',
		            "btns": [{
		                "txt": "去抽奖",
		                "cb": function() {
		                	//ToDo: 抽奖回调
		                	// 中奖
		                	/*Util.popup({
		                		"conClassName": 'prize',
					            "content": '<p class="alert-msg">恭喜您！成功拿下******！</p>',
					            "btns": [{
					                "txt": "分享",
					                "cb": function() {
					                	//ToDo: 分享回调
					                	share();
					                }
					            },{
					                "txt": "不分享"
					            }]
					        })*/
		                	// 没中奖
					        if(isShare){
	        					//分享过
	        					Util.popup({
	        	            		"conClassName": 'super',
	        			            "content": '<p class="alert-msg">虽然您没有拿下奖品，<br />但您答对了全部题目是小π最佩服的学霸！</p>',
	        			            "btns": [{
	        			                "txt": "知道了"
	        			            }]
	        			        })
					        }else{
					        	// 没分享过
			                	Util.popup({
			                		"conClassName": 'no-prize',
						            "content": '<p class="alert-msg">手气欠佳，<br />分享页面可再获得1次答题抽奖机会！</p>',
						            "btns": [{
						                "txt": "分享",
						                "cb": function() {
						                	//ToDo: 分享回调
						                	share();
						                }
						            },{
						                "txt": "不分享"
						            }]
						        })
					        }
		                }
		            }]
		        })

    		}else{
    			// 答错了
    			if(isShare){
    				// 分享过
					Util.popup({
	            		"conClassName": 'cry',
			            "content": '<p class="alert-msg">很遗憾~您答错了第X题，<br />下次要认真点哟！</p>',
			            "btns": [{
			                "txt": "知道了"
			            }]
			        })
    			}else{
    				// 没分享过
	    			Util.popup({
	            		"conClassName": 'cry',
			            "content": '<p class="alert-msg">很遗憾~您答错了第X题，<br />分享页面可再获得1次答题抽奖机会！</p>',
			            "btns": [{
			                "txt": "分享",
			                "cb": function() {
			                	//ToDo: 分享回调
			                	share();
			                }
			            },{
			                "txt": "不分享"
			            }]
			        })
    			}
    		}
    	})

    	// 点赞
    	$commentWrapper.on('click', '.comment-like i', function () {
    		var $this = $(this),
    			index = +$this.attr('data-index');
    		// liked[index] = false; //获取是否点过赞
    		console.log(!like[index]);
    		if(!like[index]){
	    		var	$likeNum = $this.next(),
	    			likeNum = $likeNum.html();
	    		$this.addClass('act');
	    		$likeNum.html(+likeNum+1);
	    		like[index] = true;
    		}
    	})

    	// 输入评论
    	$commentWrapper.on('focus', '.comment-input', function () {
   //  		if(Util.isAndroid() && Util.isApp()){
			// 	$('.content').css('transform', 'translateY(-8rem)');
			// }
    		//未登录
    		if(!isLogin){
    			/*Util.popup({
		            "content": '<p class="alert-msg">请先登录团贷网哦！</p>',
		            "btns": [{
		                "txt": "登 录",
		                "cb": function() {
		                	//ToDo: 登录回调
		                }
		            }]
		        })
		        return;*/
    		}
    	})
    	$commentWrapper.on('blur', 'comment-input', function (e) {
			// if(Util.isAndroid() && Util.isApp()){
			// 	$('.content').css('transform', 'translateY(0)');
			// }
		})
    	// 输入评论限制
    	$commentWrapper.on('input', '.comment-input', function () {
    		var $this = $commentInput,
    		 	commentNum = $this.val().length,
    		 	$commentLeftNum = $("#comment_left_num"),
    		 	limitNum = 40,
    		 	leftNum = parseInt(limitNum - commentNum);
			
			if(leftNum > 0 ){
				$commentLeftNum.html(leftNum);
			}else{
				$commentLeftNum.html('0');
				$this.val($this.val().substring(0, limitNum));
			}
    	})

    	// 提交问题
    	$commentWrapper.on('click', '.submit-btn', function () {
    		var comment = $commentInput.val();
    		console.log(comment);
    		console.log(!commentChance);
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
    		commentChance--;
    	})
    }

    function init() {
    	// 视频初始化
    	showVideo("video_box", 'XMzE1NjM0NjMyOA==');
    	initSwiper();
    	commentSlider($commentList);
    	// initCommentSlider();
    	bindEvent();
    }
    init();
})();