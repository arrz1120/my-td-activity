//页面初始化
$(function () {
    $("#txtMobileNumber").blur(function () { CheckUserName(); });
    $("#txtImageCode").blur(function () { ValidateImgCode(); });

    $(".but-getcode").click(function () { 
        if (!CheckUserName()) {
            return false;
        } 
        GetVerificationCode();
    });
    //立即注册领取
    $(".getnow-but").click(function () {
        $(".getnow-but").attr('disabled', true);
        RegisterSubmit();
        $(".getnow-but").attr('disabled', false);
    });

    $("#txtMobileNumber").bind("keyup", function () {
        $this = $(this);
        $this.val($this.val().toString().replace(/[^(\d|\.)]+/, ""));
    });
    $("#txtCode").bind("keyup", function () {
        $this = $(this);
        $this.val($this.val().toString().replace(/[^(\d|\.)]+/, ""));
    });
    //清除
    $("#clear").click(function () {
        $('#txtMobileNumber').val("").focus();
    });
});


//刷新图形码
function reloadCode(urlString) {
    document.getElementById("imVcode").src = urlString + "?id=" + Math.random();
}
//验证图形码
function ValidateImgCode() { 
    var imgCode = $("#txtImageCode").val();

    if (imgCode == "") {
        $("#lblImageCode").text("图形码不能为空");
        $("#lblImageCode").show();
        return false;
    } else if (imgCode.length != 4) {
        $("#lblImageCode").text("图形码输入有错");
        $("#lblImageCode").show();
        return false;
    }
    else {
        $("#lblImageCode").hide();
        return true;
    }
}
 
/*验证用户名是否存在*/
function CheckUserName() {
    var flag = false;
    if (!ValidateMobilerNumber()) {
        return false
    }
    var userName = $("#txtMobileNumber").val();
    $.ajax({
        type: "post",
        async: false,
        url: "/Activity/ExperienceGold/RegHandler.ashx",
        data: { cmd: "CheckUserName", username: userName },
        dataType: "json",
        timeout: 3000,
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                $("#lblMobileNumber").text(json.msg);
                $("#lblMobileNumber").show();
                flag = false;
            }
            else {
                $("#lblMobileNumber").hide();
                flag = true;
            }
        },
        error: function () {
            flag = false;
        }
    });
    return flag;
}


/*手机号码验证*/
function ValidateMobilerNumber() {
    var mobileNumber = $("#txtMobileNumber").val(); 
    var phoneRegex = /^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$/
    if (mobileNumber == "") {
        $("#lblMobileNumber").text("手机号码不能为空");
        $("#lblMobileNumber").show();
        return false;
    }
    else if (!phoneRegex.test(mobileNumber)) {
        $("#lblMobileNumber").text("输入手机号码格式不正确");
        $("#lblMobileNumber").show();
        return false;
    } 
    else {
        $("#lblMobileNumber").hide();
        return true;
    }
};

/*验证码验证*/
function ValidateCode() {
    var code = $("#txtCode").val();
    var imgCode = $("#txtImageCode").val(); 

    if (imgCode == "") {
        $("#lblImageCode").text("图形码不能为空");
        $("#lblImageCode").show();
        return false;
    }else  if (code == "") {
        $("#lblCode").text("手机验证码不能为空");
        $("#lblCode").show();
        return false;
    }
    else {
        $("#lblCode").hide();
        $("#lblImageCode").hide();
        return true;
    }
}

/*获取手机验证码*/
function GetVerificationCode() {
    var mobileNumber = $("#txtMobileNumber").val();
    $("#lblImageCode").hide();

    var imgCode = $("#txtImageCode").val(); 
    if (imgCode == "") {
        $("#lblImageCode").text("图形码不能为空");
        $("#lblImageCode").show();
        return false;
    }
    $(".but-getcode").val("短信发送中..");
    $(".but-getcode").attr('disabled', true);
    $('.but-getcode').addClass("disabled");
    $.ajax({
        url: "/Activity/ExperienceGold/RegHandler.ashx",
        type: "post",
        dataType: "json",
        data: { cmd: "GetPhoneRegCode", mobilenumber: mobileNumber, validatecode: imgCode },
        success: function (json) {
            var result = json.result;
            if (result == "1") { 
                $("#lblCode").text("发送成功，如未收到请稍后重新获取。");
                $("#lblCode").show();
                updateTimeLabel(180);
                return true;
            }
            else { 
                $("#lblCode").text(json.msg);
                $("#lblCode").show();
                updateTimeLabel(180);
                return false;
            }
        },
        error: function () {
            $(".but-getcode").attr('disabled', true);
            $('.but-getcode').addClass("disabled");
            $("#lblCode").text("网络异常，请重试。");
            $("#lblCode").show();
            updateTimeLabel(180);
            return false;
        }
    });
}; 
 
function updateTimeLabel(time) {
    var btn = $(".but-getcode");
    btn.fadeIn(1000);
    btn.val(time <= 0 ? "获取验证码" : ("重新发送" + (time) + "秒"));
    var hander = setInterval(function () {
        if (time <= 0) {
            clearInterval(hander);
            btn.val("获取验证码");
            btn.attr("disabled", false); 
            $('.but-getcode').removeClass("disabled");
        }
        else {
            btn.val("重新发送" + (time--) + "秒");
        }
    }, 1000);
};

/*注册*/
function RegisterSubmit() { 
    if (!CheckUserName()) {
        return false;
    }
    if (!ValidateCode()) {
        return false;
    } 
    var mobileNumber = $("#txtMobileNumber").val();
    var verificationCode = $("#txtCode").val();

    $.ajax({
        url: "/Activity/ExperienceGold/Index.aspx?action=RegisterUser",
        type: "post",
        dataType: "json",
        async: false,
        data: {  mobilenumber: mobileNumber, verificationCode: verificationCode, StoreNo: storeNo },
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                $("#txtMobileNumber").val("");
                $("#txtCode").val("");
                $("#txtImageCode").val("");
                window.location.href = "/Activity/ExperienceGold/GoInvest.aspx";
            }
            else {
                alert(json.msg);
                reloadCode("/Activity/ExperienceGold/ImageCode.ashx");
            }
        },
        error: function () {
            alert("网络异常,请重试!"); 
        }
    });
}
