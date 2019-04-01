(function() {
	FastClick.attach(document.body);
	//do your thing.

	var cmmentScroller = new CommentScroller('#award-list', {
		showSlides: 1, //显示的条数
		autoplay: true, //autoplay:true 开启滚动
		delay: 3000, //轮播间隔时间
	})

	var nameScroller = new CommentScroller('#name-list', {
		showSlides: 4, //显示的条数
		autoplay: true, //autoplay:true 开启滚动
		delay: 3000 //轮播间隔时间
	})

	var mySwiper = new Swiper('#investSwiper', {
		nextButton: '.next',
		prevButton: '.prev',
		autoplayDisableOnInteraction: false,
		//		autoplay: 3000,
		loop: true
	})

	function initTxtSwiper() {
		var txtSwiper = new Swiper('#txtSwiper', {
			autoplay: true,
			noSwiping: true,
			loop: true,
			freeMode: true,
			speed: 8000,
			slidesPerView: 'auto'
		})
	}

	var timer;

	function eggMove() {
		var toSmall = 0.74;
		var toBig = 1.35;
		var egg1 = $("#egg1");
		var egg2 = $("#egg2");
		var egg3 = $("#egg3");
		var num = 0;
		timer = setInterval(function() {
			num++;
			console.log(num);
			switch(num) {
				case 1:
					egg1.removeClass().addClass('egg egg2 z12');
					egg2.removeClass().addClass('egg egg3 z11');
					egg3.removeClass().addClass('egg egg1 z10');

					break;
				case 2:
					egg1.removeClass().addClass('egg egg3 z11');
					egg2.removeClass().addClass('egg egg1 z10');
					egg3.removeClass().addClass('egg egg2 z12');
					break;
				case 3:
					egg1.removeClass().addClass('egg egg1 z10');
					egg2.removeClass().addClass('egg egg2 z12');
					egg3.removeClass().addClass('egg egg3 z11');
					break;
				default:
					break;
			}
			if(num == 3) {
				num = 0;
			}
		}, 2000)
	}
	eggMove();

	var letCount = 3;
	//砸蛋
	$(".normal").each(function(i, item) {
		$(item).click(function() {
			$(item).unbind();
			clearInterval(timer);
			//console.log($(item).parent().attr('class'));
			$(".chui").hide().removeClass('move_chui');
			$(item).parent().find('.chui').show().addClass('move_chui');
			setTimeout(function() {
				$(item).removeClass('egg_move').addClass('move_egg_click');
			}, 850);
			setTimeout(function() {
				//显示砸蛋后的结果
				$(".chui").fadeOut(200);
				$(item).hide();
				var txt = $('#txtSwiper').find('.swiper-slide');
				if(letCount == 3) {
					$(item).next().fadeIn(200);
					txt.html('<span>800元京东卡</span>');
					//initTxtSwiper();
					$('#show800').show();
				} else if(letCount == 2) {
					$(item).next().next().fadeIn(200);
					txt.html('<span>800元京东卡</span><span>518元红包+2888元理财金</span>');
					initTxtSwiper();
					$('#show518').show();
				} else {
					$(item).next().next().next().fadeIn(200);
					$('#show0').show();
					$('#btn-gray').addClass('btn-gray').unbind();
				}
				letCount--;
				$('#leftCount').text(letCount);
			}, 1600);
		})
	})

	//设置年回报率可选利率
	//	$(".rate").each(function(i, item) {
	//		$("#select").append('<option value="">' + $(item).text() + '</option>');
	//	})

	//投资金额输入框，限制只能输入数字
	$(".input").on('input', function() {
		var val = $(this).val().replace(/\D/g, '');
		$(this).val(val);
	})

	function clearNoNum(value) {
		value = value.replace(/[^\d.]/g, ""); //清除“数字”和“.”以外的字符
		value = value.replace(/^\./g, ""); //验证第一个字符是数字而不是.
		value = value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.
		value = value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
		return value;
	}

	$("#rate").on('input', function() {
		var val = clearNoNum($(this).val());
		$(this).val(val);
	})

	//月份选择
	$(".month").click(function() {
		$(".month-selected").removeClass("month-selected");
		$(this).addClass("month-selected");
	})

	$(".close").on('click', function(e) {
		$(this).parent().parent().hide();
	})

	$("#telInp").on('input', function() {
		if($(this).val().length == 11) {
			$("#inpTab").show();
		}
	})

	//计算
	var rate = 0;
	$(".calculate").click(function() {
		var time = $(".month-selected").attr('month') / 12;
		if($('#select').css('display') != 'none') {
			rate = parseFloat($("#rate").val());
		}
		if(!isNaN(time)) {
			var money = parseInt($("#investMoney").val());
			if(rate == 0) {
				var onlyIncome = 0;
				var allIncome = money;
			} else {
				var onlyIncome = parseInt(money * rate * time / 100);
				var allIncome = parseInt(money + onlyIncome);
				console.log(money + onlyIncome);
			}
			$(".onlyIncome").html(onlyIncome);
			$(".allIncome").html(allIncome);
			$("#result").show();
		}
	})

	//马上砸蛋
	$(".bot-btn,.egg_bot").click(function() {
		$("body").animate({
			'scrollTop': 0
		}, 800);
	})

	var sT = $(".txt-rect").offset().top - 10;
	$(window).on('scroll touchmove', function() {
		if($("#inputBox").css('display') == 'none') {
			if($('body').scrollTop() > sT) {
				$(".bot_float").addClass('bot_fixed');
				$(".index").addClass('isFixed');
			} else {
				$(".bot_float").removeClass('bot_fixed');
				$(".index").removeClass('isFixed');
			}
		}
	})

	$(".alert").on('touchmove', function(e) {
		e.preventDefault();
	})

	//	alert($(window).height())

	//	$('#txtSwiper').find('.swiper-slide').html('<span>800元京东卡</span><span>518元红包+2888元理财金</span>');
	//	initTxtSwiper();

	function hideInput() {
		$("#inputBox").hide();
		$("#eggWrap").show();
		$(".bot_float").show();
		$(".index").addClass('isFixed');
		$('footer').removeClass('mt0');
	}

	function showInput() {
		$("#inputBox").show();
		$("#eggWrap").hide();
		$(".bot_float").hide();
		$(".index").removeClass('isFixed');
		$('footer').addClass('mt0');
	}

	//回到上一页
	$("#return").click(function() {
		hideInput();
		initTxtSwiper();
	})

	$('.rect-r').click(function() {
		showInput();
	})
	$('.toRegister').click(function() {
		showInput();
		$("body").scrollTop(0);
	})

	function isAndroidPlatform() {
		if(navigator.userAgent.match(/(Android)/)) {
			return true;
		} else {
			return false;
		}
	}

	$('input').on('focus', function(e) {
		if(isAndroidPlatform()) {
			$('.maskInp').css('transform', 'translateY(-5rem)');
		}
	})

	$('input').on('blur', function(e) {
		if(isAndroidPlatform()) {
			$('.maskInp').css('transform', 'translateY(0)');
		}
	})

	$(".agree").click(function (e) {
		var i = $(this).find('span');
		if (e.target.nodeName != 'A') {
			if (i.hasClass('checked')) {
				i.removeClass('checked');
			} else {
				i.addClass('checked');
			}
		}
	})
})();