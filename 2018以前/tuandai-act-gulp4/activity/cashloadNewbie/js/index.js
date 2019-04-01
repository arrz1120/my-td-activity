(function() {
    FastClick.attach(document.body);

    /* ************** 事件绑定 ************** */
    // 分享按钮事件绑定
    $('#btn_share').on('click', function(e) {
        share(e);
    });

    // 微信分享弹窗 我知道了 按钮事件绑定
    $('#share_wx').on('click', '.btn-close', function(e) {
        closeShareWX();
    });

    // wap分享弹窗 前往下载 按钮事件绑定
    $('#share_wap').on('click', '.btn-pos', function(e) {
        download();
    });

    // wap分享弹窗 取消 按钮事件绑定
    $('#share_wap').on('click', '.btn-nav', function(e) {
        hideShareWap();
    });

    // 注册按钮
    $('#btn_signup').on('click', function(e) {
        signUp();
    });

    // 查看优惠券按钮
    $('#btn_check_coupon').on('click', function(e) {
        gotoCouponList();
    });

    // 活动规则按钮
    $('#btn_rule').on('click', function(e) {
        showRule();
    });

    // 活动规则遮罩
    $('#pop_rule').on('click', '.masker, .icon-close', function(e) {
        hideRule();
    });
    /* ************** 具体实现事件 ************** */
    // 分享事件
    function share(e) {
        if (isWeiXin()) {
            showShareWX();
        } else if (isApp()) {
            shareApp();
        } else {
            showShareWap();
        }
    }
    // 显示微信分享弹窗
    function showShareWX() {
        $('#share_wx').show();
        disableScroll();
    }
    // 关闭微信分享弹窗
    function closeShareWX() {
        $('#share_wx').hide();
        enableScroll();
    }
    // 显示wap分享弹窗
    function showShareWap() {
        $('#share_wap').show();
        disableScroll();
    }
    // 关闭wap分享弹窗
    function hideShareWap() {
        $('#share_wap').hide();
        enableScroll();
    }
    // 显示规则弹窗
    function showRule() {
        $('#pop_rule').show();
        disableScroll();
    }
    // 关闭规则弹窗
    function hideRule() {
        $('#pop_rule').hide();
        enableScroll();
    }
    // 下载app
    function download() {
        var _href = '';
        if (isIosPlatform()) {
            // todo 修改为ios下载地址
            _href = '';
        } else {
            // todo 修改为android下载地址
            _href = '';
        }
        window.location.href = _href;
    }
    // app分享
    function shareApp() {
        // todo 修改分享参数
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
            }]
        };
        Jsbridge.exec('SharePlugin', function(result) {
            console.info('sharePlugin----', result);
            // alert(result);
        }, params);
    }
    // 跳转去注册
    function signUp() {
        if (isApp()) {
            // todo 调用jsbridge，跳转原生注册页
        } else {
            // todo 跳转到wap 注册页
            window.location.href = '';
        }
    }
    // 跳转去优惠券列表页
    function gotoCouponList() {
        if (isApp()) {
            Jsbridge.exec('GoToView', function(result) {
                console.info('OnLineService----', result);
            }, {
                'methodName': 'ToMyCoupons'
            });
        } else {
            // todo 跳转到wap 优惠券页
            window.location.href = '';
        }
    }
    // 判断是否是app 
    function isApp() {
        return (/sulaidaiapp/i).test(navigator.userAgent.toLowerCase());
    }
    // 判断是否是微信
    function isWeiXin() {
        return (/micromessenger/i).test(navigator.userAgent.toLowerCase());
    }
    // 判断是否是ios
    function isIosPlatform() {
        if (navigator.userAgent.match(/(iPad|iPhone)/)) {
            return true;
        } else {
            return false;
        }
    }
    // 判断是否是android
    function isAndroidPlatform() {
        if (navigator.userAgent.match(/(Android)/)) {
            return true;
        } else {
            return false;
        }
    }
    // 禁止滑动
    function disableScroll() {
        $(".scroll").removeClass("scroll-active");
    }
    // 允许滑动
    function enableScroll() {
        $(".scroll").addClass("scroll-active");
    }
})();