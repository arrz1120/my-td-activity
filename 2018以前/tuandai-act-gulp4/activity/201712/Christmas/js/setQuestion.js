(function() {
	FastClick.attach(document.body);
	//do your thing.

	var answer = [
		[
			'炉火纯青，老司机', '一个字，大写的“稳”', '初出茅庐，有点飘 ', '不开车，节能环保'
		],
		[
			'努力工作', '彩票', '成为富一代的爹妈', '我也不知道'
		],
		[
			'顺其自然，跟团', '放荡不羁，自助游 ', '随心所欲，自驾游  ', '路在脚下，徒步'
		],
		[
			'幽默风趣乐天派', '有才文艺小清新 ', '霸道犀利有主见', '温暖居家靠得住'
		],
		[
			'煲剧打游戏，一宅到底', '出去嗨，聚会唱K泡吧约约约 ', '看书、学习充充电', '我爱工作，工作使我快乐'
		],
		[
			'无辣不欢，随身备有老干妈', '清淡饮食，拒绝自我“膨胀”', '酸甜苦辣咸，样样爱不释口', '很少有食物能满足我挑剔的味蕾'
		],
		[
			'健身房，享受肌肉撕裂的快感', '瑜伽，塑造完美形体', '跑步、游泳等有氧运动', '很少运动'
		],
		[
			'西装革履商务风', '宽松舒适运动风', '简约大方休闲风', '随意，开心就好'
		],
		[
			'海景房，面朝大海春暖花开', '郊区别墅，环境优美空气新鲜', '都市学位房，交通便利教育发达', '乡村庭院，欣赏庭前花开花落'
		]
	]

	function setAnswer(index) {
		$(".ans-list").find('p').each(function(i, item) {
			$(item).html(answer[index][i]);
		})
	}

	var mySwiper = new Swiper('.swiper-container', {
		direction: 'vertical',
		freeMode: true,
		freeModeSticky: true,
		slidesPerView: 'auto',
		// 如果需要滚动条
		scrollbar: '.swiper-scrollbar',
		scrollbarHide: false,
	})

	//选择题目
	$(".que-slide").each(function(i, item) {
		$(item).click(function() {
			var tit = $(this).html();
			setAnswer(i);
			$(".que-step").eq(1).addClass('step-cur');
			$(".ans-tit").find('p').html(tit);
			$(".que-con").eq(0).hide();
			$(".que-con").eq(1).show();
		})
	})
	
	function resetQuestion(){
		$(".ans-list").find('.selected').removeClass('selected');
		$(".step-cur").removeClass('step-cur');
		$(".que-step").eq(0).addClass('step-cur');
		$(".que-con").hide();
		$(".que-con").eq(0).show();
		$("#set_off").show();
		$("#set_confirm").hide();
	}

	//重选题目
	$(".ans-tit").find('span').click(function() {
//		$(".ans-list").find('.selected').removeClass('selected');
//		$(".que-step").eq(1).removeClass('step-cur');
//		$(".que-con").eq(1).hide();
//		$(".que-con").eq(0).show();
//		$("#set_off").show();
//		$("#set_confirm").hide();
		resetQuestion();
	})

	//设置答案
	$(".que-con").find('.ans-item').click(function() {
		$(".que-con").find('.selected').removeClass('selected');
		$(this).addClass('selected');
		$("#set_off").hide();
		$("#set_confirm").show();
	})

	//设置确定
	$("#set_confirm").click(function() {
		$(".que-con").eq(1).hide();
		$(".que-con").eq(2).show();
		$(".que-step").eq(2).addClass('step-cur');
	})
	
	// $(".que-step").eq(0).click(function() {
	// 	resetQuestion();
	// })
	
})();