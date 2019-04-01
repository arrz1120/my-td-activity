var vtitle = '优质资产端业务车易贷风控实录';
var viconUrl = '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201709/20170901zhibo/weixin/images/wxshare0.jpg';
var vcontent = '投资如驾驶，安全最重要。小π实地考察车易贷业务，真实纪录风控审核。';

var vshareUrl = '<%=TuanDai.ActivityHD.Common.Globals.HDActivityWebsiteUrl %>/201709/20170901zhibo/weixin/index.aspx';
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
	}
	else if(isWeiXin()){
		$("#wxAlert").show();
	}
	else{
		alert('打开app即可分享');
	}
});

$("#wxAlert").click(function() {
	$(this).hide();
})