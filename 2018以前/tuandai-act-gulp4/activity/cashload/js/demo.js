(function() {
	Jsbridge.appLifeHook(function(data) {
		$('body').prepend('readyCb--------', data);
	}, function(data) {
		$('body').prepend('webonPauseCb-------', data);
	}, function(data) {
		$('body').prepend('webonDestroyCb-----', data);
	}, function(data) {
		$('body').prepend('webonResumeHomeCb---------', data);
	});

	$('.btn').on('click', function() {
		var type = $(this).attr('data-type');
		switch (+type) {
			case 0:
				//保存数据
				Jsbridge.exec('SetData', function(result) {
					console.info('setData----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('SetData---' + typeof result + '--' + data);
				}, {
					'key': 'aa',
					'value': {
						'1': [11, 33],
						'2': 22
					}
				});
				break;
			case 1:
				//获取数据
				Jsbridge.exec('GetData', function(result) {
					console.info('getData----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('GetData--' + typeof result + '--' + data);
				}, {
					'key': 'aa'
				});
				break;
			case 2:
				//分享
				var shareUrl = 'https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionA&shareToolType=1?extendkey=3BA8FFF78706DE10FB51F593B9C4180D';
				var shareIcon = 'http://hd.tuandai.com//weixin/20160401/images/sharelog.png';
				var params = {
					"shareTypeList": [{
						"shareToolType": 1,
						"shareToolName": "微信",
						"iconUrl": shareUrl,
						"title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
						"shareContent": "3轮风投融资累计6.75亿，5年安全运行，年化收益达12.6%！",
						"shareUrl": shareUrl,
						"isEnabled": true
					}, {
						"shareToolType": 5,
						"shareToolName": "朋友圈",
						"iconUrl": shareIcon,
						"title": "",
						"shareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
						"shareUrl": shareUrl,
						"isEnabled": true
					}, {
						"shareToolType": 4,
						"shareToolName": "QQ",
						"iconUrl": shareIcon,
						"title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
						"shareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
						"shareUrl": shareUrl,
						"isEnabled": true
					}, {
						"shareToolType": 6,
						"shareToolName": "QQ空间",
						"iconUrl": shareIcon,
						"title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
						"shareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
						"shareUrl": shareUrl,
						"isEnabled": true
					}, {
						"shareToolType": 3,
						"shareToolName": "微博",
						"iconUrl": shareIcon,
						"title": "",
						"shareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
						"shareUrl": shareUrl,
						"isEnabled": true
					}, {
						"shareToolType": 2,
						"shareToolName": "短信",
						"iconUrl": shareIcon,
						"title": "短信分享",
						"shareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
						"shareUrl": "http://m.tuandai.com/url.aspx/txJl5/2-2",
						"isEnabled": true
					}, {
						"shareToolType": 7,
						"shareToolName": "二维码",
						"iconUrl": "",
						"title": "面对面分享",
						"shareContent": "",
						"shareUrl": shareUrl,
						"isEnabled": true
					}, {
						"shareToolType": 8,
						"shareToolName": "复制链接",
						"iconUrl": "",
						"title": "复制链接分享",
						"shareContent": "",
						"shareUrl": shareUrl,
						"isEnabled": true
					}]
				};
				Jsbridge.exec('SharePlugin', function(result) {
					console.info('sharePlugin----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('SharePlugin---' + typeof result + '---' + data);
				}, params);
				break;
			case 3:
				//在线客服
				var params = {
					'methodName': 'OnLineService',
					'params': {}
				};
				Jsbridge.exec('GoToView', function(result) {
					console.info('OnLineService----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('OnLineService-' + typeof result + '---' + data);
				}, params);
				break;
			case 4:
				//电话客服
				var params = {
					'methodName': 'CallService',
					'params': {}
				};
				Jsbridge.exec('GoToView', function(result) {
					console.info('CallService----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('CallService--' + typeof result + '-' + data);
				}, params);
				break;
			case 5:
				//关闭页面
				Jsbridge.exec('CloseWebView', function(result) {
					console.info('closeWebView----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('CloseWebView---' + typeof result + '----' + data);
				}, {});
				break;
			case 6:
				//上传通讯录
				Jsbridge.exec('UpContactInfo', function(result) {
					console.info('UpContactInfo----', result);
					var data = typeof result === 'object' ? JSON.stringify(result) : result;
					$('body').append('UpContactInfo---' + typeof result + '----' + data);
				}, {});
		}
	});

})();