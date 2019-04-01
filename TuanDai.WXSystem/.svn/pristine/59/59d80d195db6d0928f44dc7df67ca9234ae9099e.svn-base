var interestRate = 10;
$(window).ready(function () {
    limitInt($("#txtAmount"));
    limitInt($("#txtTimes"));

    $(".maskLayer").click(function () {
        Done();
    });
    $("#beforeApply").click(function () {
        var txtAmount = $("#txtAmount").val().trim().replace(/,/g, "");
        if (txtAmount == "" || txtAmount == "0") {
            ShowMsg('请输入保证金金额', '0', '', '');
            return;
        }

        var regAmount = /^[0-9]*[1-9][0-9]*$/;
        if (!regAmount.test(txtAmount)) {
            ShowMsg('保证金格式不正确', '0', '', '');
            return;
        }

        var Amount = parseInt(txtAmount);
        if (Amount % 1000 != 0) {
            ShowMsg('保证金必须是1000的整数倍', '0', '', '');
            return;
        }
        var deposit = parseInt(curObj.amount1);
        if (Amount < deposit) {
            ShowMsg("保证金不能低于" + deposit + "元", '0', '', '');
            return;
        }

        deposit = parseInt(curObj.amount2) / 5;
        if (Amount > deposit) {
            Amount = deposit;
            $("#txtAmount").val(formatMoney(deposit.toString(), 0));
        }
        var strtimes = $("#txtTimes").val();
        if (strtimes == "") {
            ShowMsg('请输入配资比例', '0', '', '');
            return;
        }
        if (strtimes != "2" && strtimes != "3" && strtimes != "4" && strtimes != "5") {
            ShowMsg('配资比例只能是2~5倍', '0', '', '');
            return;
        }

        var txtRate = $("#txtRate").val().trim();
        if (txtRate == "") {
            ShowMsg('请输入利率', '0', '', '');
            return;
        }
        else if (!NumberCheck(txtRate)) {
            ShowMsg('利率格式不正确', '0', '', '');
            return;
        }
        else if (parseFloat(txtRate) > 24) {
            ShowMsg('利率不能高于24%', '0', '', '');
            return;
        }
        else if (parseFloat(txtRate) < parseFloat(interestRate)) {
            ShowMsg("利率不能低于" + interestRate + "%", '0', '', '');
            return;
        }

        $(".maskLayer").fadeIn();
        $("#affirmLoanMain").animate({
            bottom: "0"
        }, 200);
        $("#txtPayPwd").focus();
    });

    $("#txtAmount").blur(function () {
        $("#divtip").hide();
        var txtAmount = $(this).val().trim().replace(/,/g, "");
        if (txtAmount.substr(0, 1) == "0") {
            $(this).val(txtAmount.substr(1));
        }
        if (txtAmount == "" || txtAmount == "0") {
            $(this).val("0");
            return;
        }
        var Amount = parseInt(txtAmount);
        if (Amount % 1000 != 0) {
            $(this).val(parseInt(Amount / 1000) * 1000);
            CheckNum();
        }
        var deposit = parseInt(curObj.amount1);
        if (Amount < deposit) {
            $(this).val("10000");
            CheckNum();
            return;
        }
    }).keyup(function () {
        var txtAmount = $(this).val().trim().replace(/,/g, "");
        if (txtAmount == "0") {
            $(this).val("");
        } else if (txtAmount.substr(0, 1) == "0") {
            $(this).val(txtAmount.substr(1));
        }
        CheckNum();
    });

    $("#txtTimes").change(function () {
        CheckNum();
    });

    $("#deadline").change(function () {
        var rate = $(this).val();
        switch (rate) {
            case "15":
                $("#txtRate").val("10");
                interestRate = 10;
                break;
            case "26":
                $("#txtRate").val("11");
                interestRate = 11;
                break;
            case "30":
                $("#txtRate").val("11.5");
                interestRate = 11.5;
                break;
            case "45":
                $("#txtRate").val("12");
                interestRate = 12;
                break;
            case "60":
                $("#txtRate").val("13");
                interestRate = 13;
                break;
            case "90":
                $("#txtRate").val("14");
                interestRate = 14;
                break;
            case "180":
                $("#txtRate").val("15");
                interestRate = 15;
                break;
        }
        CheckNum();
    });

    $("#txtRate").blur(function () {
        var txtRate = $(this).val().trim();
        if (txtRate == "" || txtRate == "0") {
            $(this).val("");
            return;
        }
        else {
            CheckNum();
        }
    }).keyup(function () {
        var txtRate = $(this).val().trim();
        if (txtRate == "0" || txtRate == "") {
            $(this).val("");
        } else if (parseFloat(txtRate) > 24) {
            $(this).val("24");
        } else {
            $(this).val(Round1(txtRate));
        }
        CheckNum();
    });

});

function NumberCheck(num) {
    var re = /^[+-]?\d+(\.\d+)?$/;
    return re.exec(num) != null;
}

function formatMoney(num, n) {
    var re = /(-?\d+)(\d{3})/;
    while (re.test(num))
        num = num.replace(re, "$1,$2")
    return n ? num : num.replace(/^([0-9,]+\.[1-9])0$/, "$1").replace(/^([0-9,]+)\.00$/, "$1"); ;
}

function CheckNum() {
    var txtAmount = $("#txtAmount").val().trim().replace(/,/g, "");
    var regAmount = /^[0-9]*[1-9][0-9]*$/;
    if (!regAmount.test(txtAmount)) {
        txtAmount = 0;
    }
    if (txtAmount == "") {
        txtAmount = 0;
    } else {
        $("#txtAmount").val(formatMoney(txtAmount, 0));
    }
    var Amount = parseInt(txtAmount);
    var deposit = parseInt(curObj.amount2) / 5;
    if (Amount > deposit) {
        Amount = deposit;
        $("#txtAmount").val(formatMoney(deposit.toString(), 0));
    }

    $("#depositAmount").html(formatMoney(Round2(Amount), 0));
    if ($("#txtTimes").val() != "") {
        Calculate(Amount);
    }
}
var total = 0;
function Calculate(Amount) {
    var times = parseInt($("#txtTimes").val());
    $("#traderAmount").html(formatMoney(Round2(Amount * (times + 1)).toString(), 0));
    $("#warningAmount").html(formatMoney(Round2(Amount * (times + 0.5)).toString(), 0));
    $("#coverAmount").html(formatMoney(Round2(Amount * times + Amount * 0.3).toString(), 0));
    $("#managerAmount").html(formatMoney(Round2(Amount * (times + 1) * parseFloat(curObj.managerAmount)).toString(), 0));
    var serviceRate = parseFloat(CalculateRate(Amount, times));
    var deadline = $("#deadline").val();
    var rate = $("#txtRate").val() == "" ? 0 : parseFloat($("#txtRate").val());
    if (deadline <= 30) {
        $("#totalInterest").html(formatMoney(fnRound(Amount * times * parseFloat(rate) / 100 * parseInt(deadline) / 360).toFixed(2), 0));
        $("#serviceAmount").html(formatMoney((Amount * times * serviceRate / 100 * parseInt(deadline)).toFixed(2), 0));
        total = formatMoney((Amount + Amount * (times + 1) * parseFloat(curObj.managerAmount) + fnRound(Amount * times * parseInt(deadline) * parseFloat(rate) / 100 / 360) + Amount * times * parseInt(deadline) * serviceRate / 100).toFixed(2), 0);
    } else {
        $("#totalInterest").html(formatMoney(fnRound(Amount * times * parseFloat(rate) / 100 * 30 / 360).toFixed(2), 0));
        $("#serviceAmount").html(formatMoney((Amount * times * serviceRate / 100 * 30).toFixed(2), 0));
        total = formatMoney((Amount + Amount * (times + 1) * parseFloat(curObj.managerAmount) + fnRound(Amount * times * 30 * parseFloat(rate) / 100 / 360) + Amount * times * 30 * serviceRate / 100).toFixed(2), 0);
    }

    $("#totalPayAmount").html(total);
}

function fnRound(a) {
    if (parseFloat(a) > parseInt(a)) {
        return parseInt(a) + 1;
    } else {
        return parseInt(a);
    }
}

function CalculateRate(Amount, times) {
    var borrowAmount = Amount * times;
    if (borrowAmount < parseInt(curObj.para1)) {
        return curObj.param1Value;
    } else if (borrowAmount >= parseInt(curObj.para1) && borrowAmount < parseInt(curObj.para2)) {
        return curObj.param2Value;
    } else {
        return curObj.param3Value;
    }
}
function Done() {
    $(".maskLayer").fadeOut();
    $("#affirmLoanMain").animate({
        bottom: "-430px"
    }, 200)
    $("#tip").animate({
        bottom: "-430px"
    }, 200)
}

function ShowMsg(msg, isShowOk, okValue, url) {
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    if (isShowOk == "1" && url!="") {
        $("#btnOk").html(okValue);
        $("#btnOk").attr("href", url);
        $("#btnCancel").val("取消");
        $("#btnOk").parent().show();
    } else {
        $("#btnCancel").val("确定");
        $("#btnOk").parent().hide();
    }
    var bottom = (document.documentElement.clientHeight -document.getElementById("tip").offsetHeight) / 2;
    $("#affirmLoanMain").animate({
        bottom: "-430px"
    }, 200)

    $("#tip").animate({
        bottom: bottom
    }, 200)
}
//获取1位小数，不四舍五入
function Round1(temp) {
    temp = temp.toString();
    if (temp.indexOf(".") > -1) {
        return temp.substring(0, temp.indexOf(".") + 2);
    }
    else {
        return temp;
    }
}

function CheckData() {
    var pwd = $("#txtPayPwd").val().trim();
    if (pwd == "") {
        alert('为了您的账户安全，请输入交易密码');
    }
    else {
        ShowMsg('正在验证信息，请稍候...', '0', '', '');

        $.ajax({
            url: "/ajaxCross/ajax_stock.ashx",
            type: "post",
            dataType: "json",
            async: true,
            data: {
                Cmd: "ApplyBefore"
            }, success: function (data) {
                if (data != null && data.result == "1") {
                    SubmitData(pwd);
                } else if (data.result == "2") {
                    ShowMsg('您还未登录，登录之后才能发标', '1', '登录', '/user/Login.aspx');
                } else if (data.result == "-99") {
                    ShowMsg('登录超时，请重新登录', '1', '登录', '/user/Login.aspx');
                }
                else if (data.result == "4") {
                    ShowMsg('为保障您的资金安全，请先完成安全设置', '1', '安全设置', '/Member/safety/safety.aspx');
                } else if (data.result == "6") {
                    ShowMsg('为保障您的资金安全，请先完成交易密码设置', '1', '设置交易密码', '/Member/safety/trade_password.aspx');
                }
                else {
                    ShowMsg(data.msg, '0', '', '');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ShowMsg("信息验证失败!", '0', '', '');
            }
        });
    }
}

function SubmitData(pwd) {
    ShowMsg('正在申请配资，请稍候...', '0', '', '');
    //调用后台
    $.ajax({
        url: "/ajaxCross/ajax_stock.ashx",
        type: "post",
        dataType: "json",
        async: true,
        data: {
            Cmd: "ApplyStockMatchFund",
            Amount: $("#txtAmount").val().trim().replace(/,/g, ""),
            Lever: $("#txtTimes").val(),
            PayPwd: pwd,
            Rate: $("#txtRate").val().trim(),
            DeadLine: $("#deadline").val()
        },
        success: function (data) {
            if (data != null && data.result == "1") {
                Done();
                window.location = "StockSuccess.aspx?projectId=" + data.msg;
            } else if (data.result == "2") {
                ShowMsg('您还未登录，登录之后才能发标', '1', '登录', '/user/Login.aspx');
            } else if (data.result == "-99") {
                ShowMsg('登录超时，请重新登录', '1', '登录', '/user/Login.aspx');
            }
            else if (data.result == "10") {
                ShowMsg('为保障您的资金安全，请先完成安全设置', '1', '安全设置', '/Member/safety/safety.aspx');
            } else if (data.result == "12") {
                ShowMsg('为保障您的资金安全，请先完成交易密码设置', '1', '设置交易密码', '/Member/safety/trade_password.aspx');
            }
            else {
                ShowMsg(data.msg, '0', '', '');
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            ShowMsg('发布失败', '0', '', '');
        }
    });
}