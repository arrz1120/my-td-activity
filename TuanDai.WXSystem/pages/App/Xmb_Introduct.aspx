<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Xmb_introduct.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.App.Xmb_introduct" %>

<!DOCTYPE html >

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>项目详情</title>
    <style type="text/css">
        html,body,h1,h2,h3,p,span,a,div,ol,ul,li,dl,dt,dd,table,tbody,tfoot,thead,tr,th,td,input,textarea, form,article,aside,details,figcaption,figure,footer,header,hgroup,nav,section { margin: 0; padding: 0; font: 12px/2rem 'Microsoft Yahei', Arial, Verdana, Helvetica, sans-serif; -webkit-tap-highlight-color: rgba(0,0,0,0); color: #808080;box-sizing: border-box;}
        body { background: #f2f2f2; -webkit-text-size-adjust: none; width: 100%;height:100%;-webkit-tap-highlight-color:rgba(0,0,0,0);padding-bottom: 85px;}
        em, i, b, strong { font-style: normal; font-weight: normal;}
        input, textarea { outline: 0;}
        input,textarea,select{-webkit-border-radius: 0; appearance:none;-moz-appearance:none; -webkit-appearance:none;}
        ul, li {list-style: none;}
        fieldset{border: none;}
        article,aside,details,figcaption,figure,footer,header,hgroup,nav,section{display: block;}
        .bt-ccc,.bb-ccc{position: relative;}
        .bt-ccc:before{content: "";position: absolute;left: 0;top: 0;right: 0;border-bottom: 1px solid #cccccc;transform: scaleY(.5);transform-origin: 0 0;}
        .bb-ccc:after{content: "";position: absolute;left: 0;bottom: 0;right: 0;border-bottom: 1px solid #cccccc;transform: scaleY(.5);transform-origin: 0 100%;}
        .con{ position: relative; padding: 0 15px 15px; margin-top: 20px; background: #fff;}
        .con h3{padding: 18px 0 10px 10px;font-size: 17px; color: #ffd000; position: relative;}
        .con h3:before{content: "";position: absolute; width: 3px; height: 15px;left: 0;top: 22px; background: #ffd000;}
        .con p{text-align: justify;font-size: 14px;line-height: 27px; color: #808080;}
    </style>
</head>
<body>
    <% if (!string.IsNullOrEmpty(AmountUsedDesc))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>资金用途</h3>
       <p>   <%=AmountUsedDesc %>     </p>
        </div>
    <% }%>


     <% if (!string.IsNullOrEmpty(ProjectDescription))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>项目简介</h3>
       <p>   <%=ProjectDescription %>     </p>
        </div>
    <% }%>


    <% if (!string.IsNullOrEmpty(ProjectProspect))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>项目前景</h3>
       <p>   <%=ProjectProspect %>     </p>
        </div>
    <% }%>

 

     <% if (!string.IsNullOrEmpty(InvestRange))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>投资范围</h3>
       <p>   <%=InvestRange %>     </p>
        </div>
    <% }%>


    <% if (!string.IsNullOrEmpty(InvestHighlight))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>投资亮点</h3>
       <p>   <%=InvestHighlight %>     </p>
        </div>
    <% }%>

      <% if (!string.IsNullOrEmpty(ProfitBudget))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>盈利预测</h3>
       <p>   <%=ProfitBudget %>     </p>
        </div>
    <% }%>

 
      <% if (!string.IsNullOrEmpty(RepaymentSecurity))
       { %>
    <div class="con bt-ccc bb-ccc">
        <h3>还款保障</h3>
       <p>   <%=RepaymentSecurity %>     </p>
        </div>
    <% }%>

     
</body>
</html> 