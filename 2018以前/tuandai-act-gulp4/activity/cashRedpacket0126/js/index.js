(function() {
    FastClick.attach(document.body);

    var _body  = $('body');


    // 未登入
    _body.on('click', '#btnOpen', function () {
        aniShow("#loginMask")
    })

    _body.on('click', '#clsoe_login', function () {
        aniHide("#loginMask")
    })


    function weixinMask(){
        $("#shareMask").show();
        Util.disableScroll();
    }
    // weixinMask()

    _body.on('click', '#shareMasker', function () {
        $("#shareMask").hide();
        Util.enableScroll();
    })

    // 中得列表滚动
    setInterval(listScroll, 3000);
    function listScroll(obj) {
        $(".scroll-list").find("ul:first").animate({
            marginTop: "-0.96rem"
        }, 500, function() {
            $(this).css({
                marginTop: "0"
            }).find("li:first").appendTo(this);
        });
    }


})();