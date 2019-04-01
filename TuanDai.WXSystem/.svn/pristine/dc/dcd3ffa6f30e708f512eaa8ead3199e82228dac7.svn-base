<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_account_more.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.my_account_more" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>我的账户</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>

	<body class="bg-f1f3f5">
	    <div class="loading-box" id="cMloading">
            <div class="loading-tips">
                <img src="/imgs/images/icon/ico_loading.png" alt=""><span>加载中...</span>
            </div>
        </div>
		<div class="pageContainer">
		    <% if (GlobalUtils.IsWeiXinBrowser)
		       {
		           %>
            <div class="mt10 bg-fff acount-link bt-e6e6e6 bb-e6e6e6">
                <div class="click-respond">
					<a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx1da84b6515b921cd&response_type=code&scope=snsapi_userinfo&&redirect_uri=https://m.tuandai.com/member/account_manager.aspx" class="bb-e6e6e6"><i class="ico_account ico_a4"></i>账户管理<i class="ico-arrow-r"></i></a>
				</div>  
			</div>
			<div class="mt10 bg-fff acount-link bt-e6e6e6 bb-e6e6e6">
                <div class="click-respond">
					<a href="/pages/push_switch.aspx" class="bb-e6e6e6"><i class="ico_account ico_a5"></i>推送开关<i class="ico-arrow-r"></i></a>
				</div>  
			</div>
            <%
		       } %>
		    
	
			<div class="mt10 bg-fff acount-link bt-e6e6e6 bb-e6e6e6"> 
                <div class="click-respond">
					<a href="http://info.tuandai.com/wap/help/index.html" class="bb-e6e6e6"><i class="ico_account ico_a11"></i>帮助中心<i class="ico-arrow-r"></i></a>
				</div>
			</div>
	
			<div class="quit click-respond bt-e6e6e6 bb-e6e6e6 mt10 logout_submit" id="quit">退出登录</div>
			<div class="sever_tel text-center c-ababab f13px">客服电话：<a href="tel:10101218" class="sever_tel text-center c-ababab f13px">1010-1218</a></div>
		</div>
		
		<!--底部-->
		<div class="bt-e6e6e6 webkit-box box-center wx-footer">
			<a class="block box-flex1 text-center" href="/Index.aspx">
				<p><img src="/imgs/images/icon/ico_f1.png" /></p>
				<p class="f10px line-h18 c-626262">首页</p>
			</a>
			<%--<a class="webkit-box box-center box-vertical box-flex1 text-center" href="/pages/invest/WE/WE_list.aspx">
				<p><img src="/imgs/images/icon/ico_f2.png" /></p>
				<p class="f10px line-h18 c-626262">投资</p>
			</a>--%>
			<a class="webkit-box box-center box-vertical box-flex1 text-center" href="my_account.aspx">
				<p><img src="/imgs/images/icon/ico_f3_act.png" /></p>
				<p class="f10px line-h18 c-ffc000">我的</p>
			</a>
		</div>
		
		</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jsbridge-3.0.0.js?<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    var IsInWeiXin = "<%=IsInWeiXin %>";
    $(".logout_submit2").bind("click", function () {
        $("body").showMessage({
            message: "您确定要退出吗？", okString: "确定", showCancel: true, okbtnEvent: function () {
                window.location.href = "/user/LogOut.aspx";
            }
        });
    });
    $(".logout_submit").bind("click", function () {
        $("body").showMessage({
            message: "您确定要退出吗？", okString: "确定", showCancel: true, okbtnEvent: function () { 
                $.ajax({
                    async: false,
                    url: "/ajaxCross/Login.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "logout" },
                    success: function (json) {
                        var d = json.result;
                        var msg = json.msg;
                        if (parseInt(d) == 1) {
                            window.location.href = "//m.tuandai.com";
                        } else {
                            //alert(msg);
                            $("body").showMessage({ message: msg, showCancel: false });
                            return false;
                        }
                    }
                });
            }
        });
    });
</script>

</html>
