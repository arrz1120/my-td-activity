(function() {
	FastClick.attach(document.body);
	var coupouList,
		pageData = {
			curPage: 1,
			pageSize: 10
		};
	var couponIntro = {}; //优惠券使用说明

	Util.initHeader({
		header: 'header'
	});
	//计算列表容器高度
	var _contentPadding = $('.content').css('padding').split('px');
	var wrapperHeight = $(window).height() - $('.list-container').offset().top - _contentPadding[2];
	$('.list-container').height(wrapperHeight);

	function loadData() {
		//模拟ajax请求获取数据
		var mod = pageData.curPage === 1 ? 'reload' : 'next'; //正在请求刷新数据还是下一页数据
		coupouList && coupouList.isLoading(true, mod); //请求时将list的loading状态设置为true
		setTimeout(function() {
			coupouList && coupouList.isLoading(false, mod); //请求完成将list的loading状态设置为false
			/*
				ajax请求成功
				更新curPage的值
				判断是否是最后一页，是的话设置list的hasMore为false  coupouList && coupouList.hasMore = false;
			*/
			//todo
			var temp = '';
			for (var i = 0; i < 10; i++) {
				var status = parseInt(Math.random() * 2); //优惠券状态 0表示已失效 1表示可用
				var _style = status ? 'coupon' : 'coupon lapsed';

				var couponItem = {
					'amount': 12,
					'type': '现金红包',
					'name': '优惠券名称' + i,
					'content': '这是一段说明文案' + i * 13,
					'startTime': '2017.7.20',
					'endTime': '2018.07.20',
					'id': pageData.pageSize * pageData.curPage + i
				};
				couponIntro[couponItem.id] = '详细说明，后台配置。详细说明，后台配置。';

				temp += '<li data-id="' + couponItem.id + '"><div class="' + _style + '"><div class="coupon-left">' +
					'<div class="money">' + couponItem.amount + '</div>' +
					'<span>' + couponItem.type + '</span></div><div class="coupon-right"><div>' + couponItem.name + '</div>' +
					'<p class="info">' + couponItem.content + '</p>' +
					'<p class="date">有效期：' + couponItem.startTime + '-' + couponItem.endTime + '</p></div></div></li>';
			}


			if (pageData.curPage == 1) {
				$('.list-coupon').html(temp);
			} else {
				$('.list-coupon').append(temp);
			}

			if (coupouList) {
				coupouList.refresh();
			} else {
				coupouList = new List('#couponList', {
					loadMore: function() {
						console.info('loadMore-------');
						pageData.curPage += 1;
						loadData();
					},
					reload: function() {
						console.info('reload-------');
						pageData.curPage = 1;
						loadData();
					}
				});

			}

		}, 1000);
	}
	loadData();

	//点击优惠券显示详细说明弹窗
	$('.list-coupon').on('tap', 'li', function() {
		var id = $(this).attr('data-id');
		var introdution = couponIntro[id];
		Util.popup({
			title: '使用说明',
			content: introdution,
			btns: [{
				name: '确定'
			}]
		});
	});
})();