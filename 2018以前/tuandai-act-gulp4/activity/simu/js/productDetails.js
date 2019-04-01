(function() {
    FastClick.attach(document.body);

    var $body = $('body');

    // 事件绑定
    function bindEvent() {

        Util.execIsAuth()
        // tab切换
        $body.on('click', '.tab-nav .btn', function(e) {
            var currentTarget = $(e.currentTarget);
            if (currentTarget.hasClass('cur')) {
                return;
            }
            $body.find('.tab-nav .btn').removeClass('cur');
            currentTarget.addClass('cur');
            if (currentTarget.hasClass('btn-info')) {
                $body.find('.zt-main').removeClass('show');
                $body.find('.info-main').addClass('show');

            } else if (currentTarget.hasClass('btn-zt')) {
                $body.find('.info-main').removeClass('show');
                $body.find('.zt-main').addClass('show');
            }
        });

        //关闭立即认证弹窗
        $body.on('click', '.clase-mask-renzheng', function () {
            $(".mask-renzheng").hide();
        })


        // 电话咨询
        $body.on('click', '#callBtn', function () {
            Util.popup({
                'msg': '400-641-0888'
            });
        })

        // 在线预约
        $body.on('click', '#yuyueBtn', function () {
            $("#yuyueMask").show();
        })

        $body.on('click', '#quxiaoBtn', function () {
            $("#yuyueMask").hide();
        })

        $body.on('click', '.j-more', function ()  {
            var jsTxt = $(this).parent(".jieshao");
            if (jsTxt.hasClass('p-ellipsis')) {
                $(jsTxt).removeClass('p-ellipsis').addClass('open');
                $(this).addClass('j-more-cur');
            } else {
                $(jsTxt).removeClass('open');
                $(this).removeClass('j-more-cur');
                setTimeout(function() {
                    $(jsTxt).addClass('p-ellipsis');
                }, 400);
            }
        });

    }

    function toAuth() {
        $(".toAuth").click(function(){
            window.location.href= "identity.html";
        })
    }

    function init() {
        bindEvent();
        toAuth()
    }
    init();
})();