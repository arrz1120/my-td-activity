var refresh = { //下拉刷新
	$dom: null,
	MAXTIME: 1000,
	tap_touch_y: 0,
	tap_touch_up: false,
	refresh_lock: false,
	swipeY: 0,
	moveY: 0,
	scrollTop:0,
	page_refresh: null,
	init: function(scroll) { //初始化-传入滚动区域选择器
		var refresh = this;
		refresh.page_refresh = $(".page-refresh");
		var page_refresh = refresh.page_refresh;
		refresh.svg = page_refresh.find('svg')
		refresh.g = page_refresh.find('g')
		refresh.circle = page_refresh.find('circle')
		refresh.animate = page_refresh.find('animate')
		refresh.animateTransform = page_refresh.find('animateTransform')
		refresh.polygon = page_refresh.find('polygon');
		$(window).on('scroll',function(){
			refresh.scrollTop = $(window).scrollTop();
			$("#value").html(refresh.scrollTop);
			console.log('offsetTop == '+refresh.$dom.offset().top+',scrollTop == '+scrollTop);
		})
		$(scroll).on('touchstart', function() {
			var $this = $(this);
			var scrollY = $(this).children().css('transform');
			refresh.$dom = $this;
			if (scrollY && scrollY !== 'none') {
				scrollY = scrollY.split(',')[5];
				scrollY = Number(scrollY.substr(1, scrollY.length - 2));
			} else {
				scrollY = $this.scrollTop();
			}
			console.log(scrollY);
			refresh.tap_touch_up = scrollY === 0 ? true : false;
			if (!refresh.tap_touch_up || refresh.refresh_lock) {
				return;
			}
			refresh.tap_touch_y = event.touches[0].pageY;
			refresh.swipeY = 0;
		}).on('touchmove', function() {
			var pageY;
			if (!refresh.tap_touch_up || refresh.refresh_lock || (refresh.scrollTop>0)) {
				return;
			}
			pageY = event.touches[0].pageY;
			refresh.moveY = (pageY - refresh.tap_touch_y) / 2;
			if (refresh.swipeY === 0) {
				refresh.swipeY = refresh.moveY;
			}
			if (refresh.swipeY < 0) {
				refresh.tap_touch_up = false;
				return;
			}
			refresh.move();
			return false;
		}).on('touchend', function() {
			if (!refresh.tap_touch_up || refresh.refresh_lock) {
				return;
			}
			if (refresh.moveY < 80) {
				refresh.back();
			} else {
				refresh.onRefresh(refresh.$dom);
				refresh.load();
			}
			refresh.moveY = 0;
		});
	},
	
	onRefresh: function(scroll) { //加载事件-传入为触发事件的jq-dom
//		console.log(scroll);
	},
	reinit: function(scroll) { //重置-传入滚动区域选择器-暂未支持
		//
	},
	move: function() {
		var refresh = this;
		var opacity;
		var rotate;
		refresh.moveY = refresh.moveY < 120 ? refresh.moveY : 120;
		var n = refresh.moveY / 80;
		var cr = 450 - 280 * n;
		var cs = 127.0599695451872 * n;
		var o = n < 0.75 ? 0.4 : 0.6 * n + 0.4;
		var sr = -(280 - n * 280) + 100 + 130 * n;
		refresh.page_refresh.css('-webkit-transform', 'translateY(' + refresh.moveY + 'px)');
		refresh.svg.css('-webkit-transform', 'rotate(' + sr + 'deg)');
		if (n > 1) {
			return;
		}
		refresh.circle.attr({
			'stroke-dasharray': cs + ' 163.36281798666926',
			'transform': 'rotate(' + cr + ' 30 30)',
		});
		refresh.polygon.css('-webkit-transform', 'scale(' + n + ')');
		refresh.g.css('opacity', o);
	},
	load: function() {
		var refresh = this;
		refresh.refresh_lock = true;
		refresh.page_refresh.css({
			'-webkit-transition': '-webkit-transform 0.3s',
			'-webkit-transform': 'translateY(80px) scale(1)',
		});
		refresh.animate[0].beginElement();
		refresh.animateTransform[0].beginElement();
		refresh.animateTransform[1].beginElement();
		refresh.polygon.css('-webkit-transform', 'scale(0)');
//		setTimeout(function() {
//			refresh.hide();
//		}, refresh.MAXTIME);
	},
	back: function() {
		var refresh = this;
		var page_refresh = this.page_refresh;
		page_refresh.one('webkitTransitionEnd', function() {
			page_refresh.css('-webkit-transition', 'none');
		}).css({
			'-webkit-transition': '-webkit-transform 0.3s',
			'-webkit-transform': 'translateY(0px)',
		});
	},
	hide: function() {
		var refresh = this;
		refresh.page_refresh.one('webkitTransitionEnd', function() {
			refresh.page_refresh.css({
				'-webkit-transition': 'none',
				'-webkit-transform': 'scale(1)',
			});
			refresh.animate[0].endElement();
			refresh.animateTransform[0].endElement();
			refresh.animateTransform[1].endElement();
			refresh.refresh_lock = false;
		}).css({
			'-webkit-transform': 'translateY(80px) scale(0)',
		});
	}
}
refresh.init('#thelist');// 初始化-传入滚动父元素
refresh.onRefresh = function(iscroll) {//刷新
	console.log('refresh');
	console.log(iscroll);
	var listHtml = '<div class="pt20 pb15 mt10 bg-fff bt-e6e6e6 bb-e6e6e6">'+
			'<div class="list-box">'+
				'<div class="list-box-left">'+
					'<p class="f14px c-fd6040"><span class="f27px c-fd6040">14</span>.40%</p>'+
					'<p class="f12px c-ababab mt5">年化利率</p>'+
				'</div>'+
				'<div class="list-box-center text-center">'+
					'<p class="f14px c-212121"><span class="f17px c-212121 inline-block" style="vertical-align:-1px;">9</span>个月</p>'+
					'<p class="f12px c-ababab mt5">投资期限</p>'+
				'</div>'+
				'<div class="list-box-right">'+
					'<p class="f14px c-212121"><span class="f17px c-212121 inline-block" style="vertical-align:-1px;">300</span>万</p>'+
		    			'<p class="f12px c-ababab mt5">剩余金额</p>'+
				'</div>'+
			'</div>'+
			'<div class="pt10 pl15 pr15 clearfix itemWrap">'+
				'<div class="lf itemTxtBox"><p class="f13px c-808080 text-overflow">【四川】某商贸有限公司短期借款</p></div>'+
				'<div class="rf clearfix itemTipsBox">'+
					'<div class="lf itemTips itemTips1">加息1%</div>'+
					'<div class="rf itemTips itemTips2">可提前退出</div>'+
				'</div>'+
			'</div>'+
		'</div>';
	var theListHtml = $("#thelist").html();	
		setTimeout(function() {
		$("#thelist").html(theListHtml + listHtml);	
		refresh.hide();
	}, 1000);
}

