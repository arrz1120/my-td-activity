(function() {
    FastClick.attach(document.body);
    // 初始化footer
    Util.initFooter('footer');
    var _is = $('.swiper-slide').length - 1;
        _per = _is >= 5 ? 6 : _is + 1;
        _cw = Util.pxTopx(125 * _is + 220),
        _translate = Util.pxTopx(_is >= 5 ? -45 : - 10 * _is);
        $('.swiper-container').width(_cw);
        $('.swiper-container').css({
            'width': _cw +'px',
            '-webkit-transform': 'translate(' + _translate + 'px, 0)',
            'transform': 'translate(' + _translate + 'px, 0)'
        })
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: _per,
        initialSlide: _is,
        centeredSlides: true,
        paginationClickable: true,
        onSlideChangeEnd: function(swiper) {
            var money = swiper.slides.eq(swiper.activeIndex).html();
            selectMoney(money);
        }
    });

    // 事件绑定
    $('.borrow-content').on('click', '#ser_charge_q', function(e) {
        showServieCharge(e);
    });

    // 选择借款期限
    $('.borrow-content').on('click', '#btn_select .btn', function (e) {
        var $target = $(e.currentTarget)
        var _value = $target.attr('data-value');
        $('#btn_select .btn').removeClass('active');
        $target.addClass('active');
        console.log(_value);
    })

    // 打开喔的优惠券
    $('.borrow-content').on('click', '#show_coupon', function(e) {
        showCoupon(e);
    })
    // 选择优惠券
    $('#list_coupon').on('click', 'li', function(e) {
        selectCoupon(e);
    });

    // 不使用优惠券
    $('.coupon-content').on('click', '.not-use', function(e) {
        cancelCoupon(e);
    });

    // 关闭优惠券窗口
    $('.pop-coupon').on('click', '#close_coupon', function(e) {
        hideCoupon(e);

    });

    // 我要借按钮
    $('.borrow-content').on('click', '#btn_borrow', function(e) {
        borrow(e);
    });


    // 具体事件实现
    function selectMoney(money) {
        // todo 通过money 计算实际到账的数额
        $('#money_real').html(money);
    }

    function showServieCharge(e) {
        // todo ajax 获取服务费用说明
        var _content = '借款利息及服务费合计日费率为：<font class="font-yellow">0.5%~0.1%</font>，根据当前信用评级而定，该费用由团贷网借款在放款时一次性扣除。';
        Util.popup({
            'title': '服务费说明',
            'content': _content,
            'btns': [{
                'name': '确定',
                'cb': function() {
                    console.log('submit')
                }
            }]
        });
    }

    function showCoupon(e) {
        // todo ajax 获取优惠券列表 
        var el = $('#test');
        $('#list_coupon').children(':first').before(el);
        var _last = $('#last');
        $('#list_coupon').children(':last').after(_last);

        $('.pop-coupon').show();
    }

    function hideCoupon(e) {
        $('.pop-coupon').hide();
    }

    function selectCoupon(e) {
        var $coupon = $(e.currentTarget).find('.coupon');
        if ($coupon.hasClass('disabled') || $coupon.hasClass('lapsed')) {
            return;
        }
        $('.coupon').removeClass('selected');
        $('.not-use').removeClass('selected');
        $coupon.addClass('selected');
        // todo 记录选中优惠券信息
        var coupon_id = $coupon.attr('data-id'),
            money = $coupon.attr('data-value');
        $('#coupon_value').html('¥' + money);
        hideCoupon();
    }

    function cancelCoupon(e) {
        $('.coupon').removeClass('selected');
        // todo 去掉选中优惠券信息
    }

    function borrow(e) {
        // 判断认证状态 如果认证成功，那跳去确认借款详情
        // 否则跳去信用认证页面
        window.location.href = '../approve/index.html';
    }

})();