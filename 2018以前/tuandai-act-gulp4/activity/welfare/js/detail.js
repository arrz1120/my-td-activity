(function() {
    FastClick.attach(document.body);
    var bannerSwiper,
        $body = $('body'),
        $backBtn = $("#back_btn"),
        $content = $("#content"),
        $latestView = $("#latest_dev_con"),
        $latestPage = $latestView.find("ul"),
        $joinView = $("#join_con"),
        $joinPage = $joinView.find("ul"),
        latestScrollHeight = $latestPage.height(),//最新进展页面高度
        latestHeight = $latestView.height(), //最新进展可视区域高度
        joinScrollHeight = $joinPage.height(), //参与情况页面高度
        joinHeight = $joinView.height(), //参与情况可视区域高度
        joinLoaded = false, //参与情况是否加载完毕
        latestLoaded = false; //最新进展分页加载是否加载完毕
    
    // 隐藏app标题
    Jsbridge.appLifeHook(null, function() {
        Jsbridge.setTitleComponent({
            titleContent: '',
            rightbuttonVisible: false,
            rightbuttonContent: '',
            rightbuttonTyppe: 1,
            showTitleComponent: false
        });
    }, null, null, null);
    // 轮播图
    var initSwiper = function() {
      bannerSwiper = new Swiper('.swiper-container', {
        autoplay: 3000, //可选选项，自动滑动
        slidesPerView: 'auto',
        spaceBeteewn: 0,
        // centeredSlides: true,
        autoplayDisableOnInteraction: false,
        pagination: '.swiper-pagination',
        loop: true
          /*,
                  onInit: function(swiper) {

                  },
                  onSlideChangeStart: function(swiper) {


                  },
                  onSlideChangeEnd: function(swiper) {

                  }*/

      });
    }
    // 事件绑定
    function bindEvent(){
        // 返回键
        $body.on('click', "#back_btn", function () {
            window.history.back();
        })
        // tab点击
        $body.on('click', '.tab-item', function () {
            var $this = $(this);
            var index = $this.attr('data-index');
            $this.addClass('act').siblings().removeClass('act');
            $('.welfare-con').eq(index-1).show().siblings().hide();
            if(index === "1"){
                bannerSwiper.onResize();
            }
        })
        // 公益详情底部按钮点击
        $body.on('click', '#bottom_btn li', function () {
            var $this = $(this);
            var index = +$this.attr('data-index');
            switch(index) {
                case 1: //分享
                    if(Jsbridge.isApp()){ //app内
                        Jsbridge.toAppActivity(1);
                    }else{ //app外
                        $("#share_con").show();
                    }
                    break;
                case 2: //点赞
                    $this.hasClass('on') ? $this.removeClass('on') && Utils.toast('取消点赞！') : $this.addClass('on') && Utils.toast('点赞成功！');
                    break;
                case 3: //关注
                    $this.hasClass('on') ? $this.removeClass('on') && Utils.toast('取消成功！') : $this.addClass('on') && Utils.toast('关注成功！')
                    break;
                // case 4: //敬请期待
                    
                //     break;
                case 5: //我要捐币
                    window.location = 'donateCoin.html'
                    break;
                case 6: //我要参加
                    //检查是否登陆
                    var isLogined = Utils.isLogined();
                    alert(isLogined);
                    if(!isLogined){
                        var returnUrl = document.location.href;
                        Utils.openLogin(returnUrl,false) ;
                    }else{
                        window.location = './join.html?projectId='+ 1111
                        break;
                    }
                    // window.location = 'join.html'
                    break;
                // case 7: //项目已完成
                    
                //     break;
            }
        })
        // 分享层点击
        $body.on('click', '#share_con', function () {
            $("#share_con").hide();
        })
        // 参与情况分页加载
        $joinView.scroll(function () {
            if (!joinLoaded) {
                //已经滚动到上面的页面高度
                var scrollTop = $joinView.scrollTop();
                //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作
                if (scrollTop + joinHeight >= joinScrollHeight - 5) {
                    //分页加载重新获取页面高度
                    joinScrollHeight = $joinPage.height();
                    console.log(1);
                    // var joinItems = '';
                    // joinItems +='<li class="join-item">' +
                    //             '<img class="user-head" src="../images/detail-head.png"/>'+
                    //             '<span class="join-txt">'+
                    //                 '<p class="user-name">夏木晓</p>'+
                    //                 '<p class="donate-date">2017-06-16 12:25</p>'+
                    //                 '<span class="donate-coin">捐赠 10000 团币</span>'+
                            
                    //                 '<span class="user-love"><i class="icon-love"></i>+20000</span>'+
                    //                 '<p class="user-msg">这样的公益活动，赠人玫瑰，手留余香。希望爱心继续传递。</p>'+
                    //             '</span>'+
                    //         '</li>';
                    // $joinPage.append(joinItems);
                }
            }
        })
        // 最新进展分页加载
        $latestView.scroll(function () {
            if(!latestLoaded){
                //已经滚动到上面的页面高度
                var scrollTop = $latestView.scrollTop();
                //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作, 浏览器偶尔有计算误差因此减5
                if (scrollTop + latestHeight >= latestScrollHeight - 5) {
                    //分页加载重新获取页面高度
                    latestScrollHeight = $latestPage.height();
                    console.log(2);
                }
            }
        })
    }

    function init() {
        // app内显示返回键
        if(Jsbridge.isApp()){
            $backBtn.show();
            //ios9以上app内tab加间距
            var iosVer = (navigator.userAgent).match(/OS (\d+)_(\d+)_?(\d+)?/);
            if (iosVer && parseInt(iosVer[1])>=8) { 
                var topHeight = 16;
                $("header").css('top', topHeight + 'px');
                $body.css('padding-top', topHeight + 'px');
            }
        }
        // 轮播图
        if($(".swiper-container li").length){
            initSwiper();
        }
        bindEvent();
    }
    init();
})();
