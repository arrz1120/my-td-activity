function RealNameValidShow() {
    $("#dv1").show();
}

function ValidRealName() {
    var txtRealName = jQuery.trim($('#txtRealName').val());
    var idcard = $.trim($('#txtIdCard').val());
    var pat = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9_]{2,12}$", "i");
    var isValidForm = true;
    if (txtRealName == '') {
        isValidForm = false;
        alert('请输入您的真实姓名');
        return;
    }
    if (txtRealName.length < 2) {
        isValidForm = false;
        alert('真实姓名最少两位');
        return;
    }
    if (idcard == '') {
        isValidForm = false;
        alert('请输入您的证件号码');
        return;
    }
    else {
        var idcartValidResult = testIdcard($.trim(idcard));
        if (idcartValidResult.indexOf('通过') == -1) {
            isValidForm = false;
            alert(idcartValidResult);
            return;
        }
        var testAgeResult = testAge($.trim(idcard));
        if (testAgeResult.indexOf('通过') == -1) {
            isValidForm = false;
            alert(testAgeResult);
            return;
        }
    }

    if (isValidForm) {
        return true;
    }
    else {
        return false;
    }
}
//验证身份证号方法
function testIdcard(idcard) {
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

//验证是否成年
function testAge(idcard) {
    var yy, mm, dd, age;
    if (idcard.length == 18) {
        yy = idcard.substr(6, 4)
        mm = idcard.substr(10, 2)
        dd = idcard.substr(12, 2)
    } else {
        return "身份证号位数不对";
    }
    age = now.getFullYear() - yy;

    if (age > 18) {
        return "通过";
    }
    else if (age == 18) {
        if (mm < now.getMonth() + 1) {
            return "通过";
        }
        else if (mm == now.getMonth() + 1)
            if (dd <= now.getDate()) {
                return "通过";
            }
            else {
                return "年龄不能小于18岁";
            }
        else {
            return "年龄不能小于18岁";
        }
    }
    else {
        return "年龄不能小于18岁";
    }
}

function RealNameValid() {
    if (!ValidRealName()) {
        return;
    }
    $.ajax({
        async: false,
        url: "/Activity/inviteGetgift/ajax.ashx",
        dataType: "json",
        type: "post",
        data: {
            cmd: "RegisterRealNameValid", realname: $("#txtRealName").val(), idcard: $("#txtIdCard").val()
        },
        success: function (json) {
            if (json.result == "1") {
                window.location = location.href;
            }
            else {
                $("#dv1").css("display", "none");
                alert(json.msg);
            }
        },
        error: function () {
            alert("认证失败");
        }
    });
}

function InvestExperienceGold() {
    $.ajax({
        async: false,
        url: "/Activity/inviteGetgift/ajax.ashx",
        dataType: "json",
        type: "post",
        data: {
            cmd: "ExperienceGoldInvest"
        },
        success: function (json) {
            $("#dv3").css("display", "block");
            switch (json.result) {
                case "-1":
                    $("#dv3").find("p").html("您还未登录，登录之后才能使用");
                    $("#dv3").find(".c-fd5f61").attr("href", "/user/Login.aspx?ReturnUrl=" + window.location.href);
                    break;
                case "-100":
                    $("#dv3").find("p").html("程序异常!");
                    $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
                    break;
                case "-101":
                case "0":
                    $("#dv3").find("p").html("领取失败!");
                    $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
                    break;
                case "1":
                    $("#dv3").find("p").html("您已领取2000元体验金<br />马上投资吧！!");
                    $("#dv3").find(".c-fd5f61").attr("href", "/pages/invest/invest_list.aspx");
                    break;
                case "2":
                    $("#dv3").find("p").html('您已经领取过体验金红包，不能再领取了！不过还有更多新手红包等您来领取');
                    $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
                    break;
                case "3":
                    $("#dv3").find("p").html('未领取体验金红包');
                    $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
                    break;
                case "4":
                    $("#dv3").find("p").html('对不起，您的体验金红包已过期');
                    $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
                    break;
                case "5":
                    $("#dv3").find("p").html('对不起，您的体验金红包已经使用');
                    $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
                    break;
            }
        },
        error: function () {
            $("#dv3").css("display", "block");
            $("#dv3").find("p").html("程序异常");
            $("#dv3").find(".c-fd5f61").attr("href", "javascript:closewin('dv3');");
        }
    });
}
function closewin(Id) {
    $("#" + Id).css("display", "none");
}