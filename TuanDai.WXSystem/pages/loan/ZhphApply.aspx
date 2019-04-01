
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZhphApply.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.loan.ZhphApply" %>
  <!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>快速借款</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/pay.css?v=20160405001" />
<style type="text/css"> 
   .disabled {background-color: #d1d1d1!important; color:#f8e9e9;}
</style>
</head>
<body class="bg-f1f3f5"> 
<div class="indexPage">
    <%= this.GetNavStr()%>
    <header class="headerMain">
	    <div class="header">
		    <div class="back" onclick="javascript:window.location.href='/pages/loan/ZhphLoanType.aspx'">返回</div>
		    <h1 class="title"><%=ApplyTypeName %></h1>
	    </div>
	    <%= this.GetNavIcon()%>
	    <div class="none"></div>
    </header>
 
    <div class="pt10 pb10 bt-e6e6e6 bb-e6e6e6 bg-fff pl15 mt15" id="placeSelect">
		<div class="clearfix inpBox4 pos-r">
			<div class="lf f17px c-212121">所在城市<span class="c-ababab f17px ml35" id="selectedPlace">请选择</span></div>
			<div class="ico_arrow_r3 pos-a" style="top: 6px;"></div>	
		</div>	
	</div>
		
	<div class="pt10 pb10 bt-e6e6e6 bb-e6e6e6 bg-fff pl15 mt15">
		<div class="clearfix inpBox4">
			<div class="lf f17px c-212121">真实姓名</div>
			<input type="text" id="txt_name" maxlength="4" class="lf f17px" placeholder="请输入您的姓名">
		</div>	
	</div> 
    <div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
		<div class="pt10 pb10 pl15 clearfix inpBox4">
			<div class="lf f17px c-212121">手机号码</div>
			<input type="text" id="txt_phone"  maxlength="11"  class="lf f17px" placeholder="请输入手机号码">
		</div>	
		<div class="inpBox34 bt-e6e6e6 pl118">
			<span class="f17px c-212121">验证码</span>
			<input type="text"  id="txt_code" class="f17px" placeholder="短信验证码">
			<div class="sendCode r15" id="btnSendMsgCode">免费获取</div>	
		</div>	
	</div>

	
     <div class="error" id="dvError" style="display:none">
        <div class="hint-text">
            <p class="f12px" id="errTips"><img src="/imgs/images/ico_warn.png" class="mr5" />手机号码格式不正确</p>
        </div>
    </div>	
	<div class="pl15 pr15 mt30">
		<div class="btn btnYellow">提交申请</div>
	</div>
</div>
      
<!--申请成功弹框-->
<div class="apply-suc-tips" style="display:none;">
	<img src="/imgs/images/ico-success.png"/>
	申请成功!
</div>

<!--省选择-->
	<div class="z-index1000 provinceBox hide">
		 <div class="header bb-e6e6e6 pos-r">
            <div class="pageReturn" id="province-close"></div>
            <h1 class="title">选择省份</h1>
        </div>
        <div class="placelist-box pos-r">
		   <div class="provinceList">
		   		<ul>
                    <% foreach(var item in provinceList){ %>
                      <li class="bb-e6e6e6" datacode="<%=item.AreaCode %>"><%=item.AreaName %></li>
                    <%} %> 
		   		</ul>
		   </div>
        </div>
	</div>
	<!--市选择-->
	<div class="z-index1000 cityBox hide">
		 <div class="header bb-e6e6e6 pos-r">
            <div class="pageReturn" id="city-close"></div>
            <h1 class="title">选择城市</h1>
        </div>
        <div class="placelist-box pos-r">
		   <div class="cityList">
		   		<ul>
		   			<li class="bb-e6e6e6" datacode="">请选择</li> 
		   		</ul>
		   </div>
        </div>
	</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script> 
<script type="text/javascript" src="/scripts/base.js?v=20151107"></script>
<script type="text/javascript">
    function clearErr() {
        $("#dvError").css("display", "none");
    }
    function addErr(txt) { 
        $("#dvError").css("display", "");
        $("#errTips").html("<img src=\"/imgs/images/ico_warn.png\" class=\"mr5\" />" + txt);
    }
    //省市选择弹框
    function moveToLeft(ele) {
        $(ele).removeClass('moveToRight').removeClass('hide').addClass('moveToLeft');
    }
    function moveToRight(ele) {
        clearErr();
        $(ele).removeClass('moveToLeft').addClass('moveToRight');
        setTimeout(function () {
            $(ele).addClass('hide');
        }, 300);
    } 
    var province = "", city = "";
    var AreaCode = "";
    function setPlace() {
        $("#selectedPlace").removeClass('c-ababab').addClass('c-212121').html(province + city);
    }
    function bindCityEvent() {
        //隐藏市的选择
        $(".cityBox").find('li').click(function () {
        	  $(this).addClass('selected');
            city += $(this).html();
            $(".indexPage").removeClass('hide');
            moveToRight(".cityBox");
            AreaCode = $(this).attr("datacode");
            setPlace();
        });
    }
    $(function () {
        $("#btnSendMsgCode").click(function () {
            sendMobileValidSMSCode();
        });
        //显示省的选择
        $("#placeSelect").click(function () {
            moveToLeft(".provinceBox");
            $(".provinceList").find("li").each(function (i, n) {
                var vText = $(n).html();
                if (vText == province)
                    $(n).addClass("selected");
                else
                    $(n).removeClass("selected");
            });
            setTimeout(function () {
                $(".indexPage").addClass('hide');
            }, 300);
        });
        //隐藏省的选择
        $("#province-close").click(function () {
            $(".indexPage").removeClass('hide');
            moveToRight(".provinceBox");
        });

        //显示省的选择
        $(".provinceBox").find('li').click(function () {
            province = $(this).html(); 
            var thisDom = $(this); 
            var parentcode = thisDom.attr("datacode");
            $(".cityList ul").children().remove();
            $.ajax({
                url: "/ajaxCross/ajax_loan.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetZhphCity", AreaCode: parentcode },
                success: function (d) {
                    $(".cityList ul").children().remove();
                    if (d.result == "1") {
                        var str = ""; 
                        var html = new Array();
                        for (var i = 0; i < d.list.length; i++) {
                            str = "<li class='bb-e6e6e6' datacode='" + d.list[i].ProId + "'>" + d.list[i].ProName + "</li> ";
                            html.push(str);
                        }
                        $(".cityList ul").append(html.join(""));
                        $(".cityList").find("li").each(function (i, n) {
                            var vText = $(n).html();
                            if (vText == city)
                                $(n).addClass("selected");
                            else
                                $(n).removeClass("selected");
                        });
                    } else {
                        $(".cityList ul").append("<li class='bb-e6e6e6' datacode=''>暂无</li>");
                    }
                    bindCityEvent();
                    moveToLeft(".cityBox");
                    setTimeout(function () {
                        $(".provinceBox").addClass('hide');
                    }, 300);
                    city = "";
                }
            });  
        });

        //隐藏市的选择
        bindCityEvent(); 
        $('#city-close').click(function () {
            $(".indexPage").removeClass('hide');
            moveToRight(".cityBox"); 
        }); 
        
        $(".btnYellow").click(function () {
            clearErr();
            if (province == "" || city == "") {
                addErr("请先选择所在城市！"); 
                return false;
            }
            if ($.trim($("#txt_name").val()).length < 1) {
                addErr("姓名不能为空！");
                $("#txt_name").focus();
                return false;
            }
            if (!$.trim($("#txt_name").val()).match(/^[\u4E00-\u9FA5_-]{0,}$/)) {
                addErr("真实姓名只能输入中文！")
                $("#txt_name").focus();
                return false;
            }
            if ($.trim($("#txt_phone").val()).length < 1) {
                addErr("手机号码不能为空！") 
                $("#txt_phone").focus();
                return false;
            }
            if (!/^(13|14|15|17|18)[0-9]{9}$/.test($("#txt_phone").val())) {
                addErr("手机号码格式不正确！") 
                $("#txt_phone").focus();
                return false;
            }

            $.ajax({
                url: "/ajaxCross/ajax_loan.ashx",
                type: "post",
                dataType: "json",
                data: {
                    Cmd: "SubmitZhphLoan", ApplyType: "<%=ApplyType %>", sel_city1: province,
                    sel_city2: city, areacode: AreaCode,
                    name: $('#txt_name').val(), phone: $("#txt_phone").val(), code: $("#txt_code").val()
                },
                success: function (json) {
                    if (json.result == "1") {
                        $(".apply-suc-tips").fadeIn(100);

                        //2秒后提示消失
                        setTimeout(function () {
                            $(".apply-suc-tips").fadeOut(); 
                             window.location.href = "/pages/loan/BorrowMoney.aspx"; 
                        }, 2000);
                    } else {
                        addErr(json.msg);
                    } 
                }
            });
          });
    });
    //============短信验证码
    //获取手机验证码 
    var leftsecond = 60;
    var timer = null;
    function sendMobileValidSMSCode() {
        if ($.trim($("#txt_phone").val()).length < 1) {
            addErr("手机号码不能为空！")
            $("#txt_phone").focus();
            return false;
        }
        if (!/^(13|14|15|17|18)[0-9]{9}$/.test($("#txt_phone").val())) {
            addErr("手机号码格式不正确！")
            $("#txt_phone").focus();
            return false;
        }
        $("#btnSendMsgCode").unbind("click");
        clearErr();
        $("#btnSendMsgCode").html("短信发送中...");
        $("#btnSendMsgCode").attr('disabled', true);
        $("#btnSendMsgCode").addClass("disabled");
        jQuery.ajax({
            url: "/ajaxCross/ajax_loan.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "GetZhphApplySMSCode", mobileno: $("#txt_phone").val() },
            success: function (json) {
                var result = json.result;
                leftsecond = 60;
                if (parseInt(result) == -100) { alert("系统繁忙，请刷新页面重试！"); }
                else if (parseInt(result) == -99) { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; }
                if (result == "1") {
                    leftsecond = 60;
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                }
                else {
                    leftsecond = 60;
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    addErr("发送失败,60秒后可重发!"); 
                    $("#btnSendMsgCode").html("60秒后重发");
                    $("#btnSendMsgCode").bind("click", function () { sendMobileValidSMSCode(); });
                }
            },
            error: function () {
                $("#btnSendMsgCode").bind("click", function () { sendMobileValidSMSCode(); });
                $("#btnSendMsgCode").attr('disabled', false);
                $("#btnSendMsgCode").removeClass("disabled");

                addErr("网络异常，请重试!"); 
                return false;
            }
        });
    }

    function setLeftTime() {
        var second = Math.floor(leftsecond);
        $("#btnSendMsgCode").html("重新获取"+second + "s");
        leftsecond--;
        if (leftsecond < 1) {
            $("#btnSendMsgCode").html("发送验证码");
            $("#btnSendMsgCode").attr('disabled', false);
            $("#btnSendMsgCode").removeClass("disabled");
            clearInterval(timer);
            clearErr();
            return;
        }
    }
</script>
</body>
</html>