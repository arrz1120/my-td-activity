﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_bills.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_bills" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>P2P账单</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <!--账户中心-->
    <style type="text/css">
        .c-9bc84a {
            color: #9bc84a;
        }
    </style>
</head>
<body>
    <%= this.GetNavStr()%>
  
    <div id="wrapper" style="top: 0 !important;">
        <div id="scroller" style="background-color: #fff;">
            <div id="pullDown" style="background-color: #fff;">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <section class="bill-box">
                <% if (model != null && model.List !=null && model.List.Count > 0)
                   {
                       var i = 0;
                       foreach (var Item in model.List)
                       {
                %>
                <% if (i == 0)
                   {
                %>
                <h3 class="pl15 c-808080 f12px" style="background-color: #f1f3f5;">
                    <%= Item.BillDate.ToString("yyyy") != DateTime.Now.ToString("yyyy") ? Item.BillDate.ToString("yyyy年MM月"):Item.BillDate.ToString("MM月")%>
                </h3>
                <%
                   } %>
                <%else if (i > 0 && Item.BillDate.ToString("yyyyMM") != model.List[i - 1].BillDate.ToString("yyyyMM"))
                   {
                %>
                <h3 class="pl15 c-808080 f12px" style="background-color: #f1f3f5;">
                    <%= model.List[i].BillDate.ToString("yyyy") != DateTime.Now.ToString("yyyy") ? model.List[i].BillDate.ToString("yyyy年MM月"):model.List[i].BillDate.ToString("MM月")%>
                </h3>
                <%
                   } %>

                <div class="bill-con bb-e6e6e6 ml15" onclick="LoadDetail('<%= Item.Id %>')">
                    <p>
                        <span class="f15px c-ababab"><%=Item.BillDate.ToString("MM-dd") %></span>
                        <span class="f12px c-ababab"><%=Item.BillDate.ToString("HH:mm:ss") %></span>
                    </p>
                    <p class="pos-a">
                        <span class="f18px <%= Item.PayOutAmount>0?"c-9bc84a":"c-fd6040"%>"><%= Item.PayOutAmount>0?"-":"+"%><%=(Item.PayOutAmount??0) > 0 ? (Item.PayOutAmount??0).ToString("N2") : ToolStatus.ConvertLowerMoney(Item.InAmount??0)%></span>
                        <span class="f12px c-808080 text-overflow"><%=GetBillTitle(Item) %>（<%=GetBillType(Item)%>）</span>
                        <!--无项目名称只显示说明-->
                    </p>
                </div>
                <%
                   i++;
                       }
                   } else {%>
                 <div class='debt-empty mt50 bg-f1f3f5'>
                        <div class='img-debt-empty text-center'>
                            <img style='width: 60%;' src='/imgs/images/debt-empty.png' />
                        </div>
                        <div class='text-center f14px c-212121 mt20'>近两个月无账单记录...</div>
                    </div> 
                <script>$("#scroller").attr("style","background-color:#f1f3f5;transition-property: transform;transform-origin: 0px 0px 0px;transition-timing-function: cubic-bezier(0.33, 0.66, 0.66, 1);transform: translate(0px, -40px) scale(1) translateZ(0px);transition-duration: 400ms;");</script>
                <%} %>
            </section>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
   
    
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        function LoadDetail(Id)
        {
            window.location.href="bills_details.aspx?Id="+Id;
        }
        pageIndex = 1; 
        pageCount=<%=pageCount %>; 
        $(function () {
            iScroll.onLoadData = LoadBillList;  
        });
        //获取交易记录
        function LoadBillList(flag) {
            $("body").showLoading("加载中...");
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/BorrowAjax.ashx",
                dataType: "json",
                data: { Cmd: "GetMyBillsShowList",pageIndex: pageIndex },
                success: function (jsonstr) {
                    $("body").hideLoading();
                    if (flag == "empty" || pageIndex == 1) {
                        $(".bill-box").html("");
                    } 
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            var opercss = "c-9bc84a";
                            if(jsonstr.list[i].OperateStr == "+")
                                opercss = "c-fd6040";
                            var h3 = "";
                            var currYear = "<%= DateTime.Now.ToString("yyyy")%>";
                            if ((pageIndex == 1 && i == 0) || (i > 0 && jsonstr.list[i].BillDate != jsonstr.list[i - 1].BillDate)) {
                                if(currYear != jsonstr.list[i].Year)
                                    h3 = '<h3 class="pl15 c-808080 f12px" style="background-color: #f1f3f5;">'+jsonstr.list[i].Year+'年'+jsonstr.list[i].Month+'月</h3>';
                                else 
                                    h3 = '<h3 class="pl15 c-808080 f12px" style="background-color: #f1f3f5;">'+jsonstr.list[i].Month+'月</h3>';
                                
                            } 
                            
                            str = h3+
                                    '<div class="bill-con bb-e6e6e6 ml15" onclick="javascript:LoadDetail(\''+jsonstr.list[i].Id+'\');">'+
                                       '<p>'+
                                            '<span class="f15px c-ababab">'+jsonstr.list[i].Day+'</span>'+
                                            '<span class="f12px c-ababab">'+jsonstr.list[i].Hour+'</span>'+
                                        '</p>'+
                                        '<p class="pos-a">'+
                                            '<span class="f18px '+opercss+'">'+jsonstr.list[i].OperateStr+jsonstr.list[i].Amount+'</span>'+
                                            '<span class="f12px c-808080 text-overflow">'+jsonstr.list[i].Title +'（'+jsonstr.list[i].BillType+'）</span>'+
                                        '</p>'+
                                    '</div>';
                            html.push(str);
                        }
                        $(".bill-box").append(html); 
                        myScroll.refresh();
                        if (pageCount <= 1) {
                            $("#pullUp").hide();
                        } else {
                            $("#pullUp").show();
                        }
                    }
                    else {
                        $(".bill-box").append("<div class='debt-empty mt50 bg-f1f3f5'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>近两个月无账单记录...</div></div></div>");
                        pageCount = 0; 
                        $("#pullUp").hide(); 
                    }
                    
                    
                },
                error: function () {
                    $("body").hideLoading();
                }
            });
        } 
    </script>
</body>
</html>
