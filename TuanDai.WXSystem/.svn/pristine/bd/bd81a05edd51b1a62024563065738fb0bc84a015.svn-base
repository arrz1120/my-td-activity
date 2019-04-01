<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="autoWeSet.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.setAuto.autoWeSet" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>自动投标-智能投资</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=20160923" />
	<link rel="stylesheet" type="text/css" href="/css/auto-invest.css?v=20160923" />
</head>
<body class="bg-f1f3f5 pb15">
    <%=GetNavStr() %>
	<div class="tabBox clearfix bg-fff">
		<div class="tabItem act w50p lf br-e6e6e6">智能投资</div>
		<div class="tabItem lf w50p" onclick="JAVASCRIPT:window.location.href='autoSet.aspx?type=0';">散标方案</div>
	</div>
	<div class="pt10 bt-e6e6e6 bb-e6e6e6"></div>
	<input type="hidden" value="<%= this.type %>" id="type"/>
    <input type="hidden" value="<%= this.id %>" id="id"/>
	<div class="selectBox selectBox1 bg-fff pl15 pb5">
		<p class="pt10 pb10 f15px">投标类型</p>
		<ul class="clearfix">
		    <li><div class="selected" data="18">复投宝(36个月)</div></li>
			<li><div class="selected" data="15">复投宝(24个月)</div></li>
			<li><div class="selected" data="14">复投宝(18个月)</div></li>
			<li><div class="selected" data="3">We计划C(12个月)</div></li>
			<li><div class="selected" data="2">We计划B(6个月)</div></li>
			<li><div class="selected" data="1">We计划A(3个月)</div></li>
			<li><div class="selected" data="9">We计划G(1个月)</div></li>
		</ul>
	</div>
	<div class="pt10 bt-e6e6e6 bb-e6e6e6"></div>
	
	<div class="pl15 bb-e6e6e6 bg-fff">
		<div class="inputBox bb-e6e6e6">
			<span class="ib_span1">预留金额</span>
			<input type="text" placeholder="请输入账户需预留金额" id="txtReservedAmount"/>
			<span class="ib_span2">元</span>
		</div>
		<div class="checkBox pt10 pb21 pt10 pb10">
			<span class="f15px">有效期</span>
			<span class="f15px"><i class="checked" id="longTime"></i>长期有效</span>
			<span class="f15px"><i id="self"></i>自定义</span>
		</div>
		<div class="dateBox hide clearfix">
			<div class="w50p lf pr15 pos-r">
				<input type="date" id="txtStartDate"/>
				<i class="ico-arrow-r ico-arrow-rl"></i>
			</div>
			<div class="w50p lf pl15 pos-r">
				<input type="date" id="txtEndDate" placeholder="请选择时间" />
				<i class="ico-arrow-r"></i>
			</div>
		</div>
        <div class="checkBox pt10 pb21 pt10 pb10 bt-e6e6e6">
            <span class="f15px"><i id="rule" class="checked"></i>我已同意<a href="auto_rule.aspx" class="f15px c-1fcafb">《自动投标规则》</a></span>
		</div>
	</div>
	
	<div class="pt10 pl10 pr10">
		<div class="btn btnYellow" id="btnSave">保存</div>
	</div>
	<% if (!string.IsNullOrEmpty(id))
	   {
	       %>
	<div class="pt10 pl10 pr10">
		<div class="btn bg-d1d1d1 c-212121" id="btnDelete">删除</div>
	</div>
	<%
	   } %>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">

    $(function () {
        var iCheck = $(".checkBox").find('i');
        var dateBox = $(".dateBox");
        iCheck.each(function(i, item) {
            $(item).click(function() {
                if (i == 0) {
                    iCheck.eq(0).addClass('checked');
                    iCheck.eq(1).removeClass('checked');
                    dateBox.addClass('hide');
                } else if (i == 1) {
                    iCheck.eq(0).removeClass('checked');
                    iCheck.eq(1).addClass('checked');
                    dateBox.removeClass('hide');
                    $("#txtStartDate").val("<%=DateTime.Now.ToString("yyyy-MM-dd")%>");
                } else {
                    if ($(item).hasClass("checked")) {
                        $(item).removeClass("checked");
                    } else {
                        $(item).addClass("checked");
                    }
                }
            });
        });

        $(".selectBox ul li div").click(function() {
            if ($(this).hasClass("selected")) {
                $(this).removeClass("selected");
            } else {
                $(this).addClass("selected");
            }
        });
        LoadDetail();//加载明细
        function LoadDetail() {
            var type = $("#type").val();
            var id = $("#id").val();
            if (type == 1 && id != "") { //修改
                $.ajax({
                    url: "/ajaxCross/ajax_autoLoan.ashx",
                    type: "post",
                    dataType: "json",
                    async: false,
                    data: { Cmd: "getWeAuto", id: id },
                    success: function(json) {
                        var d = json.result;
                        if (d == "1") {
                            var item = JSON.parse(json.msg);
                            var arr = item.ProjectType.split(",");
                            if (arr.indexOf("1") == -1)
                                $($("ul li div")[5]).removeClass("selected");
                            if (arr.indexOf("2") == -1)
                                $($("ul li div")[4]).removeClass("selected");
                            if (arr.indexOf("3") == -1)
                                $($("ul li div")[3]).removeClass("selected");
                            if (arr.indexOf("15") == -1)
                                $($("ul li div")[1]).removeClass("selected");
                            if (arr.indexOf("14") == -1)
                                $($("ul li div")[2]).removeClass("selected");
                            if (arr.indexOf("9") == -1)
                                $($("ul li div")[6]).removeClass("selected");
                            if (arr.indexOf("18") == -1)
                                $($("ul li div")[0]).removeClass("selected");
                            
                            $("#txtReservedAmount").val(item.ReservedAmout);
                            if (item.StartDate != null || item.EndDate != null) {
                                $("#longTime").removeClass("checked");
                                $("#self").addClass("checked");
                                $("#txtStartDate").val(item.StartDate.substr(0, 10));
                                $("#txtEndDate").val(item.EndDate.substr(0, 10)).attr("placeholder","");
                                $(".dateBox").removeClass("hide");
                            }
                        }
                    }
                });
            }
        }
        //保存
        $("#btnSave").click(function () {
            var investType = "";
            $("ul li div").each(function (ind, div) {
                if ($(div).hasClass("selected")) {
                    if (investType == "") {
                        investType = $(div).attr("data");
                    } else {
                        investType += "," + $(div).attr("data");
                    }
                }
            });
            if (investType == "") {
                $("body").showMessage({ message: "未选择投标类型", showCancel: false });
                return false;
            }
            
            var reservedAmount = $("#txtReservedAmount").val();
            if (reservedAmount == "") {
                reservedAmount = "0";
            }
            if (parseFloat(reservedAmount) < 0) {
                $("body").showMessage({ message: "预留金额不能小于0", showCancel: false });
                return false;
            }
            var startDate = "";
            var endDate = "";
            if ($("#self").hasClass("checked")) {
                startDate = $("#txtStartDate").val();
                if (startDate == "") {
                    $("body").showMessage({ message: "起始时间不能为空", showCancel: false });
                    return false;
                }
                endDate = $("#txtEndDate").val();
                if (endDate == "") {
                    $("body").showMessage({ message: "结束时间不能为空", showCancel: false });
                    return false;
                }
                if (startDate > endDate) {
                    $("body").showMessage({ message: "起始时间不能大于结束时间", showCancel: false });
                    return false;
                }
            }

            if (!$("#rule").hasClass("checked")) {
                $("body").showMessage({ message: "请认真阅读并同意规则", showCancel: false });
                return false;
            }

            var id = $("#id").val();
            var cmd = "addAuto";
            if (id != "") {
                cmd = "updateAuto";
            }
            $("body").showLoading("正在提交中...");
            $.ajax({
                url: "/ajaxCross/ajax_autoLoan.ashx",
                type: "post",
                async: true,
                dataType: "json",
                data: { Cmd: cmd, ProjectType: investType,  ReservedAmout: reservedAmount, beginDate: startDate, endDate: endDate, id: id, pattern: 2 },
                success: function (json) {
                    $("body").hideLoading();
                    var d = json.result;
                    if (parseInt(d) == 1) {
                        window.location.href = 'set_suc.aspx';
                    }
                    else if (parseInt(d) == -2) {
                        $("body").showMessage({ message: "自动投标只能设置3条", showCancel: false });
                        return false;
                    }
                    else {
                        $("body").showMessage({ message: json.msg, showCancel: false });
                    }
                },
                error: function () {
                    $("body").hideLoading();
                    showMessage("保存失败");
                }
            });
        });
        
        //模拟placeholder属性
        function datePlaceholder(){
	        var o = document.getElementById('txtEndDate');
			o.onfocus = function(){
			    this.removeAttribute('placeholder');
			};
			o.onblur = function(){
			    if(this.value == '') this.setAttribute('placeholder','请选择时间');
			};
        }
        datePlaceholder();
        
        //删除
        $("#btnDelete").click(function () {
            $("body").showMessage({
                message: "确定要删除吗？", okString: "删除", cancelString: "取消", okbtnEvent: function () {
                    var type = $("#type").val();
                    var id = $("#id").val();
                    if (type == 1 && id != "") {//修改
                        $.ajax({
                            url: "/ajaxCross/ajax_autoLoan.ashx",
                            type: "post",
                            dataType: "json",
                            async: false,
                            data: { Cmd: "deleteAuto", id: id, pattern: 2 },
                            success: function (json) {
                                var d = json.result;
                                if (d == "1") {
                                    window.location.href = 'auto_invest.aspx';
                                } else {
                                    $("body").showMessage({ message: json.msg, showCancel: false });
                                }
                            }
                        });
                    }
                }
            });
        });
    });

</script>

</body>
</html>