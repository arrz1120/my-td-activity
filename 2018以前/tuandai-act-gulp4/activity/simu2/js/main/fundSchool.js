(function() {
	FastClick.attach(document.body);
	var pageData = {
		curPage: 1,
		pageSize: 20
	};
	var type = 0;
	var isLoading = false,
		_can_ajax = true;
	// $('.school-tabs>a').on('click', function() {
	// 	var type = $(this).attr('data-type');
	// 	// console.info('type-----', type);
	// 	// $('.school-tabs>a').removeClass('active');
	// 	// $(this).addClass('active');
	// 	var newUrl = '';
	// 	switch (+type) {
	// 		case 3:
	// 			//漫画学堂
	// 			newUrl = './cartoonSchool.html';
	// 			break;
	// 		case 4:
	// 			//视频学堂
	// 			break;
	// 		default:
	// 			//其他
	// 			newUrl = './fundSchool.html?type=' + type;
	// 			break;
	// 	}
	// 	location.replace(newUrl);

	// });

	Util.showNoData({tips:'aaa'});
	
	function init() {
		type = Util.getParam('type') ? Util.getParam('type') : 0;
		// $('.school-tabs>a').removeClass('active');
		// $('.school-tabs>a[data-type=' + type + ']').addClass('active');
		Util.initTabs(type);
		// getData();
	}
	init();


	//获取数据
	function getData() {
		if (isLoading) {
			return;
		}
		var url = '',
			params = {
				curPage: pageData.curPage
			};
		//根据不同的type定义请求参数跟请求路径
		switch (+type) {
			case 0:
				//固收私募学堂
				url = '';
				params.type = '固收私募学堂';
				break;
			case 1:
				//阳光私募学堂
				url = '';
				params.type = '阳光私募学堂';
				break;
			case 2:
				//股权私募学堂
				url = '';
				params.type = '股权私募学堂';
				break;
		}

		var $list = $('.s-question-list');
		/*-----------test---setTImeout 只是前端模拟效果，实际开发请去掉*/
		setTimeout(function() {
			if (pageData.curPage === 1) {
				$list.html(compileTemp());
			} else {
				$list.append(compileTemp());
			}
			_can_ajax = true;
		}, 1000);
		return;
		/*-----------test*/


		Util.Ajax({
			url: url,
			type: 'get',
			dataType: 'json',
			data: params,
			beforeSend: function() {
				isLoading = true;
			},
			cbOk: function(data, textStatus, jqXHR) {
				// var $list = $('.s-question-list');
				if (pageData.curPage === 1) {
					$list.html(compileTemp(data));
				} else {
					$list.append(compileTemp(data));
				}
			},
			cbErr: function(e, xhr, type) {
				//请求失败回调
				Util.toast('请求出错，请稍后再试');
			},
			cbCp: function() {
				//请求完成回调
				isLoading = false;
				_can_ajax = true;

			}
		});
	}
	var _loadmore_height = $('#loader_more').height();
	$('.scroll').on('scroll', function(e) {
		// console.info('scroll-----');
		getNextPage(e);

	});

	// 获取下一页数据
	function getNextPage(e) {
		var $target = $(e.currentTarget);
		if ($target[0].scrollHeight - $target.height() - $target[0].scrollTop <= 30) {
			console.info('next page---');
			if (_can_ajax) {
				_can_ajax = false;

				// todo 请求数据
				pageData.curPage += 1;
				getData();
			}
		}
	}
	// 模版编译
	function compileTemp(data) {
		var temp = [];
		for (var i = 0; i < 20; i++) {
			// todo 结合数据
			var item = {
				id: i + pageData.curPage * pageData.pageSize,
				text: '什么是阳光私募？'
			}
			temp.push('<li class="sq-row row-arrow" data-id="' + item.id + '">' + item.text + '</li>');
		}

		return temp.join('');
	}
	//跳转到私募学堂内容
	$('.s-question-list').on('click', '.sq-row', function() {
		var id = $(this).attr('data-id');
		location.href = './fundQuestions.html?type=' + type;
	});

})();