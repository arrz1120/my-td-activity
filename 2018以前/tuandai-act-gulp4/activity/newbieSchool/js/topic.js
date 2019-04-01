(function() {
    FastClick.attach(document.body);



    // 弹窗

    $('.mask').on('touchmove', function(e) {
        e.preventDefault();
    })


    var tab_con = $('#tab_con');

    tab_con.find('.tab_nav li').on('click', function(e) {
        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');

        var index = $(this).index();
        tab_con.find('.rule_box').hide();
        $('#rule_' + index).show();

    });


    $('.close,.know').on('click', function(e) {
        e.preventDefault();
        $(this).parents('.alert').hide();
    });


    $('.alert_notouchmove').on('touchmove', function(e) {
        e.preventDefault();
    });



    //答题选择

    $('.topic').find('.radio').on('click', function(e) {
        e.preventDefault();
        $(this).siblings().removeClass('radio_checked');
        $(this).addClass('radio_checked');
    });


    $('.topic').find('.checkbox').on('click', function(e) {
        e.preventDefault();

        if ($(this).hasClass('checkbox_checked')) {
            $(this).removeClass('checkbox_checked');
        }else{
            $(this).addClass('checkbox_checked');
        }
    });



})();