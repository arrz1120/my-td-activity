﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="juntuo.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.juntuo" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>俊拓金融介绍</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/juntou.css" /><!--关于我们--> 
</head>
<body> 
<% if(appType==""){ %>
 <%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">俊拓金融介绍</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header> 
<%}  %>

<img src="/imgs/juntou/header.png">

<section class='con_1'>
	<h2>
	<img src="/imgs/juntou/con_1_tit.png">
	</h2>
	<div class="fold">
	<p class="gray_font">       
	深圳前海俊拓金融服务股份有限公司（以下简称“俊拓金融”）创建于2015年，是一家专注国内电商供应链的金融咨询服务公司 。以大数据为基础、金融为手段，俊拓金融深度切入电商完整供应链，打造服务电商的开放性综合服务平台。</p>
    <p class="gray_font"> 通过整合产业链，将电商供应链交易环节……</p>
    </div>
    <div class="unfold">
		<p class="gray_font"> 深圳前海俊拓金融服务股份有限公司（以下简称“俊拓金融”）是一家专注国内电商供应链的金融咨询服务公司 。以大数据为基础、金融为手段，俊拓金融深度切入电商完整供应链，打造服务电商的开放性综合服务平台。
		</p>
		<p class="gray_font"> 通过整合产业链，将电商供应链交易环节整体透明化、阳光化，全盘掌控电商供应链，深度捆绑电商的供应链的全流程，从而达到对风险控制的审核标准。在这个基础上，对电商量身定制融资方案、代采方案、运营方案等，解决电商资金运转的困难，高度聚集电商客户群，以规模获得团购效益，从而达到共赢收益。
		</p>
		<p class="gray_font">
			2015年8月28日，团贷网与俊拓金融达成战略合作，深度切入供应链金融，在团贷网总部召开新闻发布会。自此，团贷网正式布局供应链金融，业务范围将从“由融而产”拓展到“由产而融”，形成“互联网金融+产业”的新局面。
		</p>
    </div>
    <a href="#" class="unfold_btn"></a>
</section>
<section class='con_2'>
	<div id="slider_img">
	  <ul>
	    <li>
	    	<div class="img_wraper">
	    	<img src="/imgs/juntou/slide_img_1.png" class="fir-img"><img src="/imgs/juntou/slide_img_2.png">
	    	</div>
	    </li>
	  </ul>
	</div>
</section>
<section class='con_3'>
	<img src="/imgs/juntou/con_3.png">
</section>
<section class='con_4'>
	<img src="/imgs/juntou/con_4.png">
</section>

<section class='con_5'>
	<div class="bg_bottom"></div>
	<div class="top_bottom"></div>

	<h2>
	<img src="/imgs/juntou/con_5_tit.png">
	</h2>
	<p>以大数据为依托，对电商企业资质、交易数据、退货数据、财务数据以及在途资金综合考评设置风控模型，真正做到无抵押、 无担保、纯信用借款。</p>
	<h3 class="tit">四大风控维度分析</h3>
	<div id="slider" class="fk_model_r">
	  <ul>
	    <li>
	    	<div class="fk_model_r_tab1">
            <span class="s1"><i class="bg-57c5fa"></i></span>
            <span class="s2"><i class="bg-fdd73f"></i></span>
            <span class="s3"><i class="bg-57c5fa"></i></span>
            <span class="s4"><i class="bg-fdd73f"></i></span>
            <span class="s5"><i class="bg-57c5fa"></i></span>
            <span class="s6"><i class="bg-fdd73f"></i></span>
            <span class="s7"><i class="bg-57c5fa"></i></span>
            <span class="s8"><i class="bg-fdd73f"></i></span>
            <span class="s9"><i class="bg-57c5fa"></i></span>
            <span class="s10"><i class="bg-fdd73f"></i></span>
            <span class="s11"><i class="bg-57c5fa"></i></span>
            <span class="s12"><i class="bg-fdd73f"></i></span>
            <div class="curve"></div>
         	</div>
         	<div class="text_tab">
         		<h5>上一年度整体销售数据分析：</h5>
         		<p>通过销售额、订单数量、已支付订单数量三重标准共同审核销售数据，仿制单一指标过高而产生的风险。</p>
         	</div>
	    </li>
		<li>
			<div class="fk_model_r_tab2">
            <span class="s1"><i class="bg-57c5fa"></i></span>
            <span class="s2"><i class="bg-57c5fa"></i></span>
            <span class="s3"><i class="bg-57c5fa"></i></span>
            <span class="s4"><i class="bg-57c5fa"></i></span>
            <span class="s5"><i class="bg-57c5fa"></i></span>
            <span class="s6"><i class="bg-57c5fa"></i></span>
            <div class="curve"></div>
          	</div>
          	<div class="text_tab">
         		<h5>过去一年在途资金分析:</h5>
         		<p>通过在途资金（物流途中、未放款、海外仓库存）的数据分析，了解到在途资金总量，解决风控资金层面的监管；在途资金可以有效展示客户的还款能力问题。</p>
         	</div>
		</li>
		<li>
			<div class="fk_model_r_tab3"><div class="curve"></div></div>
			<div class="text_tab">
         		<h5>上一年退货量分析，确定企业良性经营：</h5>
         		<p>销售客单价分析，目的是保持相对产品阶层的稳定性，产品  价值空间跨度比较低，风险等级相对较低；</p>
         	</div>
		</li>
		<li>
			<div class="fk_model_r_tab4">
            <span class="s1"><i class="bg-57c5fa"></i></span>
            <span class="s2"><i class="bg-57c5fa"></i></span>
            <span class="s3"><i class="bg-57c5fa"></i></span>
            <span class="s4"><i class="bg-57c5fa"></i></span>
            <span class="s5"><i class="bg-57c5fa"></i></span>
            <span class="s6"><i class="bg-57c5fa"></i></span>
            <div class="curve"></div>
            </div>
            <div class="text_tab">
         		<h5>过去一年销售客单价分析：</h5>
         		<p>任何成交客单价激增的情况，系统均会予以提示及报警，上传新品的客单价偏离平均水平，系统均会产生预警；新品数量的增加，也是风控指标中重要的组成部分。</p>
         	</div>
		</li>
	  </ul>
	</div>
</section>


<section class='con_6'>
	<h2>
	<img src="/imgs/juntou/con_6_tit.png">
	</h2>
	<p class="gray_font">
		在未来，俊拓金融将整合电商需求资源信息与供应商资源信息，在供需两端进行资源错配，并结合互联网金融，打造供应链的“互 联网金融+行业”的闭合生态圈。 
	</p>
	<p  class="gray_font">
		作为参与企业管理的金融服务机构，俊拓金融利用团贷网的资金杠杆帮助中小型电商、贸易 商企业实现扩大规模发展。以及带动整体产业发展，最终带动整个链条上各类企业的健康发展。
	</p>
</section>


<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/yxMobileSlider.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20151029001"></script>
  <script>
      $("#slider").yxMobileSlider({ width: 640, height: 800, during: 5000, focus_con: $(".con_5") })

      /*展开收起*/
      $("body").delegate('.unfold_btn', 'touchend', function (e) {
          e.preventDefault();
          $('.fold').hide();
          $('.unfold').show();
          $(this).removeClass('unfold_btn').addClass('fold_btn');
      });
      $("body").delegate('.fold_btn', 'touchend', function (e) {
          e.preventDefault();
          $('.fold').show();
          $('.unfold').hide();
          $(this).removeClass(' fold_btn').addClass('unfold_btn');
      });
  </script>
</body>
</html>