(function() {
    FastClick.attach(document.body);

    var $body = $('body');

    var rem = (20 * ($(window).width() / 320)),
        stretch_rem = 480 / 23.4375 / 2 * rem,
        depth_rem = 430 / 23.4375 / 2 * rem;

    swiper2 = new Swiper("#treasureSwiper", {
        effect: 'coverflow',
        centeredSlides: true,
        slidesPerView: 'auto',
        //autoplay: 2000,
        loop: true,
        speed: 300,
        coverflow: {
            rotate: 0,
            stretch: stretch_rem,
            depth: depth_rem,
            modifier: 1,
            slideShadows: false
        },
        onTransitionEnd:function(swiper){
            var ind = swiper.realIndex + 1;
            showPrize(ind);
        },
        nextButton: '.swiper-button-prev',
        prevButton: '.swiper-button-next'
    })

    function showPrize(index){
        $(".prize-wrap").hide();
        $(".prize-wrap").eq(index-1).show();
    }


    var str= navigator.userAgent.toLowerCase();
    var ver=str.match(/cpu iphone os (.*?) like mac os/);
    if(!ver){
        $('.index-wrap').addClass('scroll scroll-active');
    }else{
        if(parseInt(ver[1])>=11){
            $('.index-wrap').addClass('scroll-ios11');
        }else{
            $('.index-wrap').addClass('scroll scroll-active');
        }
    }


    // π能明细
    $body.on('click', '#painengMx', function () {
        location.href = "./myRecord.html";
    })

    // 规则
    $body.on('click', '#toRule', function () {
        location.href = "./rule.html";
    })

    $body.on('click', '#toMore', function () {
        $('#makeMore').removeClass('hide');
        Util.disableScroll();
    })
    $body.on('click', '#makeMoreClose', function () {
        $('#makeMore').addClass('hide');
        Util.enableScroll();
    })


    // 显示第一次弹窗

    function showFirstMask(){
        $('#firstMask').removeClass('hide');
        Util.disableScroll();
    }
    // showFirstMask()

    $body.on('click', '#closeFirstMask', function () {
        $('#firstMask').addClass('hide');
        Util.enableScroll();
    })



    function weixinMask(){
        $("#shareMask").show();
        Util.disableScroll();
    }
    // weixinMask()

    $body.on('click', '#shareMasker', function () {
        $("#shareMask").hide();
        Util.enableScroll();
    })



    // 中奖弹窗
    /*
    Util.popup({
        "conClassName": "lottery",
        "title": "恭喜你获得",
        "icon": "iphone-x",
        "iconTxt": "iphone-x",
        "btns": [ {
            "txt": "", //关闭按钮
            "cb": function () {
            }
        },{
            "txt": "分享攒人品",
            "cb": function () {
                window.location.href = "https://www.tuandai.com/app/install.aspx?tdsource=tdwleft";
            }
        }]
    });


    //普通弹窗
    Util.popup({
        "conClassName": "normal",
        "title": "确定消耗250π能抽奖？",
        "btns": [ {
            "txt": "", //关闭按钮
            "cb": function () {
            }
        },{
            "txt": "确定",
            "cb": function () {
            }
        }]
    });



    // 领取弹窗
    Util.popup({
        "conClassName": "draw",
        "icon": "paineng",
        "iconTxt": "50π能",
        "txt": "嗨，签到君记得你哟~<br/>奖励您在9月签到有礼活动中的杰出表现，<br/> 双手捧上小小心意~",
        "btns": [ {
            "txt": "", //关闭按钮
            "cb": function () {
            }
        },{
            "txt": "领  取",
            "cb": function () {
            }
        }]
    });
     */

})();