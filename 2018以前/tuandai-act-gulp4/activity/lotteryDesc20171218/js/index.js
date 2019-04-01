(function() {
	var $body = $('body')
	var $shareConEl = $body.find('.share-con');
	// 绑定分享按钮事件
	$body.on('click', '#btnShare',function() {
		if (!Jsbridge.isApp()) {
			$shareConEl.show();
			return;
		}
		$shareConEl.hide();
		var sharData = { //分享配置
			csrf_url: window.location.href,
			title: '快来玩元气大转盘，最高赢取1218元现金！',
			desc: '还有京东卡、腾讯VIP季卡、补签卡、团币等1218份奖品等你拿！',
			img_url: 'http://10.100.69.11:3000/images/share.jpg'
		}

		// 调用app分享插件
		if (Jsbridge.isCorrectVersion('5.1.2', true)) {
			Jsbridge.toAppWebViewShare({
				"shareTypeList": [{
					"ShareToolType": 1,
					"ShareToolName": '微信分享',
					"IconUrl": sharData.img_url,
					"Title": sharData.title,
					"ShareContent": sharData.desc,
					"ShareUrl": sharData.csrf_url,
					"IsEnabled": true
				}, {
					"ShareToolType": 5,
					"ShareToolName": '朋友圈分享',
					"IconUrl": sharData.img_url,
					"Title": sharData.title,
					"ShareContent": sharData.title,
					"ShareUrl": sharData.csrf_url,
					"IsEnabled": true
				}]
			}, function(e) {
				console.log('分享成功');
			});
		}
	});

	$shareConEl.on('click', function() {
		$shareConEl.hide();
	});
})()