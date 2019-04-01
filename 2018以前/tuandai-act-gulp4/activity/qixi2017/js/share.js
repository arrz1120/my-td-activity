(function() {
    FastClick.attach(document.body);

    var params = {
        "shareTypeList": [{
            "ShareToolType": 1,
            "ShareToolName": "微信",
            "IconUrl": "http://hd.tuandai.com//weixin/20160401/images/shareImg.jpg",
            "Title": "七夕毒鸡汤，看谁比谁忧伤?",
            "ShareContent": "单身狗看了都发出了银铃般的笑声~",
            "ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionA&shareToolType=1?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
            "IsEnabled": true
        }, {
            "ShareToolType": 5,
            "ShareToolName": "朋友圈",
            "IconUrl": "http://hd.tuandai.com//weixin/20160401/images/shareImg.jpg",
            "Title": "",
            "ShareContent": "单身狗看了都发出了银铃般的笑声~",
            "ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionB&shareToolType=5?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
            "IsEnabled": true
        }, {
            "ShareToolType": 4,
            "ShareToolName": "QQ",
            "IconUrl": "http://hd.tuandai.com//weixin/20160401/images/shareImg.jpg",
            "Title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
            "ShareContent": "单身狗看了都发出了银铃般的笑声~",
            "ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionA&shareToolType=4?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
            "IsEnabled": true
        }, {
            "ShareToolType": 6,
            "ShareToolName": "QQ空间",
            "IconUrl": "http://hd.tuandai.com//weixin/20160401/images/shareImg.jpg",
            "Title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
            "ShareContent": "单身狗看了都发出了银铃般的笑声~",
            "ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionB&shareToolType=6?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
            "IsEnabled": true
        }, {
            "ShareToolType": 3,
            "ShareToolName": "微博",
            "IconUrl": "http://hd.tuandai.com//weixin/20160401/images/shareImg.jpg",
            "Title": "",
            "ShareContent": "单身狗看了都发出了银铃般的笑声~",
            "ShareUrl": "https://hd.tuandai.com/weixin/20170105Invite/InviteMainM.aspx?shareVersion=versionB&shareToolType=3?extendkey=3BA8FFF78706DE10FB51F593B9C4180D",
            "IsEnabled": true
        }, {
            "ShareToolType": 2,
            "ShareToolName": "短信",
            "IconUrl": "http://hd.tuandai.com//weixin/20160401/images/shareImg.jpg",
            "Title": "短信分享",
            "ShareContent": "单身狗看了都发出了银铃般的笑声~",
            "ShareUrl": "http://m.tuandai.com/url.aspx/txJl5/2-2",
            "IsEnabled": true
        }, {
            "ShareToolType": 7,
            "ShareToolName": "二维码",
            "IconUrl": "",
            "Title": "面对面分享",
            "ShareContent": "",
            "ShareUrl": "https://m.tuandai.com/pages/APPCreateImage.aspx?extendkey=3BA8FFF78706DE10FB51F593B9C4180D&functionType=2",
            "IsEnabled": true
        }, {
            "ShareToolType": 8,
            "ShareToolName": "复制链接",
            "IconUrl": "",
            "Title": "复制链接分享",
            "ShareContent": "",
            "ShareUrl": "https://m.tuandai.com/pages/APPCreateImage.aspx?extendkey=3BA8FFF78706DE10FB51F593B9C4180D&functionType=2",
            "IsEnabled": true
        }]

    };
    Jsbridge.appLifeHook(null, function() {
        $('body').append('<div></div>');
        // Jsbridge.setTitleComponent({
        //  titleContent: '分享测试',
        //  rightbuttonVisible: true,
        //  rightbuttonContent: '分享',
        //  rightbuttonTyppe: 1,
        //  // showTitleComponent: true,
        //  shareTypeList: params.shareTypeList,
        //  rightBtnCb: function(result) {
        //      console.info('result---setTitleComponent---', result);
        //      var str = result ? JSON.stringify(result) : '';
        //      var _show = $('<div/>').html('result---setTitleComponent---' + str);
        //      $('body').append(_show);
        //  }
        // });

    }, null, null, null);


    $(".appShareBtn").on('click', function() {
        Jsbridge.toAppWebViewShare(params, function(result) {
            /*
                result:"{\"ShareResult\":\"onCancel\"}"
                分享成功：onComplete
                分享失败：onError
                取消分享：onCancel
            */
        });
    });

})();