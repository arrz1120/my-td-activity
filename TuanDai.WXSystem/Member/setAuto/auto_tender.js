
$(function () {
    //
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-yellow',
        radioClass: 'iradio_square-yellow',
        increaseArea: '20%'

    });

    //  限制只能输入数字
    limitInt($("input[typeval='num']"));
    limitNumber($("input[typeval='float']"));

     
    $('input').on('ifClicked', function () {
        if ($(this).attr("checked") == "checked") {
            $(this).removeAttr("checked");
        } else {
            $(this).attr("checked", "checked");
        }
    });
    var type = $("#type").val();
    if (type == "0") {
        setCheck(); //新增
    } else {
        setEdit(); //修改
    }

    //保存
    $("#btnSubmit").click(function () {
        var ok = AllChecked();
        if (ok) {
            if ($("#ckbGptype").attr("checked") == "checked" && $("#ckbPzRepay").attr("checked") != "checked") {
                var str = "您选择了证券宝，却没有选择'满标付息'，是否需要设置？"
                ShowMsg(str, 1, "不需要", "", SaveData, Close, "需要");
            } else {
                SaveData();
            }
        }
    });
    //删除
    $("#del").click(function () {
        var id = $("#id").val();

        ShowMsg("确定要删除吗？", 1, "确定", "", Delete, Close, "取消");
        function Delete() {
            $.ajax({
                url: "/ajaxCross/ajax_autoLoan.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "deleteAuto", id: id },
                success: function (json) {
                    var d = json.result;
                    if (parseInt(d) == 1) {
                        alert("删除成功")
                        window.location.href = "auto_invest.aspx";
                    }
                    else {
                        alert("删除失败");
                        Close();
                    }
                },
                error: function () {
                    alert("删除失败");
                    Close();
                }
            });
        }
    });

})
//新增
function setCheck() {
    $('input').iCheck('check');
    $("#Ptype").text("微团贷,商友贷...");
    $("#Wtype").text("一次性还款,每月付息...");

    var ProjectTypes = new Array("9", "1", "3", "6", "17");
    for (var i = 0; i < ProjectTypes.length; i++) {
        $("input[name='ProjectType'][value='" + ProjectTypes[i] + "']").attr("checked", "checked");
    }
    var RepaymentTypes = new Array("1", "2", "4", "6");
    for (var i = 0; i < RepaymentTypes.length; i++) {
        $("input[name='RepaymentType'][value='" + RepaymentTypes[i] + "']").attr("checked", "checked");
    }
}
//修改
function setEdit() {
    //$("#dvMaxAmount").hide();
    var id = $("#id").val();
    $.ajax({
        url: "/ajaxCross/ajax_autoLoan.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "getSingleAuto", id: id },
        success: function (json) {
            var d = json.result;
            if (d == "1") {
                $("#beginRate").val(json.beginRate);
                $("#endRate").val(json.endRate);
                $("#beginDeadline").val(json.beginDeadline);
                $("#endDeadline").val(json.endDeadline);
                //类型
                var Ptype = "";
                for (var i = 0; i < json.ProjectType.split(',').length; i++) {
                    $("input[name='ProjectType'][value='" + json.ProjectType.split(',')[i] + "']").iCheck('check');
                    $("input[name='ProjectType'][value='" + json.ProjectType.split(',')[i] + "']").attr("checked", "checked");
                    //
                    var con = $("input[name='ProjectType'][value='" + json.ProjectType.split(',')[i] + "']").parent().parent().prev().text();
                    if (i < 2) {
                        if (Ptype == "")
                            Ptype = con;
                        else
                            Ptype = Ptype + "," + con;
                    }
                }
                if (json.ProjectType.split(',').length > 2)
                    Ptype = Ptype + "...";
                $("#Ptype").text(Ptype);

                //还款方式
                var Wtype = "";
                for (var i = 0; i < json.RepaymentType.split(',').length; i++) {
                    $("input[name='RepaymentType'][value='" + json.RepaymentType.split(',')[i] + "']").iCheck('check');
                    $("input[name='RepaymentType'][value='" + json.RepaymentType.split(',')[i] + "']").attr("checked", "checked");
                    //
                    var con = $("input[name='RepaymentType'][value='" + json.RepaymentType.split(',')[i] + "']").parent().parent().prev().text();
                    if (i < 2) {
                        if (Wtype == "")
                            Wtype = con;
                        else
                            Wtype = Wtype + "," + con;
                    }
                }
                if (json.RepaymentType.split(',').length > 2)
                    Wtype = Wtype + "...";
                $("#Wtype").text(Wtype);
            }

            if (json.ReservedAmout == "0") {
                $("#ReservedAmout").val("");
            }
            else {
                $("#ReservedAmout").val(json.ReservedAmout);
            }
            $("#beginDate").val(json.beginDate);
            $("#endDate").val(json.endDate);
            //$("#preAmout").val(json.preAmout);
//            if (json.preAmout != "100000000") {
//                $("#dvMaxAmount").show();
//            }
        }
    });
}
//保存
function SaveData() {
    var ProjectType = "";
    var beginDeadline = "";
    var endDeadline = "";
    var RepaymentType = "";
    for (var i = 0; i < $("input[name='ProjectType']:checked").length; i++) {
        if (ProjectType == "") {
            ProjectType = $($("input[name='ProjectType']:checked").eq(i)).val();
        }
        else {
            ProjectType = ProjectType + "," + $($("input[name='ProjectType']:checked").eq(i)).val();
        }
    }
    for (var i = 0; i < $("input[name='RepaymentType']:checked").length; i++) {
        if (RepaymentType == "") {
            RepaymentType = $($("input[name='RepaymentType']:checked").eq(i)).val();
        }
        else {
            RepaymentType = RepaymentType + "," + $($("input[name='RepaymentType']:checked").eq(i)).val();
        }
    }

    ProjectType = ProjectType.replace("6", "6,7");
    ProjectType = ProjectType.replace("9", "9,10,11");
    beginDeadline = $("#beginDeadline").val();
    endDeadline = $("#endDeadline").val();
    var beginRate = $("#beginRate").val();
    var endRate = $("#endRate").val();
    var preAmout = "100000000"; //$("#preAmout").val();
    var ReservedAmout = $("#ReservedAmout").val();
    var beginDate = $("#beginDate").val();
    var endDate = $("#endDate").val();
    var cmd = "addAuto";
    var id = "";
    var attrid = $("#id").val();
    if (attrid != "") {
        cmd = "updateAuto";
        id = attrid;
    }

    ShowMsg("确定提交自动投标设置？", 1, "确定", "", Submit, Close, "取消");
    function Submit() {
        $.ajax({
            url: "/ajaxCross/ajax_autoLoan.ashx",
            type: "post",
            async: true,
            dataType: "json",
            data: { Cmd: cmd, ProjectType: ProjectType, beginRate: beginRate, endRate: endRate, beginDeadline: beginDeadline, endDeadline: endDeadline, RepaymentType: RepaymentType, ReservedAmout: ReservedAmout, preAmout: preAmout, beginDate: beginDate, endDate: endDate, id: id },
            success: function (json) {
                var d = json.result;
                if (parseInt(d) == 1) {
                    alert("保存成功")
                    window.location.href = "auto_invest.aspx";
                }
                else if (parseInt(d) == -2) {
                    alert("自动投标只能设置3条");
                    Close();
                }
                else {
                    alert("保存失败");
                    Close();
                }
            },
            error: function () {
                alert("保存失败");
                Close();
            }
        });
    }
}

//投标金额
function checkpreAmout() {
    return true;
//    var preAmout = $("#preAmout").val();
////    if (preAmout == "") {
////        alert("投资金额不能小于" + perAmountLimit);
////        return false;
////    }
//    if (parseInt(preAmout) < perAmountLimit) {
//        alert("投资金额不能小于" + perAmountLimit);
//        return false;
//    }
//    else if (parseInt(preAmout) % 100 > 0) {
//        alert("投资金额必须是100的倍数");
//        return false;
//    }
//    else {
//        return true;
//    }
}
//利率范围
function checkbeginRate() {
    if ($("#beginRate").val() == "" && $("#endRate").val() == "") {
        alert("请输入年化利率");
        return false;
    }
    if (parseInt($("#beginRate").val()) < 5) {
        alert("年化利率不能低于5%");
        return false;
    }
    if (($("#endRate").val() == "" && $("#beginRate").val() != "") || ($("#beginRate").val() == "" && $("#endRate").val() != "")) {
        var strbeginrate = ($("#beginRate").val() == "" ? "开始" : "结束");
        alert("请输入" + strbeginrate + "利率范围");
        return false;
    }
    if ($("#endRate").val() != "" && parseInt($("#beginRate").val()) > parseInt($("#endRate").val())) {
        alert("利率范围填写有误");
        return false;
    } else {
        return true;
    }
}
function checkendRate() {
    if ($("#beginRate").val() == "" && $("#endRate").val() == "") {
        alert("请输入年化利率");
        return false;
    }
    if (parseInt($("#beginRate").val()) < 5) {
        alert("年化利率不能低于5%");
        return false;
    }
    if (($("#endRate").val() == "" && $("#beginRate").val() != "") || ($("#beginRate").val() == "" && $("#endRate").val() != "")) {
        var strbeginrate = ($("#beginRate").val() == "" ? "开始" : "结束");
        alert("请输入" + strbeginrate + "利率范围");
        return false;
    }
    if ($("#beginRate").val() != "" && parseInt($("#beginRate").val()) > parseInt($("#endRate").val())) {
        alert("利率范围填写有误");
        return false;
    }
    else {
        return true;
    }
}
//回购期限
function checkbeginDeadline() {
    if ($("#beginDeadline").val() == "" && $("#endDeadline").val() == "") {
        alert("请输入回购期限");
        return false;
    }
    if (($("#beginDeadline").val() == "" && $("#endDeadline").val() != "") || ($("#endDeadline").val() == "" && $("#beginDeadline").val() != "")) {
        var strdeadline = ($("#beginDeadline").val() == "" ? "开始" : "结束");
        alert("请输入" + strdeadline + "回购期限");
        return false;
    }
    if ($("#endDeadline").val() != "" && parseInt($("#beginDeadline").val()) > parseInt($("#endDeadline").val())) {
        alert("回购期限填写有误");
        return false;
    }
    if (parseInt($("#endDeadline").val()) > 36) {
        alert("回购期限最大为36个月");
        return false;
    }
    else {
        return true;
    }
}
function checkendDeadline() {
    if ($("#beginDeadline").val() == "" || $("#endDeadline").val() == "") {
        alert("请输入回购期限");
        return false;
    }
    if (($("#beginDeadline").val() == "" && $("#endDeadline").val() != "") || ($("#endDeadline").val() == "" && $("#beginDeadline").val() != "")) {
        var strdeadline = ($("#beginDeadline").val() == "" ? "开始" : "结束");
        alert("请输入" + strdeadline + "回购期限");
        return false;
    }
    if ($("#beginDeadline").val() != "" && parseInt($("#beginDeadline").val()) > parseInt($("#endDeadline").val())) {
        alert("回购期限填写有误");
        return false;
    }
    if (parseInt($("#endDeadline").val()) > 36) {
        alert("回购期限最大为36个月");
        return false;
    }
    else {
        return true;
    }
}
//有效期
function checkbeginDate() {
    var begindate = $("#beginDate").val();
    var enddate = $("#endDate").val();
    if (begindate == "") {
        return true;
    }
    if (begindate.length == 8) {
        var nYear = begindate.substring(0, 4);
        var nMonth = begindate.substring(4, 6);
        var nDay = begindate.substring(6, 8);
        begindate = nYear + "-" + nMonth + "-" + nDay;
        $("#beginDate").val(begindate);
    }
    if (!check(begindate)) {
        alert("开始时间输入有误");
        return false;
    }
    if (enddate != "" && new Date(begindate) > new Date(enddate)) {
        alert("有效期范围填写有误");
        return false;
    } else {
        return true;
    }
}
function check(date) {
    return (new Date(date).getDate() == date.substring(date.length - 2));
}
function checkendDate() {
    var begindate = $("#beginDate").val();
    var enddate = $("#endDate").val();
    if (enddate == "") {
        return true;
    }
    if (enddate.length == 8) {
        var nYear = enddate.substring(0, 4);
        var nMonth = enddate.substring(4, 6);
        var nDay = enddate.substring(6, 8);
        enddate = nYear + "-" + nMonth + "-" + nDay;
        $("#endDate").val(enddate);
    }
    if (!check(enddate)) {
        alert("结束时间输入有误");
        return false;
    }
    if (begindate != "" && new Date(begindate) > new Date(enddate)) {
        alert("有效期范围填写有误");
        return false;
    } else {
        return true;
    }
}
//投资类型
function checkType() {
    if ($("input[name='ProjectType']:checked").length == 0) {
        alert("至少选择一种类型");
        return false;
    }
    else {
        return true;
    }
}
//还款方式
function checkRepaymentType() {
    if ($("input[name='RepaymentType']:checked").length == 0) {
        alert("至少选择一种还款方式");
        return false;
    }
    else {
        return true;
    }
}


function AllChecked() {
    var ok2 = checkbeginRate();
    if (ok2) {
        var ok3 = checkendRate();
        if (ok3) {
            var ok6 = checkbeginDate();
            if (ok6) {
                var ok7 = checkendDate();
                if (ok7) {
                    var ok8 = checkpreAmout();
                    if (ok8) {
                        var ok4 = checkbeginDeadline();
                        if (ok4) {
                            var ok5 = checkendDeadline();
                            if (ok5) {
                                var ok9 = checkType();
                                if (ok9) {
                                    var ok1 = checkRepaymentType();
                                    if (ok1) {
                                        return true;
                                    } else { return false; }
                                } else { return false; }
                            } else { return false; }
                        } else { return false; }
                    } else { return false; }
                } else { return false; }
            } else { return false; }
        } else { return false; }
    } else { return false; }

}

//限制只能输入数字
function limitInt(fn) {
    $(fn).keydown(function (e) {
        if (((e.keyCode > 47) && (e.keyCode < 58)) || (e.keyCode == 9) || (e.keyCode == 8) || ((e.keyCode >= 96) && (e.keyCode <= 105))) {// 判断键值  
            return true;
        } else {
            return false;
        }

    }).focus(function () {
        this.style.imeMode = 'disabled';
    }); 
}
//限制只能输入数字(可以含有小数)
function limitNumber(fn) {
    $(fn).keydown(function (e) {
        // 注意此处不要用keypress方法，否则不能禁用　Ctrl+V 与　Ctrl+V,具体原因请自行查找keyPress与keyDown区分，十分重要，请细查

        if (((e.keyCode > 47) && (e.keyCode < 58)) || (e.keyCode == 110) || (e.keyCode == 9) || (e.keyCode == 8) || ((e.keyCode >= 96) && (e.keyCode <= 105))) {// 判断键值  

            return true;
        } else {
            return false;
        }

    }).focus(function () {
        this.style.imeMode = 'disabled';   // 禁用输入法,禁止输入中文字符
    }); 
}

//提示
function ShowMsg(msg, isShowOk, okValue, url, funOk, funCancle, CancleValue) {
    $("#btnOk").unbind("click"); //
    $("#btnCancle").unbind("click"); //
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    if (isShowOk == "1") {
        $("#btnOk").html(okValue);
        // $("#btnOk").attr("href", url);
        $("#btnOk").parent().show();
        $("#btnOk").click(funOk); //
    } else {
        $("#btnOk").parent().hide();
    }
    $("#btnCancle").click(funCancle); //
    $("#btnCancle").val(CancleValue); //
    var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
    $("#tip").animate({
        bottom: bottom
    }, 200)
}
//关闭弹窗
function Close() {
    $(".maskLayer").fadeOut();
    $("#tip").animate({
        bottom: "-430px"
    }, 200);
}