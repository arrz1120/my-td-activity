<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bankInfo.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Bank.bankInfo" %>
<%@ Import Namespace="Tool" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>完善开户行信息</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css" />
    <link rel="stylesheet" type="text/css" href="/css/cunguan.css" />
</head>
<body class="bg-f1f3f5">
    <form id="form1" runat="server">
        <!-----底部跳转按钮---->
        <div class='float-jump'><a href='/Index.aspx'>
            <img src='/imgs/images/icon/ico_toHome.png' /></a>   <a href='/Member/my_account.aspx'>
                <img src='/imgs/images/icon/ico_toAccount.png' /></a></div>
        <div class="tips">
            <div class="pt10">
                <div class="myBank bg-fff">
                    <img src="<%=bankImg %>" class="jianshe"/>
                    <p><%=bankName %><span>（尾号<%=bankNo.Right(4)%>）</span></p>
                </div>
                <%if (!string.IsNullOrEmpty(bankProvice) && !string.IsNullOrEmpty(bankCity) && !string.IsNullOrEmpty(openBankName))
                  { %>
                <div class="bg-fff mt10 pl15">
                    <div class="inputBox webkit-box bb-e6e6e6">
                        <div class="inpName pl0">开户行地址</div>
                        <div class="inp">
                            <input type="text" value="<%=bankProvice+bankCity %>" readonly="readonly" />
                        </div>
                    </div>
                    <div class="inputBox webkit-box">
                        <div class="inpName pl0">开户行名称</div>
                        <div class="inp">
                            <input type="text" value="<%=openBankName %>" readonly="readonly" />
                        </div>
                    </div>
                </div>
                <%}
                  else
                  { %>
                <a href="/Member/cgt/BindCardcomplete.aspx" class="block pos-r bg-fff f15px c-333 pt10 pb10 pl15 mt10">完善开户行信息
				<i class="ico-arrow-r"></i>
                </a>
                <div class="lf c-999 f12px">完善开户行信息后才能提现。</div>
                <%} %>
                <div class="clearfix pl15 pr15 mt10">
                    <a href="/Member/Bank/recharge_question.aspx" class="c-fab600 f12px rf">我要更换银行卡&gt</a>
                </div>
            </div>
            </div>
    </form>
</body>
</html>
