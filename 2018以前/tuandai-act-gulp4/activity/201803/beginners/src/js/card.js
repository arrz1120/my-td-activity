(function(){


    var  cons = $('.con');

    $('.tab_nav').on('click','.item',function(){
         if(!$(this).hasClass('.cur')){
             $(this).addClass('cur');
             $(this).siblings().removeClass('cur');
             cons.eq($(this).index()).addClass('cur_con');
             cons.eq($(this).index()).siblings().removeClass('cur_con');
         }
    });



})();