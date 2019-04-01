<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubscribeUser.aspx.cs"
    Inherits="TuanDai.WXApiWeb.pages.invest.SubscribeUser" %>

<%@ Import Namespace="TuanDai.WXApiWeb.pages.invest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>申购人数</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=20160419" />

</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-e6e6e6">
            <div class="pageReturn" onclick="<%=BackURL %>"></div>
            <h1 class="title">申购人数</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div id="wrapper" style="top: 0;">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div id="report_detail_processing" class="dataTables_processing" style="display: none">正在加载...</div>

            <div class="sub-list">
                <ul class="pl15 bg-fff bb-e6e6e6 pos-r z-index10" id="thelist">
                    <% if (dataList != null && dataList.Any())
                       {
                           var i = 0;%>
                        <% foreach (SubscribeUser.SubscribeUserInfo item in dataList)
                            { %> 
                    <li class="clearfix <%=i==0?"":"bt-e6e6e6" %> pr15">
                        <div class="lf">
                            <p class="c-212121 f17px pt10"><%= string.IsNullOrWhiteSpace(item.NickName)  ? SubStringName(item.UserName) : SubStringTelNo(item.NickName)%></p>
                            <p class="f13px c-d1d1d1 line-h16 mt5"><span class="sub_way"><%= item.OrderType == "智能投资"?"智能投资": item.IsAuto?"自动":"手动" %></span>
                                <% if (item.OrderType == "网站" || item.OrderType == "自动" || item.OrderType == "智能投资")
                                   {
                                       %>
                                <i class="ico-inline ico-pc"></i>
                                <%
                                   }else if (item.OrderType == "IOS")
                                   {
                                       %>
                                <i class="ico-inline ico-apple"></i>
                                <%
                                   }else if (item.OrderType == "安卓")
                                   {
                                       %>
                                <i class="ico-inline ico-android"></i>
                                <%
                                   }else if (item.OrderType == "触屏版")
                                   {
                                       %>
                                <i class="ico-inline ico-mobile"></i>
                                <%
                                   } else if (item.OrderType == "微信")
                                   {
                                %>
                                <i class="ico-inline ico-weixin"></i>
                                <%  }  else {  %>
                                <i class="ico-inline ico-pc"></i>
                                <%
                                   }%> 
                            </p>
                        </div>
                        <div class="rf f15px c-212121 pt10">
                            <p class="c-fab600 f17px text-right">￥<%= ToolStatus.ConvertLowerMoney(item.Amount)%></p>
                            <p class="f13px c-d1d1d1 line-h16 mt3"><i class="ico-inline ico-clock"></i><%= item.OrderDate.Value.ToString("yyyy-MM-dd HH:mm:ss")%></p>
                        </div>
                    </li>
                        <% i++;
                            }
                       }else{ %>
                       <div class="debt-empty webkit-box box-center box-vertical w100p pos-a bg-fff" style="height: 100%;">
                           <div class="img-debt-empty text-center">
                               <img style="width: 60%;" src="/imgs/images/debt-empty.png"/>
                           </div>
                           <div class="text-center f14px c-212121 mt20">暂时没有记录...</div> 
                       </div> 
                    <%} %>
                </ul>
            </div>

            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>

        </div>
    </div>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    pageIndex = 1; 
    pageCount=<%=pageCount %>; 
    $(function () { 
        iScroll.onLoadData=LoadDataList; 
        if(pageCount<=1){
            $("#pullUp").hide();
        } 
    });
    function LoadDataList(flag){ 
        $("#report_detail_processing").show();
        if (flag == "empty") {
            $("#thelist").children().remove(); 
        }
        jQuery.ajax({
            async: false,
            type: "Post",
            url: "/ajaxCross/NewsAjax.ashx",
            dataType: "json",
            data: { Cmd: "GetSubscribeUserList", 
                pageIndex: pageIndex, projecttype:"<%=strType %>", projectid:"<%=projectId %>"},
            success: function (jsonstr) { 
                if (flag == "empty") {
                    $("#thelist").children().remove();
                }
                var html = new Array();
                var str = "";
                if (jsonstr.result == "1") {
                    for (var i = 0; i < jsonstr.list.length; i++) { 
                        var style = "";
                        if (i != 0)
                            style = "bt-e6e6e6";
                        if(i == 0 && pageIndex > 1)
                            style = "bt-e6e6e6";
                        var auto = "手动";
                        if (jsonstr.list[i].IsAuto == "True")
                            auto = "自动";
                        if (jsonstr.list[i].OrderType == "We计划")
                            auto = "We计划";
                        var ihtml = "";
                        if (jsonstr.list[i].OrderType == "网站" || jsonstr.list[i].OrderType == "自动" || jsonstr.list[i].OrderType == "We计划") {
                            ihtml = '<i class="ico-inline ico-pc"></i>';
                        }else if (jsonstr.list[i].OrderType == "IOS") {
                            ihtml = '<i class="ico-inline ico-apple"></i>';
                        }
                        else if (jsonstr.list[i].OrderType == "安卓") {
                            ihtml = '<i class="ico-inline ico-android"></i>';
                        }
                        else if (jsonstr.list[i].OrderType == "触屏版") {
                            ihtml = '<i class="ico-inline ico-mobile"></i>';
                        }
                        else if (jsonstr.list[i].OrderType == "微信") {
                            ihtml = '<i class="ico-inline ico-weixin"></i>';
                        } else {
                            ihtml = '<i class="ico-inline ico-pc"></i>';
                        }
                        str='<li class="clearfix '+style+' pr15">'+
                                '<div class="lf">'+
                                    '<p class="c-212121 f17px pt10">'+jsonstr.list[i].NickName+'</p>'+
                                    '<p class="f13px c-d1d1d1 line-h16 mt5"><span class="sub_way">'+auto+'</span>'+ihtml+'</p>'+
                                '</div>'+
                                '<div class="rf f15px c-212121 pt10">'+
                                    '<p class="c-fab600 f17px text-right">￥'+jsonstr.list[i].Amount+'</p>'+
                                    '<p class="f13px c-d1d1d1 line-h16 mt3"><i class="ico-inline ico-clock"></i>'+jsonstr.list[i].AddDate+'</p>'+
                                '</div>'+
                            '</li>'; 
                        html.push(str);
                    }
                    $("#thelist").append(html.join("")); 
                }
                else {
                    str="<div class='debt-empty webkit-box box-center box-vertical w100p pos-a bg-fff' style='height: 100%;'>"+
                       "<div class='img-debt-empty text-center'>"+
                       "    <img style='width: 60%;' src='/imgs/images/debt-empty.png'/>"+
                       " </div>"+
                       " <div class='text-center f14px c-212121 mt20'>暂时没有记录...</div> "+
                       "</div>";
                    $("#thelist").append(str);
                }
                $("#report_detail_processing").hide(); 
            },
            error: function () {
                $("#report_detail_processing").hide();
            }
        });
        }
</script>
</html>
