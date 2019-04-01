(function(){

    var ActivityWebsiteUrl ='https://at.tuandai.com';
    var vtitle ="";
    var vcontent ="";
    var icoUrl = ActivityWebsiteUrl +"/weixin/20170315tiancheng/images/share.png";
    var shareUrl = ActivityWebsiteUrl +"/weixin/20170315tiancheng/index.aspx";

    function indexFn(){}

    indexFn.prototype = {
        //初始化调用
        init : function(){
            this.preload();
            this.callSlide();
            this.rankScrollLeft();
            this.questionSelect();
            this.spreadGift();
            this.rankTab();
            this.share();
        },
        //图片预加载
        preload : function(){
            [
                './images/index/bg_con_open.png',
                './images/index/giftSmall/youku.png',
                './images/index/giftSmall/supermember.png',
                './images/index/giftSmall/signcard.png',
                './images/index/giftSmall/tb.png',
                './images/index/bg_gift.png',
                './images/index/bg_mask.png'
            ].forEach(function(item) {
                var img = new Image();
                img.src = item;
            })
        },
        //分享调用
        share:function(){

            $(".shareBtn").on('click',function(){
                appShare.set({
                    icon:icoUrl,
                    title:vtitle,
                    content:vcontent,
                    shareUrl:shareUrl,
                    cover:{
                        src:'./images/index/wxShare.png',
                        style:{
                            width:'100%',
                        }
                    },
                    custom:[{
                        key:5,
                        val:"朋友圈",
                        title: vtitle
                    }],
                    callback:function(){}
                })
            })

            //WeiXinShare( shareUrl + "?tdshare=wxshare",vtitle,vcontent, icoUrl,function(){});
        },
        //滚动调用
        callSlide:function(){
            var awardScroll=new Comment('.award-list',{
                showSlides:1
            });
            var prizeSwiper = new Swiper ('.prize-swiper', {
                loop: true,
                pagination: '.prize-pagination',
                nextButton: '.prize-next',
                prevButton: '.prize-prev',
                lazyLoading : true,
                autoplay:3000
            })
            var lessonSwiper = new Swiper ('.lesson-swiper', {
                loop: true,
                pagination: '.lesson-pagination',
                autoplay:3000
            })
        },
        //展开收起奖品
        spreadGift : function(){
            $(".gift-tab").on("click",function(){
                var dom =  $("#giftHide");
                if(dom.css("display") == "none"){
                    $("#giftHide").show();
                    $("#content").addClass("con-open");
                    $(this).find("p").html("收起");
                    $(this).find("i").css({
                        "-webkit-transform":"rotateZ(180deg)",
                        "transform":"rotateZ(180deg)"
                    })
                }else{
                    $("#giftHide").hide();
                    $("#content").removeClass("con-open");
                    $(this).find("p").html("查看全部奖品");
                    $(this).find("i").css({
                        "-webkit-transform":"rotateZ(0)",
                        "transform":"rotateZ(0)"
                    })
                }
            })
        },
         //初始化学分排行版滚动
        rankScrollLeft:function(){
            new Comment('.rank-scroll-l',{
                showSlides:5,
                delay:3000
            });
        },
        //初始化投资排行版滚动
        rankScrollRight:function(){
            new Comment('.rank-scroll-r',{
                showSlides:5,
                delay:3000
            });
        },
        //牌行榜切换
        rankTab : function(){
            var _this = this;
            $(".tab-item").on("click",function(){
                var idx = $(this).index();
                $(this).siblings().removeClass("tab-cur");
                $(this).addClass("tab-cur");
                $(".list-item").addClass("d-hide");
                $(".list-item").eq(idx).removeClass("d-hide");
            })
            $(".tab-left").on("click",function(){
                _this.rankScrollLeft();
            })
            $(".tab-right").on("click",function(){
                _this.rankScrollRight();
            })
        },
        //移除问题对或者错的icon
        removeIcon: function(){
            if($(".ico-correct")){
                $(".ico-correct").remove();
            }
            if($(".ico-wrong")){
                $(".ico-wrong").remove();
            }
        },

        //问题答案选择
        questionSelect:function(){
            var _this = this;
            var question = $(".question").find("li");
            question.on("click",function(){
                //_this.removeIcon();
                $("#errorTips").hide();
                $(this).siblings().removeClass("checked");
                $(this).addClass("checked");
            })
            $("#submit").on("click",function(){
                _this.removeIcon();
                //定义正确答案
                var answerIndex = 0;
                var $this = $(this);
                var choose = $(".question").find(".checked").index();
                if(choose == -1){
                    $("#errorTips").html("你还没有选择答案哦！").show();
                }else{
                    //答案正确
                    if(choose == answerIndex){
                        $(".question").find(".checked").append("<span class='ico-correct'></span>");
                        setTimeout(function(){
                            question.unbind();
                            $("#errorTips").html("恭喜答对，+10学分").fadeIn();
                            $this.hide();
                            $("#lottery").fadeIn();
                            _this.lottery();
                        },800);
                    //答案错误
                    }else{
                        $(".question").find(".checked").append("<span class='ico-wrong'></span>");
                        setTimeout(function(){
                            $("#errorTips").html("不是这个答案呢，再试一次吧~").fadeIn();
                        },800);
                    }
                }
            })
        },
        //抽奖
        lottery : function(){
            var _this = this;
            $("#lottery").on("click",function(){
                //定义查看奖品提示文案
                var tips = [
                    "请前往<span>【APP-我-我的会员-会员商城-我的商品】</span><br />查看并填写收货地址",
                    "请前往<span>【APP-我-我的会员-会员商城-我的商品】</span><br />查看",
                    "请前往<span>【APP-我-我的会员】</span>查看",
                    "请前往<span>【APP-我-团宝箱-签到卡】</span>查看",
                    "请前往<span>【APP-我-我的会员-我的团币】</span>查看",
                    "请前往<span>【APP-我-团宝箱-现金红包】</span>查看",
                    "请前往<span>【APP-我-团宝箱-投资红包】</span>查看"
                ];
                //定义奖品信息
                var giftInfo = {
                    name:"iPhone X",
                    src:"../images/index/gift/",
                    tips:""
                }
                switch (giftInfo.name) {
                    case "iPhone X":
                        giftInfo.src += "iphonex.png";
                        giftInfo.tips = tips[0];
                        break;
                    case "iPad 32G":
                        giftInfo.src  += "ipad.png";
                        giftInfo.tips = tips[0];
                        break;
                    case "苹果手表":
                        giftInfo.src += "iwatch.png";
                        giftInfo.tips = tips[0];
                        break;
                    case "优酷会员1个月":
                        giftInfo.src += "youku.png";
                        giftInfo.tips = tips[1];
                        break;
                    case "超级会员5天":
                        giftInfo.src += "supermember.png";
                        giftInfo.tips = tips[2];
                        break;
                    case "补签卡":
                        giftInfo.src += "signcard.png";
                        giftInfo.tips = tips[3];
                        break;
                    case "5团币 ":
                    case "10团币 ":
                    case "50团币 ":
                        giftInfo.src += "tb.png";
                        giftInfo.tips = tips[4];
                        break;
                    case "0.5元现金红包":
                        giftInfo.src += "hb.png";
                        giftInfo.tips = tips[5];
                        break;
                    case "5元投资红包":
                    case "10元投资红包":
                    case "15元投资红包":
                    case "20元投资红包 ":
                        giftInfo.src += "hb.png";
                        giftInfo.tips = tips[6];
                        break;
                    default:
                        break;
                }
                var img = new Image();
                img.src = giftInfo.src;
                img.onload = function(){
                    $(".sgift-p1").html('恭喜您答题抽奖获得'+ giftInfo.name);
                    $("#resultGift").html('<img src="'+ giftInfo.src +'">');
                    $(".aq-box").hide();
                    $(".share-box").show();
                    mask.buildGiftMask({
                        score : '连续答题3天及以上，+20学分',
                        src : giftInfo.src,
                        gift : giftInfo.name,
                        tips:giftInfo.tips
                    });
                }
            })
        }
    }

    function maskFn(){}

    maskFn.prototype = {
        init : function(){
            this.closeMask();
            this.showBigPrize();
            this.baoming();
        },
        showBigPrize:function(){
            $("#showBigPrize").on('click',function(){
                $("#bigPrizeMask").show();
            })
        },
        //隐藏弹窗
        closeMask : function(){
            $('.mask-bg').on('click',function(){
                $(this).parent().hide();
            })
            $('.close').on('click',function(){
                $(this).parent().parent().parent().hide();
            })
        },
        //移除奖品弹窗
        removeMask:function(){
            $('.mask-bg').on('click',function(){
                $(this).parent().remove();
            })
            $('.close').on('click',function(){
                $(this).parent().parent().parent().remove();
            })
        },
        //创建奖品弹窗
        buildGiftMask:function(opt){
            var gift = '<div class="mask">'+
                        '<div class="mask-bg"></div>'+
                        '<div class="mask-con mask-gift">'+
                            '<div class="mask-gift">'+
                            '<p class="mask-p1">恭喜答对！</p>'+
                                '<p class="mask-p2">'+ opt.score +'</p>'+
                                '<div class="gift">'+
                                    '<img src="'+ opt.src +'" alt="">'+
                                '</div>'+
                                '<p class="mask-p3">恭喜您答题抽奖获得 ' + opt.gift + '<br>' + opt.tips + '</p>'+
                                '<div class="close"></div>'+
                            '</div>'+
                        '</div>'+
                    '</div>';
            $('body').append(gift);
            this.removeMask();
        },
        //我要报名
        baoming:function(){
            $("#baoming").on("click",function(){
                $("#maskBmSuccess").show();
            })
            $("#bmConfirm").on("click",function(){
                $("#maskBmSuccess").hide();
            })
        }
    }

    var index = new indexFn();
    var mask = new maskFn();

    index.init();
    mask.init();

})();