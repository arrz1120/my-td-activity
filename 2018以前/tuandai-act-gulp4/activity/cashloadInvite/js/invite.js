(function() {
    FastClick.attach(document.body);

    window.onload = function() {
            $('.content').addClass('anit');
        }
        //查看明细
    $('#checkDetail').on('click', function() {
        //todo
        if (Util.isApp()) {
            Jsbridge.exec('GoToView', function(result) {}, {
                'methodName': 'ToAppDiscountCoupon'
            });
        } else {
            //todo
            console.info('我的优惠券');
        }
    });
    $('.masker, .wx-share').on('click', function() {
        $('.share-mask').hide();
    });
    //分享
    var shareUrl = 'https://at.tuandai.com/201709/20170912zxjh/weixin/index.aspx';
    var shareIcon = 'https://at.tuandai.com/201709/20170912zxjh/weixin/images/wxshare0.jpg';
    var shareParams = {
        "shareTypeList": [{
            "shareToolType": 1,
            "shareToolName": "微信",
            "iconUrl": shareUrl,
            "title": "我在团贷网理财好久啦，送你518红包，撸起袖子加油赚",
            "shareContent": "3轮风投融资累计6.75亿，5年安全运行，年化收益达12.6%！",
            "shareUrl": shareUrl + '?ShareToolType=1',
            "isEnabled": true
        }, {
            "shareToolType": 5,
            "shareToolName": "朋友圈",
            "iconUrl": shareIcon,
            "title": "",
            "shareContent": "17年的小目标，从加入团贷网开始！安全运营5年，收益高达12.6%，杠杠滴！",
            "shareUrl": shareUrl + '?ShareToolType=5',
            "isEnabled": true
        }]
    };
    //分享
    $('.btn-share').on('click', function() {
        if (Util.isApp()) {
            Jsbridge.exec('SharePlugin', null, shareParams);
        } else if (Util.isWeiXin()) {
            $('.share-mask').show();
        } else {
            Util.popup({
                "content": "请下载App进行分享",
                "btns": [{
                    "name": "取消",
                    "cb": function() {

                    }
                }, {
                    "name": "前往下载",
                    "cb": function() {
                        //todo
                    }
                }]
            });
        }
    });
    // 判断是否是app 
    // function isApp() {
    //     return (/sulaidaiapp/i).test(navigator.userAgent.toLowerCase());
    // }

})();