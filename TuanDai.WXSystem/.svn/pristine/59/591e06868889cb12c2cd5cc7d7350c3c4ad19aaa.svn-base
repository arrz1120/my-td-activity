var bkName = "";
var isHaveCard = 0;
var nameReg = /^([\u4e00-\u9fa5]){2,7}$/;
var cardReg = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
var bankCardReg = /^(\d{16}|\d{18}|\d{19})$/;
var phoneReg = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
var gangaoReg = /^[a-zA-Z0-9]{5,21}$/;
var passportReg = /^[a-zA-Z0-9]{3,21}$/;
var foreiReg = /^[a-zA-Z]{3}\d{12}$/;
var pageType = "";
var cookieDomain = "tuandai.com";


$(function () {
    $(".alert").on('touchmove', function (e) {
        e.preventDefault();
    }); 
    //银行卡输入完毕
    $("#txt_bankCard").bind("blur", function () {
        checkBankCard();
    });

    //if ($("#txt_bankCard").val().trim().length > 0) {
    //    checkBankCard();
    //}

    //前往存管通
    $("#btnGoCgt").click(function () {
        submitBankCard();
    });
});
 
function aniShow(msg) {
    $("body").showMessage({ message: msg, showCancel: false });
}
function aniHide(parent) {
    $("body").hideMessage();
}

//window.onbeforeunload = function () { 
//   return "必优博客提示您，您确定要退出页面吗？";
//}
function submitBankCard() { 
    var realName = $("#txtRealName").val().trim();
    if (realName.length <= 0) {
        aniShow("真实姓名不能为空");
        return false;
    }
    if (!nameReg.test(realName)) {
        aniShow("姓名填写不正确"); 
        return false;
    }
    var _ctype = $("#txtCardType").val();
    if (_ctype == "") {
        aniShow("请选择证件类型");
        return false;
    }

    var identity = $("#txtIdentity").val().trim();
    if (identity.length <= 0) {
        aniShow("证件号码不能为空");
        return false;
    }
    //var idcardNo = $("#txtIdentity").val().replace(/[ ]/g, "");
    if (_ctype == "1") {
        if (!cardReg.test(identity) || identity.length < 18) {
            aniShow("身份证填写不正确");
            return false;
        }
    } else if (_ctype == "2") {
        if (!gangaoReg.test(identity)) {
            aniShow('港澳台通行证填写不正确');
            return false;
        } 
    }
    else if (_ctype == "4") {
        if (!passportReg.test(identity)) {
            aniShow('护照填写不正确');
            return false;
        } 
    }
    else if (_ctype == "3") {
        if (!foreiReg.test(identity)) {
            aniShow('外国人永久居留证填写不正确');
            return false;
        }
    }

    var bankNo = $("#txt_bankCard").val().trim();
    if (bankNo.length <= 0) {
        aniShow("银行卡号不能为空");
        return false;
    }

    var telNo = $("#txtTelNo").val().trim();
    if (telNo.length <= 0) {
        aniShow("预留手机不能为空");
        return false;
    }
    else if (!phoneReg.test(telNo) || telNo.length < 11) {
        aniShow("手机号输入错误");
        return false;
    }

    $("#btnGoCgt").removeClass("btnYellow").addClass("bg-cecfd0");
    $("body").showLoading("加载中...");
    if (!checkBankCard()) {
        $("#btnGoCgt").removeClass("bg-cecfd0").addClass("btnYellow");
        return false;
    }

    $("#bigDiv").addClass("hide").parent().removeClass("bg-f1f3f5");
    $("#jumpPage").removeClass("hide"); 

    var cmdname = "PERSONAL_REGISTER";

    if ($('#btnGoCgt').attr("opertype") == "bindcard")
        cmdname = "PERSONAL_BIND_BANKCARD";

    $.ajax({
        url: "/ajaxCross/ajax_cgt.ashx",
        type: "post",
        dataType: "json",
        async: false,   //同步
        data: { Cmd: cmdname, realName: realName, cardNo: identity, bankno: bankNo, telno: telNo, bkName: bkName, cardType: _ctype },
        success: function (json) {
            var status = parseInt(json.result);
            if (status == 1) {
                //通过投资前准备页跳转的
                if (pageType == "ready") {
                    CookieHelper.setCookie("wxcurgocgturl", "/Member/ready/complete.aspx", 1, cookieDomain);
                }
               window.location.href= unescape(json.msg);
            } else {
                $("#bigDiv").removeClass("hide").parent().addClass("bg-f1f3f5");
                $("#jumpPage").addClass("hide");
                $("#btnGoCgt").removeClass("bg-cecfd0").addClass("btnYellow");
                aniShow(json.msg);
            }
        },
        error: function () {
            $("#bigDiv").removeClass("hide").parent().addClass("bg-f1f3f5");
            $("#jumpPage").addClass("hide");
            $("#btnGoCgt").removeClass("bg-cecfd0").addClass("btnYellow");
            aniShow("前往存管通处理错误，请重试");
        }
    });
}
function checkBankCard() {
    var cardNo = $("#txt_bankCard").val().trim();
    if (cardNo.length <= 0) {
        // aniShow("银行卡号不行为空");
        $(this).focus().val("");
        return false;
    } else if (!bankCardReg.test(cardNo)) {
        aniShow("银行卡输入错误");
        return false;
    }
    var isResult = false;
    $("body").showLoading("加载中...");
    $.ajax({
        url: "/ajaxCross/ajax_cgt.ashx",
        type: "post",
        dataType: "json",
        async: false,
        data: { cmd: "GetBankInfo", CardNo: cardNo },
        success: function (json) { 
            bkName = "";
            isHaveCard = 0;
            isResult = false;
            var result = json.result;
            if (result == "1") {
                var bankInfo = JSON.parse(json.msg);
                if (bankInfo.card_type == null || bankInfo.card_type == "") {
                    aniShow("录入的银行卡信息有误");
                    return false;
                }
                //if (bankInfo.card_type != "储蓄卡") {
                //    aniShow("暂不支持绑定信用卡");
                //    return false;
                //}
                if (bankInfo.card_bound == "true") {
                    aniShow("卡号已绑定另一用户");
                    return false;
                }
                bkName = bankInfo.bank_name;
                isHaveCard = 1;
                isResult = true;
            } else {
                aniShow("无法识别卡号，请输入正确的银行卡卡号");
            }
        },
        error: function () { 
            aniShow("绑卡出错，请重试");
            isResult = false;
        }
    });
    $("body").hideLoading();
    return isResult;
}