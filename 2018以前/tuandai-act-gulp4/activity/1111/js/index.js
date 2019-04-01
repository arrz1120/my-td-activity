(function() {
	FastClick.attach(document.body);



	var nav_1 = $('.nav_1'),
		nav_2 = $('.nav_2'),
		nav_scroll = $('.nav_scroll'),
		rem = 20 * ($(window).width() / 320);

	console.log(rem);
	var navTop = 390 / 23.4375 / 2 * rem;

	// $(document).scrollTop(500)

	//定位做滚动动画的元素


	var show_ani = $('.show_ani');

	function aniRun(dom) {

		if (dom.length > 0) {

			dom.addClass('show');

			if (dom.find('.bar_box').length == 2) {

				var _thisBar_1 = dom.find('.bar_box').eq(0).find('.bar'),
					_thisBar_2 = dom.find('.bar_box').eq(1).find('.bar');

				_thisBar_1.width(_thisBar_1.find('.cur_num').html() / 40 * 100 + '%');

				_thisBar_2.width(_thisBar_2.find('.cur_num').html() / 40 * 100 + '%');

			} else if (dom.find('.bar_box').length == 1) {
				var _thisBar_1 = dom.find('.bar_box').eq(0).find('.bar');

				_thisBar_1.width(_thisBar_1.find('.cur_num').html() / 40 * 100 + '%');

			}
		}



	}

	var bescroll = $(document).scrollTop(),
		aniShowTop = 652 / 23.4375 / 2 * rem,
		aniShowAddHei = 652 / 23.4375 / 2 * rem + 100 / 23.4375 / 2 * rem;


	var demo = window.sessionStorage.getItem('scrollTop') || '0';
	var first_in = window.sessionStorage.getItem('is_first_in') || true;



	var touDisStart,
		touDisEnd,
		first_screen = $('.first_screen'),
		list_wraper = $('.list_wraper');


	//当前页面刷新对应处理

	if (first_in == 'false') {

		first_screen.hide();

		list_wraper.removeClass('list_wraper_fir');

		list_wraper.addClass('list_refresh');

		$('.nav_bottom').show();
		//第一个版块动画

		if ($('.cur_con').find('.show_ani').length > 0) {

			$('.cur_con').find('.show_ani').each(function() {
				aniRun($(this));
			});
		}


	}

	window.scrollTo(0, demo * 1)

	$(window).scroll(function() {
		var afscroll = $(document).scrollTop();
		var res = afscroll - bescroll;
		if (res > 0) {
			nav_1.show();
			nav_2.hide();
		} else {
			nav_2.show();
			nav_1.hide();
		}
		bescroll = afscroll;
		//判断显示上下导航
		if (afscroll > navTop) {
			nav_scroll.show();
		} else {
			nav_scroll.hide();
		}

		//判断滚动出发动画

		if (afscroll > aniShowTop) {
			aniRun($('.cur_con').find('.show_ani').eq(1))
		}


		if (afscroll > aniShowTop + aniShowAddHei) {
			aniRun($('.cur_con').find('.show_ani').eq(2))
		}


		if (afscroll > aniShowTop + aniShowAddHei * 2) {
			aniRun($('.cur_con').find('.show_ani').eq(3))
		}

		if (afscroll > aniShowTop + aniShowAddHei * 3) {
			aniRun($('.cur_con').find('.show_ani').eq(4))
		}

		if (afscroll > aniShowTop + aniShowAddHei * 4) {
			aniRun($('.cur_con').find('.show_ani').eq(5))
		}



		if (afscroll > aniShowTop + aniShowAddHei * 5) {
			aniRun($('.cur_con').find('.show_ani').eq(6))
		}


		window.sessionStorage.setItem('scrollTop', afscroll)



	});



	//导航切换

	var contents = $('.content'),
		nav_top = $('.nav_top');

	nav_top.find('span').on('click', function(e) {

		var _this = $(this),
			cur_num = _this.index();

		nav_top.find('span').removeClass('cur');

		nav_top.eq(0).find('span').eq(cur_num).addClass('cur');

		nav_top.eq(1).find('span').eq(cur_num).addClass('cur');

		// _this.addClass('cur');
		contents.removeClass('cur_con');

		contents.eq(cur_num).addClass('cur_con');


		if (cur_num = 1) {
			//第一个版块动画
			var fir_md = $('.cur_con').find('.show_ani').eq(0);
			aniRun(fir_md);
		}

		$(document).scrollTop(navTop);

	});



	//1500毫秒之后开启滑动开关

	var isSwiper = false;

	setTimeout(function() {
		isSwiper = true;
	}, 1500);



	//第一屏幕动画切换


	first_screen.on('touchmove', function(e) {
		e.preventDefault();
	});
	first_screen.on('touchstart', function(e) {
		touDisStart = e.originalEvent.changedTouches[0].pageY;
	});
	first_screen.on('touchend', function(e) {


		touDisEnd = e.originalEvent.changedTouches[0].pageY;
		if (touDisStart - touDisEnd > 25 && isSwiper) {

			first_screen.addClass('fs_up');


			list_wraper.addClass('list_up');


			list_wraper.show();

			setTimeout(function() {
				$('.nav_bottom').show();
				//第一个版块动画
				var fir_md = $('.cur_con').find('.show_ani').eq(0);
				aniRun(fir_md);
			}, 300)


			window.sessionStorage.setItem('is_first_in', false)



		}

		// if (touDisEnd - touDisStart > 25) {
		// 	console.log('下翻')
		// }
	});



	//弹窗


	//规则弹窗

	var alert_rule = $('.alert_rule'),
		alert = $('.alert');

	alert.on('touchmove', function(e) {
		e.preventDefault();
	});

	alert.find('.close,.close_left,.mark').on('click', function(e) {
		e.preventDefault();
		$(this).parents('.alert').hide();
	});


	$('.rule_btn').on('click', function() {
		alert_rule.show();
	});



	//拆红包弹窗

	$('.open_btn').on('click', function() {
		$(this).parent().hide();
		$(this).parent().next('.hb_open').show();
		$(this).parents('.con').addClass('cd_down');
	})


	//无缝滚动

	var Marquee = function(id) {
		var container = document.getElementById(id),
			original = container.getElementsByTagName("dt")[0],
			clone = container.getElementsByTagName("dd")[0],
			speed = arguments[1] || 10;
		clone.innerHTML = original.innerHTML;
		var rolling = function() {
			if (container.scrollTop == clone.offsetTop) {
				container.scrollTop = 0;
			} else {
				container.scrollTop++;
			}
		}
		var timer = setInterval(rolling, 40) //设置定时器
	}



	// 初始化滚动元素

	var marquees = $('.marquee');

	for (var i = 0; i < marquees.length; i++) {
		marquees.eq(i).attr('id', 'marquee_' + i);
		Marquee("marquee_" + i);
	}



})();