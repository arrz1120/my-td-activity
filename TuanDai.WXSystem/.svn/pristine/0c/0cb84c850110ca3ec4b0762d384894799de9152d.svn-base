//验证身份证
function setIdCard() {
    var txtRealName = jQuery.trim($('#txtRealName').val());
    var idcard = $.trim($('#idcard').val());
    var nickname = $.trim($("#txtNickName").val());
    var pat = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9_]{2,12}$", "i");
    var isValidForm = true;
    if (txtRealName == '') {
        isValidForm = false;
        $('#realnameErr').html('请输入您的真实姓名。');
        return;
    }
    if (txtRealName.length < 2) {
        isValidForm = false;
        $('#realnameErr').html('真实姓名最少两位。');
        return;
    }
    //    if (/[^\u4e00-\u9fa5]/.test($.trim(txtRealName))) {
    //        isValidForm = false;
    //        $('#realnameErr').html('真实姓名只能为中文。');
    //        return;
    //    }
    if (idcard == '') {
        isValidForm = false;
        $('#idcardErr').html('请输入您的证件号码。');
        return;
    }
    else {
        var idcartValidResult = testIdcard($.trim(idcard));
        if (idcartValidResult.indexOf('通过') == -1) {
            isValidForm = false;
            $('#idcardErr').html(idcartValidResult);
            return;
        }
        var testAgeResult = testAge($.trim(idcard));
        if (testAgeResult.indexOf('通过') == -1) {
            isValidForm = false;
            $('#idcardErr').html(testAgeResult);
            return;
        }
    }

    if (isValidForm) {
        $('#realnameErr').html('');
        $('#idcardErr').html('');
    }
    else {
        return; ;
    }

    $.ajax({
        url: "/ajaxCross/ajax_s1a2fe.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "setidcard", realname: txtRealName, idcard: idcard, nickName: "", CredTypeId: "1", BirthDay: "", Sex: ""},
        success: function (json) {
            var data = parseInt(json.result);
            var msg = json.msg;
            if (data == -100) { $("#ValidateIdentity1").html('系统繁忙，请稍后重试') }
            if (data == 1) {
                $("#div_Identity").hide();
                $("#div_Ok").show();
                setTimeout("Ok()", 2500);
            } else if (data == 100) {
                window.location = json.msg;
            } else {
                $("#ValidateIdentity1").html(json.msg);
            }
        }
    });
}

function Ok() {
    window.location.href = "/Member/my_account.aspx";
}

//验证身份证号方法
var testIdcard = function (idcard) {
    idcard = idcard.toUpperCase();
    var Errors = new Array("验证通过!", "身份证号码位数不对!", "身份证号码出生日期超出范围!", "身份证号码校验错误!", "身份证地区非法!");
    var area = { 11: "北京", 12: "天津", 13: "河北", 14: "山西", 15: "内蒙古", 21: "辽宁", 22: "吉林", 23: "黑龙江", 31: "上海", 32: "江苏", 33: "浙江", 34: "安徽", 35: "福建", 36: "江西", 37: "山东", 41: "河南", 42: "湖北", 43: "湖南", 44: "广东", 45: "广西", 46: "海南", 50: "重庆", 51: "四川", 52: "贵州", 53: "云南", 54: "西藏", 61: "陕西", 62: "甘肃", 63: "青海", 64: "宁夏", 65: "xinjiang", 71: "台湾", 81: "香港", 82: "澳门", 91: "国外" }
    var idcard, Y, JYM;
    var S, M;
    var idcard_array = new Array();
    idcard_array = idcard.split("");
    if (area[parseInt(idcard.substr(0, 2))] == null) return Errors[4];
    switch (idcard.length) {
        case 18:
            if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式 
            }
            else {
                ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式 
            }
            if (ereg.test(idcard)) {
                S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7 + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9 + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10 + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5 + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8 + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4 + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2 + parseInt(idcard_array[7]) * 1 + parseInt(idcard_array[8]) * 6 + parseInt(idcard_array[9]) * 3;
                Y = S % 11;
                M = "F";
                JYM = "10X98765432";
                M = JYM.substr(Y, 1);
                if (M == idcard_array[17])
                    return Errors[0];
                else
                    return Errors[3];
            }
            else
                return Errors[2];
            break;
        default:
            return Errors[1];
            break;
    }
}
