<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewLogistics.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.ViewLogistics" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>物流信息</title>
	<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/progress.css?v=20151224001" />
	
	</head>
	<body>
	    <%= this.GetNavStr()%>
		<header class="headerMain">
		    <div class="header">
		        <div class="back" onclick="javascript:history.go(-1);">返回</div>
		        <h1 class="title">物流信息</h1>
		    </div>
            <%= this.GetNavIcon()%>
		    <div class="none"></div>
		</header>
		<section class="bg-fff-bb-d1d1d1 pl15 pb20 pt20">
			<p class="f14px c-212121">运单号码：<%= ExpressNumber%></p>
			<p class="f14px c-212121 mt10">物流公司：<%= Express%></p>
		</section>
		<div class="progress mt15 bg-bdTop-ccc">
			<%--<section>
				<div class="date-wp date-active">
					<div class="date">【东莞市】东莞南城派件员：李喜田正在为你派件</div>
				</div>
				<div class="con bl-ababab">
					<div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						2015-12-13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;09:00
					</div>
				</div>	
			</section>
			<section>
				<div class="date-wp">
					<div class="date">【东莞市】  快件已到东莞南城</div>
				</div>
				<div class="con bl-ababab">
					<div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						2015-12-13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;09:00
					</div>
				</div>	
			</section>
			<section>
				<div class="date-wp">
					<div class="date">【东莞市】  东莞中心<span class="ml15">已发出</span></div>
				</div>
				<div class="con bl-ababab">
					<div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						2015-12-13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;09:00
					</div>
				</div>	
			</section>
			<section>
				<div class="date-wp">
					<div class="date">【广州市】  广州中转站<span class="ml15">已发出</span></div>
				</div>
				<div class="con bl-ababab">
					<div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						2015-12-13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;09:00
					</div>
				</div>	
			</section>
			<section>
				<div class="date-wp">
					<div class="date ml8">
						已发货，请耐心等待收货。
						<br>	
						运单号码：320000697706
						<br>
						物流公司：顺丰速运
						<br>
					</div>
				</div>
				<div class="con bl-ababab pt40 mt-20">
					<p class="c-ababab f12px lh14 bb-e6e6e6 pb20">2015-12-13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;09:00</p>	
				</div>	
			</section>
			<section>
				<div class="date-wp">
					<div class="date ml8">
						您已确认了收货信息<span class="ml15">备货中</span>
						<br>
						收件人：姚莉      18909090988	
						<br>
						地址：广东省深证市南山区科技园北区122号苍松大厦2楼
					</div>
				</div>
				<div class="con pr15 pt10">
					<!--<p class="c-ababab pt10 f12px lh14">收件人：姚莉&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;18909090988</p>
					<p class="c-ababab f12px lh14">地址：广东省深证市南山区科技园北区122号苍松大厦2楼</p>-->
					<p class="c-ababab f12px lh14">2015-12-13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;09:00</p>
				</div>	
			</section>		--%>
            <% if (listLsDt != null && listLsDt.Count > 0)
               {
                   for (int i = 0; i < listLsDt.Count; i++)
                   {
                       var item = listLsDt[i];
                       if (i == listLsDt.Count -1) //最后一个
                       {
                           %>
                            <section>
				                <div class="date-wp">
					                <div class="date ml8 f13px">
						                <%=item.Description %>
					                </div>
				                </div>
				                <div class="con pr15 pt10">
					                <p class="c-ababab f12px lh14"><%=item.CreateDate %></p>
				                </div>
			                </section>
            <%
                       }
                       else if (i == 0) //第一个
                       {
            %>
                            <section>
				                <div class="date-wp date-active">
					                <div class="date ml8 f13px"><%=item.Description %></div>
				                </div>
				                <div class="con bl-ababab">
					                <div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						                <%=item.CreateDate %>
					                </div>
				                </div>
			                </section>
            <%
                       }
                       else if (item.Description.Contains("br")) //中间节点包含br
                       {
            %>
                            <section>
				                <div class="date-wp">
					                <div class="date ml8 f13px"><%= item.Description %></div>
				                </div>
				                <div class="con bl-ababab pt55 mt-45">
					                <p class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						                <%= item.CreateDate %>
					                </p>
				                </div>	
			                </section>
            <%
                       }
                       else
                       {
                           %>
                            <section>
				                <div class="date-wp">
					                <div class="date ml8 f13px"><%= item.Description %></div>
				                </div>
				                <div class="con bl-ababab">
					                <div class="c-ababab pt10 pb20 bb-e6e6e6 f12px">
						                <p class="c-ababab f12px lh14"><%= item.CreateDate %></p>
					                </div>
				                </div>	
			                </section>
            <%
                       }
                   }
               }%>
		</div>
        <script type="text/javascript" src="/scripts/jquery.min.js"></script>
        <script type="text/javascript" src="/scripts/base.js?v=20151229001"></script>
	</body>
</html>
