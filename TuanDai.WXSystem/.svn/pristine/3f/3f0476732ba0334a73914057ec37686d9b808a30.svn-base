<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity._20150901Vote.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title> 
     <script type="text/javascript" src="/scripts/jquery.min.js"></script>  
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>     
    <script type="text/javascript" src="/scripts/weixinapi.js?v=3.3"></script>  

     <script type="text/javascript">
         wxData.isWxJsSDK = true;
         //wxData.debug = true; 
         wxData.url = 'http://weixin.hao8dai.com/Activity/20150901Vote/Index.aspx';
         wxData.title = "团贷杯登山摄影大赛";
         wxData.desc = "大家快点来偷我啊！";
         wxData.img_url = "http://m.tuandai.com/imgs/bav_head.gif";
         wxData.ShareCallBack = function (ex)
         {
             alert(ex == "success" ? "分享成功" : "取消分享");
         }
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <div>已参与投票人数:<%=VoterCount %></div>
        <div><input type="text" id="keyword"/> <input type="button" value="查找" onclick="loadVoteList(1)"/></div>
    <div>
        <input type="button" value="投票" onclick="loadVoteOrderList()"/>
        
        <input type="button" value="加载排名列表" onclick="loadTop20List()"/>
        
        <input type="button" value="加载参赛列表" onclick="loadVoteList(1)"/>
        <div id="images">
            
        </div>
    </div>
    </form>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>  
    <script language="javascript" type="text/javascript">
        var currentPageIndex = 1;
        var code = "<%=HostOpenId %>";
        function loadVoteList(pageIndex) {
            var keyword = $('#keyword').val(); 
            $.ajax({
                url: "VoteAjaxHandler.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetParticpantsList", pageIndex: pageIndex, keyword: keyword, rand: Math.random() },
                success: function (result)
                {
                    if (result.Success) {
                        var html = "";
                        for (var i = 0; i < result.list.length ;i++)
                        {
                            html = html + "<input type='button' onclick=\"Vote('" + result.list[i].ParticipantId + "',this);\" value='" + result.list[i].Name + "_" + result.list[i].OrderNo + "'/></br>";
                        }
                        $("#images").html(html);
                        alert("加载成功");
                    }
                   
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { }
            });
        }

        function loadTop20List()
        {
            $.ajax({
                url: "VoteAjaxHandler.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetVoteTop20List",rand:Math.random() },
                success: function (result)
                {
                    if (result.Success)
                    {
                        var html = "";
                        for (var i = 0; i < result.list.length ; i++)
                        {
                            html = html + "<input type='button' onclick=\"Vote('" + result.list[i].ParticipantId + "',this);\" value='_" + result.list[i].Name + result.list[i].OrderNo + "_'/></br>";
                        }
                        $("#images").append(html);
                        alert("加载成功");
                    }
                    alert(result.Message);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { }
            });
        }



        function Vote(participantId,btnObjec) {
            alert(participantId);
            $.ajax({
                url: "VoteAjaxHandler.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "Vote", participantId: participantId,code:code, rand: Math.random() },
                success: function (result)
                { 
                        var message = "投票失败！";
                        switch (result.Status)
                        {
                            case 1:
                                message = "投票成功";
                                break;
                            case 0:
                                message = "系统异常";
                                break;
                            case -1:
                                message = "活动未开始!";
                                break;
                            case -2:
                                message = "活动已结束!";
                                break;
                            case -3:
                                message = "每个用户每天只能投一次喔!";
                                break;
                            case -4:
                                message = "没有获取ID";
                                break;
                        } 

                    alert(message);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { }
            });
        } 
    </script>
</body>
</html>
