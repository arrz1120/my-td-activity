<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="newsdetail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.news.newsdetail" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>团贷热点详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /> 
    <link rel="stylesheet" type="text/css" href="/css/news.css?v=1.0" />
    <script src="/scripts/youku.jsapi.js" type="text/javascript"></script>
    <style type="text/css">
      #video
        {
            z-index: 100;
            height: 412px;
            width: 100%;
            float: left;
            position: relative;
        }
       .datestyle{ margin-bottom:10px;}
       .header .more{ width: auto; height: 48px; line-height: 48px; color: #000; font-size: 1.3rem; position: absolute; top: 0; right: 15px; z-index: 100; cursor:pointer;}
    </style>
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">团贷热点详情</h1> 
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header> 
  <div class="newsMain pt15 pb20"> 
        <h1 class="title"><%=strTitle %></h1>     
        <div class="date"><%=AddDate %></div>
        <% if (InfoType == 1)
           { %>
        <div class="newsCont"><%=Content%></div>
    <%}
       else
       { %>
	      <div id="video">
                 <%
           if (VideoPath.Length < 20)
           {%>
                        <script type="text/javascript" src="http://player.youku.com/jsapi">
                            var id = '<%=VideoPath %>';
                            player = new YKU.Player('video', {
                                styleid: '0',
                                client_id: '52b3fa57e9fe17cf',
                                vid: id,
                                autoplay: false,
                                show_related: false
                            });
                        </script>
                    <%}
           else if (VideoPath.Substring(VideoPath.Length - 3).ToLower() == "flv")
           {
                          //如果是FLV则调用自己的flvplayer来播放
                     %>
                    <script src="/scripts/jw_player/jwplayer.js" type="text/javascript"></script>
                    <script type="text/javascript">
                        jwplayer("video").setup({
                            file: "<%=VideoPath %>",
                            image: "<%=VideoPath %>",
                            title: "<%=Title %>",
                            width: 720,
                            height: 445
                        });
                    </script>
                    <%
           }  
                    %>
                </div>
      <%} %> 
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
</body>
</html>
