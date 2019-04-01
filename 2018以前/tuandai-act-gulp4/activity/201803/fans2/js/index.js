(function() {
	FastClick.attach(document.body);
	//do your thing.

	var isLogin = false;
	var isHbOpen = false;

	function pageInit() {
		//预先请求某些图片资源
		[
			'../images/rule-bg.png',
			'../images/close.png',
			'../images/code.png',
			'../images/end-bg.png',
			'../images/gift-bg.png',
			'../images/rule-bg.png',
			'../images/img-none.png',
			'../images/light.png',
			'../images/bar-bg.png'
		].forEach(function(item) {
			var img = new Image();
			img.src = item;
		});
		var cmmentScroller = new CommentScroller('#name-list', {
			showSlides: 1,
			autoplay: true,
			delay: 3000
		})
	}

	//翻牌
	function init() {
		$(".item-gift").addClass('rotate180');
		$(".item-hb").addClass('rotateY0');
		setTimeout(function() {
			cardMove();
		}, 601);
	}

	//洗牌
	function cardMove() {
		var aPos = [];
		var count = 0;
		$(".item-hb").each(function(i, item) {
			aPos.push({
				'left': $(item).offset().left,
				'top': $(item).offset().top
			})
		})

		var boxLeft = $(".card-box").offset().left;
		var boxTop = $(".card-box").offset().top;

		$(".item-hb").each(function(i, item) {
			$(item).css({
				'position': 'absolute',
				'left': aPos[i].left - boxLeft + 'px',
				'top': aPos[i].top - boxTop + 'px'

			})
		})

		var count = 0;
		var timer = setInterval(function() {
			count++;
			if(count == 11) {
				clearInterval(timer);
				$(".item-hb").css({
					'-webkit-transition': 'all linear 0.5s'
				})
				$(".item-hb").attr('style', "");
				// showFinger();
				lottery();
			} else {
				aPos.sort(function() {
					return Math.random() - 0.5;
				});

				$(".item-hb").each(function(i, item) {
					$(item).css({
						'-webkit-transition': 'all linear 0.15s',
						'transition': 'all linear 0.15s',
						'left': aPos[i].left - boxLeft + 'px',
						'top': aPos[i].top - boxTop + 'px'

					})
				})
			}
		}, 160);

	}

	// function showFinger() {
	// 	$(".fingerBox").fadeIn(500);
	// 	setTimeout(function() {
	// 		$(".fingerBox").fadeOut(500);
	// 	}, 5000);
	// }

	function showLoading() {
		$("#loading").show();
	}

	function hideLoading() {
		$("#loading").hide();
	}

	//抽奖事件绑定
	function lottery() {
		$("body").on("click", ".item-hb", function(e) {
			if(isHbOpen) return;
			isHbOpen = true;
			showLoading();
			var $target = $(e.currentTarget);
				award = 1,
				src = '../images/' + award + '.png',
				i = $target.attr('data-index'),
				itemGift = $(".item-gift").eq(i);
			itemGift.html("<img src=" + src +" />");
			$target.removeClass('rotateY0');
			itemGift.addClass('rotateY0');
			setTimeout(function() {
				hideLoading();
			}, 700)
		})
	}

	function initRuleSwiper() {
		var ruleSwiper = new Swiper('#ruleSwiper', {
			direction: 'vertical',
			freeMode: true,
			freeModeSticky: true,
			slidesPerView: 'auto',
			scrollbar: '.swiper-scrollbar'
		})
	}

	//弹窗交互
	function alertFn() {
		$(".close").on('click', function() {
			$(this).parent().parent().hide();
		})
		$(".alert-bg").on('click', function() {
			$(this).parent().hide();
		})
		$(".alert-bg,.end-con,.gift-con,.nomove").on('touchmove', function(e) {
			e.preventDefault();
		})
		$(".ruleBtn").on('click', function() {
			$("#ruleAlert").show();
			initRuleSwiper();
		})
		$(".ub-r").click(function() {
			$("#recordAlert").show();
		})
	}

	pageInit();

	window.onload = function() {
		alertFn();
		setTimeout(function() {
			if(isLogin) {
				$(".lotteryBtn").hide();
				$(".userBox").show();
				init();
			} else {
				$(".lotteryBtn").on('click', function() {
					location.href = "login.html";
				})
			}
		}, 1000);
	}

})();