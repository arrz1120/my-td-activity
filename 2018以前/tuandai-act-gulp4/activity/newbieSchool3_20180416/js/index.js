(function() {
    FastClick.attach(document.body);



    var swiper_course = new Swiper('#swiper-course', {
        paginationClickable: true,
        nextButton: '#swiper-course-next',
        prevButton: '#swiper-course-prev',
        spaceBetween: 30
    });

    var swiper_rank_1 = new Swiper('#swiper-rank', {
        paginationClickable: true,
        direction: 'vertical',
        autoplay : 3000,
		autoplayDisableOnInteraction: false
    });

    var swiper_rank_2 = new Swiper('#swiper-rank-1', {
        paginationClickable: true,
        direction: 'vertical',
        autoplay : 3000,
		autoplayDisableOnInteraction: false

    });



    var swiper_prize = new Swiper('#swiper-prize', {
        paginationClickable: true,
        nextButton: '#swiper-prize-next',
        prevButton: '#swiper-prize-prev',
        spaceBetween: 30
    });

    var tab = $('#tab');

    tab.find('.nav').on('click',function(e){
    	e.preventDefault();
    	var cur_num = $(this).attr('data-num');
    	tab.find('.con').removeClass('con_visible');
    	tab.find('.con_'+cur_num).addClass('con_visible');
    	if(cur_num<2){
    		swiper_rank_1.slideTo(0, 0, function(){
    			swiper_rank_1.startAutoplay();
    		});
    	}else{
    		swiper_rank_2.slideTo(0, 0, function(){
    			swiper_rank_2.startAutoplay();
    		});
    	}
    });



    // 弹窗

    $('.mask').on('touchmove',function(e){
        e.preventDefault();
    })


    var tab_con = $('#tab_con');

    tab_con.find('.tab_nav li').on('click',function(e){
        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');

        var index  = $(this).index();
        tab_con.find('.rule_box').hide();
        $('#rule_'+index).show();

    });


    $('.close,.know').on('click',function(e){
        e.preventDefault();
        $(this).parents('.alert').hide();
    });


    $('.alert_notouchmove').on('touchmove',function(e){
        e.preventDefault();
    });




    // 学分押注

    $('#bet_on').on('click',function(e){
        e.preventDefault();
        $('#alert_score').show();
    });




    $('#btn_rule').on('click',function(e){
        e.preventDefault();
        $('#rule').show();
    });




    $('#look_for').on('click',function(e){
        e.preventDefault();
        $('#alert_prize').show();
    });


    
    $('#btn_strategy').on('click',function(e){
        e.preventDefault();
        $('#alert_strategy').show();
    });


    var toastDom = $('#toast');

    function toast(str){
            toastDom.find('p').html(str);
            toastDom.show();
            setTimeout(function(){
                toastDom.hide();
            },800);
    }

    // toast('传入的文案');

})();