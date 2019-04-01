var AppId = "wx9140fc0a0b9db917";
var title = "团贷网高铁广告小游戏";
var desc = "脑洞全开之测你财“经”有多大？";
var linkurl = "http://m.tuandai.com/Activity/HighSpeedGame/GameIndex.aspx";
var imgurl = "http://m.tuandai.com/imgs/bav_head.gif";

wx.ready(function () {
    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
    //分享到朋友圈
    wx.onMenuShareTimeline({
        title: title,
        link: linkurl,
        imgUrl: imgurl,
        trigger: function (res) {
            //   alert('用户点击分享到朋友圈');
        },
        success: function (res) {
            alert('已分享');
        },
        cancel: function (res) {
            alert('已取消');
        },
        fail: function (res) {
            alert("失败:" + JSON.stringify(res));
        }
    });
    //分享给好友
    wx.onMenuShareAppMessage({
        title: title, // 分享标题
        desc: desc, // 分享描述
        link: linkurl, // 分享链接
        imgUrl: imgurl, // 分享图标
        type: 'link', // 分享类型,music、video或link，不填默认为link
        //dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
        success: function () {
            alert('已经分享!');
        },
        cancel: function () {
            // 用户取消分享后执行的回调函数
        }
    });
    //分享到QQ
    wx.onMenuShareQQ({
        title: title,
        desc: desc,
        link: linkurl,
        imgUrl: imgurl,
        trigger: function (res) {
            // alert('用户点击分享到QQ');
        },
        complete: function (res) {
            // alert(JSON.stringify(res));
        },
        success: function (res) {
            alert('已分享');
        },
        cancel: function (res) {
            alert('已取消');
        },
        fail: function (res) {
            // alert(JSON.stringify(res));
        }
    });
    //分享到微博
    wx.onMenuShareWeibo({
        title: title,
        desc: desc,
        link: linkurl,
        imgUrl: imgurl,
        trigger: function (res) {
            //alert('用户点击分享到微博');
        },
        complete: function (res) {
            // alert(JSON.stringify(res));
        },
        success: function (res) {
            alert('已分享');
        },
        cancel: function (res) {
            alert('已取消');
        },
        fail: function (res) {
            // alert(JSON.stringify(res));
        }
    });
});

wx.error(function (res) {
   // alert("授权错误:" + res);
});


document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
    // 发送给好友
    WeixinJSBridge.on('menu:share:appmessage', function (argv) {
        WeixinJSBridge.invoke('sendAppMessage', {
            "appid": AppId,
            "img_url": imgurl,
            "img_width": "160",
            "img_height": "160",
            "link": linkurl,
            "desc": desc,
            "title": title
        }, function (res) {
            _report('send_msg', res.err_msg);
        })
    });

    // 分享到朋友圈
    WeixinJSBridge.on('menu:share:timeline', function (argv) {
        WeixinJSBridge.invoke('shareTimeline', {
            "img_url": imgurl,
            "img_width": "160",
            "img_height": "160",
            "link": linkurl,
            "desc": desc,
            "title": title
        }, function (res) {
            _report('timeline', res.err_msg);
        });
    });
    //分享到腾讯微博
    WeixinJSBridge.on('menu:share:weibo', function (argv) {
        WeixinJSBridge.invoke("shareWeibo", {
            "content": desc,
            "url": linkurl
        }, function (res) {
            _report("weibo", res.err_msg);
        });
    });
}, false);
 