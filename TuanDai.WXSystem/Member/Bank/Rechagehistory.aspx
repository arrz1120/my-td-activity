<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rechagehistory.aspx.cs"
    Inherits="TuanDai.WXApiWeb.Member.Bank.Rechagehistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" >
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>充值记录</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=20160328" /> 
</head>
<body class="bg-f1f3f5">
 <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-e6e6e6">
            <div class="back" onclick="javascript:window.location.href='/Member/Repayment/DealLog.aspx'">返回</div>
            <h1 class="title">充值记录</h1>
        </div>
          <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>  

    <div class="recharge-list">
        <div class="pt11 pb11 pl15 c-808080 f15px bb-e6e6e6">
    	    累计成功充值：￥<%=ToolStatus.ConvertLowerMoney(TotalRecharge)%>
        </div> 
     <div id="wrapper" style="top: 46px;">
        <div id="scroller"> 
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div id="report_detail_processing" class="dataTables_processing" style="display:none">正在加载...</div> 
           
             

             <!--列表 start-->
    	        <ul class="bg-fff bb-e6e6e6 pos-r z-index10" id="thelist" >
                     <% if (dataList != null && dataList.Any())
                     {  %>
                      <% foreach (var Item in dataList) { %>
    		            <li class="pl15 clearfix pr15 bt-e6e6e6">
    			            <div class="lf">
    				            <p class="c-212121 f17px pt10">￥<%=ToolStatus.ConvertLowerMoney(Item.Amount)%></p>
    				            <p class="f13px c-d1d1d1 line-h16 mt4"><i class="ico-inline ico-clock"></i><%= Item.AddDate.ToString("yyyy-MM-dd HH:mm")%> <i class="ico-inline <%=GetDeviceType(Item.From??1) %>"></i></p>
    			            </div>
    			            <div class="rf f15px c-212121 pt20"><%=GetStatusIcon(Item.Status) %></div>
    		            </li>
                    <%}
                      }else{ %>
                     <li><div class='debt-empty mt50 bg-f1f3f5'>
                            <div class='img-debt-empty text-center'>
                                <img style='width: 60%;' src='/imgs/images/debt-empty.png' />
                            </div>
                            <div class='text-center f14px c-212121 mt20'>暂时没有记录...</div>
                        </div></li>
                    <%} %> 
    	        </ul>
       <div id="pullUp">
         <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
      </div>          
</div>
</div> 
</div> 

     <div class="pos-f look-record bt-e6e6e6">
    	 只看成功记录
     </div>

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?=1.0"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
    var pStatus=-1;
    pageIndex = 1; 
    pageCount=<%=pageCount %>;  
     $(function () { 
        iScroll.onLoadData=LoadDataList; 
        if(pageCount<=1){
            $("#pullUp").hide();
        } 
        $(".look-record").click(function(){
            if(pStatus==-1){
                $(this).html("查看全部记录");
                pStatus=2;
            }else{
                $(this).html("只看成功记录");
                pStatus=-1;
            }
            pageIndex=1;
            LoadDataList("empty");
        });
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
            data: { Cmd: "GetRechageShowList", pageIndex: pageIndex ,status:pStatus},
            success: function (jsonstr) { 
                if (flag == "empty") {
                    $("#thelist").children().remove();
                }
                var html = new Array();
                var str = "";
                if (jsonstr.result == "1") {
                    pageCount=parseInt(jsonstr.pagecount);
                    for (var i = 0; i < jsonstr.list.length; i++) { 
                        str="<li class='pl15 clearfix pr15 bt-e6e6e6'>"+
                             " <div class='lf'>"+
                             " <p class='c-212121 f17px pt10'>￥"+jsonstr.list[i].Amount+"</p>"+
                             "  <p class='f13px c-d1d1d1 line-h16 mt4'><i class='ico-inline ico-clock'></i>"+jsonstr.list[i].AddDate+"<i class='ico-inline "+jsonstr.list[i].DeviceType+"'></i></p>"+
                             "</div>"+
                             "<div class='rf f15px c-212121 pt20'>"+jsonstr.list[i].StatusStr+"</div>"+
                             "</li>";
                        html.push(str);
                    }
                    $("#thelist").append(html.join("")); 
                    if(pageCount<=1){
                        $("#pullUp").hide();
                    }else{
                        $("#pullUp").show();
                    } 
                }
                else {
                    var emtpyHtml="<li><div class='debt-empty mt50 bg-f1f3f5'>"+
                              " <div class='img-debt-empty text-center'>"+
                              "     <img style='width: 60%;' src='/imgs/images/debt-empty.png' />"+
                              "</div>"+
                              "<div class='text-center f14px c-212121 mt20'>暂时没有记录...</div>"+
                              "</div></li>";
                    $("#thelist").append(emtpyHtml);
                    $("#pullUp").hide();
                }
                $("#report_detail_processing").hide();
                $('#thelist').find('li:first').removeClass('bt-e6e6e6');
                myScroll.refresh();
            },
            error: function () {
                $("#report_detail_processing").hide();
            }
        });
    }
    
    $('#thelist').find('li:first').removeClass('bt-e6e6e6');
    </script>
</body>
</html>
