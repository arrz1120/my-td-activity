(function() {
    FastClick.attach(document.body);
	    //do your thing.
    var _body = $('body');

    _body.on('click', '.close-top', function () {
        $(this).parent(".top-con").hide();
    });

    // 倒计时
    // window.jQuery(function ($) {
    //     "use strict";
    //     $('.countdown').countDown({
    //         css_class: 'countdown-alt-1',
    //         with_labels: true,
    //         label_hh: '时',
    //         label_mm: '分',
    //         label_ss: '秒',
    //
    //     });
    // });
    //
    // $('.countdown').on('time.elapsed', function () {
    //     console.log('到时结束 todo..')
    // });

    var clock;
    clock = $('#invest_countdown').FlipClock({
        clockFace: 'HourlyCounter ',
        autoStart: false,
        countdown: true,
        callbacks: {
            stop: function() {
                console.log("倒计时完成")
            }
        }
    });

    clock.setTime(259200);
    clock.start();



    var clockFb;
    clockFb = $('#fanbei_countdown').FlipClock({
        clockFace: 'HourlyCounter ',
        autoStart: false,
        countdown: true,
        callbacks: {
            stop: function() {
                console.log("倒计时完成")
            }
        }
    });

    clockFb.setTime(259200);
    clockFb.start();

    // app分享配置
    var vtitle = '邀请你一起瓜分现金红包！';
    var vcontent =   '说“瓜分到的现金红包可以提现哦，名额有限，速来！”';
    var icoUrl = "/201804/20180425gfhb/weixin/images/shareLogo.jpg";
    var shareUrl =   "/201804/20180425gfhb/weixin/landing.aspx" ;

    appShare.set({
        icon: icoUrl,
        title: vtitle,
        content: vcontent,
        shareUrl: shareUrl,
        cover: {
            src: '../images/wxShare.png',
            style: {
                width: '12rem',
                display: 'block',
                margin: '0 0 0 1.5rem'
            }
        },
        callback: function () {}
    })

    // 去邀请
    _body.on('click', '#goInvite', function () {

        appShare.show()
    });


    _body.on('click', '.tips-fanbei', function () {
        aniShow("#tianjianMask")
    })

    _body.on('click', '#close_tianjianMask', function () {
        aniHide("#tianjianMask")
    })


    // tab切换
    _body.on('click', '.nav .box-flex1', function(e) {
        var currentTarget = $(e.currentTarget);
        if (currentTarget.hasClass('active')) {
            return;
        }
        _body.find('.nav .box-flex1').removeClass('active');
        currentTarget.addClass('active');
        if (currentTarget.hasClass('nav-gf')) {
            _body.find('.yq-list').removeClass('show');
            _body.find('.gf-list').addClass('show');

        } else if (currentTarget.hasClass('nav-yq')) {
            _body.find('.gf-list').removeClass('show');
            _body.find('.yq-list').addClass('show');
        }
    });

    $(".btn-log").on('click', function() {
        var type = $(this).attr('data-type');
        switch (parseInt(type)) {
            case 0:
                window.location.href = 'myFriend.html';
                break;
            case 1:
               window.location.href = 'commission.html';
                break;
            case 2:
               window.location.href = 'investRedpacket.html';
                break;
            case 3:
               window.location.href = 'cashRedpacket.html';
                break;
        }
    });

})();