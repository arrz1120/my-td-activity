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

	$(window).on('scroll touchmove', function() {
		var sT = $("body").scrollTop();
		var los = $("#titLos").offset().top - 700;
		if(sT >= los) {
			$(".bankuai").addClass('floatIn');
		} else {
			$(".bankuai").removeClass('floatIn');
		}
	})

	var vtitle = '派生集团与万和集团达成全面战略合作';
    var viconUrl = '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201711/wanhe/weixin/images/sharepic.jpg';
    var vcontent = '万和集团与派生集团深度合作 促“实业+科技+金融”均衡发展';
    var vshareUrl = '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201711/wanhe/weixin/index.aspx';
    document.querySelector('.shareBtn').addEventListener('click', function() {
		window.appShare.set({
			iconUrl: viconUrl,
			title: vtitle,
			content: vcontent,
			shareUrl: vshareUrl,
			wxShareImg: {
				url: 'images/wxAlert.png',
				style: {
					width: '100%',
				}
			},
			custom: []
		})
	});

})();