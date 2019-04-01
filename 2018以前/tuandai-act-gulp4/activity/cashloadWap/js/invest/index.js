(function() {
	FastClick.attach(document.body);
	// 初始化footer
	Util.initFooter('footer');

	var investList,
		pageData = {
			curPage: 1,
			pageSize: 10
		};
	//计算列表容器高度
	var _contentPadding = $('.content').css('padding').split('px');
	var wrapperHeight = $(window).height() - $('.list-container').offset().top - _contentPadding[2];
	$('.list-container').height(wrapperHeight);

	function loadData() {
		//模拟ajax请求获取数据
		var mod = pageData.curPage === 1 ? 'reload' : 'next'; //正在请求刷新数据还是下一页数据
		investList && investList.isLoading(true, mod); //请求时将list的loading状态设置为true
		setTimeout(function() {
			investList && investList.isLoading(false, mod); //请求完成将list的loading状态设置为false
			/*
				ajax请求成功
				更新curPage的值
				判断是否是最后一页，是的话设置list的hasMore为false  investList && investList.hasMore = false;
			*/
			//todo

			var temp = '';
			for (var i = 0; i < 10; i++) {
				var investItem = {
					id: pageData.curPage * pageData.pageSize + i,
					left: 322,
					rate: '10.30',
					date: '15天',
					name: '［资产标］' + i
				};
				var rateArr = investItem.rate.split('.');
				temp += '<li class="invest-tr" data-id="' + investItem.id + '" ><i class="invest-title">' + investItem.name + '</i>' +
					'<div class="invest-txt item-row"><span>预期年化利率</span><span>到期本息</span>' +
					'<span>剩余 <font class="txt-black">' + investItem.left + '</font>万元</span></div>' +
					'<div class="invest-num item-row"><span data-content=".' + rateArr[1] + '%">' + rateArr[0] + '</span>' +
					'<span>' + investItem.date + '</span></div><i class="invest-btn">已售罄</i></li>';
			}

			if (pageData.curPage == 1) {
				$('.invest-list').html(temp);
			} else {
				$('.invest-list').append(temp);
			}

			if (investList) {
				investList.refresh();
			} else {
				investList = new List('#investList', {
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

	$('.invest-list').on('tap', 'li', function() {
		var id = $(this).attr('data-id');
		location.href = './investDetail.html?id=' + id;
	});

})();