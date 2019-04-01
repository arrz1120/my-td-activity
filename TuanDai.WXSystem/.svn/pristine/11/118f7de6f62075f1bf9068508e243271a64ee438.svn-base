<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="account_manager.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.account_manager" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>我的账户</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=GlobalUtils.Version %>" />
        <!--账户中心-->
        <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>
    <% if (uList != null && uList.Count > 0)
       {
           %>
    <body class="bg-f1f3f5 pt10">
        <%= this.GetNavStr()%>
        <div style="display: none;"><%= this.GetNavIcon()%></div>
		<div class="bt-e6e6e6">
			<div class="zhgl-top bb-e6e6e6 pl15">
				<div class="bb-e6e6e6">
					<p class="f17px top-p1"><span class="c-fab700 mr5 f17px"><%=string.IsNullOrEmpty(wxUserInfo.nickname)?"当前微信号":wxUserInfo.nickname %></span>绑定的团贷网账户</p>
					<p class="f13px c-ababab top-p2 telNum"><%=Tool.Common.Utils.StringHandler.MaskTelNo(firstUser.Tel) %></p>
					<a href="javascript:void(0);" class="jiebang" pvalue="<%=firstUser.DescUserId %>">解绑</a>
				</div>
			</div>
            <% 
               if (uList.Count > 1)
               {
                   int lc = 1;
                   if (uList.Exists(o => o.UserId == WebUserAuth.UserId.Value))
                   {
                       lc = 0;
                   }
                   for (int i = lc; i < uList.Count; i++)
                   {
                       if(uList[i].UserId == WebUserAuth.UserId.Value)
                           continue;
                       %>
            <div class="zhgl-item bb-e6e6e6 pl15">
				<div class="bb-e6e6e6">
					<p class="f17px top-p1 telNum" ><%=Tool.Common.Utils.StringHandler.MaskTelNo(uList[i].Tel) %></p>
					<a href="javascript:void(0);" class="jiebang" pvalue="<%=uList[i].DescUserId %>">解绑</a>
				</div>
			</div>
            <%
                   }
               } %>
			

			<div class="bb-e6e6e6 pl20 zhgl-bottom bg-fff">
				<p onclick="JAVASCRIPT:window.location.href='account_bind.aspx';">绑定其他团贷网账户</p>
			</div>
		</div>

	</body>
    <%
       }
       else
       {
           %>
    <body class="bg-fff">
        <%= this.GetNavStr()%>
        <div style="display: none;"><%= this.GetNavIcon()%></div>
		<div class="ico-bind"></div>
		<p class="f17px text-center mt40">
			你的团贷网账户<%=Tool.Common.Utils.StringHandler.MaskTelNo(CurrTel) %>是否与 <br />
			<span class="f17px c-fab600"><%=string.IsNullOrEmpty(wxUserInfo.nickname)?"当前微信号":wxUserInfo.nickname %></span>微信号绑定？
		</p>
		<div class="pl15 pr15 mt40" id="bindwx">
			<a class="btn btnYellow">确认绑定</a>
		</div>
		<p class="f13px mt5 c-999 text-center">绑定后可收到团贷网公众号关于资金动态的推送</p>
	</body>
    <%
       } %>
	
	<script type="text/javascript" src="/scripts/jquery.min.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/fastclick.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript">
	    $(".jiebang").bind("click", function () {
	        var telNum = $(this).parent().find('.telNum').html();
	        var vaid = $(this).attr("pvalue");
	        $("body").showMessage({
	            message: "确定<span class='f17px c-fab600'><%=string.IsNullOrEmpty(wxUserInfo.nickname)?"当前微信号":wxUserInfo.nickname %></span>与" + telNum + "<br />解除账户绑定关系",
	            okString: "解绑",
	            showCancel: true,
	            okbtnEvent: function () {
	                $.ajax({
	                    type: "post",
	                    url: "account_manager.aspx?cmd=notbind",
	                    data: { vaid: vaid },
	                    dataType: "json",
	                    timeout: 3000,
	                    success: function (resp) {
	                        //resp = JSON.parse(resp);
	                        if (parseInt(resp.result) > 0) {
	                            alert('解绑成功');
	                            window.location.href = window.location.href;
	                        } else {
	                            alert('解绑失败');
	                        }
	                    },
	                    error: function () {
	                        alert('解绑失败');
	                    }
	                });
	            }
	        });
	    });
	    $("#bindwx").click(function() {
	        $.ajax({
	            type: "post",
	            url: "account_bind.aspx?cmd=bind",
	            data: { type:1 },
	            dataType: "json",
	            async: false,
	            success: function (resp) {
	                if (parseInt(resp.result) == 1) {
	                    window.location.href = "account_bindsuc.aspx";
	                } else {
	                    showErr(resp.msg);
	                }
	            },
	            error: function () {
	                showErr("绑定失败");
	            }
	        });
	    });
	</script>

</html>