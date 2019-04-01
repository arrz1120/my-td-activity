<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="Apply.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.loan.Apply" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>申请资产标</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/pay.css?v=20160309" />
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body class="bg-f1f3f5 pos-r" style="width: 100%;overflow-x: hidden;">
    <%= this.GetNavStr()%>
	<header class="headerMain">
	    <div class="header bb-e6e6e6">
	        <a class="back" href="borrowMoney.aspx">返回</a>
	        <h1 class="title">申请资产标</h1>
	    </div>
        <%= this.GetNavIcon()%>
	    <div class="none"></div>
	</header>
	<div class="pb80">
		<div class="mt10 pl15 bg-fff bt-e6e6e6 bb-e6e6e6">
			<div class="abs-inpBox">
				<span>标题</span>
				<input class="oInp" type="text" placeholder="请输入借款标题" id="title"/>
			</div>
			<div class="abs-inpBox bt-e6e6e6">
				<span>借款理由</span>
				<input class="oInp" type="text" placeholder="请输入借款理由" id="purpose"/>
			</div>
		</div>
		
		<div class="c-fd6040 f13px pt20 pb10 pl15">您的可用借款额度为:  ¥<%=ToolStatus.ConvertLowerMoney(creditAmount) %>元</div>
		
		<div class="pl15 bg-fff bt-e6e6e6 bb-e6e6e6">
			<div class="abs-inpBox">
				<span>借款金额</span>
                <input type="hidden" value="<%=creditAmount %>" id="hdbidType" name="hdbidType"  datarate="<%=tuandaiFeeRate%>"/>
				<input class="oInp" type="number" placeholder="请输入借款金额" id="amount" onkeyup="value=value.replace(/[^\d.]/g,'')"  onblur="value=value.replace(/[^\d.]/g,'')"/>
				<i>元</i>
			</div>
		</div>
		
		<div class="c-fd6040 f13px pt20 pb10 pl15"><%--15天~1个月免管理费，--%>4天未满标则自动下架</div>
		
		<div class="pl15 bg-fff bt-e6e6e6 bb-e6e6e6">
			<a class="abs-inpBox">
				<span>还款期限</span>
				<%--<input class="oInp" type="text" placeholder="请选择还款期限"/>--%>
                <input type="hidden" id="dealType"  />
				<img src="/imgs/images/ico_arrow_r3.png"/>
                <select name="deadline" class="select" id="deadline" style="width:100%;height:80%;font-size:1.4rem; border: hidden;outline:none;"> 
                        <option value="" dealtype="" ></option>
                    <% int j = 0; 
                        for (int i = minDeadlineDay, k = 0; i <= maxDeadlineDay; i++, k++)
                        {%>
                    <option value="<%=i %>" dealtype="2" ><%=i %>天</option>
                    <%
                            j = k;
                        }
                        for (int i = 1, q = j + 1; i <= maxDeadline; i++, q++)
                        {%>
                    <option value="<%=i %>" dealtype="1" ><%=i %>个月</option>
                    <%}%>
                </select>
			</a>
			<div class="abs-inpBox bt-e6e6e6">
				<span>最小单位</span>
				<input class="oInp" type="number" placeholder="请输入最小投资单位" id="unit" onkeyup="value=value.replace(/[^\d.]/g,'')" onblur="value=value.replace(/[^\d.]/g,'')"/>
				<i>元</i>
			</div>
			<div class="abs-inpBox bt-e6e6e6">
				<span>年化利率</span>
				<input class="oInp" type="number" placeholder="请输入年化利率" id="interestRate" onkeyup="value=value.replace(/[^\d.]/g,'')" onblur="value=value.replace(/[^\d.]/g,'')"/>
				<i>%</i>
			</div>
			<a class="abs-inpBox bt-e6e6e6 repayType">
				<span>还款方式</span>
				<%--<input class="oInp" type="text" placeholder="请选择还款方式" id="repaymentDesc" readonly/>
				<img src="/imgs/images/ico_arrow_r3.png"/>--%>
                <div class="repayType-select">
					<span style="border-right:1px solid rgb(255,207,10);" dataValue="1">到期本息</span>
					<span dataValue="2">每月付息</span>
				</div>
			</a>
			<div class="abs-inpBox bt-e6e6e6">
				<span>交易密码</span>
				<input class="oInp" type="password" placeholder="请输入交易密码" id="txtPayPwd"/>
			</div>
		</div>
	</div>
	<div class="bg-ffcf1f bottom-btn c-ffffff f17px text-center" id="borrow-now">马上借款</div>
	
	<!--确认借款弹框-->
	<div class="alert hide" id="alert">
		<div class="pos-a bg-fff w100p" id="borrow-alert">
			<div class="clearfix ml15 pt15 pb15 pr15">
				<div class="lf f17px c-212121">总利息</div>
				<div class="rf f17px c-ababab"><span class="c-fd6040 f17px" id="interest">0.00</span>元</div>
			</div>
			<div class="clearfix ml15 bt-e6e6e6 pt15 pb15 pr15">
				<div class="lf">
					<p class="f17px c-212121">管理费</p>
                    <% if (ManagerRate < 1)
                       {
                    %>
                    <p class="c-ababab f13px" id="p_sale">V<%= UserVipLevel %>会员<%= ManagerRate*10 %>折优惠，已优惠<span class="c-fd6040 f13px" id="tuandaiSale">0.00</span>元</p>
                    <%
                       }
                       else
                       {
                           %>
                    <p class="c-ababab f13px">V<%= UserVipLevel %>会员无折扣优惠</p>
                    <%
                       } %>
					
				</div>
				<div class="rf f17px c-ababab mt10"><span class="c-fd6040 f17px" id="tuandaiFee">0.00</span>元</div>
			</div>
			<div class="bg-ffcf1f c-ffffff f17px text-center pt15 pb15" id="borrow-confirm">确认借款</div>
		</div>
	</div>
	<!--校验提示语-->
	<div class="error-tips" style="display: none;"></div>
    <!--遮罩层-->
    <div class="maskLayer hide"></div>
    <!--加载进度条-->
    <div class="loadAlert" style="display:none;z-index:1000;">
        <div class="loadTips">
            <div class="loadingCirle"></div>
            
            <div class="loadTips_txt"><h3>借款申请中，请稍等...</h3></div>
        </div>
    </div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=12456421456546"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script src="/scripts/icheck.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript">
    var IsRegHasOneMonth = "<%=IsRegHasOneMonth%>";
    //确认借款弹框
    function moveToTop(ele) {
        $("#alert").removeClass('hide');
        $(ele).removeClass('moveToBottom').addClass('moveToTop');
    }
    function moveToBottom(ele) {
        $(ele).removeClass('moveToTop').addClass('moveToBottom');
        setTimeout(function () {
            $("#alert").addClass('hide');
        }, 400);
    }
    function showTips(placeholder) {
        $('.error-tips').html(placeholder).fadeIn(function () {
            setTimeout(function () {
                $('.error-tips').fadeOut();
            }, 1000);
        });
    }
    //校验input是否为空，如果为空，显示提示，不为空，显示弹框
    $("#borrow-now").click(function () {
        var aInput = $('.oInp');
        var placeholder = '';
        aInput.each(function (i) {
            var eq = aInput.eq(i);
            if (eq.val() == '') {
                placeholder = eq.attr('placeholder');
                return false;
            }
        });
        if (placeholder == '') {
            Check();
        } else {
            showTips(placeholder);
        }
    });

    $("#alert").click(function () {
        moveToBottom("#borrow-alert");
    });
    $("#borrow-confirm").click(function () {
        moveToBottom("#borrow-alert");
        submitApply();
    })
    $("#borrow-alert").click(function () {
        return false;
    });

    var endDeadlineDay = "<%=endDeadlineDay%>";
    var isFree = "<%= IsProjectFreePaidUser%>";
    var repayment = 0;
    var managerRate = '<%= ManagerRate%>';
    $(function () {
        //var temp_repayment = 0;
        //var temp_repaymentDesc = "";
        if (IsRegHasOneMonth == "0") {
            $("body").showMessage({
                message: "您好，注册需满一个月后才能发布资产标！", showCancel: false, okbtnEvent: function () {
                    window.location.href = "/pages/loan/BorrowMoney.aspx";
                }
            });
            return;
        }
        //贷款金额校验.
        $("#amount").change(function () {

            var $amount = $("#amount");
            var txt_amount = $amount.val();
            if (txt_amount == "") return;

            var regex = /^[0-9]*[1-9][0-9]*$/;
            if (!regex.test(txt_amount)) {
                //alert("请输入正整数!");
                $("body").showMessage({
                    message: "请输入正整数!", showCancel: false
                });
                $amount.focus();
                return;
            }

            var amount = parseInt(txt_amount);
            var availableAmount = parseFloat($("#hdbidType").val());

            if (amount > availableAmount) {
                //alert("您的可用授信额度不足!");
                $("body").showMessage({
                    message: "您的可用借款额度不足!", showCancel: false
                });
                $amount.focus();
                return;
            }

            var $unit = $("#unit");
            var txt_unit = $unit.val();
            if (txt_unit == "") return;

            if (!regex.test(txt_unit)) {
                //alert("请输入正整数！");
                $("body").showMessage({
                    message: "请输入正整数!", showCancel: false
                });
                $unit.focus();
                return;
            }

            var unit = parseInt(txt_unit);
            if (unit > amount) {
                //alert("年化利率最多输入两位小数！");
                $("body").showMessage({
                    message: "年化利率最多输入1位小数!", showCancel: false
                });
                $unit.focus();
                return;
            }

            if (amount % unit != 0) {
                //alert("最小单位不能被整除，请更换最小单位！");
                $("body").showMessage({
                    message: "最小单位不能被整除，请更换最小单位!", showCancel: false
                });
                $unit.focus();
                return;
            }
        });


        //最小单位校验.
        $("#unit").change(function () {

            var $amount = $("#amount");
            var $unit = $("#unit");

            var txt_amount = $amount.val();
            var txt_unit = $unit.val();

            if (txt_unit == "") return;

            var regex = /^[0-9]*[1-9][0-9]*$/;
            if (!regex.test(txt_unit)) {
                //alert("请输入正整数!");
                $("body").showMessage({
                    message: "请输入正整数!", showCancel: false
                });
                $unit.focus();
                return;
            }

            if (txt_amount == "") return;
            if (!regex.test(txt_amount)) {
                //alert("请输入正整数!");
                $("body").showMessage({
                    message: "请输入正整数!", showCancel: false
                });
                $amount.focus();
                return;
            }
            var amount = parseInt(txt_amount);
            var unit = parseInt(txt_unit);
            if (unit > 1000) {
                //alert("最小单位不能大于贷款金额，请更换最小单位!");
                $("body").showMessage({
                    message: "最小单位不能大于1000!", showCancel: false
                });
                $unit.focus();
                return;
            }
            if (unit > amount) {
                //alert("最小单位不能大于贷款金额，请更换最小单位!");
                $("body").showMessage({
                    message: "最小单位不能大于贷款金额，请更换最小单位!", showCancel: false
                });
                $unit.focus();
                return;
            }

            if (amount % unit != 0) {
                //alert("最小单位不能被整除，请更换最小单位!");
                $("body").showMessage({
                    message: "最小单位不能被整除，请更换最小单位!", showCancel: false
                });
                $unit.focus();
                return;
            }
        });

        //年化利率校验.
        $("#interestRate").change(function () {
            var input_interestRate = $(this).val();
            if (input_interestRate == "") return;

            var interestRate = parseFloat(input_interestRate);
            var regex = /^[0-9]+([.]\d{1})?$/;
            if (!regex.test(input_interestRate)) {
                //alert("年化利率最多输入两位小数！");
                $("body").showMessage({
                    message: "年化利率最多输入1位小数!", showCancel: false
                });
                $(this).focus();
                return;
            }

            if (interestRate < 5 || interestRate > 20) {
                //alert("年化利率在5-20%之间！");
                $("body").showMessage({
                    message: "年化利率在5-20%之间!", showCancel: false
                });
                $(this).focus();
                return;
            }
        });

        //还款期限校验.
        $("#deadline").change(function () {
            var months = $(this).val();
            if (months == "") {
                //alert("请选择还款期限!");
                $("body").showMessage({
                    message: "请选择还款期限!", showCancel: false
                });
                $(this).focus();
                return;
            }
            var dealtype = $("#deadline").find("option:selected").text();
            if (dealtype.indexOf("天") != -1)
                dealtype = "2";
            else
                dealtype = "1";
            $("#dealType").val(dealtype);
            if (dealtype == "1") {
                if (months == 1) {
                    $($(".repayType .repayType-select span").eq(0)).addClass("active");
                    $($(".repayType .repayType-select span").eq(1)).removeClass("active");
                    repayment = 1;
                } else if (1 < months && months < 6) {
                    $($(".repayType .repayType-select span").eq(0)).removeClass("active");
                    $($(".repayType .repayType-select span").eq(1)).removeClass("active");
                    repayment = 0;
                } else if (months >= 6) {
                    $($(".repayType .repayType-select span").eq(0)).removeClass("active");
                    $($(".repayType .repayType-select span").eq(1)).addClass("active");
                    repayment = 2;
                }
            } else {
                $($(".repayType .repayType-select span").eq(0)).addClass("active");
                $($(".repayType .repayType-select span").eq(1)).removeClass("active");
                repayment = 1;
            }
        });

        
        $(".repayType .repayType-select span").click(function () {
            var months = $("#deadline").val();
            if (months == "") {
                //alert("请选择还款期限!");
                $("body").showMessage({
                    message: "请选择还款期限!", showCancel: false
                });
                $("#deadline").focus();
                return false;
            }
            var dealtype = $("#deadline").find("option:selected").text();
            if (dealtype.indexOf("天") != -1)
                dealtype = "2";
            else
                dealtype = "1";
            if (dealtype == "1" && months > 1 && months < 6) {
                $(this).addClass("active");
                var dataV = parseInt($(this).attr("dataValue"));
                if (dataV == 1) {
                    $(this).next().removeClass("active");
                } else {
                    $(this).prev().removeClass("active");
                }
                repayment = dataV;
            }
        });
    });
    //提交借款
    function submitApply() {
        Check();
        $("#submit").unbind("click");
        var type = "6";
        var amount = $("#amount").val();
        var title = $.trim($("#title").val());
        var purpose = $.trim($("#purpose").val());
        var unit = $("#unit").val();
        var deadline = $("#deadline").val();
        var dealType = $("#dealType").val();
        var interestRate = $("#interestRate").val();
        var PayPwd = $("#txtPayPwd").val();
        if (unit > 1000) {
            $("body").showMessage({
                message: "最小单位不能大于1000！", showCancel: false
            });
            return false;
        }
        $("body").showLoading("借款中...");
        $.ajax({
            url: "/ajaxCross/ajax_loan.ashx?Cmd=Submit",
            type: "post",
            dataType: "json",
            data: {
                Type: type, Amount: amount, Title: title, Purpose: purpose, Unit: unit,
                Deadline: deadline, DealType: dealType, InterestRate: interestRate, Repayment: repayment, PayPwd: PayPwd, rate: managerRate
            },
            success: function (json) {
                $("body").hideLoading();
                if (json.result == "1") {
                    window.location.href = 'applySuccess.aspx';
                } else {
                    $("body").showMessage({
                        message: json.msg, showCancel: false
                    });
                    //alert(json.msg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("body").hideLoading();
                //alert("网络错误,请重试!");
                $("body").showMessage({
                    message: "服务器繁忙，请重试!", showCancel: false
                });
            }
        });
    }

    //点击“确认出借”检查.
    function Check() {

        //取值.
        var $amount = $("#amount");
        var $title = $("#title");
        var $purpose = $("#purpose");
        var $unit = $("#unit");
        var $deadline = $("#deadline");
        var $dealType = $("#dealType");
        var $interestRate = $("#interestRate");

        var amount = $amount.val();
        var title = $title.val();
        var purpose = $purpose.val();
        var unit = $unit.val();
        var deadline = $deadline.val();
        var dealType = $dealType.val();
        var input_interestRate = $interestRate.val();



        var availableAmount = parseFloat($("#hdbidType").val());
        var tuandaiFeeRate = parseFloat($("#hdbidType").attr("datarate"));
        var PayPwd = $("#txtPayPwd").val();

        //校验.
        if (amount == "") {
            //alert("请输入借款金额!");
            $("body").showMessage({
                message: "请输入借款金额!", showCancel: false
            });
            $amount.focus();
            return;
        }

        var regex = /^[0-9]*[1-9][0-9]*$/;
        if (!regex.test(amount)) {
            //alert("请输入正整数!");
            $("body").showMessage({
                message: "请输入正整数!", showCancel: false
            });
            $amount.focus();
            return;
        }

        if (amount > availableAmount) {
            //alert("您的可用授信额度不足!");
            $("body").showMessage({
                message: "您的可用借款额度不足!", showCancel: false
            });
            $amount.focus();
            return;
        }

        if (title == "") {
            //alert("请输入借款标题!");
            $("body").showMessage({
                message: "请输入借款标题!", showCancel: false
            });
            $title.focus();
            return;
        }

        if (/[,.!\u3002\uff0c]/.test(title)) {
            //alert("标题中不能输入标点符号!");
            $("body").showMessage({
                message: "标题中不能输入标点符号!", showCancel: false
            });
            $title.focus();
            return;
        }

        if (purpose == "") {
            //alert("请输入借款理由!");
            $("body").showMessage({
                message: "请输入借款理由!", showCancel: false
            });
            $purpose.focus();
            return;
        }

        if (unit == "") {
            //alert("请输入最小投资单位!");
            $("body").showMessage({
                message: "请输入最小投资单位!", showCancel: false
            });
            $unit.focus();
            return;
        }

        if (!regex.test(unit)) {
            //alert("请输入正整数!");
            $("body").showMessage({
                message: "请输入正整数!", showCancel: false
            });
            $unit.focus();
            return;
        }

        if (amount % unit != 0) {
            //alert("最小单位不能被整除，请更换最小单位!");
            $("body").showMessage({
                message: "最小单位不能被整除，请更换最小单位!", showCancel: false
            });
            $unit.focus();
            return;
        }
        var months = $("#deadline").val();
        if (months == "") {
            //alert("请输入还款期限!");
            $("body").showMessage({
                message: "请输入还款期限!", showCancel: false
            });
            $("#deadline").focus();
            return;
        }

        if (input_interestRate == "") {
            //alert("请输入年化利率!");
            $("body").showMessage({
                message: "请输入年化利率!", showCancel: false
            });
            $interestRate.focus();
            return;
        }

        var regex = /^[0-9]+([.]\d{1})?$/;
        if (!regex.test(input_interestRate)) {
            //alert("年化利率最多输入两位小数！");
            $("body").showMessage({
                message: "年化利率最多输入1位小数!", showCancel: false
            });
            $interestRate.focus();
            return;
        }

        var interestRate = parseFloat(input_interestRate);
        if (interestRate < 5 || interestRate > 20) {
            //alert("年化利率在5-20%之间！");
            $("body").showMessage({
                message: "年化利率在5-20%之间!", showCancel: false
            });
            $interestRate.focus();
            return;
        }

        if (repayment == 0) {
            //alert("请选择还款方式!");
            $("body").showMessage({
                message: "请选择还款方式!", showCancel: false
            });
            return;
        }
        if (PayPwd == "" || PayPwd == null) {
            //alert("请输入交易密码!");
            $("body").showMessage({
                message: "请输入交易密码!", showCancel: false
            });
            return;
        }

        //计算利息
        var interest = 0;
        if (dealType == "1")
            interest = amount * (interestRate / 100) * (deadline / 12);
        else
            interest = amount * (interestRate / 100) * (deadline / 365);

        //计算管理费.
        var tuandaiFee = "0.0000";
        var tuandaiSale = "0.0000";//管理费优惠
        var date = new Date(endDeadlineDay);
        if ((isFree == 'True' && parseInt(dealType) == 1 && parseInt(deadline) == 1 && new Date() < date) || (isFree == 'True' && parseInt(dealType) == 2 && new Date() < date)) {
            tuandaiFee = "0.0000";
            tuandaiSale = "0.0000";
        } else if (parseInt(dealType) == 2) {
            //tuandaiFee = parseFloat(amount * (tuandaiFeeRate * deadline / 30) * parseFloat(managerRate)).toFixed(4);
            var r = subTwoPoint((parseFloat((deadline / 30).toFixed(4)) * tuandaiFeeRate * parseFloat(managerRate) * 100).toFixed(6), 4);
            tuandaiFee = parseFloat(amount * r / 100).toFixed(4);
            var r1 = subTwoPoint((parseFloat((deadline / 30).toFixed(4)) * tuandaiFeeRate * parseFloat(1 - managerRate) * 100).toFixed(6), 4);
            tuandaiSale = parseFloat(amount * r1 / 100).toFixed(4);
            
        } else {
            tuandaiFee = parseFloat(amount * tuandaiFeeRate * deadline * parseFloat(managerRate)).toFixed(4);
            tuandaiSale = parseFloat(amount * tuandaiFeeRate * deadline * parseFloat(1 - managerRate)).toFixed(4);
            
        } 
        //    else {
        //    tuandaiFee = parseFloat(amount * tuandaiFeeRate * deadline).toFixed(4);
            
        //}


        $("#interest").text($.toMoney(interest, 2));
        $("#tuandaiFee").text(subTwoPoint(tuandaiFee, 2));
        $("#tuandaiSale").text(subTwoPoint(tuandaiSale, 2));

        moveToTop("#borrow-alert");
    };
    
    function subTwoPoint(str, n) {//截断取两位小数，不四舍五入，注意：传字符串,n代表几位小数
        return str.substring(0, str.indexOf('.') + (n + 1));
    }
</script>

</body>
</html>
