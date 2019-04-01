<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_debt_carry_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_debt_carry_detail" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>回款详情</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/debt.css?v=20160223" />
    <style type="text/css">
    	.state1{width: 11px;height: 11px;background-image: url('/imgs/images/state1.png');background-size:100% 100%;vertical-align: 0;}
		.state2{width: 11px;height: 11px;background-image: url('/imgs/images/state2.png');background-size:100% 100%;vertical-align: 0;}
		.state3{width: 11px;height: 11px;background-image: url('/imgs/images/state3.png');background-size:100% 100%;vertical-align: 0;}
		.state4{width: 11px;height: 11px;background-image: url('/imgs/images/state4.png');background-size:100% 100%;vertical-align: 0;}
		.state5{width: 11px;height: 11px;background-image: url('/imgs/images/state5.png');background-size:100% 100%;vertical-align: 0;}
		.state7{width: 11px;height: 11px;background-image: url('/imgs/images/state7.png');background-size:100% 100%;vertical-align: 0;}
		.state8{width: 11px;height: 11px;background-image: url('/imgs/images/state8.png');background-size:100% 100%;vertical-align: 0;}
		.state9{width: 11px;height: 11px;background-image: url('/imgs/images/state9.png');background-size:100% 100%;vertical-align: 0;}

        .weList-tit{height: 40px;line-height: 40px;padding-left: 15px;background: #fbfbf9;}
        .mt7 { margin-top:7px;  }
        .ico_report{display: inline-block;width: 14px;height: 15px;background: url(/imgs/images/ico_report.png) no-repeat;background-size: 14px 15px;margin-right: 5px;vertical-align:-2px;}
    </style>
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <a class="back" href="my_debt_carry_list.aspx?tab=<%=CurrTab %>">返回</a>
            <h1 class="title">承接详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <a href="/pages/invest/zqzr_detail.aspx?projectid=<%=projectId %>&&backurl=<%= GetEncodeBackUrl()%>">
    <div class="bg-fff pl15 pr15 pt20 pb20 pos-r">
    	<p class="f17px c-212121">债权转让<span class="f17px c-808080 ml10"><%=projectTitle %></span></p>
    	<div class="c-ababab f13px pt20">投标时间：<%=Convert.ToDateTime(subscribeInfo.AddDate).ToString("yyyy-MM-dd HH:mm")%>
            <span class="ml15 f13px c-9aca40">
                <%if (Status == "回款中")
                      {%>
                    <i class="icoBox11 state5"></i><span class="f13px c-9aca40"><%=Status%></span>
                    <%}
                      else if (Status == "已完成")
                      {%>
                    <i class="icoBox11 state2"></i><span class="f13px c-9aca40"><%=Status%></span>
                    <%}
                      else if (Status == "逾期")
                      {%>
                    <i class="icoBox11 state1"></i><span class="f12px c-fd6040"><%=Status%></span>
                    <%}
                      else if (Status == "投标中")
                      {%>
                    <i class="icoBox11 state3"></i><span class="f12px c-ffcf1f"><%=Status%></span>
                    <%}
                      else if (Status == "已流标")
                      {%>
                    <i class="icoBox11 state4"></i><span class="f12px c-fd6040"><%=Status%></span>
                    <%}
                      else if (Status == "持有中")
                      {%>
                    <i class="icoBox11 state7"></i><span class="f13px c-fd6040"><%=Status%></span>
                    <%}
                    %>
            </span></div>
    	<div class="title-arrow pos-a"></div>
    </div></a>
    <div class="bg-ffcf1f pt20 pb20">
    	<div class="f13px c-694514 pl20">可获本息（元）</div>
    	<div class="c-ffffff f40px pt13 pl20">¥ <%= ToolStatus.ConvertLowerMoney(subscribeInfo.Amount + subscribeInfo.InterestAmount) %></div>
    	<div class="debt-amo">
	    	<div class="clearfix">
	    		<div class="lf pl20 w50p">
	    			<p class="f13px c-694514">承接本金（元）</p>
	    		</div>
	    		<div class="lf pl30 w50p">
	    			<p class="f13px c-694514">可获利息（元）</p>
	    		</div>
	    	</div>
	    	<div class="clearfix pt13">
	    		<div class="lf pl15 w50p">
	    			<p class="f23px c-ffffff">￥<%= ToolStatus.ConvertLowerMoney(subscribeInfo.Amount) %></p>
	    		</div>
	    		<div class="lf pl25 w50p">
	    			<p class="f23px c-ffffff">￥<%= ToolStatus.ConvertLowerMoney(subscribeInfo.InterestAmount) %></p>
	    		</div>
	    	</div>
	    	<div class="debt-amo-yLine"></div>
    	</div>
    </div>
    <div class="f14px c-212121 pt20 pl15 pr15 pb5 clearfix">
    	回款列表（<span class="c-fd6040 f14px"><%=listtable.Count %></span>笔）
    	<div class="rf"><a href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/contractZqzr.aspx?key=<%=subscribeInfo.ContractNo %>" class="c-fd6040 f13px">查看合同</a></div>
    </div> 

    <div class="bg-fff mt15 bt-d1d1d1 bb-d1d1d1">
    	<div class="webkit-box pl15 pr15 bb-e6e6e6 pt20 pb20">
    		<div class="box-flex1 f13px c-808080 text-left">回款时间</div>
    		<div class="box-flex1 f13px c-808080 text-center">本金+利息</div>
    		<div class="box-flex1 f13px c-808080 text-right">状态</div>
    	</div>
        <% if (listtable != null && listtable.Count > 0)
           {
               foreach (var item in listtable)
               {
                   %>
        <div class="webkit-box pl15 pr15 bb-e6e6e6 pt20 pb20">
    		<div class="box-flex1 f13px c-212121 text-left"><%=Convert.ToDateTime(item.CycDate).ToString("yyyy-MM-dd") %></div>
    		<div class="box-flex1 f13px c-212121 text-center">￥<%=ToolStatus.ConvertLowerMoney(item.Amount) %><span class="f13px c-ff6600">+<%=ToolStatus.ConvertLowerMoney(item.InterestAmout+item.PublisherRedPacket+item.TuandaiRedPacket) %></span></div>
    		<div class="box-flex1 f13px c-212121 text-right"><%=item.Desc %></div>
    	</div>
        <%
               }
           }
           else
           {
               %>
        <div class="webkit-box pl15 pr15 bb-e6e6e6 pt20 pb20">未找到相关记录</div>
        <%
           } %>
    	
    </div>
    <%--<div class="bg-fbfbf9 pt15"></div>--%>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1.0"></script>
<script type="text/javascript">
    
</script>
</body>
</html>
