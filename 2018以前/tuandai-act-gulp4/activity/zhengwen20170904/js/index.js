(function() {
	FastClick.attach(document.body);
	//do your thing.

	var swiper_1 = new Swiper('.swiper-container_1', {
		pagination: '.swiper-pagination',
		paginationClickable: true,
		nextButton: '#swiper-button-next-1',
		prevButton: '#swiper-button-prev-1',
		spaceBetween: 30,
        autoplay : 3000
	});

	var swiper_1 = new Swiper('.swiper-container_2', {
		pagination: '.swiper-pagination',
		paginationClickable: true,
		nextButton: '#swiper-button-next-2',
		prevButton: '#swiper-button-prev-2',
		spaceBetween: 30
	});



//分享


    //app分享配置对象

    // var params = {
    //     "shareTypeList": [{
    //         "ShareToolType": 1,
    //         "ShareToolName": "微信",
    //         "IconUrl": viconUrl,
    //         "Title": vtitle,
    //         "ShareContent": vcontent,
    //         "ShareUrl": vshareUrl,
    //         "IsEnabled": true
    //     }, {
    //         "ShareToolType": 5,
    //         "ShareToolName": "朋友圈",
    //         "IconUrl": viconUrl,
    //         "Title": vtitle,
    //         "ShareContent": vcontent,
    //         "ShareUrl": vshareUrl,
    //         "IsEnabled": true
    //     }, {
    //         "ShareToolType": 4,
    //         "ShareToolName": "QQ",
    //         "IconUrl": viconUrl,
    //         "Title": vtitle,
    //         "ShareContent": vcontent,
    //         "ShareUrl": vshareUrl,
    //         "IsEnabled": true
    //     }, {
    //         "ShareToolType": 6,
    //         "ShareToolName": "QQ空间",
    //         "IconUrl": viconUrl,
    //         "Title": vtitle,
    //         "ShareContent": vcontent,
    //         "ShareUrl": vshareUrl,
    //         "IsEnabled": true
    //     }, {
    //         "ShareToolType": 3,
    //         "ShareToolName": "微博",
    //         "IconUrl": viconUrl,
    //         "Title": vtitle,
    //         "ShareContent": vcontent,
    //         "ShareUrl": vshareUrl,
    //         "IsEnabled": true
    //     }, {
    //         "ShareToolType": 8,
    //         "ShareToolName": "复制链接",
    //         "IconUrl": viconUrl,
    //         "Title": vtitle,
    //         "ShareContent": vcontent,
    //         "ShareUrl": vshareUrl,
    //         "IsEnabled": true
    //     }]

    // };	


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




    $('.close').on('click',function(){
        $('#wx_tips').hide();
    });


    $('.close_alert').on('click',function(e){
        $('#rule').hide();
    })

    rule_btn.on('click',function(e){
        e.preventDefault();
        $('#rule').show();
    });


    $('#rule').on('touchmove',function(e){
        e.preventDefault();
    });

           /*滚动*/
    var height_img =10,
        win_w = $(window).width(),
        scrollH =  height_img*100*(win_w/750);


    $(document).on('scroll',function(){

        if($(window).scrollTop()>scrollH){
            rule_btn.show();
            share_btn.show();
        }
    })


})();