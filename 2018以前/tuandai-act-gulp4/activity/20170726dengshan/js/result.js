(function() {
	FastClick.attach(document.body);

	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r != null) return unescape(r[2]);
		return null;
	}

	var icon_url = "http://hd.tuandai.com//weixin/20160401/images/sharelog.png";
	var share_url = "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionA&shareToolType=1?extendkey=3BA8FFF78706DE10FB51F593B9C4180D"

	var params = {
		"shareTypeList": [{
			"ShareToolType": 1,
			"ShareToolName": "微信",
			"IconUrl": icon_url,
			"Title": "我在团贷网理财好久啦，推荐你来领518元红包，撸起袖子加油赚吧！",
			"ShareContent": "新三板挂牌上市，3轮风投融资累计6.75亿，4年安全运行，年化收益达13%",
			"ShareUrl": share_url,
			"IsEnabled": true
		}, {
			"ShareToolType": 5,
			"ShareToolName": "朋友圈",
			"IconUrl": icon_url,
			"Title": "",
			"ShareContent": "新三板挂牌上市，3轮风投融资累计6.75亿，4年安全运行，年化收益达13%",
			"ShareUrl": share_url,
			"IsEnabled": true
		}]

	};

	$("#shareBtn").on('click', function() {
		if(Jsbridge.isApp()) {
			 if (Jsbridge.isCorrectVersion('5.1.2', 1)) {
			 	Jsbridge.toAppWebViewShare(params, function(result) {
			 		
			 	});
			 }else{
			 	Jsbridge.toAppActivity(2);
			 }
		}
	});

})();