<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_debt_transferlist.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_debt_transferlist" %>

 <!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>债权转让</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/debt.css?v=20160317001"/>
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <script type="text/javascript"> 
        var pStatus = "<%=CurTabName%>";
        var curPageUrl = "<%=curPageUrl%>";
    </script>
</head>
<body class="bg-f1f3f5">
 <%= this.GetNavStr()%>
<header class="headerMain2">
	<div class="header bb-e6e6e6"> 
	     <div class="header-tab">
	    	    <a href="/Member/Repayment/my_debt_carry_list.aspx" class="">承接</a>
	    	    <a href="/Member/Repayment/my_debt_transferlist.aspx" class="active">转让</a>
	     </div> 
	</div> 
</header> 

<div class="tab-nav webkit-box bg-fff bb-e6e6e6 pt10 pb10">
	<div class="box-flex1 text-center f17px <%=CurTabName=="CanTran"?"tab-nav-active":"" %>" id="tabCanTran">可转让</div>
	<div class="box-flex1 text-center f17px <%=CurTabName=="Traning"?"tab-nav-active":"" %>" id="tabTraning">转让中</div>
	<div class="box-flex1 text-center f17px <%=CurTabName=="Finished"?"tab-nav-active":"" %>" id="tabFinished">已完成</div>
</div>

<div id="wrapper" class="pr0" style="top:94px;background: #f1f3f5;">
    <div id="scroller">
        <div id="pullDown" style="margin-bottom: 0;background: #f1f3f5;">
            <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
        </div>
      <!--下拉数据 start-->    

 
<div class="debt-on" >
 <%-- 这里动态加载数据--%>
    <div class="bg-fff8e2 text-center c-fd6040 f13px pt8 pb8" style="display:none;" id="dvLastTime">
		<i class="ico ico-clock-red"></i>剩余时间：<span class="timeSet" count="0">00时00分00秒</span>
    </div>
    <div id="thelist" style="margin:0;padding:0;">  
    </div>
</div>

<!--可转让、转让中：空-->
<div class="debt-empty" style="display: none;">
	<div class="img-debt-empty">
		<img src="/imgs/images/debt-empty.png"/>
	</div>
	<div class="text-center f17px c-212121 mt40" id="dvEmptyText">暂无可转让标的</div> 
	<a href="/pages/invest/zhaiquan_question.aspx" class="block f13px c-ff7357 text-center mt15">查看转让规则</a>
</div> 	
 
  <!--下拉数据 end-->   
     <div id="pullUp" style="background: #f1f3f5;">
         <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
     </div>
  </div>
</div>


	
<div class="alert z-index10" style="display: none;"></div>  




<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script> 
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/zqzrTransfer.js?v=20160317001"></script> 
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
   
</body>
</html>