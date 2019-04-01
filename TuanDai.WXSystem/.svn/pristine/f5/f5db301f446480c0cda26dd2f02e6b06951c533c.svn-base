$(function () {
    $("#txtPhone").blur(function () { CheckPhoneNum(); });

    $(".hbBtn").click(function () {
        $(".hbBtn").unbind("click");
        var tag = $(this).attr("dataval");
        goToGetPrize(tag);
    });
    $(".pgBtn").click(function () {
        $(".pgBtn").unbind("click");
        var tag = $(this).attr("dataval");
        goToGetPrize(tag);
    });
    //发送验证码
    $("#btnSendCode").click(function () {
        GetVerificationCode();
    });

    //立即领钱
    $("#btnGetMoney").click(function () { 
        if (!ValidateMobilerNumber())
            return;
        $("#txtPhone").hide();
        $("#btnGetMoney").hide();
        $("#dvImgCode").hide(); 

        $("#dvCode").show();
        $("#btnConfirm").show();
       
        GetVerificationCode();
    });
    //确认注册
    $("#btnConfirm").click(function () { 
        RegisterSubmit();
    });


    //使用触屏版登录
    $("#btnExistLogin").click(function () {
        var tag = $(".pgBtn").attr("dataval");
        var strType = "redpacket";
        if (tag == "1")
            strType = "invest";
        if (isCookieLogin())
            window.location.href = "/Activity/GodWealth/GetPrize.aspx?type=" + strType;
        else {
            window.location.href = "/user/Login.aspx?ReturnUrl=/Activity/GodWealth/GetPrize.aspx?type=" + strType;
        }
    });
});
//刷新图形码
function reloadCode(urlString) {
    document.getElementById("imVcode").src = urlString + "?id=" + Math.random();
}

/*手机号码验证*/
function ValidateMobilerNumber() {
    var mobileNumber = $("#txtPhone").val();
    var phoneRegex = /^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$/
    if (mobileNumber == "") {
        alert("手机号码不能为空");
        $("#txtPhone").focus();
        return false;
    }
    else if (!phoneRegex.test(mobileNumber)) {
        alert("输入手机号码格式不正确");
        $("#txtPhone").focus();
        return false;
    }
    if ($.trim($("#txtImgCode").val()) == "") {
        alert("图形验证码不能为空!");
        $("#txtImgCode").focus();
        return false;
    }
    if ($.trim($("#txtImgCode").val()).length != 4) {
        alert("图形验证码长度输入错误!");
        $("#txtImgCode").focus();
        return false;
    }
    return true;
}

function goToGetPrize(tag) {
    var strType = "redpacket";
    if (tag == "1")
        strType = "invest";
    if (isCookieLogin())
        window.location.href = "/Activity/GodWealth/GetPrize.aspx?type=" + strType;
    else {
        $("#div1").hide();
        $(".hbBtn").hide();
        $(".pgBtn").hide();

        $(".phone-box").show();
        $("#txtPhone").focus();
        $(".pgBtn").hide(); 
        // window.location.href = "/user/Login.aspx?ReturnUrl=/Activity/GodWealth/GetPrize.aspx?type=" + strType;
    }
}

function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "="); //这里因为传进来的的参数就是带引号的字符串，所以c_name可以不用加引号
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start); //当indexOf()带2个参数时，第二个代表其实位置，参数是数字，这个数字可以加引号也可以不加（最好还是别加吧）
            if (c_end == -1) c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return null;
}
//判断cookie是否有登录凭证
function isCookieLogin() {
    var cookieValue = getCookie(".MTUANDAIAUTH");
    if (cookieValue != "" && cookieValue != null)
        return true;
    else {
        cookieValue = getCookie("tuandaiwexin");
        if (cookieValue != "" && cookieValue != null)
            return true;
        else
            return false;
    }
}
function CheckPhoneNum() {
    $.ajax({
        url: "/Activity/GodWealth/Gift.aspx?action=CheckPhoneNum",
        type: "post",
        dataType: "json",
        data: { mobilenumber: mobileNumber },
        success: function (json) {
            
        },
        error: function () { 
            alert("网络异常，请重试！"); 
            return false;
        }
    });
}

/*获取手机验证码*/
function GetVerificationCode() {
    var mobileNumber = $("#txtPhone").val();
    var imgCode = $("#txtImgCode").val();
    if (mobileNumber == "") {
        alert("手机号不能为空！");
        $("#txtPhone").focus();
        return;
    }
    if (imgCode == "") {
        alert("图形验证码不能为空！");
        $("#txtImgCode").focus();
        return;
    }
    $("#btnSendCode").val("短信发送中..");
    $("#btnSendCode").attr('disabled', true);
    $('#btnSendCode').addClass("disabled");
    $.ajax({
        url: "/Activity/GodWealth/Gift.aspx?action=GetPhoneRegCode",
        type: "post",
        dataType: "json",
        data: { mobilenumber: mobileNumber, validatecode: imgCode },
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                updateTimeLabel(180);
                return true;
            } else if (result == "-1") {
                alert(json.msg);
                reloadCode("/Activity/ExperienceGold/ImageCode.ashx");//刷新验证码

                $("#txtImgCode").val();
                $("#txtPhone").show();
                $("#btnGetMoney").show();
                $("#dvImgCode").show();

                $("#dvCode").hide();
                $("#btnConfirm").hide();
            } else {
                alert(json.msg);
                updateTimeLabel(180);
                return false;
            }
        },
        error: function () {
            $("#btnSendCode").attr('disabled', true);
            $('#btnSendCode').addClass("disabled");
            alert("网络异常，请重试。");
            updateTimeLabel(180);
            return false;
        }
    });
};

function updateTimeLabel(time) {
    var btn = $("#btnSendCode");
    btn.fadeIn(1000);
    btn.val(time <= 0 ? "获取验证码" : "重新发送" + time + "秒");
    var hander = setInterval(function () {
        if (time <= 0) {
            clearInterval(hander);
            btn.val("获取验证码");
            btn.attr("disabled", false);
            $('#btnSendCode').removeClass("disabled");
        }
        else {
            btn.val("重新发送" + (time--) + "秒");
        }
    }, 1000);
};

/*注册*/
function RegisterSubmit() {
    $("#btnConfirm").unbind("click");
    var mobileNumber = $("#txtPhone").val();
    var verificationCode = $("#txtCode").val();

    $.ajax({
        url: "/Activity/GodWealth/Gift.aspx?action=RegisterUser",
        type: "post",
        dataType: "json",
        async: false,
        data: { mobilenumber: mobileNumber, verificationCode: verificationCode },
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                var tag = $(".pgBtn").attr("dataval");
                var strType = "redpacket";
                if (tag == "1")
                    strType = "invest";
                window.location.href = "/Activity/GodWealth/GetPrize.aspx?type=" + strType;
            }
            else {
                alert(json.msg);
                //清空
            }
           
            $('#btnConfirm').click(function () { RegisterSubmit() });
        },
        error: function () {
            alert("注册失败,请重试!");
            $('#btnConfirm').click(function () { RegisterSubmit() });
        }
    });
}
