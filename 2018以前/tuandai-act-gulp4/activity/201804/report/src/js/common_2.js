window.onload = function () {
    // FastClick
    FastClick.attach(document.body);

    var isChartRender = false;

    function isIphoneX(){
        return /iphone/gi.test(navigator.userAgent) && (screen.height == 812 && screen.width == 375)
    };

    if(isIphoneX()){
        $('.slide1-1 .wrp1').addClass('iPx');
        $('.inWrp').addClass('iPx');
    }

    // swiper

    function anClsName(swiper) {
        for (var i = 0; i < swiper.slides.length; i++) {
            if (i == swiper.activeIndex) {
                swiper.slides[i].classList.add('animate');
            } else {
                swiper.slides[i].classList.remove('animate');
            }
        }
    }

    function an1_2(swiper) {
        if (swiper.activeIndex == 1) {
            $('#swiper2 .slide2-0').addClass('animate');
        } else {
            $('#swiper2 .slide2-0').removeClass('animate');
        }
    }

    function an2_9(swiper) {
        if (swiper.activeIndex == 4) {
            $('#swiper3 .slide3-1').addClass('animate');
        } else {
            Swiper3.slideTo(0, 0);
            $('#swiper3 .slide3-1').removeClass('animate');
        }
    }

    function an2_11(swiper) {
        if (swiper.activeIndex == 6) {
            chart.draw();
            isChartRender = true;
        } else {
            if(isChartRender){
                chart.clear();
                isChartRender = false;
            }
        }
    }

    function an2_arr(swiper){
        if(swiper.isEnd){
            $('.slide1-2 .arr').fadeOut();
        }else{
            $('.slide1-2 .arr').fadeIn();
        }
    }

    function SwitchSlibar(index){
        $('.sli-nav .nav_item').eq(index).addClass('on').siblings().removeClass('on');
    }

    function SwitchItemTitle(index){
        $('#iTitNum').text(index + 1);
        switch (index+1){
            case 1:
                $('.slide1-2 .inwHd .tit').html("运营数据概览");
                $('#ttwrp').fadeIn();
                break;
            case 2:
                $('.slide1-2 .inwHd .tit').html("投资人数据");
                $('#ttwrp').fadeIn();
                break;
            case 3:
                $('.slide1-2 .inwHd .tit').html("运营大事记");
                $('#ttwrp').fadeIn();
                break;
            case 4:
                $('.slide1-2 .inwHd .tit').html("团贷大事记");
                $('#ttwrp').fadeIn();
                break;
            case 5:
                $('.slide1-2 .inwHd .tit').html("团粉互动");
                $('#ttwrp').fadeIn();
                break;
            case 6:
                $('#iTitNum').text(index);
                $('#ttwrp').fadeOut();
                break;
        }
    }

    function SwitchSwiper(index){
        if(Swiper2){
            Swiper2.slideTo(index);
        }
    }

    // items 切换
    function ItemSwitch(configs){
        var key = configs.key;
        var ranges = configs.ranges;
        var cache = {};

        var methods = {
            'sw2less': function(index){
                for(var i = 1; i<ranges.length; i++) {
                    if(index < ranges[i]){
                        return i-1;
                    }
                }
            },
            'sw2more': function(index){
                return ranges[index];
            }
        };
        this.listen = function(){ // listen(key, []);
            var key = Array.prototype.shift.apply(arguments);
            if(!cache[key]){
                cache[key] = [];
            }
            cache[key] = Array.prototype.concat.apply([], arguments);
        };
        this.execute = function(){ // execute(key, index);
            var key = Array.prototype.shift.apply(arguments);
            var index = Array.prototype.shift.apply(arguments);
            var itemIndex = methods[key](index);
            Array.prototype.unshift.call(arguments,itemIndex);
            var fns = cache[key];

            if(!fns || fns.length === 0){
                return false;
            }
            for(var i=0,fn;fn=fns[i++];){
                fn.apply(null, arguments);
            }
        };
    }


    var itemSwitch = new ItemSwitch({
        ranges: [0, 6-2, 10-2, 11-2,12-2, 14-2, 15-2],
    });
    itemSwitch.listen('sw2less', [SwitchSlibar, SwitchItemTitle]);
    itemSwitch.listen('sw2more', [SwitchSlibar, SwitchSwiper]);
    // 一屏一屏地滑动
    function Folder() {
        this.initalPosY = 0;
        this.lastPosY = 0;
    }

    Folder.prototype = {
        handleTouchStart: function (swiper, ev) {
            this.initialPosY = event.targetTouches[0].clientY;
        },
        handleTouchMove: function (swiper, ev) {
            this.lastPosY = event.targetTouches[0].clientY;
            var gap = this.lastPosY - this.initialPosY;
            if (swiper.activeIndex != 1) return;
            if (gap > 0) { // 下拉
                if (Swiper2 && Swiper2.isBeginning) {
                    swiper.unlockSwipeToPrev();
                } else {
                    swiper.lockSwipeToPrev();
                }
            } else if (gap < 0) { // 上拉
                if (Swiper2 && Swiper2.isEnd) {
                    swiper.unlockSwipeToNext();
                } else {
                    swiper.lockSwipeToNext();
                }
            }
        },
        handleTouchEnd: function (swiper, ev) {
            swiper.unlockSwipeToNext();
            swiper.unlockSwipeToPrev();
            swiper.update();
        }

    };
    var floder = new Folder();

    Pulisher.listen('anClsName', anClsName);
    Pulisher.listen('animate1', an1_2);

    Pulisher.listen('animate2', an2_9);
    Pulisher.listen('animate2', an2_11);
    Pulisher.listen('onSlideChangeStart', an2_arr);

    var Swiper1 = new Swiper('#swiper1', {
        direction: 'vertical',
        resistanceRatio: 0,
        onInit: function (swiper) {
            Pulisher.trigger('anClsName', swiper);
        },
        onReachBeginning: function(swiper){
            Pulisher.trigger('anClsName', swiper);
        },
        onReachEnd: function(swiper){
            Pulisher.trigger('anClsName', swiper);
        },
        onSlideChangeEnd: function (swiper) {
            Pulisher.trigger('anClsName', swiper);
            Pulisher.trigger('animate1', swiper);
        },
        onTouchStart: function (swiper, event) {
            floder.handleTouchStart(swiper, event);
        },
        onTouchMove: function (swiper, event) {
            floder.handleTouchMove(swiper, event);
        },
        onTouchEnd: function (swiper, event) {
            floder.handleTouchEnd(swiper, event);
        }
    });
    var Swiper2 = new Swiper('#swiper2', {
        direction: 'vertical',
        touchReleaseOnEdges:true,
        noSwiping: true,
        onSlideChangeStart:function(swiper){
            Pulisher.trigger('onSlideChangeStart', swiper);
            itemSwitch.execute('sw2less', swiper.activeIndex);
        },
        onReachBeginning:function(swiper){
            Pulisher.trigger('anClsName', swiper);
        },
        onTransitionEnd:function (swiper) {
            Pulisher.trigger('anClsName', swiper);
            Pulisher.trigger('animate2', swiper);
        },
        onSlideChangeEnd: function (swiper) {
            Pulisher.trigger('anClsName', swiper);
            Pulisher.trigger('animate2', swiper);
        },
        onReachEnd: function (swiper) {
            Pulisher.trigger('anClsName', swiper);
            Pulisher.trigger('animate2', swiper);
        }
    });
    var Swiper3 = new Swiper('#swiper3', {
        spaceBetween: 5,
        prevButton: '.nav_item_prev',
        nextButton: '.nav_item_next',
        onSlideChangeEnd: function (swiper) {
            Pulisher.trigger('anClsName', swiper);
            // 更改标题
            if(swiper.activeIndex == 0){
                $('.slide2-9 .dtxt.tit').text('3月份不同地域投资人数分布');
            }else{
                $('.slide2-9 .dtxt.tit').text('3月份不同地域投资金额分布');
            }
        }
    });




    // swiper4
    var Swiper4 = new Swiper('#swiper4', {
        direction: 'vertical',
        slidesPerView: 'auto',
        freeMode: true,
        nested: true,
        scrollbar:'.swiper-scrollbar'
    });




// Swiper1.slideTo(1);

// Swiper2.slideTo(9);


    // circle data
    var canvas = document.getElementById('circular'),
        ctx = canvas.getContext('2d');
    // correct W/H
    function correctPx(num){
        var rem = num / 23.4375 / 2;
        var bfs = document.documentElement.style.fontSize.match(/(^\d+)/)[0];

        return Math.floor(rem * bfs);
    }

    ctx.canvas.width = correctPx(ctx.canvas.width);
    ctx.canvas.height = correctPx(ctx.canvas.height);

    var chart = new TDChart(ctx).Ring({
        label: ['3.38%', '28.88%', '33.10%', '34.64%' ],
        datasets: [
            {
                lineColor: '#c4e24d',
                percent: 0.0338,
            },
            {
                lineColor: '#23995b',
                percent: 0.2888,
            },
            {
                lineColor: '#75ca59',
                percent: 0.3310,
            },
            {
                lineColor: '#f9d87f',
                percent: 0.3464,
            }
        ]
    },{
        animateScale: false,
        animationEasing: 'easeOutBounce',
        animationSteps: 60,

        lineWidth: 7,
        dataDnmtor: (2*Math.PI),
        dataBorder: true,
        lableXpos: 7,
        scaleFontSize: 12,
        scaleFontColor: '#343434',
        scaleLineBgColor: '#f3f3f3'
    });

    // 初始化侧边栏
    var slidebar = new SlideBar('.sli-bar');

    // 显示侧边栏
    $('.btn.slibar').click(function () {
        slidebar.show();
    });

    // 定位数据板块
    $('.sli-nav .nav_item').click(function () {
        slidebar._close();
        itemSwitch.execute('sw2more', $(this).index());
    });

    // 返回首页
    $('#backIndex').click(function () {
        Swiper1.slideTo(0);
        Swiper2.slideTo(0, 0);
        // reset
        $('#swiper2 .slide2-1').removeClass('animate');
        $('#swiper3 .slide3-1').removeClass('animate');
    });

    // 二维码
    $('.slide2-18 .wx_item').click(function (ev) {
        $('.qrcode-modal').removeClass('hide');
        switch ($(this).index()){
            case 0:
                $('.qrcode-modal-img .w1').removeClass('hide').siblings().addClass('hide');
                $('.qrcode-modal-qrname').html("团贷网订阅号(dgtuandaiwang)");
                $('.qrcode-modal-ul .item').eq(0).html("长按并复制微信号查找添加");
                $('.qrcode-modal-ul .item').eq(1).html("或截屏后在微信端打开识别二维码");
                break;
            case 1:
                $('.qrcode-modal-img .w2').removeClass('hide').siblings().addClass('hide');
                $('.qrcode-modal-qrname').html("团贷网微服务(dgtuandaiservice)");
                $('.qrcode-modal-ul .item').eq(0).html("长按并复制微信号查找添加");
                $('.qrcode-modal-ul .item').eq(1).html("或截屏后在微信端打开识别二维码");
                break;
            case 2:
                $('.qrcode-modal-img .w3').removeClass('hide').siblings().addClass('hide');
                $('.qrcode-modal-qrname').html("新浪微博@团贷网官博");
                $('.qrcode-modal-ul .item').eq(0).html("在新浪微博搜索“团贷网官博”添加关注");
                $('.qrcode-modal-ul .item').eq(1).html("或截屏后在微信端打开识别二维码");
                break;
        }
    });
    $('.qrcode-modal-close').click(function (ev) {
        $('.qrcode-modal').addClass('hide');
    });
};





