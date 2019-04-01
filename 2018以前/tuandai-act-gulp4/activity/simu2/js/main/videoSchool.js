(function() {
	FastClick.attach(document.body);
	var isLoading = false,
		_can_ajax = true,
		pageData = {
			curPage: 1,
			pageSize: 20
		},
		dataType; //数据类型

	function init() {
		// var _tabWidth = $('.school-tabs>a').width();
		// $('.school-tabs')[0].scrollLeft = _tabWidth * 2;
		Util.initTabs(4);
		var _wrapperHeight = $(window).height() - $('.list-wrapper').offset().top;
		$('.list-wrapper').height(_wrapperHeight);
		getData();
	}
	init();
	//获取数据
	function getData() {
		if (isLoading) {
			return;
		}

		var $list = $('.list-cartoon');
		/** setTimeout只是前端模拟效果，实际开发请去掉*/
		setTimeout(function() {
			if (pageData.curPage === 1) {
				$list.html(compileTemp());
			} else {
				$list.append(compileTemp());
			}
			_can_ajax = true;
		}, 1000);
		return;
		/**-------------*/
		var reqParams = {
			curPage: pageData.curPage
		};
		switch (+dataType) {
			case 1:
				//认识私募
				reqParams.type = '1'; //筛选条件，根据实际情况更改即可
				break;
			case 2:
				//挑选私募
				reqParams.type = '2';
				break;
			case 3:
				//购买私募
				reqParams.type = '3';
				break;
			case 4:
				//私募运行
				reqParams.type = '4';
				break;
			case 5:
				//私募赎回
				reqParams.type = '5';
				break;
		}
		Util.Ajax({
			url: '请求路径',
			type: 'get',
			dataType: 'dataType',
			data: reqParams,
			beforeSend: function() {
				isLoading = true;
			},
			cbOk: function(result) {
				if (pageData.curPage === 1) {
					$list.html(compileTemp(result));
				} else {
					$list.append(compileTemp(result));
				}
			},
			cbErr: function(e) {
				//请求失败回调
				Util.toast('请求出错，请稍后再试');
			},
			cbCp: function() {
				//请求完成回调
				isLoading = false;
				_can_ajax = true;
			}
		})
	}

	// 模版编译
	function compileTemp(data) {
		var temp = [];
		for (var i = 0; i < 20; i++) {
			// todo 结合数据
			temp.push('<li class="item-video" data-id="' + (pageData.curPage * pageData.pageSize + i) +'">' +
				'<div class="left video-info">' +
				'<p>热门精选热门精选热门 ' + i + '</p>' +
				'<div><i class="icon-inline icon-clock"></i><span>2017-09-01</span><i class="icon-inline icon-eye"></i><span>999 +</span></div>' +
				'</div>' +
				'<div class="right pic-play">' +
				'<img src="../../images/cover.png" >' +
				'</div>' +
				'</li>');
		}

		return temp.join('');
	}

	$('.cl-wrapper').on('scroll', function(e) {
		getNextPage(e);
	});

	function getNextPage(e) {
		var $target = $(e.currentTarget);
		if ($target[0].scrollHeight - $target.height() - $target[0].scrollTop <= 30) {
			if (_can_ajax) {
				_can_ajax = false;
				pageData.curPage += 1;
				getData();
			}
		}
	}

	//二级目录点击筛选数据
	$('.sub-tabs>a').on('click', function(e) {
		dataType = $(this).attr('data-type');
		$('.sub-tabs>a').removeClass('active');
		$(this).addClass('active');
		pageData.curPage = 1;
		$('.cl-wrapper')[0].scrollTop = 0;
		getData();
	});

	//跳转到视频详情
	$('.list-cartoon').on('click', '.item-video', function() {
		var id = $(this).attr('data-id');
		location.href = '../video/detail.html?id=' + id;
	})


})();