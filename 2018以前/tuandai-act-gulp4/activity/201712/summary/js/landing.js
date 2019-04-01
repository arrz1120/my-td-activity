$(function() {

    FastClick.attach(document.body);
    var _body = $('body');
    var translateBox = $('.wrapper');

    function isAndroidPlatform() {
        if (navigator.userAgent.match(/(Android)/)) {
            return true;
        } else {
            return false;
        }
    }


    //禁止弹窗背景滑动
    $(".mask").on('touchmove',function(e){
        e.preventDefault();
    })

    //弹窗通用关闭事件
    $(".close").click(function(){
        $(this).parent().parent().hide();
    })
    $(".mask_bg").click(function(){
        $(this).parent().hide();
    })


    $('#phone').on('input',function(){
        if($(this).val().length==11){
            $('.input-con-hide').removeClass('hide');
        }
    })

    // 倒计时
    var timer = null;
    var countdownTime = 180; //倒计时时间(单位秒)
    function countdown(second, callback) {
        var nowTime = +new Date(),
            endTime = nowTime + second * 1000;

        timer = setInterval(function() {
            nowTime = +new Date();
            // 剩余时间
            var leftTime = Math.round((endTime - nowTime) / 1000);
            // 剩余时间小于0清除倒计时
            leftTime < 0 && clearInterval(timer);
            callback(leftTime);
        }, 1000)
    }

    // 输入框聚焦失焦事件 解决Android bug
    _body.on('focus', 'input', function (e) {
        if(isAndroidPlatform()){
            translateBox.css('transform', 'translateY(-14rem)');
        }
    })

    _body.on('blur', 'input', function (e) {
        if(isAndroidPlatform()){
            translateBox.css('transform', 'translateY(0)');
        }
    })


    var phoneReg = /^1[3|4|5|7|8]\d{9}$/,
        codeReg = /^\d{6}$/,
        inputPhone = _body.find('input[name="phone"]'), //手机号
        phoneErr = _body.find('.phone-err'), //手机号错误提示
        inputCode = _body.find('.code'), //验证码
        verifyCodeErr = _body.find('.code-err'),//验证码错误提示
        sendCodeBtn = _body.find('.send-code'), //发送短信
        inputPassword = _body.find('.password'), // 密码
        passwordErr = _body.find('.password-err'), // 密码错误提示
        inputInviter = _body.find('.inviter'), // 邀请人
        inviterErr = _body.find('.inviter-err'); //邀请人错误提示

    var isSendingCode = false;

    // 点击发送短信
    _body.on('click', '#sendCode', function() {

        if (!sendCodeBtn.hasClass('retry')) {
            if (isSendingCode == true) {
                return;
            }
            var phone = inputPhone.val(), //手机号
                verifyCode = inputCode.val(); //邀请人手机号

            // 如果显示错误提示则隐藏
            !phoneErr.hasClass('hide') && phoneErr.html('').addClass('hide');
            !verifyCodeErr.hasClass('hide') && verifyCodeErr.html('').addClass('hide');

            // 手机号为空
            if (!phone) {
                phoneErr.html('<i></i>手机号不能为空，请填写！').removeClass('hide');
                return;
            }
            // 手机号格式不对
            if (!phoneReg.test(phone)) {
                phoneErr.html('<i></i>手机号格式不对，请修改！').removeClass('hide');
                return;
            }

            isSendingCode = true;

            // todo ajax 发送验证码...
            clearInterval(timer);
            countdown(countdownTime, function(leftTime) {
                leftTime >= 0 ? sendCodeBtn.addClass('retry').html('重新发送' + leftTime + 's') : sendCodeBtn.removeClass('retry').html('发送短信');
            });

        }
    });

    // 立即领取
    _body.on('click', '#get_btn', function() {


        var phone = inputPhone.val(), //手机号
            verifyCode = inputCode.val(), //验证码
            psw = inputPassword.val(),// 密码
            inviterPhone = inputInviter.val();// 邀请人

        // 如果显示错误提示则隐藏
        !phoneErr.hasClass('hide') && phoneErr.html('').addClass('hide');
        !verifyCodeErr.hasClass('hide') && verifyCodeErr.html('').addClass('hide');
        !passwordErr.hasClass('hide') && passwordErr.html('').addClass('hide');
        !inviterErr.hasClass('hide') && inviterErr.html('').addClass('hide');

        // 手机号为空
        if (!phone) {
            phoneErr.html('<i></i>手机号不能为空，请填写！').removeClass('hide');
            return;
        }

        // 手机号格式不对
        if (!phoneReg.test(phone)) {
            phoneErr.html('<i></i>手机号格式不对，请修改！').removeClass('hide');
            return;
        }

        // 验证码为空
        if (!verifyCode) {
            verifyCodeErr.html('<i></i>验证码不能为空，请填写！').removeClass('hide');
            return;
        }

        //验证码错误
        if (!codeReg.test(verifyCode)) {
            verifyCodeErr.html('<i></i>验证码格式不对，请修改！').removeClass('hide');
            return;
        }
        // 密码为空
        if (!psw) {
            passwordErr.html('<i></i>请输入您的密码！').removeClass('hide');
            return;
        }

        //邀请人手机格式不对
        if (!inviterPhone) {
            return;
        }

        if (!phoneReg.test(inviterPhone)) {
            inviterErr.html('<i></i>邀请人手机号码格式不正确！').removeClass('hide');
            return;
        }

        // todo ajax 去提交..

    });

    var swiper = new Swiper('#swiper', {
        slidesPerView: 'auto',
        loop: true,
		autoplay: 4500,
        spaceBetween : 40,
        direction: 'horizontal',
        autoplayDisableOnInteraction: false,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        pagination: '#swiper_pagination'
    });

    var  imageSwiper = new Swiper('#images_swiper', {
        slidesPerView: "auto",
        initialSlide :1,
        loop: true,
        autoplay: 4500,
        direction: 'horizontal',
        centeredSlides : true,
        autoplayDisableOnInteraction : false,
        pagination: '#images_swiper_pagination'
    });

});







