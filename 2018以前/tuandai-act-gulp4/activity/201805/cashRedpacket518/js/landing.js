(function() {
    FastClick.attach(document.body);
    //do your thing.

    var _body  = $('body');
    var translateBox = $('.content');
    function isAndroidPlatform() {
        if (navigator.userAgent.match(/(Android)/)) {
            return true;
        } else {
        }
            return false;
        }

        // 输入框聚焦失焦事件 解决Android bug
        _body.on('focus', 'input', function (e) {
            if(isAndroidPlatform()){
                translateBox.css('transform', 'translateY(-7rem)');
            }
        })
    
        _body.on('blur', 'input', function (e) {
            if(isAndroidPlatform()){
                translateBox.css('transform', 'translateY(0)');
            }
        })

    $("#phone").on('input', function () {
        if($(this).val().length == 11) {
            //todo 判断新老用户

            $("#codeInput").show();
            $(".reg-tips").removeClass("hide")
        }
    })


    // $('#phone').val("");
    // $('#messCode').val("");

    // $('#phone').blur(function () { BlurTelNo(false); });
    $('#messCode').blur(function () { BlurCode(false); });




    _body.on('click', '.btn-get', function () {
        $('#phone').blur();
    })




//校验手机号码
    function BlurTelNo(isSubmit) {
        var result = false;
        var phoneError = "#phoneError";
        var patTel = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
        var phoneNumber = $("#phone").val();
        if ($.trim(phoneNumber) != "") {
            if (patTel.test(phoneNumber)) {
                //
                // $.ajax({
                //     async: false,
                //     url: "ajax/reg.ashx",
                //     dataType: "json",
                //     data: {
                //         Action: "CheckPhoneIsExist",
                //         phoneNumber: phoneNumber
                //     },
                //     success: function (jsondata) {
                //         var data = jsondata.result;
                //         if (data == "false") {
                //             $(phoneError).html("");
                //             result = true;
                //         }
                //         else {
                //             $(phoneError).html('<i class="bg-size"></i>手机号已被注册');
                //             result = false;
                //         }
                //     },
                //     error: function () {
                //     }
                // });
            }
            else {
                $(phoneError).html('<i class="bg-size"></i>输入手机号码格式不正确');
                result = false;
                $("#phone").focus();
            }
            return result;
        }
        else {
            if (isSubmit == true) {
                $(phoneError).html('<i class="bg-size"></i>手机号码不能为空');
                $("#phone").focus();
            }
            else {
                $(phoneError).html("");
                //不是提交注册,置为空
            }
            return false;
        }
    }


    //检验 手机验证码
    function BlurCode(isSubmit) {
        var codeError = "#codeError";
        var messCode = $("#messCode").val();
        var pat = new RegExp("^[0-9]{6}$", "i");

        if ($.trim(messCode) != "") {
            if (!pat.test(messCode)) {//格式不正确
                $(codeError).html('<i class="bg-size"></i>验证码错误,请重新输入');
                $("#messCode").focus();
                return false;
            }
            else {
                $(codeError).html("");
                return true;
            }
        }
        else {
            if (isSubmit == true) {
                $(codeError).html('<i class="bg-size"></i>请输入验证码');
                $("#messCode").focus();
            }
            else {
                $(codeError).html("");
            }

            return false;
        }
    }



})();


