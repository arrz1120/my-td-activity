<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="APPCreateImage.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.APPCreateImage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>二维码邀请分享</title>
    <style type="text/css">
        html,body,h1,h2,h3,p,span,a,div,ol,ul,li,dl,dt,dd,table,tbody,tfoot,thead,tr,th,td,input,textarea, form,article,aside,details,figcaption,figure,footer,header,hgroup,nav,section { margin: 0; padding: 0; font: 12px/2rem 'Microsoft Yahei', Arial, Verdana, Helvetica, sans-serif; -webkit-tap-highlight-color: rgba(0,0,0,0); color: #212121;box-sizing: border-box;}
        body { background: #fff; -webkit-text-size-adjust: none; width: 100%;height:100%;-webkit-tap-highlight-color:rgba(0,0,0,0);}
        em, i, b, strong { font-style: normal; font-weight: normal;}
        input, textarea { outline: 0;}
        input,textarea,select{-webkit-border-radius: 0; appearance:none;-moz-appearance:none; -webkit-appearance:none;}
        ul, li {list-style: none;}
        fieldset{border: none;}
        article,aside,details,figcaption,figure,footer,header,hgroup,nav,section{display: block;}
        img {  border:0; -ms-interpolation-mode:bicubic; max-width:100%; vertical-align:middle;}
        a{text-decoration: none; color: #212121;}
        .webkit-box{display: -webkit-box;}
        .box-center{-webkit-box-pack:center;-webkit-box-align:center; }
        .pos-r{ position: relative !important;}
        .pos-a{ position: absolute !important;}
        .alert{width: 100%;height: 100%;position: fixed;top: 0;left: 0;z-index: 20001 !important;}
        .code-con{width: 62%; height:auto; background: url("imgs/line.png") center no-repeat;margin: 0 auto;text-align: center;padding:20px 10px;background-size: 99% 100%;}
        .code-con .code{width: 87%;height: auto;display: block;margin: 0 auto;}
        .code-con .avatar{left: 50%;width: 56px; height: 56px; margin-left: -28px; top: 50%; margin-top: -28px;display: block;border: 0px solid #fff;-webkit-border-radius:5px;border-radius: 5px;}
        .code-popup p{ font-size: 13px; color: #ababab;width: 80%; padding-top: 20px;margin: 0 auto;text-align: center;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="alert webkit-box box-center">
        <div class="bg-fff code-popup  text-center">
            <div class="code-con pos-r">
                <asp:Image ID="Image2" runat="server" CssClass="code" />
                <%if (isEnable)
                {%>
                    <img src="<%=headImage %>" class="avatar pos-a" />
                <%} %>
            </div>
        
                <%if (isEnable)
                {%>
                    <p>好友扫描二维码，在打开的页面中完成注册，您才能获得奖励</p>
                <%} %>
                <%else
                {%> 
                    <p style="width:150px">参数有误,请重新打开</p>
                <%} %>
        </div>
    </div>
    </form>
</body>
</html>
