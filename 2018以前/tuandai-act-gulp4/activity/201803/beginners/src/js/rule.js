(function(){


    var  rules = $('.rule');

    $('#list_nav').on('click','.item',function(){
         if(!$(this).hasClass('.cur')){
             $(this).addClass('cur');
             $(this).siblings().removeClass('cur');
             rules.eq($(this).index()).addClass('rule_cur');
             rules.eq($(this).index()).siblings().removeClass('rule_cur');
         }
    });



    var  win_height = $(window).height(),
         nav_height = $('#list_nav').height(),
         footer_height = $('#footer').height(),
         remai_height =win_height -  nav_height - footer_height*2.2;

        //  console.log(win_height,remai_height,footer_height);

        //
         rules.each(function(){
            if($(this).height()<remai_height){
                $(this).height(remai_height);
            }
         });


})();