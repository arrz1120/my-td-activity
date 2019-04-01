$(function() {
	//攻略弹窗标签显示隐藏切换
	function lableTab() {
		$(".gl_tit").each(function(i, item) {
			$(item).click(function() {
				var gl_lableBox = $(this).next();
				var arrow = $(this).find('i');
				if(gl_lableBox.css('display') == 'none') {
					arrow.css('-webkit-transform', 'rotateZ(-90deg)');
					gl_lableBox.slideDown(300);
				} else {
					arrow.css('-webkit-transform', 'rotateZ(90deg)');
					gl_lableBox.slideUp(300);
				}
			})
		})
	}

	//攻略弹窗
	function dealAlert() {
		var bigDiv = $('#bigDiv');
		var glAlert = $('#glAlert');
		var callUsAlert = $('#callUsAlert');
		var scrollT = 0;
		$(".top_a2 ").click(function() {
			glAlert.removeClass('moveToRight').removeClass('hide').addClass('moveToLeft');
			setTimeout(function() {
				bigDiv.addClass('hide');
			}, 300);
		});
		$(".alertClose1").click(function() {
			bigDiv.removeClass('hide');
			glAlert.removeClass('moveToLeft').addClass('moveToRight');
			setTimeout(function() {
				glAlert.addClass('hide');
			}, 300);
		})
		$("#callUs").click(function() {
			scrollT = $(window).scrollTop();
			callUsAlert.removeClass('moveToBottom').removeClass('hide').addClass('moveToTop');
			setTimeout(function() {
				bigDiv.addClass('hide');
			}, 300);
		});
		$(".ico_close2").click(function() {
			bigDiv.removeClass('hide');
			$(window).scrollTop(scrollT);
			callUsAlert.removeClass('moveToTop').addClass('moveToBottom');
			setTimeout(function() {
				callUsAlert.addClass('hide');
			}, 300);
		})
	}
	dealAlert();
	lableTab();
})