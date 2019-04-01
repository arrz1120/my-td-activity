<%@ Page Language="C#" AutoEventWireup="true" CodeFile="update.aspx.cs" Inherits="TuanDai.WXApiWeb.APPShutdownMaintenance.html.update" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
    <meta name="format-detection" content="telephone=no"/>
	<title>更新版本</title>
    <link rel="stylesheet" href="/APPShutdownMaintenance/css/main.css?v=20170503"/>
    <script src="/APPShutdownMaintenance/js/lib/adapt.js?v=20170503"></script>
</head>
<body>
    <div class="content">
	<div class="update-container">
		<i class="icon-update"></i>
		<span class="update-txt">当前版本太旧，</span>
		<span class="update-txt">请更新App至最新版本。</span>
		<div class="u-btn go-update">立即更新</div>
	</div>
</div>
</body>
    <script src="/APPShutdownMaintenance/js/lib/vendor/fastclick.js?v=20170503"></script>
<script src="/APPShutdownMaintenance/js/lib/vendor/jsbridge-3.1.2.js?v=20170503"></script>
<script type="text/javascript">
	(function() {
		FastClick.attach(document.body);
		document.querySelector('.go-update').addEventListener('click', function() {
			Jsbridge.toAppUpdateAPK();
		});
	})();
</script>
</html>
