<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_return_smbdetail.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_return_smbdetail" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>回款详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=20151202001" />
    <!--账户中心-->
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <a class="back"   href="<%=string.IsNullOrEmpty(GoBackUrl)?"/Member/Repayment/my_return_list.aspx?tab="+tab:GoBackUrl %>">返回</a>
            <h1 class="title">回款详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <a href="<%=GetUrl()%>">
    <section class="return-top-cn">
        <div class="clearfix">
            <div class="lf">
                <p class="f11px c-434343"><%=ToolStatus.ConvertProjectType((int)projectInfo.Type)%>&nbsp;&nbsp;<%=projectInfo.Title%></p>
                <p class="f10px c-ababab mt5">投标时间：<%=Convert.ToDateTime(subscribeInfo.AddDate).ToString("yyyy-MM-dd HH:mm")%>(<%=TenderMode%>)</p>
            </div>
            <div class="rf">
                
                    <%if (Status == "回款中")
                      {%>
                    <i class="icoBox11 state5"></i><span class="f13px c-9aca40"><%=Status%></span>
                    <%}
                      else if (Status == "已完成")
                      {%>
                    <i class="icoBox11 state2"></i><span class="f13px c-9aca40"><%=Status%></span>
                    <%}
                      else if (Status == "逾期")
                      {%>
                    <i class="icoBox11 state1"></i><span class="f12px c-fd6040"><%=Status%></span>
                    <%}
                      else if (Status == "投标中")
                      {%>
                    <i class="icoBox11 state3"></i><span class="f12px c-ffcf1f"><%=Status%></span>
                    <%}
                      else if (Status == "已流标")
                      {%>
                    <i class="icoBox11 state4"></i><span class="f12px c-fd6040"><%=Status%></span>
                    <%}
                      else if (Status == "持有中")
                      {%>
                    <i class="icoBox11 state7"></i><span class="f13px c-fd6040"><%=Status%></span>
                    <%}
                    %>
                
            </div>
        </div>
    </section>
        </a>
    <section class="fundPreview">
        <% if (projectInfo.Type == 18 && projectSmb != null && simubaoCurve != null && projectSmb.ProfitTypeId == 1)
           { %>
        <div class="c-694514 f12px">最新市值(元)</div>
            <% if (subscribeInfo.Status == 2)
               { %>
            <div class="c-fff f30px pt15 pb15">¥<%= ToolStatus.ConvertLowertwo(simubaoCurve.simubao.CountInterestPrice) %> </div>
            <% }
               else
               { %>
            <div class="c-fff f30px pt15 pb15">--</div>
            <% }  
           } else  {%>
        <div class="c-694514 f12px">待收本息</div>
        <div class="c-fff f30px pt15 pb15">¥<%= ToolStatus.ConvertLowerMoney(projectInfo.Type==23? subscribeInfo.Amount+xmbDSInterest:subscribeInfo.Amount + subscribeInfo.InterestAmount+subscribeInfo.TuandaiRedPacket+subscribeInfo.PublisherRedPacket) %></div>
        <% } %>

        <div class="warningMain clearfix">
            <div>
                <p class="c-212121 f12px lh20">投资金额</p>
                <p class="c-fff f16px pt5 pb15">￥<%=ToolStatus.ConvertLowerMoney(subscribeInfo.Amount)%></p>
            </div>
            <div>
                <% if (projectInfo.Type == 18 && projectSmb != null && simubaoCurve != null && projectSmb.ProfitTypeId == 1)
                   { %>
                <p class="c-212121 f12px lh20">当前浮动利息</p>
                <p class="c-fff f16px pt5 pb15">￥<%= ToolStatus.ConvertLowerMoney(simubaoCurve.simubao.Profit) %></p>
                <%
                   }
                   else if (projectInfo.Type == 23) {  %>
                 <p class="c-212121 f12px lh20">可获利息</p>
                 <p class="c-fff f16px pt5 pb15">￥<%=ToolStatus.ConvertLowerMoney(xmbDSInterest) %></p>
                <% }  else { %>
                <p class="c-212121 f12px lh20">可获利息+奖金</p>
                <p class="c-fff f16px pt5 pb15">￥<%= ToolStatus.ConvertLowerMoney(subscribeInfo.InterestAmount+subscribeInfo.TuandaiRedPacket+subscribeInfo.PublisherRedPacket) %></p>
                <% } %>
            </div>
        </div>
    </section>
    <div class="returned-box clearfix">
        <% if (projectInfo.Type == 18 && projectSmb != null)
           {%>
        <div class="hint-text">
            <p class="mr15 f12px mt10"><%=(projectSmb.InvestFeeRate ?? 0)==0?"无": GetInvestFeeRate((projectSmb.InvestFeeRate ?? 0),projectSmb.ProfitTypeId??0)%></p>
        </div>
        <div class="bg-fbfbf9 pt15"></div>
        <%
           } %>
        <% if (projectInfo.Type == 18 && projectSmb != null && projectSmb.ProfitTypeId == 1)
           {%>
        <!--显示图表 start-->
        <section class="trend-chart bg-fff pl15 pr15">
            <h3 class="c-434343 f14px pt15">近期走势</h3> 
            <div style="width: 100%">
                <div>
                    <canvas id="canvas" height="350" width="600"></canvas>
                </div>
            </div>
        </section>
        <script type="text/javascript" src="/scripts/jquery.min.js"></script>
        <script type="text/javascript" src="/scripts/Chart.min.js"></script>
        <script type="text/javascript">
            function getSMBProjectFundDetail() {
                var dateList = new Array();
                var priceList = new Array();

                jQuery.ajax({
                    async: false,
                    type: "post",
                    url: "/ajaxCross/ajax_simubao.ashx",
                    dataType: "json",
                    data: { Cmd: "GetSMBProjectFundDetail", projectid: "<%=ProjectId%>" },
                    success: function (jsonstr) {
                        if (jsonstr.result == "1") {
                            for (var i = 0; i < jsonstr.list.length; i++) {
                                dateList[i] = jsonstr.list[i].PriceDate;
                                priceList[i] = jsonstr.list[i].Price;
                            }
                        }
                    }
                });
                var lineChartData = {
                    labels: dateList,
                    datasets: [
                        {
                            label: "收益走势",
                            fillColor: "transparent",
                            strokeColor: "rgba(255,194,27,1)",
                            pointColor: "rgba(151,187,205,1)",
                            pointStrokeColor: "#000",
                            pointHighlightFill: "#000",
                            pointHighlightStroke: "rgba(151,187,205,1)",
                            data: priceList
                        }
                    ]
                }

                var ctx = document.getElementById("canvas").getContext("2d");
                window.myLine = new Chart(ctx).Line(lineChartData, {
                    responsive: true,
                    bezierCurve: false,
                    pointDot: false,
                    scaleLineWidth: 1,
                    scaleFontColor: "#adadad",
                    scaleFontSize: 8
                });
            }

            $(function () {
                getSMBProjectFundDetail();
            });
        </script> 
        <!--显示图表 end--> 
        <%  }
           else
           {%>
        <section class="clearfix">
            <div class="returned-nav clearfix">
                <% if(projectInfo.Type==23){%>
                 <div class="p-left">
                        <div class="textBox" id="textBox">
                            <span class="dataBox f12px">持有时间</span>
                        </div>
                    </div>
                    <div class="p-right f12px">当前利率<img id="detail_B" onclick="showAlert();" src="/imgs/images/state1.png" style="width:16px;height:16px;"></div> 
                <%}else{ %>
                    <div class="p-left">
                        <div class="textBox" id="textBox1">
                            <span class="dataBox f12px">回款时间</span>
                        </div>
                    </div>
                    <div class="p-left1 f12px">本金+(利息+奖金)</div>
                    <div class="p-right f12px">状态</div>
                <%} %>
            </div>
        </section>
        <section class="clearfix">
            <div class="listBox pd0 clearfix">
                <ul class="clearfix">
                    <%
               if (this.listtable.Count > 0)
               {
                   foreach (SubscribeInfo model in this.listtable)
                   {
                    %>
                    <!--begin-->
                    <%
                       if (projectInfo.Type == 23) { %>
                       <li>
                            <span class="lf f12px c-808080"><%=xmbHoldDay%>天</span>
                            <span class="md pos-a f12px c-808080">&nbsp;</span>
                            <span class="rf f12px c-808080"><%=ToolStatus.DeleteZero(xmbDeadRate)%>%</span>
                        </li>
                    <%} else  if (model.Desc == "已逾期") {%>
                        <li class="on">
                            <span class="lf f12px c-808080"><%=model.CycDate != null ? Convert.ToDateTime(model.CycDate).ToString("yyyy-MM-dd") : ""%></span>
                            <div class="pos-a list-cn">
                                <p><span class="f12px c-808080"><b class="c-212121">¥<%= ToolStatus.ConvertLowerMoney(model.Amount)%></b>+<i class="c-fd6040"><%= ToolStatus.ConvertLowerMoney(model.InterestAmout+model.TuandaiRedPacket+ model.PublisherRedPacket)%></i></span></p>
                                <p><span class="f12px sp1">滞纳金</span><span class="f12px c-fd6040">&nbsp;&nbsp;¥<%= ToolStatus.DeleteZero(model.PenaltyAmount)%></span></p>
                            </div>
                            <div class="pos-a hint-cn">
                                <p>发生逾期，团贷网已经提供安全保障服务</p>
                            </div>
                            <div class="pos-a state-cn">
                                <span class="f12px c-fd6040">逾期</span>
                                <span class="f12px c-fd6040"><%=model.OverDueDay%>天</span>
                            </div>
                        </li>
                    <%} else {%>
                        <li>
                            <span class="lf f12px c-808080"><%=model.CycDate != null ? Convert.ToDateTime(model.CycDate).ToString("yyyy-MM-dd") : ""%></span>
                            <span class="md pos-a f12px c-808080"><b class="c-212121">¥<%= ToolStatus.ConvertLowerMoney(model.Amount)%></b>+<i class="c-fd6040"><%= ToolStatus.ConvertLowerMoney(model.InterestAmout+model.TuandaiRedPacket+ model.PublisherRedPacket)%></i></span>
                            <span class="rf f12px c-808080"><%=model.Desc%></span>
                        </li>
                    <%} %> 
                    <!--end-->
                  <% }
               }
                    %>
                </ul>
            </div>
        </section>
        <%
           } %>
    </div>
      <!--弹窗-->
    <div class="alert bg-opacity07 zIndex250" id="alert" style="display: none;">
        <div class="alert_bg">
            <div class="alert_wp">
                <div class="alert_close" id="close" onclick="closeAlert()">
                </div>
                <div class="alert_tit">
                    <p>年化利率随资金使用时间变化而变化，时间越长利率越高</p>
                </div>
                <div class="tableB">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr class="th">
                            <td>资金使用时间（月）</td>
                            <td>对应年化利率</td>
                        </tr>
                        <% if (rateRangeList!=null && rateRangeList.Count > 0)
                           {
                               foreach (var item in rateRangeList)
                               { %>
                                        <tr>
                                        <td>
                                            <%=item.MinDeadLine == 0 ? "时间≤"+item.MaxDeadLine+"个月" : string.Format("{0}＜时间≤{1}个月",item.MinDeadLine -1 ,item.MaxDeadLine)  %> 
                                        </td>
                                        <td>
                                             <%=ToolStatus.DeleteZero(item.YearRate.Value) %>%
                                        </td>
                                       </tr>     
                                     <%}} %>   
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript">
    function showAlert() {
        $("#alert").show();
    }
    function closeAlert() {
        $("#alert").hide();
    }
</script>
</body>
</html>