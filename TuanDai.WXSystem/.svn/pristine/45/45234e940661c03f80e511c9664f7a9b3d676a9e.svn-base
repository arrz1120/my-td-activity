<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="yuyue_address.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.XinXingFansMeetAndGreet.yuyue_address" %>

 <!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>填写预约信息</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
</head>
<body> 
    <%= this.GetNavStr()%>
	<header class="headerMain">
		<div class="header">
			<div class="back" onclick="javascript:window.location.href='Index.aspx'">返回</div>
			<h1 class="title">填写预约信息</h1>
		</div>
		<%= this.GetNavIcon()%>
		<div class="none"></div>
	</header>


    <!--连动地址选择器-->
    <section class="bg-fff ml15 mr15 mt20 clearfix">
        <div class="addressBox input-border">
            <div class="leftBox">所在地区</div>
            <div class="address-cn"> 
                <select id="province" name="province" class="select">
                        <optgroup label="广东省">
                            <option>东莞市</option>
                            <option>佛山市</option>
                            <option>珠海市</option>
                            <option>湛江市</option>
                        </optgroup>
                        <optgroup label="福建省"> 
                            <option>厦门市</option>
                            <option>泉州市</option>
                        </optgroup>
                        <optgroup label="湖南省">
                            <option>长沙市</option>
                        </optgroup>
                        <optgroup label="江苏省">
                            <option>苏州市</option>
                            <option>无锡市</option>
                            <option>南京市</option>
                        </optgroup>
                        <optgroup label="江西省">
                            <option>南昌市</option>
                        </optgroup>
                        <optgroup label="山东省">
                            <option>济南市</option>
                        </optgroup>
                        <optgroup label="山西省">
                            <option>太原市</option>
                        </optgroup>
                        <optgroup label="河南省">
                            <option>郑州市</option>
                        </optgroup>
                        <optgroup label="河北省">
                            <option>石家庄市</option>
                        </optgroup>
                        <optgroup label="天津市">
                            <option>天津市</option>
                        </optgroup>
                        <optgroup label="广西壮族自治区">
                            <option>南宁市</option>
                        </optgroup>
                        <optgroup label="云南省">
                            <option>昆明市</option>
                        </optgroup>
                        <optgroup label="安徽省">
                            <option>合肥市</option>
                        </optgroup>
                        <optgroup label="浙江省">
                            <option>杭州市</option>
                            <option>宁波市</option>
                            <option>温州市</option>
                        </optgroup>
                    </select>
            </div>
        </div>   

            <div class="addressBox input-border pl10">
                <input type="text" placeholder="请填写真实姓名" id="userName" />
            </div>
            <div class="error" style="display:none;" id="errUserName">
                <div class="hint-text">
                    <p class="f12px"><img src="/imgs/images/ico_warn.png" class="mr5">真实姓名不能为空</p>
                </div>
            </div>
            <div class="addressBox input-border pl10">
                <input type="text" placeholder="请输入您的手机号码" id="mobile"/>
            </div>
            <div class="error" style="display:none;" id="errmobile">
                <div class="hint-text">
                    <p class="f12px"><img src="/imgs/images/ico_warn.png" class="mr5">手机号码格式不正确</p>
                </div>
            </div>
            <div class="addressBox input-border pl10">
                <input type="text" placeholder="请输入您的邮箱地址" id="email"/>
            </div>
            <div class="error" style="display:none;" id="erremail">
                <div class="hint-text">
                    <p class="f12px"><img src="/imgs/images/ico_warn.png" class="mr5">邮箱地址格式不正确</p>
                </div>
            </div>
            <div class="addressBox">
                <input type="submit" value="提交预约" class="btn btnYellow" id="btnSubmit"/>
            </div>
    </section>

    <!--成功领取奖品-->
    <!--start-->
    <section class="popup-wrap" style="display: none;">
        <div class="popup-box pb15">
            <div class="popup-content clearfix text-center mt15">
                <p class="c-212121 f15px">恭喜您！预约成功！</p>
            </div>
            <div class="control-but pb15">
                <a href="javascript:;" class="f14px cancel">取消</a>
                <a href="javascript:;" class="f14px check">确定</a>
            </div>
        </div>
        <div class="mask"></div>
    </section>
    <!--end-->

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
    <script type="text/javascript" src="/scripts/Common.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20151107"></script>
<script type="text/javascript">
    var current = "南京市"; 
    $(function () { 
        $("#province").val(current);
        $("#userName").blur(function () { if ($("#userName").val() != "") { $("#errUserName").hide(); } });
        $("#mobile").blur(function () { if ($("#mobile").val() != "") { $("#errmobile").hide(); } });
        $("#email").blur(function () { if ($("#email").val() != "") { $("#erremail").hide(); } });
        $(".cancel").click(function () { $(".popup-wrap").hide(); });
        $(".check").click(function () { window.location.href = "Index.aspx"; });

        $("#btnSubmit").click(function () { 
            var area = $("#province").find("option:selected").text(); 
            var userName = $.trim($("#userName").val());
            if (userName == "" || userName == "请输入真实姓名") {
                $("#errUserName p").html("<img src=\"/imgs/images/ico_warn.png\" class=\"mr5\">真实姓名不能为空");
                $("#errUserName").show();
                $("#userName").focus();
                return;
            }
            if (/[^\u4E00-\u9FA5]/g.test(userName)) {
                $("#errUserName p").html("<img src=\"/imgs/images/ico_warn.png\" class=\"mr5\">真实姓名格式不正确");
                $("#errUserName").show();
                $("#userName").focus();
                return false;
            }

            var mobile = $.trim($("#mobile").val());
            if (mobile == "" || mobile == "请输入手机号码") {
                $("#errmobile").show();
                $("#mobile").focus();
                return;
            }

            if (!$.isMobile(mobile)) {
                $("#errmobile").show();
                $("#mobile").focus();
                return;
            }

            var email = $.trim($("#email").val());
            if (email == "" || email == "请输入邮箱地址") {
                $("#erremail").show();
                $("#email").focus();
                return;
            }

            if (!$.isEmail(email)) {
                $("#erremail").show();
                $("#email").focus();
                return;
            }

            $.ajax({
                url: "yuyue_address.aspx?Action=Register",
                type: "post",
                dataType: "json",
                data: { Area: area, Current: current, UserName: userName, Mobile: mobile, Email: email },
                success: function (result) {
                    if (result.Success) {
                        $("#area").val(current);
                        $("#userName").val("");
                        $("#mobile").val("");
                        $("#email").val("");
                        if (result.SessionId) {
                            $.cookies.set('sessionId', result.SessionId);
                        } else {
                            $.cookies.del('sessionId');
                        }
                        $(".popup-wrap").show();
                    } else {
                        alert(result.Message);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { }
            }); 
        });
    });

</script>
</body>
</html>