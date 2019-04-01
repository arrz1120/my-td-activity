$(function () {
        $('#phone').val("");
        $('#messCode').val("");

        $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
        $('#messCode').blur(function () { BlurCode(false); });
        $("#phone").blur(function () { BlurTelNo(false); });
        $("#btnReg").click(function () {
                RegSubmit($("#btnReg"));
        });

        $('#messCode').focus(function () {
                if ($('#phone').val() == "") {
                        $("#dvPhoneError").html("手机号码不能为空");
                        return;
                }
        });
});

function checkPhone() {
        if ($("#phone").val().length >= 10) {
                $(".code-box div").css("display", "block");
        }
}
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
                                async: false,
                                url: "/ajaxCross/Login.ashx",
                                dataType: "json",
                                type: "post",
                                data: {
                                        cmd: "CheckPhone", mobilenumber: $("#phone").val()
                                },
                                success: function (json) {
                                        if (json.result == "False") {
                                                $(td).html("&nbsp;");
                                                result = true;
                                        } else {
                                                $(td).html("该手机号码已注册，本活动页仅限邀请新注册用户");
                                                result = false;
                                        }
                                },
                                error: function () {
                                        $(td).html("手机号码检测失败");
                                        result = false;
                                }
                        });

                }
                else {
                        $(td).html("输入手机号码格式不正确");
                        result = false;
                }
                return result;
        }
        else {
                if (isSubmit == true) {
                        $(td).html("手机号码不能为空");
                }
                else {
                        $(td).html("&nbsp;");
                }
                return false;
        }
}
/*图形验证码验证*/
function ValidateImgCode() {
        var code = $("#txtValidNumber").val();
        if (code == "") {
                $("#dvValidNumber").html("图形验证码不能为空");
                return false;
        }
        else {
                $("#dvValidNumber").html("&nbsp;");
                return true;
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
                        $(td).html("&nbsp;");
                        return true;
                }
        }
        else {
                if (isSubmit == true) {
                        $(td).html("请输入验证码");
                }
                else {
                        $(td).html("&nbsp;");
                }
                return false;
        }
}

function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
}

function RegSubmit(ctrl) {
        if (BlurTelNo(true) && ValidateImgCode() && BlurCode(true)) {
                $(ctrl).unbind("click");
                $("#btnReg").html("红包领取中...");

                $.ajax({
                        async: true,
                        url: "/Activity/inviteGetgift/ajax.ashx",
                        dataType: "json",
                        type: "post",
                        data: {
                                cmd: "RegisterUser", mobilenumber: $("#phone").val(), verificationCode: $("#messCode").val(), ExtendKey: extendKey, from: isMobile
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
                window.location.href = "resultApp.aspx?tel=" + $("#phone").val();
        }
        else {
                $("#btnReg").html("马上领取");
                $("#loginWrap").show();
                $("#loginWrap .p").html(data.msg);
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
        $("#dvCodeError").html("&nbsp;");
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
                                $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
                                $("#btnSendMsg").val("获取手机验证码");
                        }
                });
        }
        else {
                $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
        }
}

function setLeftTime() {
        var second = Math.floor(leftsecond);
        $("#btnSendMsg").val(second + "秒后可重发");
        leftsecond--;
        if (leftsecond < 1) {
                $("#btnSendMsg").val("获取验证码");
                clearInterval(timer);
                try {
                        $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
                        $("#phone").removeAttr("readonly");
                } catch (E) { }
                return;
        }
}