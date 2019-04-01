var _body  = $('body');

(function() {

    FastClick.attach(document.body);

    //app 分享
    var vtitle = '国庆活动';
    var viconUrl = '';
    var vcontent = '国庆活动抽奖';

    var vshareUrl = '';
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

    _body.on('click', '#btnShare', function () {
        if(Jsbridge.isApp()) {
            Jsbridge.toAppWebViewShare(params, function(result) {});
        } else if(Util.isWeiXin()) {
            weixinMask()
        } else {
            Util.toast('打开app即可分享');
        }
    })
    function weixinMask(){
        $("#shareMask").show();
        Util.disableScroll();
    }

    _body.on('click', '#shareMasker', function () {
        $("#shareMask").hide();
        Util.enableScroll();
    })

})();