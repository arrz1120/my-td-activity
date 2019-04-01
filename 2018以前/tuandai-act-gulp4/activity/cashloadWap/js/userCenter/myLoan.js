(function() {
	FastClick.attach(document.body);

	var loanList;
	var pageData = {
		curPage: 1,
		pageSize: 10
	};

	Util.initHeader({
		header: 'header'
	});
	   //计算列表容器高度
    var _contentPadding = $('.content').css('padding').split('px');
    var wrapperHeight = $(window).height() - $('.list-container').offset().top - _contentPadding[2];
    $('.list-container').height(wrapperHeight);

	function loadData() {
		// Util.showNoData({
		// 	selector: '.list-container'
		// });
		// return;
		//模拟ajax请求获取数据
		var mod = pageData.curPage === 1 ? 'reload' : 'next'; //正在请求刷新数据还是下一页数据
		loanList && loanList.isLoading(true, mod); //请求时将list的loading状态设置为true
		setTimeout(function() {
			loanList && loanList.isLoading(false, mod); //请求完成将list的loading状态设置为false
			/*
				ajax请求成功
				更新curPage的值
				判断是否是最后一页，是的话设置list的hasMore为false  loanList && loanList.hasMore = false;
			*/
			//todo

			var temp = '';
			for (var i = 0; i < 10; i++) {
				var loadItem = {
					'num': 5000,
					'startTime': '2015-08-18 15:00',
					'endTime': '2015-09-18',
					'term': '30天',
					'seviceCharge': 100,
					'id': i
				};

				var status = i % 8; //借款状态
				var statusText = '',
					btnClass;

				switch (status) {
					case 0:
						//待审核
						statusText = '待审核';
						btnClass = 'li-item-yellow';
						break;
					case 1:
						//已审核
						statusText = '已审核';
						btnClass = 'li-item-yellow';
						break;
					case 2:
						//未通过
						statusText = '未通过';
						btnClass = 'li-item-yellow';
						break;
					case 3:
						//已放款
						statusText = '已放款';
						btnClass = 'li-item-yellow';
						break;
					case 4:
						//待还款
						statusText = '待还款';
						btnClass = 'li-item-yellow';
						break;
					case 5:
						//已完成
						statusText = '已完成';
						btnClass = 'li-item-green';
						break;
					case 6:
						//已逾期
						statusText = '已逾期';
						btnClass = 'li-item-red';
						loadItem.lateFee = 100;
						break;
					case 7:
						//严重逾期
						statusText = '严重逾期';
						btnClass = 'li-item-red';
						loadItem.lateFee = 100;
						break;
				}

				temp += '<li class="loan-tr" data-id="' + loadItem.id + '"><div><p class="loan-num">' + loadItem.num + '元</p>' +
					'<p class="loan-time"><span>' + loadItem.startTime + ' 发起</span><span>' + loadItem.endTime + ' 到期</span></p></div>' +
					'<div class="loan-det-cont"><p class="loan-det"><span><i class="loan-txt">期限</i>' +
					'<i class="loan-txt2">' + loadItem.term + '</i></span><span><i class="loan-txt">服务费</i>' +
					'<i class="loan-txt2">' + loadItem.seviceCharge + '</i></span></p>';
				if (status == 6 || status == 7) {
					temp += '<p class="loan-det"><span><i class="loan-txt">滞纳金</i><i class="loan-txt3">' + loadItem.lateFee + '</i></span></p>';
				}
				temp += '</div><i class="loan-item-btn ' + btnClass + '">' + statusText + '</i></li>';

			}
			if (pageData.curPage === 3) {
				loanList.hasMore = false;
				loanList.refresh();
				return;
			} else {
				loanList && (loanList.hasMore = true);
			}

			if (pageData.curPage == 1) {
				$('.loan-list').html(temp);
			} else {
				$('.loan-list').append(temp);
			}

			if (loanList) {
				loanList.refresh();
			} else {
				loanList = new List('#loanList', {
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

	$('.loan-list').on('tap', '.loan-tr', function() {
		var id = $(this).attr('data-id');
		location.href = './loanDetail.html';
	});
})();