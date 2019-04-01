<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WE_detail_bak.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.WE.WE_detail_bak" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>项目详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/weplan.css" />
    <script type="text/javascript">
        var projectId = "<%=projectId %>";
    </script>
</head>
<body>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/pages/invest/we/WE_list.aspx'">返回</div>
        <h1 class="title">We计划详情</h1>
    </div>
    <div class="none"></div>
</header>

<section class="investMain"> 
  <div id="wrapperdetail">
    <div id="scroller">
        <div id="pullDown">
            <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
        </div> 

   <div class="investBox clearfix">
        <div class="investLeft c-212121 f14px">可用资金：</div>
        <div class="investRight">
            <span class="f14px c-ababab" id="spAviMoney">0.00元</span> 
            <span><%=ReChangeStr%></span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft">
            <p class="c-212121 f14px">认购份数：</p>
            <p class="f12px c-ababab"><%= Convert.ToDouble(model.UnitAmount ?? 0)%>元/份</p>
        </div>
        <div class="investRight">
            <div class="formBox">
                <input type="button" class="Btn btn-left disabled subtract" />
                <input type="text" class="middle num-buy" name="invest_share"  id="invest_share" value="1 份" maxshare="">
                <input type="button" class="Btn btn-right plusNum" />
            </div>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-212121 f14px">预期收益：</div>
        <div class="investRight">
            <span class="f14px c-fd6040" id="spExpectedMoney">0.00<i class="f14px c-ababab">元</i></span>
        </div>
    </div> 
    <div class="investBox border0 clearfix">
        <div class="investLeft c-212121 f14px">实际支付：</div>
        <div class="investRight">
            <span class="f18px c-fd6040" id="spJoinAmount">0.00<i class="f14px c-ababab">元</i></span>
        </div>
    </div>
    <a href="javascript:void();" class="investBtn">马上投资</a>

    <div class="investBox pt15 pb15 c-212121 f14px clearfix"><%=TuanDai.WXApiWeb.Index.GetWePlanTitle(model.ProductName, 1)%> <i class="c-ababab">(<%=TuanDai.WXApiWeb.Index.GetWePlanTitle(model.ProductName, 2)%>) </i></div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">计划总额：</div>
        <div class="investRight">
             <span class="f18px c-fd6040"><%=ToolStatus.ConvertDetailWanMoney(model.PlanAmount)%><i class="f14px c-ababab">元</i></span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">年化收益：</div>
        <div class="investRight">
             <span class="f14px c-212121"><%=ToolStatus.DeleteZero(model.YearRate)%>%</span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">投资期限：</div>
        <div class="investRight">
             <span class="f16px c-212121"><%= model.Deadline%>个月</span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">计划单位：</div>
        <div class="investRight">
             <span class="f14px c-212121"><%= Convert.ToDouble(model.UnitAmount ?? 0)%>元</span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">还款方式：</div>
        <div class="investRight" style="float:none;">
             <span class="f12px c-212121">到期还本付息(适用于A和B)或每月付息到期还本(适用于C)</span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">加入份数：</div>
        <div class="investRight">
             <span class="f14px c-212121"><%=model.OrderQty??0 %>份</span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">剩余份数：</div>
        <div class="investRight">
             <span class="f14px c-212121"><%=(model.TotalQty ?? 0) - (model.OrderQty??0)%>份</span>
        </div>
    </div>
    <div class="investBox clearfix">
        <div class="investLeft c-ababab f14px">截止时间：</div>
        <div class="investRight">
             <span class="f14px c-212121"><%=(model.EndDate.HasValue? model.EndDate.Value.ToString("yyyy-MM-dd"):"暂无") %></span>
        </div>
    </div>
     </div>
</div> 
</section>
<!--弹窗-->
 <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
           <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/>
    </span>
    <span style="float: right;max-width: 60%;padding-right: 10px;">
         <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>
    </span>
  </div>
</section>
<!--遮罩层-->
 <div class="maskLayer hide"></div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script> 
<script type="text/javascript" src="/scripts/Common.js"></script>  
<script type="text/javascript" src="/scripts/WePlanDetail.js?v=20150525"></script> 
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/scrollDetail.js"></script>
<script type="text/javascript">
    $(function () {
        iScroll.onLoadData = refreshPage;
    });    
</script>
</body>
</html>