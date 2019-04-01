<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wxJSRecharge.aspx.cs" Inherits="TuanDai.WXApiWeb.PaymentPlatform.weixin.wxJSRecharge" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>微信支付--充值</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <style type="text/css">
    .dataTables_processing {
      position: absolute;
      top: 40%;
      left: 40%;
      margin-left: -55px;
      margin-top: -25px;
      width: 60%;
      height: 80px;
      text-align: center;
      text-indent: 2em;
      color: #333;
      background: url(/imgs/loading01.gif) 20px 30px no-repeat #fff; 
      box-shadow: 0 0 10px #ccc;
      line-height: 80px;
      border-radius: 5px;
      font-size:1.7rem;
    }
  </style>
</head>
<body> 
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/Bank/Recharge.aspx';">返回</div>
        <h1 class="title">微信支付--充值</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>

 <div id="report_detail_processing" class="dataTables_processing">系统处理中...</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20151218001"></script>
<script type="text/javascript"> 
    $(function () { 
        callWXPay();
    });
    //调用微信JS api 支付 
    function jsApiCall() { 
        WeixinJSBridge.invoke(
          "getBrandWCPayRequest",
            <% if(wxJsApiParam==""){%>
             {
                 "appId": "",
                 "timeStamp": "",
                 "nonceStr": "",
                 "package": "",
                 "signType": "",
                 "paySign": "",
             }
            <% }else{ %>
            <%=wxJsApiParam%>
            <%}%> 
            ,//签名串
              function (res) {
                  if (res.err_msg == "get_brand_wcpay_request:ok") {
                      window.location.href = "/PaymentPlatform/weixin/wxReturn.aspx";
                  } else {
                      //alert(res.err_msg);
                      window.location.href = "/PaymentPlatform/recharge_fail.aspx";
                  }
              }
          ); 
    }

    //外面调用微信支付
    function callWXPay() {
        if ("<%=responObj.result%>" != "1") {
            alert("<%=responObj.msg%>");
            window.location.href = "/Member/Bank/Recharge.aspx";
            return;
        }else{
            if (typeof WeixinJSBridge == "undefined") {
                if (document.addEventListener) {
                    document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
                }
                else if (document.attachEvent) {
                    document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                    document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
                }
            }
            else {
                jsApiCall();
            }
        }
    }
</script>
</body>
</html>
