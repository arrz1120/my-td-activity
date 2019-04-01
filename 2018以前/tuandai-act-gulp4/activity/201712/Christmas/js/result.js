(function() {
	FastClick.attach(document.body);
	//do your thing.
	
	//定义第一题为正确答案
	var correct = 0;

	var mySwiper = new Swiper('.swiper-container', {
		direction: 'vertical',
		freeMode: true,
		freeModeSticky: true,
		slidesPerView: 'auto',
		// 如果需要滚动条
		scrollbar: '.swiper-scrollbar',
		scrollbarHide: false,
	})

	//选择答案
	var li = $(".timu-txt").find('li');
	li.each(function(i, item) {
		$(item).click(function() {
			li.unbind();
			$(this).addClass('selected');
			if(i == correct) {
				$(".correct").show();
			} else {
				$(".wrong").show();
			}
			$("#normal").hide();
			$("#tb18,.daozhang").show();
		})
	})

})();