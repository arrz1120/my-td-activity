(function() {
	FastClick.attach(document.body);
	//do your thing.

	$("#talkList").on('click touchmove', function() {
		//		$('#inp').blur();
	})

	$('#inp').focus(function() {

	})

	function buildAnswer(param) {
		var answer =
			'<li class="answer">' +
			'<div class="time">' + param.time + '</div>' +
			'<img class="header-answer" src="' + param.headImg + '" />' +
			'<div class="name">' + param.name + '</div>' +
			'<div class="text">' +
			'<div class="triangle-topright"></div>' +
			'<p>' + param.text + '</p>' +
			'</div>' +
			'</li>';
		$("#talkList").find('ul').append(answer);
	}

	function buildAsk(param) {
		var answer =
			'<li class="ask">' +
			'<div class="time">' + param.time + '</div>' +
			'<img class="header-ask" src="' + param.headImg + '" />' +
			'<div class="text">' +
			'<div class="triangle-topleft"></div>' +
			'<p>' + param.text + '</p>' +
			'</div>' +
			'</li>';
		$("#talkList").find('ul').append(answer);
		$(window).scrollTop(100000000);
	}

	buildAnswer({
		time: '13:42',
		headImg: '../images/online/header-answer.png',
		name: '注册理财师-Kevin',
		text: '你好，我是理财师Kevin，请问有什么可以为您解答？'
	})

	//发送
	$("#send").on('click', function() {
		var val = $("#inp").val();
		if(val != '') {
			$("#inp").val('');
			buildAsk({
				time: '13:42',
				headImg: '../images/online/header-ask.png',
				text: val
			})
			$(window).scrollTop(100000000);
		} else {

		}
	})

})();