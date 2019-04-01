(function() {
	FastClick.attach(document.body);
	//do your thing.

	// var rotateTimeOut = function() {
	// 	$('#rotate').rotate({
	// 		angle: 0,
	// 		animateTo: 2160,
	// 		duration: 5000,
	// 		callback: function() {
	// 			alert('网络超时，请检查您的网络设置！');
	// 		}
	// 	});
	// };
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




	$('.lotteryBtn').click(function() {

		if(bRotate) return;
		var item = 1;

		switch(item) {
			case 1:
				rotateFn(1,  function(){
						alert('nihao');
				});
				break;
			case 2:
				rotateFn(2, 45, '168团币');
				break;
			case 3:
				rotateFn(3, 90, '88元投资红包');
				break;
			case 4:
				rotateFn(4, 135, '3元现金红包');
				break;
			case 5:
				rotateFn(5, 180, '60团币');
				break;
			case 6:
				rotateFn(6, 225, '0.5%加息券');
				break;
			case 7:
				rotateFn(7, 270, '5元投资红包');
				break;
			case 8:
				rotateFn(8, 315, '1%加息券');
				break;
			default:
				break;
		}

		console.log(item);
	});

	function rnd(n, m) {
		return Math.floor(Math.random() * (m - n + 1) + n)
	}
	
	$(".alert-close").click(function() {
		$(this).parent().parent().hide();
	})
	
	$(".ruleBtn").click(function() {
		$('#ruleAlert').show();
	})
	
	$("#rule-ok").click(function() {
		$('#ruleAlert').hide();
	})
	
	$(".tab-left").click(function() {
		$('.fqr').css('opacity',1);
		$('.tzr').css('opacity',0);
	})
	
	$(".tab-right").click(function() {
		$('.fqr').css('opacity',0);
		$('.tzr').css('opacity',1);
	})
})();