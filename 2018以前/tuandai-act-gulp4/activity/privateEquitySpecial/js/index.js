(function() {
    FastClick.attach(document.body);
	var $body = $('body'),
		docH = $(document).height(),
		$infoDescP = $('.info-desc').find('p'),
		$swiperSlideWrapper = $('#swiper_slide_wrapper'),
		swiperSlideWrapperH = $('#swiper_slide_wrapper').height(),
		$swiperSlideCon = $swiperSlideWrapper.find('.swiper-slide-con'),
		$swiperSlideTxtCon = $swiperSlideWrapper.find('.swiper-slide-txt-con'),
		$swiperSlideTxt = $swiperSlideWrapper.find('.swiper-slide-txt'),
		$page4SwitchCon = $('#page4_switch_con'),
		$page4SwitchConCurIcon = $page4SwitchCon.find('i').eq(0),
		$page4SwitchConCurTxt = $page4SwitchCon.find('.page4-switch-txt'),
		$moreBtnTxt = $swiperSlideWrapper.find('.more-txt'),
		inputNameVal = '',
		inputTelVal = '',
		isAndroid = navigator.userAgent.indexOf('Android') > -1 || navigator.userAgent.indexOf('Adr') > -1; //android终端;
	// 页面滑动
	var initPageSwiper = function() {
	    var bannerSwiper = new Swiper('#page-swiper-container', {
	        // autoplay: 3000, //可选选项，自动滑动
	        direction : 'vertical',
	  //       effect : 'fade',
	  //       fade: {
			//   crossFade: true,
			// },
	        spaceBeteewn: 0,
	        // centeredSlides: true,
	        // pagination: '.swiper-pagination',
	        // loop: true
	          /*,
	                  onInit: function(swiper) {

	                  },
	                  onSlideChangeStart: function(swiper) {


	                  },*/
	        onSlideChangeEnd: function(swiper) {
	        	if(swiper.activeIndex === swiper.slides.length - 1){
	        		$("#page-arrow").hide()
	        	}else{
	        		$("#page-arrow").show()
	        	}
	        }

      	});
    }
    // 页面内轮播图
	var initPageInnerSwiper = function() {
	    var bannerSwiper = new Swiper('#page-inner-swiper', {
	        // autoplay: 3000, //可选选项，自动滑动
	        effect : 'coverflow',
	        coverflow: {
	            rotate: 0,
	            stretch: 10,
	            depth: 60,
	            modifier: 2,
	            slideShadows : true
	        },
	        slidesPerView: 'auto',
	        spaceBetween: -30,
	        // centeredSlides: true,
	        pagination: '.swiper-pagination',
	        loop: true
      	});
    }
    // 马上预约回调(在线预约咨询弹窗)
    function order() {
		Util.popup({
			"type": 2, //1--电话呼叫弹窗, 2--自定义弹窗
	        "content": '<div class="input-con">' + 
							'<span class="input-name">姓名</span>' +
							'<input id="inputName" type="text" maxlength="30" name="" placeholder="请输入" >' +
						'</div>' +
						'<div class="input-con">' +
							'<span class="input-name">手机</span>' +
							'<input id="inputTel" type="tel" maxlength="11" name="" placeholder="请输入" >' +
						'</div>' +
						'<p class="order-txt">预约后理财顾问将在20分钟内给您回电，为您提供一对一理财咨询服务。</p>',
	        "btns": [{
	            "txt": "取消",
	            "className": "cancel-btn",
	            "cb": function() {}
	        }, {
	            "txt": "提交",
	            "className": "confirm-btn",
	            "cb": function() {
	            	var reg = /^1[3|4|5|7|8]\d{9}$/;
	            	
	            	if(!inputNameVal) {
	            		Util.toast('请填写姓名');
						return;
	            	}else if(!inputTelVal || !reg.test(inputTelVal)){
	            		Util.toast('手机号码不能为空或格式错误');
						return;
	            	}
	            	// 预约成功弹窗
            		Util.popup({
            			"type": 2, //1--电话呼叫弹窗, 2--自定义弹窗
            	        "content": '<i class="icon-order-success"></i>' + 
										'<p class="order-txt center">预约成功<br/>我们将在20分钟内给您回电，来电号码为 <br/><em>0769-23602330</em></p>',
            	        "btns": [{
            	            "txt": "确定",
            	            "className": "confirm-btn one",
            	            "cb": function() {
            	            	return 1;
            	            }
            	        }]
            		});
            		return 1;
	            }
	        }]
		});
    }
	// 事件绑定
	function bindEvent() {
		// 第二页展开更多
		$('#more_btn').toggle(function() {
			/* Stuff to do every *odd* time the element is clicked */
			$swiperSlideTxt.css('-webkit-line-clamp','initial');
			$moreBtnTxt.html('收回');

			var swiperSlideConH = $swiperSlideCon.height(); // swiperSlide总高度
			// 文字部分可能有自适应样式transform
			var transform = $swiperSlideTxtCon.css('transform')==='none' ? '' : $swiperSlideTxtCon.css('transform');
			var transformY = transform ? -transform.split(',')[5].split(')')[0] : 0;

			// 文字展开swiperSlide滚到底部
			$swiperSlideWrapper.scrollTop(swiperSlideConH-swiperSlideWrapperH-transformY);
		}, function() {
			/* Stuff to do every *even* time the element is clicked */
			$swiperSlideTxt.css('-webkit-line-clamp','1');
			$moreBtnTxt.html('展开更多');
			$swiperSlideWrapper.scrollTop(0);
		});
		// 第四页点击切换
		$body.on('click', '#page4_switch_con i', function (e) {
			var $this = $(this);
			var index = $this.attr('data-index');
			if(index > 1){
				var thisIcon = $this.attr('class').split(' ')[1];
				var thisIconIndex = thisIcon.split('icon')[1];
				console.log(thisIcon);
				var currentIcon = $page4SwitchConCurIcon.eq(0).attr('class').split(' ')[1];
				console.log(currentIcon);
				$this.removeClass(thisIcon).addClass(currentIcon);
				$page4SwitchConCurIcon.removeClass(currentIcon).addClass(thisIcon);
				$page4SwitchConCurTxt.attr('src','../images/page4-switch-txt' + thisIconIndex + '.png')
			}
		})
		// 最后一页说明文字箭头
		$('#arrow_up').toggle(function() {
			/* Stuff to do every *odd* time the element is clicked */
			$this = $(this);
			$this.addClass('down');
			$infoDescP.css('-webkit-line-clamp','initial');
		}, function() {
			/* Stuff to do every *even* time the element is clicked */
			$this.removeClass('down');
			$infoDescP.css('-webkit-line-clamp','1');
		});
		// 马上预约
		$body.on('click', '#order_btn', function () {
			order();
		})
		// 底部按钮'马上预约'
		$body.on('click', '#order', function () {
			order();
		})
		// 热线电话
		$body.on('click', '#hotline', function () {
			Util.popup({
				'msg': '0769-26987956'
			});
		})
		// input事件
		$body.on('input', 'input', function (e) {
			var $inputName = $('#inputName'),
	    		$inputTel = $('#inputTel');
    		switch(e.target.id) {
    			case 'inputName':
    				inputNameVal = $inputName.val();
    				break;
    			case 'inputTel':
            		inputTelVal = $inputTel.val();
    				break;
    		}
		})
		
		$body.on('focus', 'input', function (e) {
			if(isAndroid){

				var $this = $(this);
				$this.parent().parent().css('top','30%')
			}
		})
		$body.on('blur', 'input', function (e) {
			if(isAndroid){
				var $this = $(this);
				$this.parent().parent().css('top','50%')
			}
		})
	}
	function init() {
        initPageSwiper();
        initPageInnerSwiper();
		bindEvent();
		// 认证弹窗
		Util.popup({
			"type": 2, //1--电话呼叫弹窗, 2--自定义弹窗
			"title": '',
			"alertConClassName": "identify-con",
	        "content": '<p class="desc">合规才能放心投资，开始投资前，请您进行</p>' +
					    	'<p class="tit">合格投资者身份认证</p>' + 
					    	'<p><span class="num">1</span>实名认证</p>' +
					    	'<p><span class="num">2</span>风险评测</p>',
	        "btns": [{
	            "txt": "",
	            "className": "cancel-btn",
	            "cb": function() {}
	        },{
	            "txt": "开始认证吧",
	            "className": "confirm-btn",
	            "cb": function() {
	            	//跳转到登录
                    Jsbridge.exec('scanTopicCallLogin');
	            	return 1;
	            }
	        }]
		});
	}
	init();
})();