(function() {
	FastClick.attach(document.body);
	//do your thing.





	var tab = $('#tab'),
		nav_span = tab.find('nav span'),
		ruleHeight,
		nav_1_top,
		nav_2_top,
		nav_3_top;


	var tab = $('#tab'),
		nav_span = tab.find('nav span');


	function setNavStyle(wrapperTransNum) {

		// console.log(wrapperTransNum)

		nav_span.removeClass('cur');

		if (wrapperTransNum > nav_1_top) {
			nav_span.eq(0).addClass('cur');
		}

		if (wrapperTransNum > nav_2_top && wrapperTransNum < nav_1_top) {
			nav_span.eq(1).addClass('cur');
		}

		if (wrapperTransNum > nav_3_top && wrapperTransNum < nav_2_top) {
			nav_span.eq(2).addClass('cur');
		}


		if (wrapperTransNum < nav_3_top) {
			nav_span.eq(3).addClass('cur');
		}
	}



	//规则弹窗


	var alert_rule = $('#alert_rule');

	$('.rule').on('click', function() {
		alert_rule.addClass('comp-alert-rule-show');
	});



	if (alert_rule.length) {


		var tabDom1=$('#tab_tit_1')[0],
		    tabDom2=$('#tab_tit_2')[0],
		    tabDom3=$('#tab_tit_3')[0],
		    tabDom4=$('#tab_tit_4')[0];


		alert_rule.find('.mark').on('touchmove', function(e) {
			e.preventDefault();
		})



		alert_rule.find('.close').on('click', function() {

			alert_rule.removeClass('comp-alert-rule-show');
		});


		alert_rule.find('.mark').on('click', function() {
			alert_rule.removeClass('comp-alert-rule-show');
		})

		var containerTop = $('#swiper-container-rule')[0].getBoundingClientRect().top;
		// console.log(containerTop)
		nav_span.on('click', function() {
			var tab1 = tabDom1.getBoundingClientRect().top;
			var tab2 =tabDom2.getBoundingClientRect().top;
			var tab3 = tabDom3.getBoundingClientRect().top;
			var tab4 = tabDom4.getBoundingClientRect().top;
			var keyVal = {
				0: tab1,
				1: tab2,
				2: tab3,
				3: tab4
			}
			var curTab = keyVal[$(this).index()];
			$(this).siblings('.cur').removeClass('cur');
			$(this).addClass('cur');

			var pos = curTab - containerTop;


			swiper_rule.setWrapperTranslate(swiper_rule.getWrapperTranslate() - pos);

		});

		var swiper_rule = new Swiper('#swiper-container-rule', {
			// scrollbar: '.swiper-scrollbar',
			direction: 'vertical',
			slidesPerView: 'auto',
			mousewheelControl: true,
			freeMode: true,
			onTouchMove: function(swiper) {
				//var wrapperTranslate = swiper_rule.getWrapperTranslate();
				//setNavStyle(wrapperTranslate);

				// console.log(wrapperTranslate);
				var distance1 = tabDom1.getBoundingClientRect().top-containerTop-100;
				var distance2 =tabDom2.getBoundingClientRect().top-containerTop-20;
				var distance3 = tabDom3.getBoundingClientRect().top-containerTop-20;
				var distance4 = tabDom4.getBoundingClientRect().top-containerTop-20;
				console.log(distance1,distance2,distance3,distance4)
				nav_span.removeClass('cur');
				if(distance4<=0){
					nav_span.eq(3).addClass('cur');
					return;
				}
				if(distance3<=0){
					nav_span.eq(2).addClass('cur');
					return;
				}
				if(distance2<=0){
					nav_span.eq(1).addClass('cur');
					return;
				}
				if(distance1<=0){
					nav_span.eq(0).addClass('cur');
					return;
				}
				
			},
			onTransitionEnd: function(swiper) {
				// var wrapperTranslate = swiper_rule.getWrapperTranslate();
				// setNavStyle(wrapperTranslate);
				var distance1 = tabDom1.getBoundingClientRect().top-containerTop-100;
				var distance2 =tabDom2.getBoundingClientRect().top-containerTop-20;
				var distance3 = tabDom3.getBoundingClientRect().top-containerTop-20;
				var distance4 = tabDom4.getBoundingClientRect().top-containerTop-20;
				console.log(distance1,distance2,distance3,distance4)
				nav_span.removeClass('cur');
				if(distance4<=0){
					nav_span.eq(3).addClass('cur');
					return;
				}
				if(distance3<=0){
					nav_span.eq(2).addClass('cur');
					return;
				}
				if(distance2<=0){
					nav_span.eq(1).addClass('cur');
					return;
				}
				if(distance1<=0){
					nav_span.eq(0).addClass('cur');
					return;
				}
				
				
				



				// console.log(tab2)

			},
			onInit: function() {
				ruleHeight = $('#swiper-container-rule .swiper-slide-active').height();
				// console.log(ruleHeight);
				nav_1_top = -ruleHeight * 0.24;
				nav_2_top = -ruleHeight * 0.66;
				nav_3_top = -ruleHeight * 0.87;
			}

		});


	}


	//宽屏幕手机适配


	var win_width = $(window).width(),
		win_height = $(window).height();

	var rate = win_width / win_height;
	if (win_width / win_height > 0.68) {
		$('body').addClass('adjust');
	}

	//分享按钮

	if ($('.comp-share-btn').length) {
		$('.comp-share-btn').on('click', function() {
			appShare.set({
				icon: '',
				title: '',
				content: '',
				shareUrl: '',
				cover: {
					src: '../images/common/share.png',
					style: {
						width: '100%',
					}
				},
				custom: []
			})
		});
	}



})();