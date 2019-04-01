function isWeiXin() {
	var ua = navigator.userAgent.toLowerCase();
	if(ua.match(/MicroMessenger/i) == 'micromessenger') {
		return true;
	} else {
		return false;
	}
}

(function() {
	FastClick.attach(document.body);

	var vtitle = '888元现金送你，9月13日-21日，团贷网见';
	var viconUrl = '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201709/20170912zxjh/weixin/images/wxshare0.jpg';
	var vcontent = '9月13日起，投资智享计划，888现金等你拿，还有高至1%加息券，88元投资红包';

	var vshareUrl = '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201709/20170912zxjh/weixin/index.aspx';
	var params = {
		"shareTypeList": [{
			"ShareToolType": 1,
			"ShareToolName": "微信",
			"IconUrl": viconUrl,
			"Title": vtitle,
			"ShareContent": vcontent,
			"ShareUrl": vshareUrl + "?ShareToolType=1",
			"IsEnabled": true
		}, {
			"ShareToolType": 5,
			"ShareToolName": "朋友圈",
			"IconUrl": viconUrl,
			"Title": vtitle,
			"ShareContent": vcontent,
			"ShareUrl": vshareUrl + "?ShareToolType=5",
			"IsEnabled": true
		}, {
			"ShareToolType": 4,
			"ShareToolName": "QQ",
			"IconUrl": viconUrl,
			"Title": vtitle,
			"ShareContent": vcontent,
			"ShareUrl": vshareUrl + "?ShareToolType=4",
			"IsEnabled": true
		}, {
			"ShareToolType": 6,
			"ShareToolName": "QQ空间",
			"IconUrl": viconUrl,
			"Title": vtitle,
			"ShareContent": vcontent,
			"ShareUrl": vshareUrl + "?ShareToolType=6",
			"IsEnabled": true
		}, {
			"ShareToolType": 3,
			"ShareToolName": "微博",
			"IconUrl": viconUrl,
			"Title": vtitle,
			"ShareContent": vcontent,
			"ShareUrl": vshareUrl + "?ShareToolType=3",
			"IsEnabled": true
		}, {
			"ShareToolType": 8,
			"ShareToolName": "复制链接",
			"IconUrl": viconUrl,
			"Title": vtitle,
			"ShareContent": vcontent,
			"ShareUrl": vshareUrl + "?ShareToolType=8",
			"IsEnabled": true
		}]

	};

	$(".shareBtn").on('click', function() {
		if(Jsbridge.isApp()) {
			Jsbridge.toAppWebViewShare(params, function(result) {});
		} else if(isWeiXin()) {
			$("#wxAlert").show();
		} else {
			alert('打开app即可分享');
		}
	});

	$("#wxAlert").click(function() {
		$(this).hide();
	})

})();