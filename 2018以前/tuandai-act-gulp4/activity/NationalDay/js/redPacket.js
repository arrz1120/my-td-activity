(function() {

    /* ==================弹出框==dialog================= */
    /*
     options : {
     icon: 图标,
     msg: 弹窗文字,
     tips: 提示文字,
     btns: [{
     name: 按钮名称
     cb: callback
     }] // 若按钮数组只有一个，那么是alert，按钮数组两个，
     }
     */

    /* 活动已结束
     Util.noLogin({
     "msg": "活动已经结束",
     "tips": "活动已结束，非常感谢您的关注！",
     'btns': [{
     'name': '我知道了',
     'cb': ""
     }, ]
     });
     */

    /* 活动尚未开始
     Util.noLogin({
     "msg": "活动尚未开始",
     'btns': [{
     'name': '我知道了',
     'cb': ""
     }, ]
     });

     */



    /* 提示信息类弹窗
    Util.msgDialog({
        "icon": "ku",
        "msg": "团币不足166",
        "tips": "好可惜哦，团币不够哦！</br>赚团币去吧！",
        'btns': [{
            'name': '我知道了',
            'cb': function() {
                  console.log('todo')
            }
        }, ]
    });
     */

    /* 没中奖弹窗
    Util.nowinDialog({
        "msg": "谢谢参与！离奖品</br>就差了那么一点点距离！",
        'btns': [{
            'name': '我知道了',
            'cb': function() {
                console.log('todo')
            }
        },{
            'name': '团币兑换机会',
            'cb': function() {
                console.log('todo')
            }
        } ]
    });
     */

    /* 第1次打开
    Util.winDialog({
        "icon": "tuanbi",
        "msg": "运气来了，谁也挡不住！",
        "tips": '恭喜您获得<span class="prize-name">100</span>团币！',
        'btns': [{
            'name': '再开一次',
            'cb': function() {
                console.log('todo')
            }
        }, ]
    });
    */

    /* 第2次打开
    Util.winDialog({
        "icon": "redpacket",
        "msg": "运气来了，谁也挡不住！",
        "tips": '恭喜您获得<span class="prize-name">8元投资红包</span>！',
        'btns': [{
            'name': '我知道了',
            'cb': function() {
                console.log('todo')
            }
        }, {
            'name': '团币兑换机会',
            'cb': function() {
                console.log('todo')
            }
        }]
    });
     */

    /* 机会已经用完
    Util.noLogin({
        "msg": "机会已用完",
        "tips": "邀好友完成首投，可使开红包</br>所获奖励翻倍哦！",
        'btns': [{
            'name': '立即邀请',
            'cb': function() {
                console.log('去邀请')
            }
        }, ]
    });
    */

    _body.on('click', '#openBtn', function () {
        Util.noLogin({
            "msg": "你还未登录",
            "tips": "请登录后再参与开红包活动~",
            'btns': [{
                'name': '登 录',
                'cb': function() {
                    console.log('去登录')
                }
            }, ]
        });
    })


    _body.on('click', '#myPrizeBtn', function () {
        Util.aniShow("#prizeMask")
    })
    _body.on('click', '#clsoe_prizeMask', function () {
        Util.aniHide("#prizeMask")
    })

    _body.on('click', '#fanbeiBtn_popup', function () {
        Util.aniHide("#prizeMask")
        Util.aniShow("#fanbeiMask")
    })

    _body.on('click', '#fanbeiBtn', function () {

        Util.aniShow("#fanbeiMask")
    })

    _body.on('click', '#clsoe_fanbeiMask', function () {
        Util.aniHide("#fanbeiMask")
    })

    _body.on('click', '#mijiBtn', function () {
        Util.aniShow("#mijiMask")
    })
    _body.on('click', '#clsoe_mijiMask', function () {
        Util.aniHide("#mijiMask")
    })

})();



