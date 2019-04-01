(function () {
	FastClick.attach(document.body);
	//do your thing.


	var gameList = $('#game_list'),
		game = $('#game'),
		smp = gameList.find('.smp_img'),
		shaizi_icon = gameList.find('.shaizi_1'),
		arrow_start = gameList.find('.arrow_start'),
		sz_timer = 1200,
		start_game = $('#start_game');


	//小派移动

	var moveTimer;


	//初始化 判断小派 是否被遮挡

	if (gameList.find('.cur').attr('data-st') == 'smp') {
		smp.hide();
	}


	if (gameList.find('.cur').attr('data-st') == 'again') {
		shaizi_icon.hide();
	}



	function moveXp(step, direction) {
		var cur_step = 0;

		moveTimer = setInterval(function () {

			if (cur_step != step) {
				cur_step++;
				var curDom = gameList.find('.cur');

				if (direction != 'back') {
					var nextIndex = (parseInt($('.cur').index()) + 1) % 12;

				} else {
					var nextIndex = (parseInt($('.cur').index()) - 1) % 12;

				}

				curDom.removeClass('cur');

				gameList.find('li').eq(nextIndex).addClass('cur');


				//跳过神秘派或者是再摇一次的时候，要把格子上的icon（太大）去掉

				if (nextIndex == 6) {
					smp.hide();
				} else {
					smp.show();
				}


				if (nextIndex == 9) {
					shaizi_icon.hide();
				} else {
					shaizi_icon.show();
				}


			} else {
				clearInterval(moveTimer);

				moveOver();
			}

		}, 700);
	}



	//行走结束,处理当前节点状态

	function moveOver() {

		var curDomSt = gameList.find('.cur').attr('data-st');


		switch (curDomSt) {
			case 'back_3':
				moveXp(3, 'back');
				break;
			case 'bqk':
				//补签卡
				preact.msgbox.set({
					type: 4,
					title: '天降一张补签卡，好棒棒哟',
					tips: '您这轮还可以摇<span style="color:#ffde46">1</span>次骰子',
					btns: [{
						text: '拿奖走人结束游戏',
						callback: function () {

						}
					}, {
						text: '再摇一次',
						callback: function () {
							this.hide();
							ysz_move(6);


						}
					},]
				}).show();
				break;
			case 'tb_5':
				//团币1/5
				preact.msgbox.set({
					type: 0,
					title: '哇哇哇，听说今天运气不错呀，获得了1/5团币~',
					tips: '您这轮还可以摇<span style="color:#ffde46">1</span>次骰子',
					btns: [{
						text: '查看奖品',
						callback: function () {

						}
					}, {
						text: '不服再战',
						callback: function () {
							this.hide();
							ysz_move(6);


						}
					},]
				}).show();
				break;
			case 'tb_3':
				//团币*3
				preact.msgbox.set({
					type: 0,
					title: '出门遇财神，3倍团币翻翻翻，恭喜您获得X团币~',
					tips: '您已用光摇骰子机会了，请参加下一轮',
					btns: [{
						text: '查看奖品',
						callback: function () {

						}
					}, {
						text: '不服再战',
						callback: function () {
							this.hide();
							ysz_move(6);


						}
					},]
				}).show();
				break;
			case 'move_4':
				moveXp(4);
				break;
			case 'smp':
				//神秘牌
				preact.msgbox.set({
					type: 3,
					title: '揭开神秘面纱，这次你获得的是3天超级会员。',
					msg: '听说这里精彩无极限，每次都有不同的惊喜哟~',
					tips: '您这轮还可以摇<span style="color:#ffde46">1</span>次骰子',
					btns: [{
						text: '拿奖走人结束游戏',
						callback: function () {

						}
					}, {
						text: '再摇一次',
						callback: function () {
							this.hide();
							ysz_move(6);


						}
					},]
				}).show();
				break;
			case 'back':
				gameList.find('.cur').removeClass('cur');
				gameList.find('li').eq(0).addClass('cur');
				setTimeout(function () {
					preact.msgbox.set({
						type: -1,
						title: '很遗憾没能获得礼品，励志成为大富翁的你继续加油哦~',
						tips: '您这轮还可以摇<span style="color:#ffde46">1</span>次骰子',
						btns: [{
							text: '分享游戏',
							callback: function () {

							}
						}, {
							text: '不服再战',
							callback: function () {
								this.hide();
								ysz_move(6);


							}
						},]
					}).show();
				}, 200)
				break;
			case 'hb':
				//投资红包
				preact.msgbox.set({
					type: 1,
					title: '撞到摇钱树，喜获X元壕气投资红包，',
					msg: '听说押得越多红包面额越高哦~',
					tips: '您这轮还可以摇<span style="color:#ffde46">1</span>次骰子',
					btns: [{
						text: '拿奖走人结束游戏',
						callback: function () {

						}
					}, {
						text: '再摇一次',
						callback: function () {
							this.hide();
							ysz_move(6);

						}
					},]
				}).show();
				break;
			case 'again':
				gameList.find('.again_tips').show();
				setTimeout(function () {
					gameList.find('.again_tips').hide();
					ysz_move();
				}, 1000)
				break;
			case 'tb_2_reduce':
				//团币 /2
				preact.msgbox.set({
					type: 0,
					title: '财神说想赏你X团币，看来你很优秀哦~',
					tips: '您已用光摇骰子机会了，请参加下一轮',
					btns: [{
						text: '查看奖品',
						callback: function () {

						}
					}, {
						text: '不服再战',
						callback: function () {
							this.hide();
							ysz_move(6);

						}
					},]
				}).show();
				break;
			case 'tb_2_add':
				//团币*2
				preact.msgbox.set({
					type: 0,
					title: '天降小财神，2倍团币送不停，恭喜您获得X团币~',
					tips: '您已用光摇骰子机会了，请参加下一轮',
					btns: [{
						text: '查看奖品',
						callback: function () {

						}
					}, {
						text: '不服再战',
						callback: function () {
							this.hide();
							ysz_move(6);
						}
					},]
				}).show();
				break;
			case 'start':
				preact.msgbox.set({
					type: -1,
					title: '很遗憾没能获得礼品，励志成为大富翁的你继续加油哦~',
					tips: '您这轮还可以摇<span style="color:#ffde46">1</span>次骰子',
					btns: [{
						text: '分享游戏',
						callback: function () {

						}
					}, {
						text: '不服再战',
						callback: function () {
							this.hide();
							ysz_move(6);
						}
					},]
				}).show();
				break;
		}



	}



	//押注滑动条

	var yz = $('#yz'),
		tb_val = yz.find('.tb');


	$("#range").ionRangeSlider({
		type: "single",
		grid: true,
		from: 0,
		to: 20,
		values: [0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000],
		onFinish: function (data) {
			changeSlide(data.from_value)
		},
		onChange: function (data) {
			changeSlide(data.from_value)
		},
		onUpdate: function (data) {
			changeSlide(data.from_value)
		}

	});


	function changeSlide(index) {
		if (index >= 50) {
			// console.log
			$('.irs-line-left').css( 'background', '#fff900');


			$('.irs-bar-edge').css( 'background', '#fff900');
		} else {
			$('.irs-line-left').css( 'background', '#4e900e')
			$('.irs-bar-edge').css( 'background', '#4e900e');


		}

		if (index ==1000) {
			$('.irs-line-right').css( 'background', '#fff900');
		}else{
			$('.irs-line-right').css( 'background', '#4e900e');
		}

		tb_val.html(index);


	}


	var slider = $("#range").data("ionRangeSlider");

	console.log(slider);


	//摇筛子
	function ysz_move(num) {

		//num 为摇倒的骰子数字

		var randomNum = num ? num : parseInt(Math.random() * 6 + 1);


		var randomAniNum = parseInt(Math.random() * 3 + 1);

		game.find('.shaizi_wraper').addClass('shaizi_wraper_down');
		game.find('.shaizi_wraper').show();
		game.find('.shaizi').attr('class', 'shaizi').addClass('shuaizi_move_' + randomAniNum);


		setTimeout(function () {

			//筛子出结果

			game.find('.shaizi_wraper').removeClass('shaizi_wraper_down');

			//隐藏引导箭头消失

			arrow_start.hide();

			game.find('.shaizi').attr('class', 'shaizi shaizi_' + randomNum);

			moveXp(randomNum);

		}, sz_timer)

	}



	start_game.on('click', function () {
		if ($(this).hasClass('btn_start')) {

			//是否是第一次玩
			yz.show();
		} else if ($(this).hasClass('btn_start_share')) {

			// 好友助力进来的
			ysz_move(4);

			start_game.removeClass('btn_start_share').addClass('btn_play_game');

		}

	});



	//押注团币提交

	yz.find('.submit').on('click', function () {


		yz.hide();
		ysz_move(4);

		start_game.removeClass('btn_start').removeClass('btn_start_share').addClass('btn_play_game');

	})



	//退出游戏


	if(Jsbridge.isApp()){
		 $('#btn_quit').show();
	}

	$('#btn_quit').on('click', function () {
		$('#quit_alert').show();
	});



	$('.close').on('click', function (e) {
		e.preventDefault();
		$(this).parents('.alert').hide();


		// 押注弹窗的关闭按钮，关闭时,需要开启,“开始游戏”按钮开关

		// if ($(this).hasClass('yz_close')) {
		// 	$('#start_game').addClass('can_play');
		// }
	})



	//初始化xp位置
	function setPaiLocation(index) {
		gameList.find('.cur').removeClass('cur');
		gameList.find('li').eq(index).addClass('cur');
	}

	//从第二位开始
	// setPaiLocation(2);


	function isWeiXin() {
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) == 'micromessenger') {
			return true;
		} else {
			return false;
		}
	}


	//退出按钮

	$('#quit_btn').on('click', function (e) {
		e.preventDefault();
		if (Jsbridge.isApp()) {
			Jsbridge.toAppViedoWebView(1, '../html/game.html');
		} else {
			window.location.href = '../html/index.html';
		}
	})


	// ysz_move(6);




	//奖品轮播


	var awardInfoList =  [{"prizeName":"25个团币","drawDate":"2018-04-13 13:28:13","prizeValue":0},
	{"prizeName":"3天超级会员","drawDate":"2018-04-13 13:28:04","prizeValue":480},
	{"prizeName":"10个团币","drawDate":"2018-04-13 13:27:55","prizeValue":0},
];



	function getPastTime(oldDate) {
		var dateStr = oldDate.replace(/\-/g, "/").replace(/T/, " ");
		var past = new Date(dateStr);
		var newDate = getNowFormatDate();
		var dateStr_1 = newDate.replace(/\-/g, "/");
		var now = new Date(dateStr_1);


		var minute = parseInt(parseInt(now - past) / 1000 / 60);


		alert(minute)


		// if (minute < 60) {
				return minute + "分钟前";
		// }

}

function getNowFormatDate() {
		var date = new Date();
		var seperator1 = "-";
		var seperator2 = ":";
		var month = date.getMonth() + 1;
		var strDate = date.getDate();
		if (month >= 1 && month <= 9) {
				month = "0" + month;
		}
		if (strDate >= 0 && strDate <= 9) {
				strDate = "0" + strDate;
		}
		var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
				+ " " + date.getHours() + seperator2 + date.getMinutes()
				+ seperator2 + date.getSeconds();
		return currentdate;
}


	function updateSwiper() {
		// getAwards();
		var code = '';
		for (var i = 0; i < awardInfoList.length; i++) {
				var time =  getPastTime("" + awardInfoList[i].drawDate);;
				if (undefined == time) {
						continue;
				}
				var name = 'hello';
				var prize = awardInfoList[i].prizeName;
				var str = " <div class=\"swiper-slide\">\n"
						+ time
						+ name
						+ "<br> 获得了"
						+ prize
						+ "</div>"
				code += str;

		}
		$(".swiper-wrapper").html(code);

}






var swiper = new Swiper('.swiper-container', {
	paginationClickable: true,
	direction: 'vertical',
	autoplay: 3000
});

updateSwiper();


})();