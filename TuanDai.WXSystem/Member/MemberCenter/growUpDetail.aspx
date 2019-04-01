﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="growUpDetail.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.growUpDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>成长明细</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/growUpDetail.css" />
    <!--成长明细-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body>
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header">
                <div class="back" onclick="javascript:window.location.href='memberCenter.aspx'">返回</div>
                <h1 class="title">成长明细</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <div class="growUpDetail_list">
            <div id="wrapper">
                <div id="scroller">
                    <div id="pullDown">
                        <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
                    </div>
                    <div id="report_detail_processing" class="dataTables_processing" style="display: none">正在加载...</div>

                    <ul id="thelist">
                        <%if (this.listGrowthInfo != null && this.listGrowthInfo.Count > 0)
                          {
                              foreach (var item in listGrowthInfo)
                              {
                        %>
                        <li>
                            <div class="row1 clearfix">
                                <font><%=Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.UserGrowthType), item.TypeId)%></font>
                                <span>+<%=item.AddGrowth %></span>
                            </div>
                            <div class="row2 clearfix">
                                <font><%=item.CreateDate %></font>
                                <span>总成长值：<%=item.Growth %></span>
                            </div>
                        </li>
                        <%}
                            }
                          else
                          { %>
                        <li>暂时没有记录...</li>
                        <%} %>
                    </ul>

                    <div id="pullUp">
                        <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
                    </div>
                </div>
            </div>
        </div>
        <!--end-->
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript">
        var dateType = 0;
        pageSize = <%=pageSize%>;
	    pageIndex = 1;
	    pageCount = <%=pageCount%>;
	    $(".item:last").css('border', 'none');
	    $(function () {
	        iScroll.onLoadData = GrowthDetailList;
	        if(pageCount<=1){
	            $("#pullUp").hide();
	        } 
	    })

	    function GrowthDetailList(flag) {
	        $("#report_detail_processing").show();
	        if (flag == "empty") {
	            $("#thelist").children().remove();
	        }
	        jQuery.ajax({
	            type: "post",
	            url: "/AjaxCross/ajax_Acticity.ashx",
	            dataType: "json",
	            data: { Cmd: "GetGrowthDetailList", pageIndex: pageIndex, DateType: dateType, pageSize: pageSize },
	            success: function (jsonstr) {
	                if (flag == "empty") {
	                    $("#thelist").children().remove();
	                }
	                var html = new Array();
	                var str = "";
	                if (jsonstr.result == "1") {
	                    for (var i = 0; i < jsonstr.list.length; i++) {
	                        str = '<li>' +
								 '   <div class="row1 clearfix">' +
								 '       <font>' + jsonstr.list[i].TypeId + '</font>' +
								 '       <span>+' + jsonstr.list[i].AddGrowth + '</span>' +
								 '   </div>'+
								 '   <div class="row2 clearfix">' +
								 '       <font>' + jsonstr.list[i].CreateDate + '</font>' +
								 '       <span>总成长值：' + jsonstr.list[i].Growth + '</span>' +
								 '   </div>' +
								 '</li>';
	                        html.push(str);
	                    }
	                    $("#thelist").append(html.join(""));
	                    if (pageCount == pageIndex) {
	                        $("#pullUp").hide();
	                    } else {
	                        $("#pullUp").show();
	                        $(".pullUpLabel").html("上拉加载更多...");
	                    }
	                }
	                else {
	                    pageCount = 0;
	                    $("#thelist").append("<li>暂时没有记录...</li>");
	                    $("#pullUp").hide();
	                }
	                //myScroll.refresh(); 
	                $("#report_detail_processing").hide();
	            },
	            error: function (a, b, c) {
	                $("#report_detail_processing").hide();
	            }
	        }); 
	    }		
    </script>
</asp:Content>