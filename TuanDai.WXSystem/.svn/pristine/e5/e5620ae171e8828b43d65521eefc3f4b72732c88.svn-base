<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamResult.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.HighSpeedGame.ExamResult" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>脑洞全开 - 测你财“经”有多大？</title>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <meta name="viewport" content="width=device-width initial-scale=1.0 user-scalable=no" />
    <meta content="telephone=no" name="format-detection" />
    <link rel="stylesheet" href="css/question.css?v=001" />
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>  
    <script type="text/javascript"> 
        wx.config({
            debug: false,
            appId: '<%=AppId %>',
            timestamp: <%=TimeStamp%>,
            nonceStr: '<%=NonceStr %>',
            signature: '<%=Signature %>',
            jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'hideMenuItems',
                'showMenuItems' 
                ]
            });
    </script>
</head>
<body>
<section class="wrapper">
 <% if (RightNum > 0)
    { %>
    <div class="full-pos result-a">
        <!--星星个数-->
        <div class="full-pos star1"></div>
        <% if (RightNum >= 2)
           { %>
        <div class="full-pos star2"></div>
        <%}
           if (RightNum >= 3)
           { %>
         <div class="full-pos star3"></div> 
         <%} %>
        <div class="link-box clearfix">
            <a href="javascript:void();" onclick="GoToLottery()" class="draw left"></a>
            <a href="javascript:void();" class="share1 right share-but"></a>
        </div>
    </div>
    <%} %>

    <% if (RightNum == 0)
       { %>
    <!--下面是一道都没有答对的--> 
    <div class="full-pos result-b">
        <div class="link-box clearfix">
            <a href="GameIndex.aspx" class="again left"></a>
            <a href="javascript:void();" class="share2 right share-but"></a>
        </div>
   </div>
   <%} %>

    <div class="sharepop">
        <a href="javascript:void();" class="sharepop-close animated slideInRight"></a>
    </div>
</section>
<script src="js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="js/weixinapi.js?v=2.3" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
<script type="text/javascript">

    function GoToLottery() {
        PostSubmit("LotteryDraw.aspx", "<%=RightNum %>");
    }
    function PostSubmit(url, data) {
        var postUrl = url; //提交地址  
        var postData = data; //第一个数据  
        var ExportForm = document.createElement("FORM");
        document.body.appendChild(ExportForm);
        ExportForm.method = "POST";
        var newElement = document.createElement("input");
        newElement.setAttribute("name", "jsondata");
        newElement.setAttribute("type", "hidden");
        ExportForm.appendChild(newElement);
        newElement.value = postData;
        ExportForm.action = postUrl;
        ExportForm.submit();
    };
    
    $(document).ready(function () {
        $(".link-box").find(".share-but").click(function () {
            $(".sharepop").fadeIn(500);
            $(this).parent().next().find("a").addClass("show-close");
        });

        $(".sharepop").find(".sharepop-close").click(function () {
            $(this).parent().fadeOut(500);
        });
    });

</script>
</body>
</html>