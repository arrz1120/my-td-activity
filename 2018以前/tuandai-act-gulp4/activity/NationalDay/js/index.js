(function() {

	footNav()

	var oDate = new Date(),
		oDay = oDate.getDate() + '',
		oMonth = oDate.getMonth() + 1;
	if(oMonth < 10) {
		oMonth = '0' + oMonth;
	} else {
		oMonth = oMonth + '';
	}

	var nowDay = oMonth + oDay,
		forNowDay = '2017-' + oMonth + '-' + oDay,
		initIndex = 0;

	var selectedDay, forSelectDay;
	var swiperData = new Swiper('#swiperData', {
		slidesPerView: 'auto',
		// centeredSlides: true,
		nextButton: '.swiper-button-next',
		prevButton: '.swiper-button-prev',
		slideToClickedSlide: true,
		onInit: function(swiper) {
			var tempDate;
			$("#swiperData").find('.swiper-slide').each(function(i, item) {
				var tempMonth = $(item).attr('month');
				if(tempMonth < 10) {
					tempMonth = '0' + tempMonth;
				} else {
					tempMonth = tempMonth + '';
				}
				tempDate = tempMonth + $(item).html();
				if(tempDate == nowDay) {
					initIndex = i;
					return;
				}
			})
			swiper.slideTo(initIndex, 100, true);
			var passListTemp = '';
			var dataList = null;
			for(var i = 0; i < objData.List.length; i++) {
				var rDate = objData.List[i].RankDate;
				if(rDate.indexOf(forSelectDay) > -1) {
					dataList = objData.List[i].List;
				}
			}
			if(dataList != null) {
				var len = dataList.length;
				if(len > 3) {
					len = 3;
				}
				for(var i = 0; i < len; i++) {
					if(dataList[i].Remark2 == null || dataList[i].Remark2 == '') {
						dataList[i].Remark2 = "https://js.tuandai.com/images/default/default.jpg"
					}
					passListTemp += '<p><span class="avatar"><img src="' + dataList[i].Remark2 + '" ></span>' + passName(dataList[i].TelNo) + '<span class="money">￥ ' + fmoney(dataList[i].Amount, 2) + '</span>' +
						'<span class="redpacket">' + getGold(dataList[i].RankOrder) + '</span></p>';
				}

				$('#list').html(passListTemp);
				$('#listWrap').show();
				$('#todayListWrap').hide();
				$('#none').hide();
			} else {
				$('#none').show();
				$('#todayListWrap').hide();
				$('#listWrap').hide();
			}
		},
		onSlideChangeStart: function(swiper) {

			var active = $("#swiperData").find('.swiper-slide-active');
			var month = active.attr('month');
			var day = active.html();
			if(day < 10) {
				day = '0' + day;
			}
			if(month < 10) {
				month = '0' + month;
			}

			//选择的日期
			selectedDay = month + day;

			forSelectDay = '2017-' + month + '-' + day;

			//小于今天，显示3条数据
			if(nowDay > selectedDay) {
				console.log('今天之前')
				var passListTemp = '';
				var dataList = null;
				for(var i = 0; i < objData.List.length; i++) {
					var rDate = objData.List[i].RankDate;
					if(rDate.indexOf(forSelectDay) > -1) {
						dataList = objData.List[i].List;
					}
				}

				if(dataList != null) {
					var len = dataList.length;
					if(len > 3) {
						len = 3;
					}
					for(var i = 0; i < len; i++) {
						if(dataList[i].Remark2 == null || dataList[i].Remark2 == '') {
							dataList[i].Remark2 = "https://js.tuandai.com/images/default/default.jpg"
						}
						passListTemp += '<p><span class="avatar"><img src="' + dataList[i].Remark2 + '" ></span>' + passName(dataList[i].TelNo) + '<span class="money">￥ ' + fmoney(dataList[i].Amount, 2) + '</span>' +
							'<span class="redpacket">' + getGold(dataList[i].RankOrder) + '</span></p>';
					}

					$('#list').html(passListTemp);
					$('#listWrap').show();
					$('#todayListWrap').hide();
					$('#none').hide();
				} else {
					$('#none').show();
					$('#todayListWrap').hide();
					$('#listWrap').hide();
				}
			}
			//等于今天，显示6条数据
			else if(selectedDay == nowDay) {
				console.log('今天');
				var todayListTemp = '';
				//				var monry = $(".money").val();
				//				var redpacket = $(".redpacket").val();
				var dataList = null;
				// forSelectDay = '2017-09-06';
				for(var i = 0; i < objData.List.length; i++) {
					var rDate = objData.List[i].RankDate;
					if(rDate.indexOf(forSelectDay) > -1) {
						dataList = objData.List[i].List;
					}
				}
				if(dataList != null) {
					var len = dataList.length;
					if(len > 6) {
						len = 6;
					}
					for(var i = 0; i < len; i++) {
						todayListTemp += '<p><i>' + dataList[i].RankOrder + '</i>' + dataList[i].TelNo + '<span class="money">￥ ' + fmoney(dataList[i].Amount, 2) + '</span><span class="redpacket">' + getGold(dataList[i].RankOrder) + '</span></p>';
					}

					$('#todayList').html(todayListTemp);
					$('#todayListWrap').show();
					$('#listWrap').hide();
					$('#none').hide();
				} else {

					$('#none').show();
					$('#todayListWrap').hide();
					$('#listWrap').hide();
				}

			}
			//大于今天，无数据
			else {
				console.log('今天之后');
				$('#none').show();
				$('#todayListWrap').hide();
				$('#listWrap').hide();
			}
		}
	});

	function getGold(_num) {

		var money = 0;
		if(_num == '1') {
			money = '￥1088';
		} else if(_num == '2') {
			money = '￥588';
		} else if(_num == '3') {
			money = '￥188';
		} else {
			money = '未上榜';
		}
		return money;
	}

	function passName(_str) {
		return _str.substr(0, 2) + '****' + _str.substr(_str.length - 2, 2);
	}

	function fmoney(s, n) {
		n = n > 0 && n <= 20 ? n : 2;
		s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
		var l = s.split(".")[0].split("").reverse(),
			r = s.split(".")[1];
		t = "";
		for(i = 0; i < l.length; i++) {
			t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
		}
		return t.split("").reverse().join("") + "." + r;
	}

	var $tic1 = $('#tickeCon .tic1');
	var $tic2 = $('#tickeCon .tic2');
	var $tic3 = $('#tickeCon .tic3');
	var $tic4 = $('#tickeCon .tic4');
	var $ticBtn = $('#tickeCon .btn-dh');
	var isChange = false;

	var arrTicket = [{
			changed: false
		},
		{
			changed: false
		},
		{
			changed: false
		},
		{
			changed: false
		}
	];

	$('#tickeCon .ticket').click(function() {
		var num = $(this).index();
		console.log(num)
		if(!isChange) {
			ticketOrigin(num);
		}
	});

	function ticketExchange(_num) {
		isChange = true;
		switch(_num) {
			case 1:
				$tic1.removeClass('icon-01').removeClass('icon-01-yellow').addClass('icon-01-gray');
				break;
			case 2:
				$tic2.removeClass('icon-02').removeClass('icon-02-yellow').addClass('icon-02-yellow');
				break;
			case 3:
				$tic3.removeClass('icon-03').removeClass('icon-03-yellow').addClass('icon-03-yellow');
				break;
			case 4:
				$tic4.removeClass('icon-05').removeClass('icon-05-yellow').addClass('icon-05-yellow');
				break;
		}
		$ticBtn.removeClass('btn-dh').addClass('btn-dh-gray').html('已兑换');
		$('.ticket').attr('title', '');
	}

	function ticketOrigin(_num) {
		$tic1.addClass('icon-01');
		$tic2.addClass('icon-02');
		$tic3.addClass('icon-03');
		$tic4.addClass('icon-05');
		switch(_num) {
			case 0:
				if(!arrTicket[0].changed) {
					$tic1.removeClass('icon-01').addClass('icon-01-yellow');
					arrTicket[0].changed = true;
					arrTicket[1].changed = false;
					arrTicket[2].changed = false;
					arrTicket[3].changed = false;
				} else {
					arrTicket[0].changed = false;
				}
				break;
			case 1:
				if(!arrTicket[1].changed) {
					$tic2.removeClass('icon-02').addClass('icon-02-yellow');
					arrTicket[0].changed = false;
					arrTicket[1].changed = true;
					arrTicket[2].changed = false;
					arrTicket[3].changed = false;
				} else {
					arrTicket[1].changed = false;
				}
				break;
			case 2:
				if(!arrTicket[2].changed) {
					$tic3.removeClass('icon-03').addClass('icon-03-yellow');
					arrTicket[0].changed = false;
					arrTicket[1].changed = false;
					arrTicket[2].changed = true;
					arrTicket[3].changed = false;
				} else {
					arrTicket[2].changed = false;
				}
				break;
			case 3:
				if(!arrTicket[3].changed) {
					$tic4.removeClass('icon-05').addClass('icon-05-yellow');
					arrTicket[0].changed = false;
					arrTicket[1].changed = false;
					arrTicket[2].changed = false;
					arrTicket[3].changed = true;
				} else {
					arrTicket[3].changed = false;
				}
				break;
		}
	}

	_body.on('click', '.invest-btn', function() {
		Util.noLogin({
			"msg": "你还未登录",
			"tips": "请登录后再参与开红包活动~",
			'btns': [{
				'name': '登 录',
				'cb': function() {
					console.log('去登录')
				}
			}, ]
		});
	})

	/* 活动已结束
	Util.noLogin({
	    "msg": "活动已经结束",
	    "tips": "活动已结束，非常感谢您的关注！",
	    'btns': [{
	        'name': '我知道了',
	        'cb': ""
	    }, ]
	});
	 */

	/* 活动尚未开始
	Util.noLogin({
	    "msg": "活动尚未开始",
	    'btns': [{
	        'name': '我知道了',
	        'cb': ""
	    }, ]
	});

	*/

	/* 团币不足
	Util.msgDialog({
	    "icon": "ku",
	    "msg": "团币数量不足",
	    "tips": "好可惜哦，团币不够哦！</br>赚团币去吧！",
	    'btns': [{
	        'name': '赚团币',
	        'cb': function() {
	              console.log('todo')
	        }
	        }, ]
	    });
	 */

	/* 兑换团币
	     Util.msgDialog({
	         "icon": "tuanbi",
	         "msg": "支付85000团币",
	         "tips": "您确定支付85000团币，兑换</br>0.1%加息特权吗？",
	         'btns': [{
	             'name': '确认兑换',
	             'cb': function() {
	                 console.log('todo')
	             }
	         }, ]
	     });
	 */

	// 日榜规则
	_body.on('click', '#ruleBtn', function() {
		Util.aniShow("#ruleMask")
	})
	_body.on('click', '#close_ruleMask', function() {
		Util.aniHide("#ruleMask")
	})

	_body.on('click', '#mijiBtn', function() {
		Util.aniShow("#mijiMask")
	})
	_body.on('click', '#clsoe_mijiMask', function() {
		Util.aniHide("#mijiMask")
	})

	var offsetT = [];
	for(var i = 1; i <= 3; i++) {
		offsetT.push($("#item" + i).offset().top);
	}
//	console.log(offsetT)
	var o1 = offsetT[0],
		o2 = offsetT[1],
		o3 = $("#swiperData").offset().top,
		bot = $("#menu").find('.foot-btn');

	$(window).on('scroll touchmove', function() {
		var sT = $('.scroll').scrollTop();
//		console.log(sT)
		if(sT < o2) {
			$("#menu").find('.cur').removeClass('cur');
			bot.eq(0).addClass('cur');
		} else if(sT >= o2 && sT < o3) {
			$("#menu").find('.cur').removeClass('cur');
			bot.eq(1).addClass('cur');
		} else {
			$("#menu").find('.cur').removeClass('cur');
			bot.eq(2).addClass('cur');
		}
	})

	bot.each(function(i, item) {
		$(item).click(function() {
			if(i < 3) {
				$("#menu").find('.cur').removeClass('cur');
				$(this).addClass('cur');
				$('.scroll').animate({
					'scrollTop': offsetT[i]
				}, 600);
			}
			if(i == 3) {
				window.location.href = 'https://mvip.tdw.cn/Member/Mall/productList.aspx';
			}
		})
	})

})();