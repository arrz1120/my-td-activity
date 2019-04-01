(function() {
	FastClick.attach(document.body);
	//do your thing.

	var swiper = new Swiper('.swiper-container-1', {
		paginationClickable: true,
		direction: 'vertical'
	});
	var swiper_1 = new Swiper('.swiper-container-2', {
		paginationClickable: true,
		direction: 'vertical'
	});


	//手机兼容
	var w = $(window).width(),
		h = $(window).height(),
		rate = w / h;
	if (rate > 0.65) {
		$('body').addClass('fixed');
	}



	var tab = $('#tab'),
		qa = $('#qa');


	tab.find('span').on('click', function() {
		$(this).siblings().removeClass('active');
		$(this).addClass('active');
		var index = $(this).index();
		tab.find('.con').removeClass('active_con');
		tab.find('.con').eq(index).addClass('active_con');
	});

	qa.find('.nav_tit').on('click', function() {
		if ($(this).hasClass('unfold')) {
			$(this).removeClass('unfold');
			qa.find('.answer').hide();

			if ($(this).hasClass('bottom_tit')) {
				qa.find('.nav_tit').eq(0).removeClass('move_top');
			}



		} else {
			$(this).siblings().removeClass('unfold');
			$(this).addClass('unfold');
			qa.find('.answer').hide();
			$(this).next('.answer').show();
			if ($(this).hasClass('bottom_tit')) {
				qa.find('.nav_tit').eq(0).addClass('move_top');
			} else {
				qa.find('.nav_tit').eq(0).removeClass('move_top');

			}

		}



	});



	/*分享*/



	function isWeiXin() {
		var ua = navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) == 'micromessenger') {
			return true;
		} else {
			return false;
		}
	}

	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) return unescape(r[2]);
		return null;
	}


	$("#wxAlert").find('.know').on('click', function(e) {
		e.preventDefault();
		$('#wxAlert').hide();
	});



	var params = {
		"shareTypeList": [{
			"ShareToolType": 1,
			"ShareToolName": "微信",
			"IconUrl": "http://hd.tuandai.com//weixin/20160401/images/sharelog.png",
			"Title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
			"ShareContent": "3轮风投融资累计6.75亿，5年安全运行，年化收益达12.6%！",
			"ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionA&shareToolType=1?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
			"IsEnabled": true
		}, {
			"ShareToolType": 5,
			"ShareToolName": "朋友圈",
			"IconUrl": "http://hd.tuandai.com//weixin/20160401/images/sharelog.png",
			"Title": "",
			"ShareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
			"ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionB&shareToolType=5?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
			"IsEnabled": true
		}, {
			"ShareToolType": 4,
			"ShareToolName": "QQ",
			"IconUrl": "http://hd.tuandai.com//weixin/20160401/images/sharelog.png",
			"Title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
			"ShareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
			"ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionA&shareToolType=4?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
			"IsEnabled": true
		}, {
			"ShareToolType": 6,
			"ShareToolName": "QQ空间",
			"IconUrl": "http://hd.tuandai.com//weixin/20160401/images/sharelog.png",
			"Title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
			"ShareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
			"ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionB&shareToolType=6?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
			"IsEnabled": true
		}, {
			"ShareToolType": 3,
			"ShareToolName": "微博",
			"IconUrl": "http://hd.tuandai.com//weixin/20160401/images/sharelog.png",
			"Title": "",
			"ShareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
			"ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionB&shareToolType=3?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
			"IsEnabled": true
		}, {
			"ShareToolType": 2,
			"ShareToolName": "短信",
			"IconUrl": "http://hd.tuandai.com//weixin/20160401/images/sharelog.png",
			"Title": "短信分享",
			"ShareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
			"ShareUrl": "http://m.tuandai.com/url.aspx/txJl5/2-2",
			"IsEnabled": true
		}, {
			"ShareToolType": 7,
			"ShareToolName": "二维码",
			"IconUrl": "",
			"Title": "面对面分享",
			"ShareContent": "",
			"ShareUrl": "https://m.tuandai.com/pages/APPCreateImage.aspx?extendkey=3BA8FFF78706DE10FB51F593B9C4180D&functionType=2",
			"IsEnabled": true
		}, {
			"ShareToolType": 8,
			"ShareToolName": "复制链接",
			"IconUrl": "",
			"Title": "复制链接分享",
			"ShareContent": "",
			"ShareUrl": "https://m.tuandai.com/pages/APPCreateImage.aspx?extendkey=3BA8FFF78706DE10FB51F593B9C4180D&functionType=2",
			"IsEnabled": true
		}]

	};


	$('.share').on('click', function(e) {
		if (Jsbridge.isApp()) {
			Jsbridge.toAppWebViewShare(params, function(result) {
			});
		} else {
			if (isWeiXin()) {
				$("#wxAlert").show();
			} else {
				alert('打开app即可分享');
			}
		}
	});

})();