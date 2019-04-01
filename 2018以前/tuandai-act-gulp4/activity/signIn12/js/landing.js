$(function() {
    FastClick.attach(document.body);

    //圆形进度条
    var second = 181;
    var angle = 0;
    var timer;
    $("#getCode").click(function() {
        $(this).addClass('hide');
        $("#timeWrap").removeClass('hide');
        getTime();
        timer = setInterval(function() {
            getTime();
        }, 1000)
    })
    timer = setInterval(function() {
        getTime();
    }, 1000)

    function getTime() {
        second -= 1;
        angle += 2;
        var rightcircle = document.getElementById('rightcircle');
        var leftcircle = document.getElementById('leftcircle');
        var show = document.getElementById('show');
        show.innerHTML = second;
        if (angle > 180) {
            rightcircle.style.cssText = "transform: rotate(" + (45 - (angle - 180)) + "deg)";
            leftcircle.style.cssText = "transform: rotate(-135deg)";
            if (second <= 0) {
                clearInterval(timer);
                $("#timeWrap").addClass('hide');
                $("#getCode").removeClass('hide');
            }
        } else {
            rightcircle.style.cssText = "transform: rotate(45deg)";
            leftcircle.style.cssText = "transform: rotate(" + (45 - angle) + "deg)";
        }
    }


    function moveToTop(target) {
        $(target).removeClass('hide').removeClass('moveToBottom').addClass('moveToTop');
        setTimeout(function() {
            $("#bigDiv").addClass('hide');
            if ($("#bigDiv").hasClass('hide')) {
                $("#res-inp").focus();
            }
        }, 300);
    }

    //显示注册表单
    $("#toReg").click(function() {
        moveToTop('#res-alert');
    });

    //关闭注册表单
    $(".log-close").click(function() {
        $("#bigDiv").removeClass('hide');
        $(this).parent().removeClass('moveToTop').addClass('moveToBottom');
        setTimeout(function() {
            $(this).parent().addClass('hide');
        }, 200);
    })


    // 输入错误提示
    function errorDialog(msg) {
        $("#error_dialog").removeClass('hide').addClass('enlarge');
        $("#error_msg").html(msg);
        setTimeout(function() {
            $("#error_dialog").removeClass('enlarge').addClass('hide');
        }, 1800);
    }


    //设置密码
    function likePlaceHolder() {
        var txtPassword = document.getElementById('setPassword').getElementsByTagName('input')[0];
        var $txtPassword = $("#setPassword").find('input');
        var placeholder = $("#likePlaceholder");
        placeholder.click(function () {
            if (txtPassword.value == '') {
                $txtPassword.focus();
            }
        });
        $txtPassword.blur(function () {
            if ($(this).val() == '') {
                placeholder.show();
            }
        });
        txtPassword.oninput = function () {
            if (this.value.length == 0) {
                placeholder.show();
            } else {
                placeholder.hide();
            }
        }

        $("#btnSee").click(function (){
            var eye = $(this).find('b');
            if($txtPassword.attr('type')=='password'){
                eye.removeClass('eye-close').addClass('eye-open');
                $txtPassword.attr('type', 'text');
            }else{
                eye.removeClass('eye-open').addClass('eye-close');
                $txtPassword.attr('type', 'password');
            }
        });

    }
    likePlaceHolder();


    var swiper = new Swiper('#swiper', {
        slidesPerView: 'auto',
        loop: true,
//		autoplay: 2000,
        direction: 'horizontal',
        autoplayDisableOnInteraction: false,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev'
    });



});







