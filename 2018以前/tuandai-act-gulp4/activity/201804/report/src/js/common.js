// slide bar
(function (window, document, Math) {

    var rAf = window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.msRequestAnimationFrame ||
            window.osRequestAnimationFrame ||
            window.requestAnimationFrame ||
            function(callback){ return window.setTimeout(callback, 1000/60)};

    var utils = (function () {
        var me = {};

        var _elementStyle = document.createElement('div').style;

        var _vendor = (function () {
            var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
                transform,
                i = 0,
                l = vendors.length;

            for (; i < l; i++) {
                transform = vendors[i] + 'ransform';
                if (transform in _elementStyle) return vendors[i].substr(0, vendors[i].length - 1);
            }

            return false;
        })();

        function _prefixStyle(style) {
            if (_vendor === false) return false;
            if (_vendor === '') return style;
            return _vendor + style.charAt(0).toUpperCase() + style.substr(1);
        }

        me.extend = function (target, obj) {
            for (var i in obj) {
                target[i] = obj[i];
            }
        }

        me.extend(me.style = {}, {
            transition: _prefixStyle('transition'),
            transform: _prefixStyle('transform'),
            transitionTimingFunction: _prefixStyle('transitionTimingFunction'),
            transitionDuration: _prefixStyle('transitionDuration'),
            transitionDelay: _prefixStyle('transitionDelay'),
            transformOrigin: _prefixStyle('transformOrigin'),
            touchAction: _prefixStyle('touchAction')
        });

        return me;
    })();

    // slide-bar
    var SlideBar = function (el, option) {
        // statue
        this.STATE_DEFAULT = 1,
        this.STATE_LEFT_SIDE = 2,
        this.STATE_RIGHT_SIDE = 3;

        // dom
        this.slideBar = typeof el == 'string' ? document.querySelector(el) : el;
        this.mask = this.slideBar.children[0];
        this.nav = this.slideBar.children[1];
        this.close = this.slideBar.querySelector('.back');

        // animate options
        this.isInTransition = false;
        this.initialTouchesPos = null;
        this.lastTouchesPos = null;
        this.moveTouchesPos = null;
        this.currentXPisition = 0;
        this.currentState = this.STATE_DEFAULT;
        this.handleSize = 10;

        this.itemWidth = this.nav.clientWidth;
        this.slopValue = this.itemWidth * (1/3);

        // new 时初始化..
        this._init();
    };

    SlideBar.prototype = {
        // animate
        update: function(){
            this.itemWidth = this.nav.clientWidth;
            this.slopValue = this.itemWidth * (1/3);
        },
        handleTouchStart: function(evt){
            //evt.preventDefault();
            // add event
            this.slideBar.addEventListener('touchmove', this, true);
            this.slideBar.addEventListener('touchend', this, true);
            this.slideBar.addEventListener('touchcancel', this, true);
            // get initialPos && init style
            this.initialTouchesPos = this.getGesturePointFromEvent(evt);
            this.nav.style[utils.style.transition] = 'initial';
            this.mask.style[utils.style.transition] = 'initial';
        },
        handleTouchMove: function(evt){

            evt.preventDefault();
            this.moveTouchesPos = this.getGesturePointFromEvent(evt);

            // translate
            var onFrameMove = this.onFrameMove();  // deal this
            rAf(onFrameMove);

        },
        handleTouchEnd: function(evt){
            //evt.preventDefault();
            this.lastTouchesPos = this.getGesturePointFromEvent(evt);
            // remove event
            this.slideBar.removeEventListener('touchmove', this, true);
            this.slideBar.removeEventListener('touchend', this, true);
            this.slideBar.removeEventListener('touchcancel', this, true);

            // update pos
            this.updatePosition();
        },
        getGesturePointFromEvent: function(evt){
            var point = {};
            if(evt.targetTouches){
                point.x = evt.changedTouches[0].clientX;
                point.y = evt.changedTouches[0].clientY;
            }else{
                point.x = evt.clientX;
                point.y = evt.clientY;
            }
            return point;
        },
        updatePosition: function(){
            var differenceInx = this.lastTouchesPos.x - this.initialTouchesPos.x;
            this.currentXPisition = this.currentXPisition + differenceInx;
            var transition = utils.style.transition;
            var transform = utils.style.transform;

            if(Math.abs(differenceInx) == 0) return;

            if(this.currentState === this.STATE_DEFAULT){
                if(differenceInx < 0 && Math.abs(differenceInx) > this.slopValue){
                    this.nav.style[transform] = 'translateX(-100%) translateZ(1px)'
                    this.nav.style[transition] = 'all 150ms ease-out';
                    this.currentState = this.STATE_LEFT_SIDE;
                    this.currentXPisition = -this.itemWidth;
                    this.mask.style.opacity = 0.8;

                }else{
                    this.nav.style[transform] = 'translateX(0) translateZ(1px)'
                    this.nav.style[transition] = 'all 150ms ease-out';
                    this.currentXPisition = 0;
                    this.mask.style.opacity = 0;
                }
            }else{

                if(differenceInx > 0 && Math.abs(differenceInx) > this.slopValue){
                    this.nav.style[transform] = 'translateX(0) translateZ(1px)'
                    this.nav.style[transition] = 'all 150ms ease-out';
                    this.currentXPisition = 0;
                    this.currentState = this.STATE_DEFAULT;
                    this.mask.style.opacity = 0;
                }else{
                    this.nav.style[transform] = 'translateX(-100%) translateZ(1px)'
                    this.nav.style[transition] = 'all 150ms ease-out';
                    this.currentXPisition = -this.itemWidth;
                    this.mask.style.opacity = 0.8;
                }
            }
            this.isInTransition = true;
        },
        onFrameMove: function(){
            var self = this;
            var transform = utils.style.transform;
            // after slibar moved...
            return function(){
                if(self.isInTransition) return;
                var differenceInx = self.moveTouchesPos.x - self.initialTouchesPos.x;
                var newTramsformX = self.currentXPisition + differenceInx;
                var opacity = (self.itemWidth - Math.abs(differenceInx)) / self.itemWidth * 0.8;
                // 0 ~ itemWidth
                if(newTramsformX < -self.itemWidth){
                    newTramsformX = -self.itemWidth;
                    opacity = 0.8;
                }
                if(newTramsformX > 0){
                    newTramsformX = 0;
                    opacity = 0;
                }


                self.mask.style.opacity = opacity;

                var transformStyle = 'translateX(' + newTramsformX + 'px) translateZ(1px)';
                self.nav.style[transform] = transformStyle;
            }

        },
        // init
        _init: function () {

            // this.slideBar.style.display = 'none';
            this._initEvents();
        },

        // show
        show: function () {
            var transform = utils.style.transform,
                duration = utils.style.transitionDuration,
                transition = utils.style.transition;

            // display
            // this.slideBar.style.display = 'block';
            this.slideBar.style.visibility = 'visible';
            // this.slideBar.offsetHeight;
            this.update();
            // transition
            this.nav.style[transform] = 'translate(-100%)';
            this.nav.style[transition] = 'all 150ms ease-out';
            this.currentXPisition = -this.itemWidth;
            this.isInTransition = true;
            this.currentState = this.STATE_LEFT_SIDE;

            this.mask.style.opacity = '0.8';
            this.mask.style[transition] = 'all 150ms ease-out';
        },

        // close
        _close: function (e) {
            var transform = utils.style.transform,
                duration = utils.style.transitionDuration,
                transition = utils.style.transition;

            // transition
            this.nav.style[transform] = 'translate(0)';
            this.nav.style[transition] = 'all 150ms ease-out';
            this.currentXPisition = 0;
            this.isInTransition = true;

            this.mask.style.opacity = '0';
        },

        // hide
        _hide: function (e) {
            if (this.currentXPisition == 0) {
                // this.slideBar.style.display = 'none';
                this.slideBar.style.visibility = 'hidden';
            }
        },

        // initEvents
        _initEvents: function () {
            this.mask.addEventListener('click', this, false);
            this.close.addEventListener('click', this, false);
            this.slideBar.addEventListener('touchstart', this, false);
            this.nav.addEventListener('webkitTransitionEnd', this, false);
            this.nav.addEventListener('transitionend', this, false);
        },

        // handleEvent
        handleEvent: function (e) {
            switch (e.type) {
                case 'click':
                    this._close(e);
                    break;
                case 'transitionend':
                case 'webkitTransitionEnd':
                    this.isInTransition = false;

                    this._hide(e);
                    break;
                case 'touchstart':
                    this.handleTouchStart(e);
                    break;
                case 'touchmove':
                    this.handleTouchMove(e);
                    break;
                case 'touchend':
                    this.handleTouchEnd(e);
                    break;
            }
        }
    };

    window.SlideBar = SlideBar;

})(window, document, Math);

// publisher
(function (window, document, Math) {
    var Pulisher = {
        cache: {},
        listen: function (key, fn) {
            if (!this.cache[key]) {
                this.cache[key] = [];
            }
            this.cache[key].push(fn);
        },
        trigger: function () {
            var key = Array.prototype.shift.call(arguments),
                fns = this.cache[key];
            if (!fns || fns.length === 0) {
                return false;
            }
            ;
            for (var i = 0, fn; fn = fns[i++];) {
                fn.apply(null, arguments);
            }
        }
    };
    window.Pulisher = Pulisher;
})(window, document, Math);

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
                $('.slide2-9 .dtxt.tit').text('2月份不同地域投资人数分布');
            }else{
                $('.slide2-9 .dtxt.tit').text('2月份不同地域投资金额分布');
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
                lineColor: '#fff844',
                percent: 0.0338,
            },
            {
                lineColor: '#f5ca49',
                percent: 0.2888,
            },
            {
                lineColor: '#f18b23',
                percent: 0.3310,
            },
            {
                lineColor: '#f8633e',
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
        dataBorderColor: '#642316',
        lableXpos: 7,
        scaleFontSize: 12,
        scaleFontColor: '#642316',
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




