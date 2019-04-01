$(function () {
    $('.agreement input').iCheck({
        checkboxClass: 'icheckbox_square-yellow',
        radioClass: 'iradio_square-yellow',
        increaseArea: '20%'
    });
    $('#phone').val("");
    $('#passWord').val("");
    $('#messCode').val("");

    $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
    $('#passWord').blur(function () { BlurPwd(false); });
    $('#messCode').blur(function () { BlurCode(false); });
    $('#phone').blur(function () { BlurTelNo(false); });
    $("#btnReg").click(function () {
        RegSubmit($("#btnReg"));
    });

    $('#passWord').focus(function () {
        if ($(this).val() != "") {
            $("#dvPwdError").html("");
            return;
        }
    });
    $('#passWord').focus(function () {
        if ($('#phone').val() == "") {
            $("#dvPhoneError").html("手机号码不能为空");
            return;
        }
    });

    $('#messCode').focus(function () {
        if ($('#phone').val() == "") {
            $("#dvPhoneError").html("手机号码不能为空");
            return;
        }
    });
});

function reloadCode(urlString) {
    $("#imgVcode").attr("src", urlString + "?id=" + Math.random());
}

function isBeginWithNum(str) {
    var number = str.substring(0, 1);
    var reg = /^\d+$/;
    return number.match(reg);
}

function BlurTelNo(isSubmit) {
    var result = false;
    var txt = "#phone";
    var td = "#dvPhoneError";
    var patTel = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
    var str = $(txt).val();
    if ($.trim(str) != "") {
        if (patTel.test(str)) {
            $.ajax({
                type: "post",
                async: false,
                url: "/ajaxCross/Login.ashx",
                data: "Cmd=CheckPhone&mobilenumber=" + str,
                dataType: "json",
                timeout: 3000,
                success: function (jsondata) {
                    var data = jsondata.result;
                    if (data == "False") {
                        $(td).html("");
                        result = true;
                    }
                    else {
                        $(td).html("手机已注册");
                        result= false;
                    }
                }
            });
            return result;
        }
        else {
            $(td).html("输入手机号码格式不正确");
            return false;
        }
    }
    else {
        if (isSubmit == true) {
            $(td).html("手机号码不能为空");
        }
        else {
            $(td).html("");
        }
        return false;
    }
}
/*图形验证码验证*/
function ValidateImgCode() {
    var code = $("#txtValidNumber").val();
    if (code == "") {
        $("#dvValidNumber").text("图形验证码不能为空");
        $("#dvValidNumber").show();
        return false;
    }
    else {
        $("#dvValidNumber").hide();
        return true;
    }
}
function BlurPwd(isSubmit) {
    var txt = "#passWord";
    var td = "#dvPwdError";
    var str = $(txt).val();

    if (str.indexOf(" ") > -1) {
        $(td).html("密码不允许含有空格");
        return false;
    }

    if ($.trim(str) != "") {
        if (/^.*?[\d]+.*$/.test(str) && /^.*?[A-Za-z].*$/.test(str) && /^.{6,16}$/.test(str)) {
            $(td).html("");
            return true;
        }
        else {
            $(td).html("密码格式错误");
            return false;
        }
    }
    else {
        if (isSubmit == true) {
            $(td).html("密码不能为空");
        }
        else {
            $(td).html("");
        }
        return false;
    }
}

//检验 验证码
function BlurCode(isSubmit) {
    var txt = "#messCode";
    var td = "#dvCodeError";
    var str = $("#messCode").val();
    var pat = new RegExp("^[0-9]{6}$", "i");

    if ($.trim(str) != "") {
        if (!pat.test(str)) {//格式不正确
            $(td).html("验证码错误,请重新输入");
            return false;
        }
        else {
            $(td).html("");
            return true;
        }
    }
    else {
        if (isSubmit == true) {
            $(td).html("请输入验证码");
        }
        else {
            $(td).html("");
        }
        return false;
    }
}

/*团贷网注册协议*/
function checkagree() {
    if ($('#agreexieyi').is(':checked')) {
        return true;
    } else {
        alert("注册成为团贷网会员，一定要同意团贷网协议");
        return false;
    }
}
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

function RegSubmit(ctrl) {
    if (BlurTelNo(true) && BlurPwd(true) && BlurCode(true) && checkagree() && ValidateImgCode()) {
        $(ctrl).unbind("click");
        $("#btnReg").html("正在提交注册信息...");
       
        $.ajax({
            async: false,
            url: "/ajaxCross/Login.ashx",
            dataType: "json",
            data: {
                cmd: "Register", from: GetQueryString("tdfrom") == null ? GetQueryString("from") : GetQueryString("tdfrom"), username: $("#phone").val(), password: $("#passWord").val(), mobilenumber: $("#phone").val(), verificationCode: $("#messCode").val(), telno: '', extendKey: ''
            },
            success: function (json) {
                AsyncReg(json);
            },
            error: function () {
                $(ctrl).click(function () { RegSubmit(ctrl); });
            }
        });
    }
}

function AsyncReg(data) {
    if (data.result == "1") {
        window.location.href = "/user/Register_Succeed.aspx";
    }
    else{
        alert(data.msg);
    }
}

var timer = null;
var leftsecond = 60; //倒计时
var mbTest = /^(13|14|15|17|18)[0-9]{9}$/;
//获取手机验证码
function sendMobileValidSMSCode() {
    var mobile = $("#phone").val();
    if (mobile == "") {
        $("#dvPhoneError").html("手机号码不能为空");
        return;
    }
    if (!ValidateImgCode()) {
        return;
    }
    var validCode = $("#txtValidNumber").val();
    $("#btnSendMsg").unbind();
    if (mbTest.test(mobile)) {
        $("#btnSendMsg").val("短信发送中...");
        $("#dvPhoneError").html("");
        $.ajax({
            url: "/ajaxCross/Login.ashx",
            type: "post",
            dataType: "json",
            data: { cmd: "GetPhoneRegCode", mobilenumber: mobile, ValidCode: validCode },
            success: function (json) {
                var result = json.result;
                leftsecond = 60;
                if (parseInt(result) == -100) { window.location.href = "/View/NoticeMessage.aspx?status=2"; }
                if (result == "1") {
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#phone").attr("readonly", true);
                }
                else if (result == "0") {
                    $("#dvCodeError").html(json.msg);
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#phone").attr("readonly", true);
                }
                else {
                    $("#dvCodeError").html(json.msg);
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#phone").attr("readonly", true);
                }
            },
            error: function () {
                $("#btnSendMsg").bind("click",function () { sendMobileValidSMSCode(); });
                $("#btnSendMsg").val("获取手机验证码");
            }
        });
    }
    else {
        $("#btnSendMsg").bind("click",function () { sendMobileValidSMSCode(); });
        $("#btnSendMsg").attr("class", "messCode_but");
    }
}

function setLeftTime() {
    var second = Math.floor(leftsecond);
    $("#btnSendMsg").val(second + "秒后可重发");
    leftsecond--;
    if (leftsecond < 1) {
        $("#btnSendMsg").val("获取手机验证码");
        clearInterval(timer);
        try {
            $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
            $("#phone").removeAttr("readonly");
        } catch (E) { }
        return;
    }
}