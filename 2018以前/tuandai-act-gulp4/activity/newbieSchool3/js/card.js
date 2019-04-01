(function() {
    FastClick.attach(document.body);



    // 弹窗

    $('.mask').on('touchmove', function(e) {
        e.preventDefault();
    })




    $('.close,.know').on('click', function(e) {
        e.preventDefault();
        $(this).parents('.alert').hide();
    });


    $('.alert_notouchmove').on('touchmove', function(e) {
        e.preventDefault();
    });



    //开关按钮

    var isChangeSwith = false;

    $('.switch').on('touchstart', function() {


    });


    $('.switch').on('touchmove', function(e) {
        e.preventDefault();
        if (!isChangeSwith) {
            if ($(this).hasClass('on')) {
                $(this).removeClass('on').addClass('off');
                console.log(1);
            } else {
                $(this).removeClass('off').addClass('on');
                console.log(2);
            }
            isChangeSwith = true;
        }

        setTimeout(function(){
            isChangeSwith = false;

        },800)
    });



    $('.tab_nav').find('span').on('click',function(e){
        e.preventDefault();
        $(this).siblings('removeClass')
    })


    var tab = $('#tab');

    tab.find('.tab_nav li').on('click', function(e) {
        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');

        var index = $(this).index();
        tab.find('.tab_con').hide();
        tab.find('.con_'+index).show();

    });




})();