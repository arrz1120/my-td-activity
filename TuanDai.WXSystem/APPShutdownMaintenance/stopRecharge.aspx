<%@ Page Language="C#" AutoEventWireup="true" CodeFile="stopRecharge.aspx.cs" Inherits="TuanDai.WXApiWeb.APPShutdownMaintenance.html.stopRecharge" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, shrink-to-fit=no" />
    <meta name="format-detection" content="telephone=no" />
    <title>充值功能停用</title>
    <link rel="stylesheet" href="/APPShutdownMaintenance/css/main.css?v=20170503"/>
    <script src="/APPShutdownMaintenance/js/lib/adapt.js?v=20170503"></script>
</head>
<body>
    <div class="content">
        <section class="m-container">
            <p class="m-title">充值功能停用通知</p>
            <p class="m-head">尊敬的团贷网用户：</p>
            <div class="m-content">
                <p class="m-txt">因团贷网进行系统升级，目前无法进行充值。由此给您带来的不便，敬请谅解。如需帮助，请拨打团贷网客服热线
                    <font class="txt-orange">400-6410-888</font>，感谢您一直以来对团贷网的支持与信任！
                </p>
            </div>
            <p class="m-txt-right">东莞团贷网互联网科技服务有限公司</p>
            <p class="m-txt-right">2017年3月13日</p>
        </section>
        <i class="icon-close"></i>
    </div>
</body>
    <script src="/APPShutdownMaintenance/js/lib/vendor/fastclick.js?v=20170503"></script>
<script src="/APPShutdownMaintenance/js/lib/vendor/jsbridge-3.1.2.js?v=20170503"></script>
<script type="text/javascript">
(function() {
    FastClick.attach(document.body);
    document.querySelector('.icon-close').addEventListener('click', function() {
        Jsbridge.closeWeb();
    });
})();

</script>
</html>
