$(function () { 
    //点击保存按钮事件
    $("#btnSubmit").bind("click", function() {
        var investType = ""; //投资类型
        $("#invest_type ul li").each(function () {
            if ($(this).hasClass("active")) {
                if (investType == "") {
                    investType = $(this).attr("value");
                } else {
                    investType += "," + $(this).attr("value");
                }
            }
        });
        if (investType == "") {
            //alert("投资类型最少要选择一项");
            showMessage("投资类型最少要选择一项");
            return false;
        }
        investType = investType.replace("1,", "1,3,");
        investType = investType.replace("6", "6,7");
        investType = investType.replace("9", "9,10,11");
        var repaymentType = "";//还款方式
        $("#repayment_type ul li").each(function () {
            if ($(this).hasClass("active")) {
                if (repaymentType == "") {
                    repaymentType = $(this).attr("value");
                } else {
                    repaymentType += "," + $(this).attr("value");
                }
            }
        });
        if (repaymentType == "") {
            //alert("还款方式最少要选择一项");
            showMessage("还款方式最少要选择一项");
            return false;
        }
        var beginRate = $("#count1").html();
        var endRate = $("#count2").html();
        var beginDeadline = $("#count3").html();
        var endDeadline = $("#count4").html();
        var reservedAmout = $("#ReservedAmout").val();
        if (reservedAmout == "") {
            //alert("请输入预留金额");
            //showMessage("请输入预留金额");
            //return false;
            reservedAmout = 0;
        } if (parseFloat(reservedAmout) < 0) {
            //alert("预留金额不可输入负数");
            showMessage("预留金额不可输入负数");
            return false;
        }
        var beginDate = "";//new Date().Format("yyyy-MM-dd");开始日期从后台取
        var endDate = $.trim($("#endDate").val());
        //if (endDate == "") { 
        //    showMessage("截止日期不能为空");
        //    return false;
        //}
        if (endDate.length == 8) {
            var nYear = endDate.substring(0, 4);
            var nMonth = endDate.substring(4, 6);
            var nDay = endDate.substring(6, 8);
            endDate = nYear + "-" + nMonth + "-" + nDay;
            $("#endDate").val(endDate);
        }
        if (endDate != "") {
            if (new Date(beginDate) > new Date(endDate)) {
                //alert("截止日期不能小于当前时间");
                showMessage("截止日期不能小于当前时间");
                return false;
            }
        }
        var id = $("#id").val();
        var cmd = "addAuto";
        if (id != "") {
            cmd = "updateAuto";
        }
        var preAmout = "100000000";
        $("body").showMessage({ message: "确定提交自动投标设置？", showCancel: true, okString: "确定", okbtnEvent: Submit, cancelString: "取消" }); 
        function Submit() {
            $.ajax({
                url: "/ajaxCross/ajax_autoLoan.ashx",
                type: "post",
                async: true,
                dataType: "json",
                data: { Cmd: cmd, ProjectType: investType, beginRate: beginRate, endRate: endRate, beginDeadline: beginDeadline, endDeadline: endDeadline, RepaymentType: repaymentType, ReservedAmout: reservedAmout, preAmout: preAmout, beginDate: beginDate, endDate: endDate, id: id },
                success: function (json) {
                    var d = json.result;
                    if (parseInt(d) == 1) { 
                        $("body").hideMessage(); 
                        showMessage("保存成功", HerfTo);
                    }
                    else if (parseInt(d) == -2) {
                        $("body").hideMessage();
                        showMessage("自动投标只能设置3条"); 
                    }
                    else {
                        $("body").hideMessage();
                        showMessage(json.msg); 
                    }
                },
                error: function () {
                    $("body").hideMessage();
                    showMessage("保存失败"); 
                }
            });
        }
    });
    //删除
    $("#del").click(function () {
        var id = $("#id").val();
        if (id == "") { 
            showMessage("删除失败");
            return false;
        } 
        $("body").showMessage({ message: "确定要删除吗？", showCancel: true, okString: "确定", okbtnEvent: Delete, cancelString: "取消" });
        function Delete() {
            $.ajax({
                url: "/ajaxCross/ajax_autoLoan.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "deleteAuto", id: id },
                success: function (json) {
                    var d = json.result;
                    if (parseInt(d) == 1) {
                        //alert("删除成功");
                        $("body").hideMessage();
                        showMessage("删除成功", HerfTo);
                    }
                    else {
                        $("body").hideMessage();
                        showMessage("删除失败"); 
                    }
                },
                error: function () {
                    $("body").hideMessage();
                    showMessage("删除失败"); 
                }
            });
        }
    });
    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
    // 例子： 
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
    Date.prototype.Format = function (fmt) { //author: meizz 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
});