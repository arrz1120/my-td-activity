(function() {
	FastClick.attach(document.body);
	//do your thing.

	var audio = $("#media"),
		txt_wraper = $('.txt_wraper'),
		rule = $('.rule'),
		open_door = $('.open_door');



	var isGame = true,
		xp = $('.xp'),
		game = $('#game'),
		ropeMoveTime = 1200,
		startTime, // 开始滚动事件
		scrolltime = 6000, // 娃娃从头滚到尾的时间 单位： ms
		spacetime = scrolltime / 6; // 每个娃娃滚动的时间



	//音乐播放

	autoPlay();



	var timer = 2200,
		rule_hide = true;


	var game_txt = new Input_type($(".txt_val"), $(".txt_print"), function() {
		//打字结束，暂停音乐
		// audio[0].pause();
		musicPause()
		// 规则弹窗显示
		setTimeout(function() {
			txt_wraper.hide();

			if (rule_hide) {
				rule.fadeIn();
			}
		}, 200);
	});
	game_txt.pri()();


	$('.skip').on('click', function() {
		rule_hide = false;
		txt_wraper.hide();
		rule.fadeIn();
		// audio[0].pause();
		musicPause()


	});



	rule.find('.close_rule').on('click', function() {
		rule.hide();
		$('.lzg').show().addClass('lz_show');
		$('.lzg_1').show().addClass('breath');

		setTimeout(function(){
			startGame();
		},1200)
	});


	var timer,
		second = $('#second');

	function startGame() {
		game.show();
		// 宝箱滚动
		game.find('.list').addClass('list_move');

		game.find('.tips').addClass('fadeOut');
		startTime = new Date().getTime();
		
		// console.log(startTime);


		timer = setInterval(function() {
			var curTime = new Date().getTime();
			var t = parseInt((curTime - startTime) / 1000);
			// console.log(t);
			if (t < 180) {
				second.html(180 - t);
			} else {
				//时间到
				$('#gameover').show();
				clearTimeout(timer);
			}
		}, 1000);


	}


	//摸金游戏

	//放爪

	var catchClassName;

	$('.start_btn').on('click', function() {

		if (isGame) {
			isGame = false;
			//放下
			xp.find('.rope').addClass('rope_down');

			setTimeout(function() {
				//收起
				xp.find('.rope').addClass('rope_up');
				xp.find('.guo').addClass('guo_catch');


				var duringTime = new Date().getTime() - startTime;
				// console.log(getIndex(duringTime));

				var catchNum = getIndex(duringTime),
					catchDom = game.find('.list li').eq(catchNum);

				catchClassName = catchDom.attr('class');


				game.find('.list').eq(0).find('li').eq(catchNum).addClass('catch_box');
				game.find('.list').eq(1).find('li').eq(catchNum).addClass('catch_box');


				game.find('.guo').addClass(catchClassName + '_show');

				// console.log(catchClassName);

				//爪子回原位
				xp.removeClass('rope_down');



				setTimeout(function() {
					clearTimeout(timer);
					// 宝箱出现
					$('#bx_big').show();
					$('#bx').addClass(catchClassName).attr('data-style', catchClassName);

				}, 200);


			}, ropeMoveTime)
		}
	})

	function getIndex(no) {
		var _index = parseInt(no / spacetime) + 3
			// console.log(_index % 6)
		return _index % 6;
	}



	$('.close').on('click', function(e) {
		$(this).parents('.alert').hide();
	});


	// 打开宝箱

	$('#bx').on('click', function(e) {
		$(this).parent().hide();
		$('#bx_open').addClass(catchClassName + '_open');
		//红包： prize_hb.png
		// 体验金： prize_tyj.png
		$('#bx_open').find('img').attr('src', '../images/prize_hb.png');

		$('#prize_wraper').show();
	});


    function isIOS() {
        return navigator.userAgent.match(/(iPad|iPhone)/);
    }
	

	document.querySelector('.share_btn').addEventListener('click', function() {
		window.appShare.set({
			iconUrl: '',
			title: '',
			content: '',
			shareUrl: '',
			wxShareImg: {
				url: '../images/share-shade.png',
				style: {
					width: '100%',
				}
			},
         callback:function(result){

           var status;
            //status:
            //成功:'onComplete'，失败:'onError'，取消:'onCancel'
            if(isIOS()){
              status=result;
            }else{
              status=JSON.parse(result).ShareResult;
            }
          
         }
		})
	});

})();