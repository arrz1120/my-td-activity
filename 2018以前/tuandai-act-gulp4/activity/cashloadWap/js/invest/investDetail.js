(function() {
	FastClick.attach(document.body);

	Util.initHeader({
		header: 'header'
	});
	//展开/隐藏项目详情
	$('.pi-arrow-container').on('click', function() {
		if ($(this).hasClass('arrow-up')) {
			$(this).removeClass('arrow-up');
			$('.pi-detail').addClass('ellipsis');
		} else {
			$(this).addClass('arrow-up');
			$('.pi-detail').removeClass('ellipsis');
		}
	});
	//切换tab
	$('.tabs>a').on('click', function() {
		var type = $(this).attr('data-type');
		$('.tabs>a').removeClass('active');
		$(this).addClass('active');
		$('.pd-tab').hide();
		$('.pd-tab[data-type="' + type + '"]').show();
		if(type == 2 && $('.ir-list').find('li').length == 0) {
			loadRecordList();
		}
		// var styleArr = ['tab-containers', 'tab-containers tab1', 'tab-containers tab2'];
		// $('.tab-containers').removeClass().addClass(styleArr[(+type)]);

	});

	function loadRecordList() {
		var temp = '';
		var iconArr = ['ir-icon-web', 'ir-icon-ios', 'ir-icon-android', 'ir-icon-wx'];
		for (var i = 0; i < 30; i++) {
			var _random = parseInt(Math.random() * 2, 10);
			var _class = _random ? 'ir-green' : 'ir-yellow';
			var _txt = _random ? '手动' : '自动';
			var index = i % 4;
			temp += '<li class="ir-row"><div><span class="ir-tel">138****1107</span>' +
				'<span class="ir-t"><i class="ir-type ' + _class + '">' + _txt + '</i><i class="' + iconArr[index] + '"></i></span>' +
				'</div><div><span class="ir-amount">￥5000</span><span class="ir-time">2014-04-17 16:56:02</span></div></li>';
		}
		$('.ir-list').html(temp);
	}

	var minHeight = $(window).height() - $('.tabs')[0].clientHeight - Util.pxTopx(100) - $('.pd-btn')[0].clientHeight;
	//计算tab的最小高度，防止切换tab时页面跳动
	$('.pd-tabs').css('min-height', minHeight + 'px');

})();