<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="newslist.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.news.newslist" %>
<%@ Import Namespace="TuanDai.PortalSystem.Model" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>团贷热点</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/news.css?v=1.0" />
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='<%= TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?"/WeiXinIndex.aspx":"/Index.aspx" %>'">返回</div>
        <h1 class="title">团贷热点</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
    <section class="screen-invest weMain">
  <div class="newsMain">
    <div id="wrapper">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
                    <div id="report_detail_processing" class="dataTables_processing" style="display:none">正在加载...</div>
                     
                     <ul id="thelist">
                     <% foreach (WXNewsVideoInfo item in this.newsList)
                        { %>
                         <li>
				            <a href="/pages/news/newsdetail.aspx?type=<%=item.InfoType%>&id=<%=item.Id%>" class="block"> 
                               <div class="listCont">
                                   <div class="picBox"><img src="<%=GetShownNewsImg(item.HeadImg)%>" alt="" style="width:100px;height: 57px;"></div>
                                   <h2 class="tit"><%= Tool.StrObj.CutString(item.Title, 20)%></h2>
                                   <p class="date"><%= (item.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd")%></p>
                               </div> 
				            </a>
			            </li> 
                      <%} %>
                    </ul> 
            <div id="pullUp">
                 <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
</div>
</section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
    pageIndex = 1; 
    pageCount=<%=pageCount %>; 
    $(function () { 
        iScroll.onLoadData=LoadNewsList; 
        if(pageCount<=1){ 
            $("#pullUp").hide();
        }
    });
    function LoadNewsList(flag){
        $("#report_detail_processing").show();
        if (flag == "empty") {
            $("#thelist").children().remove(); 
        }
        jQuery.ajax({ 
            type: "post",
            url: "/ajaxCross/NewsAjax.ashx",
            dataType: "json",
            data: { Cmd: "GetNewsShowList", pageIndex: pageIndex },
            success: function (jsonstr) {
                if (flag == "empty") {
                    $("#thelist").children().remove();
                }
                var html = new Array();
                var str = "";
                if (jsonstr.result == "1") {
                    for (var i = 0; i < jsonstr.list.length; i++) {
                        str =" <li>"+
				             " <a href=\"/pages/news/newsdetail.aspx?type="+jsonstr.list[i].InfoType+"&id="+jsonstr.list[i].NewsId+"\" class=\"block\">"+
                             " <div class=\"listCont\"> "+
					         "    <div class=\"picBox\"><img src=\""+jsonstr.list[i].HeadImg +"\" alt=\"\" style=\"width:100px;height: 57px;\"></div>"+
					         "    <h2 class=\"tit\">"+jsonstr.list[i].Title +"</h2>"+
					         "    <p class=\"date\">"+jsonstr.list[i].AddDate +"</p>"+
                             "  </div> "+
				             " </a>"+
			                " </li> ";
                        html.push(str); 
                    }
                    $("#thelist").append(html.join("")); 
                }
                else {
                    $("#thelist").append("<li>暂时没有动态...</li>");
                }
                $("#report_detail_processing").hide();
            },
            error: function () {
                $("#report_detail_processing").hide();
            }
        });
    }
    </script>
</body>
</html>
