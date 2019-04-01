(function() {
	FastClick.attach(document.body);

	// var lottery = new LotteryWheel('#rotate', {
	// 	duration: 5000,
	// 	items: [{
	// 		key: 0,
	// 		percent: .125
	// 	}, {
	// 		key: 1,
	// 		percent: .125
	// 	}, {
	// 		key: 2,
	// 		percent: .125
	// 	}, {
	// 		key: 3,
	// 		percent: .125
	// 	}, {
	// 		key: 4,
	// 		percent: .125
	// 	}, {
	// 		key: 5,
	// 		percent: .125
	// 	},
	// 	 {
	// 		key:6,
	// 		percent: .125
	// 	}, {
	// 		key:7,
	// 		percent: .125
	// 	}, ]
	// });



	var bRotate = false;

	var rotateFn = function(awards, callB) {
		bRotate = !bRotate;

		var stepDeg = 360 / 8;
		var allDeg = 720 - awards * stepDeg + stepDeg / 2;

		$('#rotate').stopRotate();
		$('#rotate').rotate({
			angle: 0,
			animateTo: allDeg,
			duration: 5000,
			callback: function() {
				callB();
			}
		});
	};



	/*

	0： ihphone   256G

	1： 5元投资红包

	2： 68元投资红包

	3： 88元投资红包

	4： 爱奇艺vip

	5： 3元现金红包

	6： 电饭煲

	7： 200团币

	*/



	$('.lotteryBtn').click(function() {

		if (bRotate) return;
		var item = 2;

		switch (item) {
			case 1:
				rotateFn(1, function() {
					alert(1);
				});
				break;
			case 2:
				rotateFn(2, function() {
					alert('5元投资红包');
				});
				break;
			case 3:
				rotateFn(3, function() {
					alert('68元投资红包');
				});
				break;
			case 4:
				rotateFn(4, function() {
					alert('88元投资红包');
				});
				break;
			case 5:
				rotateFn(5, function() {
					alert('爱奇艺vip');
				});
				break;
			case 6:
				rotateFn(6, function() {
					alert('3元现金红包');
				});
				break;
			case 7:
				rotateFn(7, function() {
					alert('电饭煲');
				});
				break;
			case 8:
				rotateFn(8, function() {
					alert('200团币');
				});
				break;
			default:
				break;
		}

		console.log(item);
	});

	function rnd(n, m) {
		return Math.floor(Math.random() * (m - n + 1) + n)
	}



	//奖品轮播；


	//名单滚动

	jQuery(".txtMarquee-left").slide({
		mainCell: ".bd ul",
		autoPlay: true,
		effect: "leftMarquee",
		vis: 2,
		interTime: 50
	});



	$(".alert-close").click(function() {
		$(this).parent().parent().hide();

		if($(this).hasClass('prize-close')){
			//打开抽奖开关
		}
	})


	//规则弹窗

	$(".ruleBtn").click(function() {
		$('#ruleAlert').show();
	})

	$("#rule-ok").click(function() {
		$('#ruleAlert').hide();
	})


	//tab切换

	$(".tab-left").click(function() {
		$('.fqr').css('opacity', 1);
		$('.tzr').css('opacity', 0);
	})

	$(".tab-right").click(function() {
		$('.fqr').css('opacity', 0);
		$('.tzr').css('opacity', 1);
	})


	$('.alert-bg').on('touchmove', function(e) {
		e.preventDefault();
	})


	$('.rule-con').on('touchmove', function(e) {
		e.stopPropagation();
	});



	var isAnd = /android|adr/gi.test(navigator.userAgent);

	if (isAnd) {
		$('.ruleTxt').addClass('ruleTxt_and');
	}



	$('.shareBtn').on('click', function() {
		appShare.set({
			icon: '',
			title: '标题',
			content: '内容',
			shareUrl: 'tdw.cn',
			cover: {
				src: '../images/wxAlert.png',
				style: {
					width: '100%',
				}
			},
			custom: [{
				key: 5,
				val: "朋友圈",
				title: 'xxx'
			}],
			callback: function() {}
		})
	});



	$('#test').on('click',function(){
		alert(1)
	})
})();