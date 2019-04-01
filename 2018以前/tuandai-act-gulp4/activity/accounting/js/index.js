(function() {
    FastClick.attach(document.body);
    var advSwiper;
    var advData = {
        1: {
            title: '自动同步',
            text: '支持近百家热门网贷平台的投资数据录入，自动同步记账，轻松管理多处资产'
        },
        2: {
            title: '投资返利',
            text: '实时更新最新返利活动，掌握第一手返利资讯，拿收益赚返利；'
        },
        3: {
            title: '理财社区',
            text: '跟大神学习网贷投资诀窍，分享自己的投资理财历程。'
        }

    }

    advSwiper = new Swiper("#advSwiper", {
        effect: 'coverflow',
        centeredSlides: true,
        slidesPerView: 'auto',
        //      autoplay: 2000,
        loop: true,
        speed: 300,
        coverflow: {
            rotate: 0,
            // //每个item间隔
            // //非active item 缩放比例
            stretch: 60,
            depth: 250,
            modifier: 1,
            slideShadows: false
        },
        onTransitionEnd: function(swiper) {
            var id = $('.swiper-slide-active').attr('data-id');
            var itemData = advData[id];
            $('.adv-title').html(itemData.title);
            $('.adv-detail').html(itemData.text);

        }
    });
    $('.adv-arrow').on('click', function() {
        if ($(this).hasClass('adv-prev')) {
            advSwiper.slidePrev();
        } else {
            advSwiper.slideNext();
        }
    })

    var actSwiper = new Swiper('#actSwiper', {
        pagination: '.swiper-pagination',
    });
    var investSwiper = new Swiper('#investSwiper', {
        pagination: '.swiper-pagination',
        spaceBetween: 5
    });

    //点击精选活动图片
    $('#actSwiper').on('click', '.act-img', function() {
        var id = $(this).attr('data-id'),
            url = $(this).attr('data-url');
        console.info(id, url);

    });
    //点击投资图片
    $('#investSwiper').on('click', '.invest-row', function() {
        var url = $(this).attr('data-url');
        if (url) {
            location.href = url;
        }
    });
    // $('#investSwiper').on('click', '.invest-button', function() {
    //     var id = $(this).attr('data-id');
    //     console.info(id);
    // });
    //跳转到关于我们
    $('.item-btns').on('click', '.about', function() {
        location.href = './aboutus.html';
    });
    //跳转到帮助中心
    $('.item-btns').on('click', '.help', function() {
        location.href = './helpercenter.html';
    });

    // 打开app
    // $('.footer').on('click', '#open_app', function(e) {
    //     var url = ''; // ios 跳转路径
    //     if(Util.isAndroidPlatform()) {
    //         url = 'http://api.qianxiaoer88.com/app/download';
    //     }
    //     window.location.href = url;
    // });
    Util.initFooter();
})();
