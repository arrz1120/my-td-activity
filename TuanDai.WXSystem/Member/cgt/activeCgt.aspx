<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activeCgt.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.cgt.activeCgt" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/cunguan.css?v=<%=GlobalUtils.Version %>" />
    <title>即将前往存管页面</title>
</head>
<body class="bg-fff">
	<div class="jumpPage webkit-box box-center box-vertical h100p">
		<div class="jump_loading"></div>
		<p>即将前往存管页面</p>
	</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script> 
<script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    var strGoUrl = '<%=strGoUrl%>';
    if (strGoUrl != "") {
        window.location.href = strGoUrl;
    } else {
        $("body").showMessage({ message: "<%=StrErr%>", showCancel: false });
    }
</script>
 </body>
</html>