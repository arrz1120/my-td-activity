﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="drawmoney.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.withdrawal.drawmoney" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<%@ Import Namespace="Tool" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>提现</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />

</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <div class="clearfix pl15 pr15 pt10 pb10">
        <div class="lf f12px c-808080">
            可用资金<span class="c-212121 f15px ml15" id="aviMoney">￥<%=ToolStatus.ConvertLowerMoney(cadAviMoney)%></span>
        </div>
        <div class="rf f12px c-1fcafb" onclick="javascript:window.location.href='withdrawal_record.aspx';">提现记录&nbsp;></div>
    </div>
    <div class="inputBox bg-fff bt-e6e6e6 bb-e6e6e6">
        <% if (!string.IsNullOrEmpty(bankNo))
           {
        %>
        <span class="c-212121 f17px">提现到</span>
        <p class="f17px pt10"><%= GetBankName() + "(" + bankNo.Right(4) + ")" %></p>
        <%
           }
           else
           {
        %>
        <span class="c-212121 f17px">未绑卡</span>
        <div class="f14px pt10 c-1fcafb" onclick="javascript:window.location.href='/Member/Bank/recharge_bindCardagreement.html?v=<%=GlobalUtils.Version %>';">绑定银行卡&nbsp;></div>
        <%
           } %>
    </div>
    <div class="inputBox bg-fff bb-e6e6e6">
        <span class="c-212121 f17px">金额</span>
        <input type="number" placeholder="最低提现金额100元" id="txt_Amount" onblur="testAmount();" />
        <input type="hidden" id="curCardMoney" value="<%=cadAviMoney %>" />
    </div>
    <div class="poundage c-ababab f13px pl15 bg-fff bb-e6e6e6">
        手续费<span class="f13px c-fab600 ml5" id="dvHandFee">￥0.00</span><i class="ico-doubt" id="poundageIns"></i>
    </div>

    <div class="pl15 pr15 pt10 pb10 mt15 bg-fff" id="ticket-box">
        <div class="clearfix">
            <div class="lf f17px">提现券</div>
            <div class="rf"><span class="c-ababab f15px" id="ticket-name">不使用</span><i class="ico-a-r"></i></div>
        </div>
    </div>

    <div class="mt30 pl15 pr15">
        <div class="btn btnYellow" id="getCash" onclick="confirmWithDraw()">下一步</div>
        <p class="f12px c-ababab text-center">充值资金不投标需等<span class="c-fd6040 f12px">15天</span>后才能提现,<a href="withdrawal_question.aspx" class="f12px c-1fcafb">更多常见问题></a></p>
    </div>

    <!--弹框-->
    <!--选择提现券 -->
    <section class="alert webkit-box box-center" id="ticket-alert" style="display: none;">
        <div class="ticket-con comonAni">
            <div class="ticket-top">选择提现券</div>
            <div class="ticket-mid">
                <ul id="ticket-select">
                    <li class="bb-e6e6e6 selected" amount="0" name="chbcoupon" prizeid="">
                        <div class="lf">不使用提现券</div>
                    </li>
                    <%--<li class="bb-e6e6e6">5元提现券</li>
            		<li class="bb-e6e6e6">10元提现券</li>
            		<li class="bb-e6e6e6">15元提现券</li>--%>
                    <% 
                        int iIndex = 0;
                        foreach (var Item in VoucherInfoList)
                        {
                            iIndex++;
                    %>
                    <li class="bb-e6e6e6" name="chbcoupon" id="chb<%=iIndex%>" amount="<%=Item.Amount%>" prizeid="<%=Item.Id %>">
                        <% if (Item.SubTypeId.HasValue && Item.SubTypeId == 900)
                           {
                        %>
                        <div class="lf">免费提现券</div>
                        <%
                           }
                           else
                           {
                               %>
                        <div class="lf"><%=Item.Amount %>元提现券</div>
                        <%
                           } %>
                        
                        <% if (Item.ExpirationDate == null)
                           {
                        %>
                        <div class="rf">永久有效</div>
                        <%
                           }
                           else
                           {
                        %>
                        <div class="rf"><%=Item.DateDeadline %>天后到期</div>
                        <%
                           } %>
                        
                    </li>
                    <%} %>
                </ul>
            </div>
        </div>
    </section>
    <!--输入交易密码 -->
    <div class="alert webkit-box box-center" style="display: none;" id="alert_tranPwd">
        <div class="alert-select">
            <div class="pt30 pb20 f17px text-center">请输入交易密码</div>
            <div class="alert-inp ml15 mr15">
                <input type="password" placeholder="交易密码" id="txtPassword">
                <div class="psdEye webkit-box box-center" id="psdEye"><i class="eye-close"></i></div>
            </div>
            <p class="c-ff6040 pl15 f13px mt3 hide" id="pwdError"><i class="ico-warn"></i>交易密码错误</p>
            <div class="clearfix pr15 mt3">
                <a class="rf f13px c-fab600" href="/Member/safety/ResetPayPwd.aspx">忘记密码</a>
            </div>
            <div class="clearfix bt-e6e6e6 mt10">
                <div class="lf w50p br-e6e6e6">
                    <div class="btn c-808080 f17px br-e6e6e6" id="btnPwdCancel">取消</div>
                </div>
                <div class="rf w50p">
                    <div class="btn c-ffc61a f17px" id="btnPwdOK">确定</div>
                </div>
            </div>
        </div>
    </div>

    <!--获取验证码 -->
    <div class="alert webkit-box box-center" style="display: none;" id="alert_code">
        <div class="alert-select">
            <div class="pt30 pb20 f15px text-center">验证码发送至<span class="f15px ml5"><%=basicinfo.TelNo %></span></div>
            <div class="alert-inp ml15 mr15">
                <input type="text" placeholder="验证码" id="txtCode">
                <div class="getTelCode">获取验证码</div>
            </div>
            <p class="c-ff6040 pl15 f13px mt3 hide" id="codeError"><i class="ico-warn"></i>验证码错误</p>
            <p class="c-ff6040 pl15 f13px mt3 hide" id="codeError1"><i class="ico-warn"></i>验证码错误</p>
            <div class="clearfix pr15 mt3">
                <p class="rf f13px c-808080">收不到短信？使用<span class="f13px c-fab600 getVoiceCode">电话验证码</span></p>
            </div>
            <div class="clearfix bt-e6e6e6 mt10">
                <div class="lf w50p br-e6e6e6">
                    <div class="btn c-808080 f17px br-e6e6e6" id="btnCodeCancel">取消</div>
                </div>
                <div class="rf w50p">
                    <div class="btn c-ffc61a f17px" id="btnCodeOK">确定</div>
                </div>
            </div>
        </div>
    </div>
    <!--手续费说明 -->
    <div class="alert webkit-box box-center" id="alert-poundage" style="display: none;">
        <div class="alert-select comonAni">
            <div class="clearfix mt25">
                <div class="lf w50p text-center br-dashed-d1d1d1">
                    <p class="f17px">普通会员</p>
                    <p class="f14px mt7 c-808080">提现金额的0.15%</p>
                    <p class="f14px c-808080">不封顶</p>
                </div>
                <div class="rf w50p text-center">
                    <p class="f17px">超级会员</p>
                    <p class="f14px mt7 c-808080">提现金额的0.05%</p>
                    <p class="f14px c-808080">200元封顶</p>
                </div>
            </div>
            <p class="f12px c-c5c5c5 pl15 pr15 mt20 line-h20">手续费从可用资金中扣除，如可用资金不足，则从提现金额中扣除</p>
            <div class="bt-e6e6e6 mt25">
                <div class="c-fcb700 text-center f17px pt10 pb10" onclick="window.location.href='/Member/upgradeaccount.aspx';">如何成为超级会员？</div>
            </div>
        </div>
    </div>
     <!--提现金额-->
    <div class="alert webkit-box box-center" id="drawmoney" style="display: none;">
		<div class="wd_amo comonAni">
			<div class="pl20 pr20">
				<div class="wd_tit f15px c-999 text-center bb-dashed-d1d1d1">提现金额</div>
				<p class="wd_p1 text-center f17px c-333 mt25">实际提现金额</p>
				<p class="wd_p2 text-center c-fab600 f30px mt15" id="txtbf"><span class="c-fab600 f19px">￥</span>1000<span class="c-fab600 f19px">.00</span></p>
				<div class="mt20">
					<p class="wd_p3 pl20 pr20 c-999">确认提现后您的资金将会被冻结，并跳转至银行页面进行交易密码验证。若验证未完成，冻结资金将会在5分钟后解冻并退回至您的账户。</p>
					<p class="wd_p3 pl20 pr20 c-fd6040" id="txtbh">申请提现金额100元，收取提现手续费1元（已使用25元优惠券）</p>
				</div>
			</div>
			<div class="clearfix bt-e6e6e6 mt25">
				<div class="lf w50p br-e6e6e6">
					<div class="btn c-808080 f17px br-e6e6e6" id="btnPopCancel1">取消</div>
				</div>
				<div class="rf w50p">
					<div class="btn c-ffc61a f17px" id="btnPopOK1">确定</div>
				</div>
			</div>
        </div>
    </div>

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/icheck.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=GlobalUtils.Version %>"></script>

    <script type="text/javascript">
        var prizeId = "<%= prizeId%>";
        $(function() {
            //提现券弹框
            var box = $("#ticket-box");
            var alert = $("#ticket-alert");
            box.click(function() {
                //alert.fadeIn(300);
                showAniFadeIn($("#ticket-alert"));
            });
            $("#ticket-select").find('li').click(function() {
                var $this = $(this);
                $this.siblings().removeClass('selected');
                $this.addClass('selected');
                var name = $this.find('.lf').html();
                if (name == '不使用提现券') {
                    name = '不使用';
                }
                $("#ticket-name").html(name).attr("prizeId",$(this).attr("prizeId"));
                //alert.fadeOut(300);
                CalculateFees(); //计算手续费
            });
            $("#ticket-alert").click(function() {
                //alert.fadeOut(300);
                hideAniFadeOut($("#ticket-alert"));

            });
            if (prizeId != "00000000-0000-0000-0000-000000000000") {
                var liPrizeId = "";
                $("#ticket-select li").each(function(ind, item) {
                    liPrizeId = $(item).attr("prizeId");
                    if (prizeId == liPrizeId) {
                        $(item).siblings().removeClass('selected');
                        $(item).addClass('selected');
                        $("#ticket-name").html($(item).find('.lf').html()).attr("prizeId",liPrizeId);
                    }
                });
            }

            //输入交易密码弹框
            $("#psdEye").click(function() {
                var eyeBg = $(this).find('i');
                var psdInp = $("#txtPassword");
                if (eyeBg.hasClass('eye-close')) {
                    eyeBg.removeClass('eye-close').addClass('eye-open');
                    psdInp.attr('type', 'text');
                } else {
                    eyeBg.removeClass('eye-open').addClass('eye-close');
                    psdInp.attr('type', 'password');
                }
            });
            $("#btnPwdCancel").click(function() {
                $("#alert_tranPwd").fadeOut();
            });
            $("#btnPwdOK").click(function() {
                var pwd = $("#txtPassword").val().trim();
                if (pwd.length <= 0) {
                    $("#pwdError").removeClass("hide").html('<i class="ico-warn"></i>交易密码不能为空');
                    return false;
                }
                $.ajax({
                    url: "/ajaxCross/ajax_s1a2fe.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: 'CheckTranPwd', TranPwd: pwd },
                    success: function(json) {
                        var status = parseInt(json.result);
                        if (status == 1) {
                            $("#alert_tranPwd").fadeOut();
                            if (!$("#codeError").hasClass("hide"))
                                $("#codeError").addClass("hide");
                            if (!$("#codeError1").hasClass("hide"))
                                $("#codeError1").addClass("hide");
                            $("#txtCode").val('');
                            $("#alert_code").fadeIn();
                        } else if (status == -252) {
                            $("body").showMessage({
                                message: "您还未设置交易密码",
                                showCancel: false,
                                okbtnEvent: function() {
                                    window.location.href = "/Member/safety/reset_password.aspx";
                                }
                            });
                        } else if (status == -100) {
                            $("#pwdError").removeClass("hide").html('<i class="ico-warn"></i>系统繁忙');
                        }else {
                            $("#pwdError").removeClass("hide").html('<i class="ico-warn"></i>' + json.msg);
                        }
                    }
                });
            });

            //验证码弹框
            function getCode(vtype) {
                $("#codeError").html('验证码发送中，请稍等...').removeClass("hide");
                jQuery.ajax({
                    url: "/ajaxCross/ajax_s1a2fe.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "getUsersMSCode", vtype: vtype },
                    success: function(json) {
                        var result = json.result;
                        if (parseInt(result) == -100) {
                            $("#codeError").html('<i class="ico-warn"></i>系统繁忙，请重新获取').removeClass("hide");
                        } else if (parseInt(result) == -99) {
                            window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href;
                        } else if (result == "1") {
                            //发送成功
                            $(".getTelCode").unbind("click");
                            $(".getVoiceCode").unbind("click");
                            var num = 180;
                            var timer = setInterval(function() {
                                num--;
                                $("#codeError").html('验证码发送成功,离重新发送还有' + num).removeClass("hide");
                                if (num <= 0) {
                                    clearInterval(timer);
                                    $("#codeError").addClass("hide");
                                    $(".getTelCode").bind("click", function() { getCode(0); });
                                    $(".getVoiceCode").bind("click", function() { getCode(1); });
                                }
                            }, 1000);
                        } else {
                            //发送失败
                            $("#codeError").html('<i class="ico-warn"></i>系统繁忙,请重新获取').removeClass("hide");
                        }
                    },
                    error: function() {
                        $("#codeError").html('<i class="ico-warn"></i>系统繁忙,请重新获取').removeClass("hide");
                        return false;
                    }
                });
            }

            $("#btnCodeCancel").click(function() { //取消按钮
                $("#alert_code").fadeOut();
            });
            $(".getTelCode").click(function() { //获取短信验证码
                getCode(0);
            });
            $(".getVoiceCode").click(function() { //获取语音验证码
                getCode(1);
            });
            var flag = 1;
            $("#btnCodeOK").click(function() { //确定按钮
                if (flag > 0) {
                    flag = -1;
                    var code = $("#txtCode").val().trim();
                    if (code.length <= 0) {
                        setInterval(function() {
                            flag = 1;
                        }, 3000);
                        $("#codeError").html('<i class="ico-warn"></i>验证码不能为空').removeClass("hide");
                        return false;
                    }
                    var couponAmount = $("li[name='chbcoupon'].selected").eq(0).attr("amount") == undefined ? 0 : parseFloat($("li[name='chbcoupon'].selected").eq(0).attr("amount"));
                    $.ajax({
                        url: "/ajaxCross/ajax_s1a2fe.ashx",
                        type: "post",
                        dataType: "json",
                        data: { Cmd: 'drawdespoint', amount: $("#txt_Amount").val(), prizeId: $("#ticket-name").attr("prizeid"), checkcode: code, couponAmount: couponAmount, drawType: 2 },
                        success: function(json) {
                            setInterval(function() {
                                flag = 1;
                            }, 3000);
                            var status = parseInt(json.result);
                            if (status > 0) {
                                window.location.href = "/Member/withdrawal/withdrawal_suc.aspx?drawtype=2";
                            } else {
                                $("#codeError1").html('<i class="ico-warn"></i>' + json.msg).removeClass("hide");
                                return false;
                            }
                        },
                        error: function() {
                            setInterval(function() {
                                flag = 1;
                            }, 3000);
                        }
                    });
                } else {
                    setInterval(function() {
                        flag = 1;
                    }, 3000);
                    $("#codeError").html('<i class="ico-warn"></i>3秒之内不能连续提现').removeClass("hide");
                    return false;
                }
            });

            //手续费说明弹框
            var poundage = $("#alert-poundage");
            $("#poundageIns").click(function() {
                //poundage.fadeIn();
                showAniFadeIn("#alert-poundage");
            });
            poundage.click(function() {
                //$(this).fadeOut();
                hideAniFadeOut("#alert-poundage");
            });
            poundage.find('.alert-select').click(function() {
                return false;
            });

        });


        var payMethod = "<%=DefPayType%>";//付款方式
        var iVoucherCnt=<%= VoucherInfoList.Count %>;
        var newTitle = '团贷网提醒您：';
        var arrWrong = "<img src='/imgs/zhuce2.gif'/>&nbsp";
        var exsitbank = '<%=exsitbank %>';
        var vailStatus = '<%=vailStatus %>'; 
      
        $(function () { 
            var strmsg = "";
            var returnurl = "";
            if (parseInt(vailStatus) ==0) {
                strmsg = "为保障您的资金安全，请先进行身份认证和设置交易密码，再进行本操作。点击确定后转到安全中心。";
                //alert(strmsg);
                //window.location.href = "/Member/safety/safety.aspx";
                $("body").showMessage({
                    message: strmsg, okString: "确定", showCancel: true, okbtnEvent: function () {
                        if (isOpenCGT == "1") {
                            window.location.href = "/Member/safety/pre_invest.aspx";
                        } else {
                            window.location.href = "/Member/safety/safety.aspx";
                        }
                        
                    }
                });
            }else if (parseInt(vailStatus) == 1) {
                strmsg = "为保障您的资金安全，请先进行身份认证，再进行本操作。点击确定后转到身份认证。";
                $("body").showMessage({
                    message: strmsg, okString: "确定", showCancel: true, okbtnEvent: function () {
                        window.location.href = "/Member/safety/ValidateIdentity.aspx";
                    }
                }); 
            } else if (parseInt(vailStatus) == 3) {
                strmsg = "为保障您的资金安全，请先进行手机认证，再进行本操作。点击确定后转到手机认证。";
                $("body").showMessage({
                    message: strmsg, okString: "确定", showCancel: true, okbtnEvent: function () {
                        window.location.href = "/Member/safety/ValidateMobile.aspx";
                    }
                }); 
            }
            else if(parseInt(vailStatus)==5){
                strmsg = "提现需绑定本人持有的银行卡。";
                var url="/Member/Bank/recharge_bindCardagreement.html?v=20160312001";
                if(isOpenCGT=="1")
                {
                    url="/Member/cgt/cgtBindCard.aspx";
                }
                $("body").showMessage({
                    message: strmsg, okString: "马上绑定", showCancel: true, okbtnEvent: function () {
                        window.location.href = url;
                    }
                });
            }
            //else if (parseInt(vailStatus) == 2) {
            //    strmsg = "为保障您的资金安全，请先进行首次交易密码设置，再进行本操作。点击确定后转到首次交易密码设置。";
            //    alert(strmsg);
            //    window.location.href = "/Member/safety/reset_password.aspx";
            //}  
            $("#txt_Amount").bind("keyup", function () {
                $this = $(this);
                $this.val($this.val().toString().replace(/[^(\d|\.)]+/, ""));
            });     
        });  

        
        function testAmount() {
            //$("#dvHandFee").html("￥0.00");   
            $("#dvRealMoney").html("￥0.00"); 

            if ($("#txt_Amount").val() == '') { 
                $("body").showMessage({message:"请输入提现金额，如1063.20",showCancel:false});
                return false;
            }
            if (!(/^\d+(.)?\d{1,2}$/.test($("#txt_Amount").val()))) { 
                $("body").showMessage({message:"请输入正确的提现金额，如1063.20",showCancel:false});
                $("#txt_Amount").val(parseFloat($("#txt_Amount").val()).toFixed(2));
                return false;
            }
            if (parseFloat($("#txt_Amount").val()) < 100) { 
                $("body").showMessage({message:"提现金额不能小于100",showCancel:false});
                return false;
            }
            var topamount = '<%=topwithdrawamount %>';
            if (parseFloat($("#txt_Amount").val()) > topamount) { 
                $("body").showMessage({message:"提现金额不能大于"+ topamount,showCancel:false});
                return false;
            }
            var aviMoney=getAviMoney();
            if (aviMoney < parseFloat($("#txt_Amount").val())) { 
                $("body").showMessage({message:"您的账户余额不足以提现",showCancel:false});
                return false;
            }
            showChineseAmount();
            CalculateFees();
            return true;
        }
        function showChineseAmount() {
            var regamount = /^(([1-9]{1}[0-9]{0,})|([0-9]{1,}\.[0-9]{1,2}))$/;
            var reg = new RegExp(regamount);
            if (reg.test($("#txt_Amount").val())) {
                var amstr = $("#txt_Amount").val();
                var leng = amstr.toString().split('.').length;
                if (leng == 1) {
                    $("#txt_Amount").val($("#txt_Amount").val() + ".00");
                } 
            }
        }  
        function getAviMoney(){
            var aviMoney=parseFloat($("#curCardMoney").val());
            return aviMoney;
        }
        function getTwo(num) {
            var a = num.toString();
            var num_index = a.indexOf(".");
            if (num_index == -1 || (num_index > -1 && (a.length - num_index) < 3)) {
                return a;
            }
            else {
                var aNew;
                var re = /([0-9]+\.[0-9]{2})[0-9]*/;
                aNew = a.replace(re, "$1");
                return aNew;
            }
        }
        //计算手续费
        function CalculateFees() {
            var aviMoney=getAviMoney();
            if (parseFloat($("#txt_Amount").val()) >aviMoney ) {
                return;
            }
            if (parseFloat($("#txt_Amount").val()) < 100) {
                return;
            }
            //申请提现金额
            $("#dvDrawMoney").text($("#txt_Amount").val());

            $.post({
                url:"/ajaxCross/ajax_s1a2fe.ashx",
                dataType:"json",
                data:{ Cmd: "checkpwdandgetfee", amount: $("#txt_Amount").val() },
                async:false,
                success:function (data) {
                    var d = data.msg;
                    if (parseFloat(d) > 0) {
                        var from = aviMoney > (parseFloat(d) + parseFloat($("#txt_Amount").val())) ? "1" : "2"; //1:从可用余额中扣除 2：从提现金额中扣除
                        var couponAmount = $("li[name='chbcoupon'].selected").eq(0).attr("amount") == undefined ? 0 : parseFloat($("li[name='chbcoupon'].selected").eq(0).attr("amount"));
                  
                        var fee = 0;
                        if (couponAmount < parseFloat(d)) {
                            fee = parseFloat(d) - couponAmount;
                        }
                        fee = fee.toFixed(2); 
                        var ActualAmount = "0";
                        if (from == "1") {
                            ActualAmount = $("#txt_Amount").val();
                        }
                        else if (from == "2") {
                            ActualAmount = parseFloat($("#txt_Amount").val()) - parseFloat(fee);
                        }
                        $("#dvHandFee").html("￥"+fee);  
                        ActualAmount = getTwo(ActualAmount); 
                        $("#dvRealMoney").html("￥"+ActualAmount); 
                    } 
                },
                error:function() {
                    CalculateFees();
                }
            }); 
        }
        //弹出确认框
        function confirmWithDraw() {
            if(!testAmount()) return;
            if ("<%=IsNoCanDraw%>" == "True") {
                $("body").showMessage({ message: "23:00-0:10分为银行维护时间，暂不能申请提现", showCancel: false });
                return false;
            }
            try {
                //-------存管通验证---2016-12-21----
                if (isOpenCGT == "1" && !checkIsOpen("tixian"))
                    return false;
                //-------存管通验证结束----------
            } catch (e) {

            } 
          
            if(isOpenCGT=="1") {
                $("#txtbf").html('<span class="c-fab600 f19px">￥</span>'+$("#txt_Amount").val().split('.')[0]+'<span class="c-fab600 f19px">.'+$("#txt_Amount").val().split('.')[1]+'</span>');
                var prizeid = $("#ticket-name").attr("prizeid");
                var prizeStr = "";
                if (prizeid != undefined && prizeid != "") {
                    if (parseFloat($("#dvHandFee").html().replace("￥","")) <= 0) {
                        prizeStr = "（已使用" + $("#ticket-name").html() + "）";
                    }else if ((parseFloat($("#dvHandFee").html().replace("￥","")) + parseFloat($("#txt_Amount").val())) <= parseFloat("<%=cadAviMoney%>")) {
                        prizeStr = "（已使用" + $("#ticket-name").html() + "），手续费从账户余额中扣除";
                    } else {
                        prizeStr = "（已使用" + $("#ticket-name").html() + "），因账户余额不足，手续费从提现金额中扣除";
                    }
                } else {
                    if ((parseFloat($("#dvHandFee").html().replace("￥","")) + parseFloat($("#txt_Amount").val())) <= parseFloat("<%=cadAviMoney%>")) {
                        prizeStr = "（未使用提现券），手续费从账户余额中扣除";
                    } else {
                        prizeStr = "（未使用提现券），因账户余额不足，手续费从提现金额中扣除";
                    }
                }
                $("#txtbh").html('申请提现金额￥'+$("#txt_Amount").val()+'元，收取提现手续费'+$("#dvHandFee").html()+'元'+prizeStr);
                showAniFadeIn("#drawmoney");
            }
            else
            {
                var exsitbank = '<%=exsitbank %>';
                if (exsitbank == '0') {      
                    $("body").showMessage({
                        message: "您还未绑定银行卡,不能提现到卡中!", okString: "立即绑卡", showCancel: true, okbtnEvent: function () {
                            window.location.href = "/Member/Bank/recharge_bindCardagreement.html?v=20170109001";
                        }
                    }); 
                    return;
                } 
                if("<%=bankModel.ValType%>"=="0"){
                    //只时完成了快速绑卡
                    window.location.href="/Member/safety/binding_cardaddress.aspx";
                }
                var hasBankAccountNo = '<%=string.IsNullOrEmpty(basicinfo.BankAccountNo)?"False":"True" %>';
                if (hasBankAccountNo != 'False') {
                    var bankStatus = '<%=bankStatus %>';
                    if (parseInt(bankStatus) == 2) { 
                        $("body").showMessage({message: "银行卡在审核中不允许提现!", showCancel: false}); 
                        return;
                    }
                } 
                confirmDrawMoney(2);
            } 
        } 
        //跳转支付页面
        var isDrawClick = true;
        function okDrawMoney()
        {
            if (isDrawClick) {
                isDrawClick = false;
                $("body").showLoading("处理中...");
                var couponAmount = $("li[name='chbcoupon'].selected").eq(0).attr("amount") == undefined ? 0 : parseFloat($("li[name='chbcoupon'].selected").eq(0).attr("amount"));
                $.ajax({
                    url:"/ajaxCross/ajax_withdrawals.ashx",
                    dataType:"json",
                    data:{"cmd":"CheckPayPwd","amount":$("#txt_Amount").val(),"userPrizeId":$("#ticket-name").attr("prizeid"),"couponAmount":couponAmount},
                    type:"POST",
                    success:function(json){
                        if(json)
                        {
                            if(json.result=="1")
                            {
                                window.location.href=json.msg;
                            }else{
                                $("body").showMessage({message: json.msg, showCancel: false}); 
                                $("body").hideLoading();      
                            }
                        }
                        setInterval(function() {
                            isDrawClick = true;
                        }, 3000);
                    },
                    error:function(){
                        setInterval(function() {
                            isDrawClick = true;
                        }, 3000);
                        $("body").hideLoading();      
                    }
                });
            }
            
        }
        //确认提现
        function confirmDrawMoney(withType){
            if (!$("#pwdError").hasClass("hide"))
                $("#pwdError").addClass("hide");
            $("#txtPassword").val('');
            $("#alert_tranPwd").fadeIn();
        }

        //提现取消
        $("#btnPopCancel1").click(function() {
            hideAniFadeOut("#drawmoney");
        });
        //提现确认跳存管
        $("#btnPopOK1").click(function() {
            okDrawMoney();
        });
    </script>
</body>
</html>
