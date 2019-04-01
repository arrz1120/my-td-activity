<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogOut.aspx.cs" Inherits="TuanDai.WXApiWeb.user.LogOut" %>

<!DOCTYPE html">

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta http-equiv="Expires" CONTENT="0"> 
    <meta http-equiv="Cache-Control" CONTENT="no-cache"> 
    <meta http-equiv="Pragma" CONTENT="no-cache"> 
    <title>退出</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body>
 <div class="loading-box" id="cMloading">
	<div class="loading-tips"><img src="/imgs/images/icon/ico_loading.png" alt=""><span>退出中...</span></div>
</div>
<script type="text/javascript">
    (function () {
        var _CALLBACKED_ = false;
        window.logoutCallback = function () {
            _CALLBACKED_ = true;
            window.top.location = "<%=this.ReturnUrl %>";
        }
        window.setTimeout(function () {
            if (!_CALLBACKED_) {
                window.logoutCallback();
            }
        }, 500);
        
    })();
</script>

</body>
</html>
