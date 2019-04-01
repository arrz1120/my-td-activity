(function() {
	FastClick.attach(document.body);
	//do your thing.

	var prizeSwiper = new Swiper('.prize-swiper', {
		pagination: '#pagination',
		paginationClickable: true,
		nextButton: '#swiper-button-next-1',
		prevButton: '#swiper-button-prev-1',
		spaceBetween: 30,
        autoplay : 3000,
        slidesPerView : 2,
        slidesPerGroup : 2,
        loop:true
	});

	var txtSwiper = new Swiper('.txt-swiper', {
		pagination: '#txtPaging',
		paginationClickable: true,
		nextButton: '#swiper-button-next-2',
		prevButton: '#swiper-button-prev-2',
		spaceBetween: 30
    });


    function showTips(txt){
        var tips = $(".ms-tips");
        tips.html(txt);
        setTimeout(function(){
            tips.html("");
        },2000);
    }

    function inputFn(){
        var val = "";
        $(".textHolder").on("click",function(){
            $("#textarea").focus();
        })
        $("#textarea").on("focus",function(){
            $(".textHolder").fadeOut();
        }).on("blur",function(){
            $(".textHolder").fadeIn();
        }).on("input",function(){
            val = $(this).val();
            if(val == ""){
                $(".textHolder").fadeIn();
            }else{
                $(".textHolder").fadeOut();
            }
            if(val.length<10){
                $(".ms-btn").addClass("btn-gray");
            }else{
                $(".ms-btn").removeClass("btn-gray");
            }
        })
        $(".ms-btn").on("click",function(){
            if(val == "" || val.length<150){
                showTips("请输入150字以上");
            }else{
                showTips("提交成功！");
            }
        })
    }

    inputFn();
    



//分享


    //app分享配置对象

    var ActivityWebsiteUrl = 'https://at.tuandai.com';
    var vtitle = "天秤大数据智能风控系统";
    var vcontent = "专注于提供大数据风控解决方案";
    var viconUrl = ActivityWebsiteUrl + "/201804/zhengwen/images/share.jpg";
    var vshareUrl = ActivityWebsiteUrl + "/201804/zhengwen/index.aspx";

    var params = {
        "shareTypeList": [{
            "ShareToolType": 1,
            "ShareToolName": "微信",
            "IconUrl": viconUrl,
            "Title": vtitle,
            "ShareContent": vcontent,
            "ShareUrl": vshareUrl,
            "IsEnabled": true
        }, {
            "ShareToolType": 5,
            "ShareToolName": "朋友圈",
            "IconUrl": viconUrl,
            "Title": vtitle,
            "ShareContent": vcontent,
            "ShareUrl": vshareUrl,
            "IsEnabled": true
        }, {
            "ShareToolType": 4,
            "ShareToolName": "QQ",
            "IconUrl": viconUrl,
            "Title": vtitle,
            "ShareContent": vcontent,
            "ShareUrl": vshareUrl,
            "IsEnabled": true
        }, {
            "ShareToolType": 6,
            "ShareToolName": "QQ空间",
            "IconUrl": viconUrl,
            "Title": vtitle,
            "ShareContent": vcontent,
            "ShareUrl": vshareUrl,
            "IsEnabled": true
        }, {
            "ShareToolType": 3,
            "ShareToolName": "微博",
            "IconUrl": viconUrl,
            "Title": vtitle,
            "ShareContent": vcontent,
            "ShareUrl": vshareUrl,
            "IsEnabled": true
        }, {
            "ShareToolType": 8,
            "ShareToolName": "复制链接",
            "IconUrl": viconUrl,
            "Title": vtitle,
            "ShareContent": vcontent,
            "ShareUrl": vshareUrl,
            "IsEnabled": true
        }]

    };	


    //是否微信访问
    function isWeiXin() {
        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == 'micromessenger') {
            return true;
        } else {
            return false;
        }
    }


    var share_btn = $(".share_btn"),
        rule_btn = $("#rule_btn");

    // 分享活动
    share_btn.click(function() {
        if (Jsbridge.isApp()) {
            Jsbridge.toAppWebViewShare(params, function(result) {});
        } else if (isWeiXin()) {
            $('#wx_tips').show();
        } else {
            alert("请使用微信或者APP分享");
        }
    });

    rule_btn.on('click',function(){
        $("#rule").show();
    });


    $('.alert-close').on('click',function(){
        $(this).parent().parent().hide();
    });
    $('.mask').on('click',function(){
        $(this).parent().hide();
    });

    $("#btnConfirm").on('click',function(){
        $(this).parent().parent().hide();
        setTimeout(function(){
            $(window).scrollTop($(".md2").offset().top);
            // $('body').animate({"scrollTop":$(".md2").offset().top},100);
        },30)
    });


    $('.mask').on('touchmove',function(e){
        e.preventDefault();
    });

           /*滚动*/
    // var height_img =10,
    //     win_w = $(window).width(),
    //     scrollH =  height_img*100*(win_w/750);


    // $(document).on('scroll',function(){

    //     if($(window).scrollTop()>scrollH){
    //         rule_btn.show();
    //         share_btn.show();
    //     }
    // })

    function dealTxt(){
        var $txt = $("#txt");
        var txt = $txt.html();
        console.log(txt.length);
        if(txt.length>83){
            var subTxt = txt.substring(0,83) + "...";
            $txt.html(subTxt);
            var watch = $('<a href="javascript:void(0);" class="watchMore">查看更多 ></a>');
            watch.on("click",function(){
                $txt.html(txt);
                watch.remove();
            })
            $txt.append(watch);
        }
    }
    dealTxt();
})();