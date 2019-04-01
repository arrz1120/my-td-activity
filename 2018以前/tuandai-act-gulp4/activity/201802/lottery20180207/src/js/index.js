(function () {
    FastClick.attach(document.body);
    /*新手抽奖*/
    var  islotery = false;


    var lottery = {
        index: 0, //当前转动到哪个位置，起点位置
        count: 0, //总共有多少个位置
        timer: 0, //setTimeout的ID，用clearTimeout清除
        speed: 20, //初始转动速度
        times: 0, //转动次数
        cycle: 20, //转动基本次数：即至少需要转动多少次再进入抽奖环节
        init: function (id) {

            if ($("#" + id).find(".lottery-unit").length > 0) {
                $lottery = $("#" + id);
                $units = $lottery.find(".lottery-unit");
                this.obj = $lottery;
                this.count = $units.length;
                $lottery.find(".lottery-unit-" + this.index).addClass("active");
            };
        },
        roll: function () {
            var index = this.index;
            var count = this.count;
            var lottery = this.obj;
            $(lottery).find(".lottery-unit-" + index).removeClass("active");
            index += 1;
            if (index > count - 1) {
                index = 0;
            };
            $(lottery).find(".lottery-unit-" + index).addClass("active");
            this.index = index;
            return false;
        },
        clear: function (index) {
            $(this.obj).find(".active").removeClass("active");
        },
        // stop: function(index) {
        // 	this.prize = index;
        // 	return false;
        // }
    };


    var   prize_alert = $('.prize_alert');

    function prize_alert_val(src,txt) {
        prize_alert.find('.prize_img').attr('src','images/'+src+'.png');
        prize_alert.find('.txt_2').html(txt);

    }

    function roll(src,txt) {
        lottery.times += 1;
        lottery.roll();
        console.log(src,txt);
        if (lottery.times > lottery.cycle + 10 && lottery.prize == lottery.index) {
            clearTimeout(lottery.timer);
            setTimeout(function () {
                /*抽中奖品显示*/

        prize_alert.find('.prize_img').attr('src','images/'+src+'.png');
        prize_alert.find('.txt_2').html(txt);

                prize_alert.show();

                //抽奖变量重置
                lottery.times = 0;
                lottery.index = 0;
                lottery.speed = 20;
                lottery.timer = 0;
                lottery.count = 8;
                //抽奖结束开关打开
                islotery =  false;

            }, 500);
            // click = false;
        } else {
            if (lottery.times < lottery.cycle) {
                lottery.speed -= 10;
            } else if (lottery.times == lottery.cycle) {
                // var index = Math.random() * (lottery.count) | 0;
                // lottery.prize = index;
            } else {
                if (lottery.times > lottery.cycle + 10 && ((lottery.prize == 0 && lottery.index == 7) || lottery.prize == lottery.index + 1)) {
                    lottery.speed += 110;
                } else {
                    lottery.speed += 20;
                }
            }
            if (lottery.speed < 40) {
                lottery.speed = 40;
            };
            //console.log(lottery.times+'^^^^^^'+lottery.speed+'^^^^^^^'+lottery.prize);
            lottery.timer = setTimeout(function () {
                roll(src,txt);
            }, lottery.speed);
        }
        return false;
    }



    //开始抽奖


    /**
     * 0:手气值
     * 1：爱奇艺
     * 2：手机话费
     * 3：kiddle
     * 4：小派礼包
     * 5:京东卡
     * 6：红包
     * 7:888现金红包
     * **/


    $('.start_btn').on('click', function () {
        if(!islotery){
            islotery =  true;
             //设置奖品值
            lottery.prize = 7;
            lottery.init('lottery');
            roll('prize_1','888元现金红包&10手气值');
        }

    });


    //奖品轮播


    var swiper = new Swiper('#prize_swiper', {
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 30,
        autoplay : 2000,
        autoplayDisableOnInteraction : false,
        loop : true

    });

    var sq_rank = $('#sq_rank'),
        month_num = sq_rank.find('.tit i');


    //排行版轮播

    var swiperbuttonnext1 = $('.swiper-button-next1'),
        swiperbuttonprev1 = $('.swiper-button-prev1'),
        naturalnext = sq_rank.find('.left'),
        naturalright = sq_rank.find('.right');

    var swiper_rank = new Swiper('#rank_swiper', {
        spaceBetween: 30,
        nextButton: '.swiper-button-next1',
        prevButton: '.swiper-button-prev1',
        onSlideChangeEnd: function (swiper) {

            //排行版切换滑动
            var cur_month = +swiper.activeIndex + 1;
            month_num.html(cur_month);

            // console.log('next1:',$('.swiper-button-next1').hasClass('swiper-button-disabled'));
            // console.log('prev1:',$('.swiper-button-prev1').hasClass('swiper-button-disabled'));


            if(swiperbuttonnext1.hasClass('swiper-button-disabled')){
                naturalright.hide();

            }else{
                naturalright.show();
            }

            if(swiperbuttonprev1.hasClass('swiper-button-disabled')){
                naturalnext.hide();

            }else{
                naturalnext.show();

            }


        }
    });







    naturalnext.on('click', function () {
        swiper_rank.slidePrev();
    });


    naturalright.on('click', function () {


        swiper_rank.slideNext();
    });





    //	奖品名单滚动
    var Marquee = function (id) {
        var container = document.getElementById(id),
            original = container.getElementsByTagName("dt")[0],
            clone = container.getElementsByTagName("dd")[0],
            speed = arguments[1] || 10;
        clone.innerHTML = original.innerHTML;
        var rolling = function () {
            if (container.scrollTop == clone.offsetTop) {
                container.scrollTop = 0;
            } else {
                container.scrollTop++;
            }
        }
        var timer = setInterval(rolling, 60) //设置定时器
    }



    // 初始化滚动元素

    Marquee("prize_marquee");


    var vxShareImg = './images/share-shade.png';


    //弹窗


    $('.close').on('click', function () {
        $(this).parents('.alert').hide();
    });

    //规则弹窗

    $('#rule_btn').on('click', function (e) {
        e.preventDefault();
        $('#rule_alert').css('visibility', 'visible');
        $('#rule_alert').show();
    });


    // 规则弹窗tab切换


    var rule_tab = $('#rule_tab');

    rule_tab.find('.tab_nav_item').on('click', function () {

        var cur_index = $(this).index();

        if (cur_index == 0) {
            $(this).parents('.tab_nav').removeClass('tab_rec');

        } else {
            $(this).parents('.tab_nav').addClass('tab_rec');
        }

        rule_tab.find('.tab_con>div').removeClass('cur_con');
        rule_tab.find('.tab_con>div').eq(cur_index).addClass('cur_con');
    });



    //  获奖记录



    // 上拉拉动
    var test = new xxy.touch(),
        rec_list = $('#rec_list');
    test.bind(document.querySelector('#comlist'), {
        move: true,
        up: function () {

            var _this = this;

            window.setTimeout(function () {
                _this.done();
                // xxy.toast('加载成功');

                rec_list.append('<li><p class="date">1111111</p> <p class="prize_num">99元现金红包</p> <a href="" class="link get">领取</a></li>');

                console.log(1);

            }, 10)

        },
		down: function(){
			window.setTimeout(function(){
				this.done()
			}.bind(this),1)

		}
    })

    //我的手气


    $('#sq_btn').on('click', function () {
        $('#sq_rank').css('visibility', 'visible');
        $('#sq_rank').show();
    });

    //分享




    $('body').on('click', '.share_btn', function () {



        appShare.set({
            icon: '',
            title: '标题',
            content: '内容',
            shareUrl: 'tdw.cn',
            cover: {
                src: vxShareImg,
                style: {
                    width: '12rem',
                    display: 'block',
                    margin: '0 0 0 1.5rem'

                }
            },
            custom: [{
                key: 5,
                val: "朋友圈",
                title: 'xxx'
            }],
            callback: function () {}
        })
    });



    function toast(txt) {
        $('#toast').find('.txt').html(txt);
        $('#toast').show();
        setTimeout(function () {
            $('#toast').fadeOut();
        }, 600);
    }




    //适配


    var ratio_wh = $(window).width()/$(window).height();



    if(ratio_wh>0.63){
            $('.wraper').addClass('fixed');
    }




    // class yrTest{


    //     constructor(a,b){

    //         this.a =a;
    //         this.b=b;
    //         return this;
    //     }


    //     print(){
    //         console.log(this.a+' '+this.b)
    //     }

    // }


    // const yrTest1 = new yrTest('hello','world')


$('#btn_know').on('click',function(){

    window.location.href  ='https://at.tuandai.com/201802/20180224sqcj/weixin/index.aspx';

})




$('.try_btn').on('click',function(){

    window.location.href  ='https://at.tuandai.com/201802/20180224sqcj/weixin/index.aspx';

})







})();