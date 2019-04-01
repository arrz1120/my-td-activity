<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="ApplyStock.aspx.cs" Inherits="TuanDai.WXApiWeb.ApplyStock" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>股票配资</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/loan.css?v=20150529001" />
    <script type="text/javascript">
     var newTitle = "";
        var curObj={
             'aviAmount':<%=ToolStatus.ConvertLowertwo(AviMoney) %>,
             'para1':<%=amountSet.Param1 %>,
             'param1Value': <%=amountSet.Param1Value %>,
             'para2': <%=amountSet.Param2 %>,
             'param2Value': <%=amountSet.Param2Value %>,
             'para3': <%=amountSet.Param3 %>,
             'param3Value': <%=amountSet.Param3Value %>,
             'amount1': <%=Set.Param3Value %>,
             'amount2': <%=Set.Param4Value %>,
             'managerAmount':<%=amountSet.Param4Value %>
        };
    </script>
</head>
<body>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location='/pages/loan/BorrowMoney.aspx';">返回</div>
        <h1 class="title">股票配资</h1>
    </div>
    <div class="none"></div>
</header>
    <div class="pd15 c-212121 f14px">
        操盘资金预览</div>
    <section class="fundPreview">
  <div class="c-694514 f12px">总操盘资金（元）</div>
  <div class="c-fff f30px pt15 pb15">￥<span id="traderAmount" class="c-fff f30px pt15 pb15">0.00</span></div>
  <div class="warningMain clearfix">
    <div>
      <p class="c-212121 f12px lh20">亏损预警线（元）</p>
      <p class="c-fff f16px pt5 pb15">￥<span  id="warningAmount" class="c-fff f16px pt5 pb15">0.00</span></p>
    </div>
    <div>
      <p class="c-212121 f12px lh20">亏损平仓线（元）</p>
      <p class="c-fff f16px pt5 pb15">￥<span  id="coverAmount" class="c-fff f16px pt5 pb15">0.00</span></p>
    </div>
  </div>
</section>
    <div class="loanMain">
      <section class="bg-bdtopBom1-ccc pl15 mt15 clearfix">
    <div class="loanBox pr40">
     <div class="leftBox">保证金</div>
     <div class="rightBox">
        <div class="contBox">
          <input type="text" name="" class="ipt" id="txtAmount"  placeholder="<%=int.Parse(Set.Param3Value)/10000%>~<%=int.Parse(Set.Param4Value)/50000%>万且为1000的整数倍">
        </div>
     </div>
     <div class="unit">元</div>
   </div>

   <div class="loanBox pr15">
     <div class="leftBox">配置比例</div>
     <div class="rightBox">
        <div class="contBox overflowText">
           <select class="select"  id="txtTimes">
                <option value="2">2倍</option>
                <option value="3">3倍</option>
                <option value="4" selected>4倍</option>
            </select>
        </div>
     </div>
   </div>

   <div class="loanBox pr15">
     <div class="leftBox">借款期限</div>
      <div class="rightBox">
        <div class="contBox overflowText">
            <select class="select"  id="deadline">
                <option value="15" selected>15天</option>
                <option value="26">26天</option>
                <option value="30">30天</option>
                <option value="45">45天</option>
                <option value="60">60天</option>
                <option value="90">90天</option>
                <option value="180">180天</option>
            </select>
        </div>
      </div>
   </div>

   <div class="loanBox pr30">
     <div class="leftBox">年化利率</div>
     <div class="rightBox">
        <div class="contBox">
          <input type="text" name="" class="ipt" value="10" placeholder="10-24" id="txtRate" >
        </div>
     </div>
     <div class="unit">%</div>
   </div>
  </section>
    </div>
    <!--已登录 S-->
    <section class="loanBtnBox">
  <input type="button" class="btn btnYellow borderRadius0 h52" value="马上借款" id="beforeApply"/>
</section>
    <!--已登录 E-->
    <!--确认借款弹窗-->
    <section class="automaticwayBox pt15 clearfix" id="affirmLoanMain">
  <ul>
    <li class="pl15 pr15 pt5 pb5 clearfix">
      <div class="LoanNumList clearfix">
        <div class="LoanCont clearfix" style="border-right: 1px solid #ddd;">
          <span class="lf">保证金</span>
          <span class="rf"><span id="depositAmount" class="c-fd6040 f12px">0.00</span>元</span>
        </div>
        <div class="LoanCont clearfix">
          <span class="lf">单期利息</span>
          <span class="rf"><span  id="totalInterest"  class="c-fd6040  f12px">0.00</span>元</span>
        </div>
      </div>
      <div class="LoanNumList clearfix">
        <div class="LoanCont clearfix" style="border-right: 1px solid #ddd;">
          <span class="lf">帐户管理费</span>
          <span class="rf"><span  id="managerAmount"  class="c-fd6040  f12px">0.00</span>元</span>
        </div>
        <div class="LoanCont clearfix">
          <span class="lf">单期服务费</span>
          <span class="rf"><span  id="serviceAmount"  class="c-fd6040  f12px">0.00</span>元</span>
        </div>
      </div>
    </li>
    <li class="f12px c-fd6040 pt10 pb10">＊如借款超过30天，利息、服务费需要每30天预付一次。</li>
    <li class="pl15 pr15 pt5 pb5 clearfix">
      <div class="lf f14px c-212121 lh22 mt10" style="line-height:17px;">首次支付：</div>
      <div class="rf f14px c-212121 lh22" style="line-height:17px;"><span class="f18px c-fd6040" id="totalPayAmount" style="height:36px;line-height:35px;">0.00</span>元</div>
    </li>
    <li  class="pl15 pr15 border0 clearfix">
      <div class="loanBox">
     <div class="leftBox" style="width: 85px;">交易密码：</div>
     <div class="rightBox">
        <div class="contBox">
          <input type="password" class="f14px ipt" placeholder="请输入交易密码" id="txtPayPwd" style="border: 0;"/>
        </div>
     </div>
   </div>
    </li>
  </ul>
  <div class="border0"><input type="button" class="btn btnYellow borderRadius0 h52" value="确认借款" onclick="CheckData();"></div>
</section>
    <!--弹窗-->
 <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
        <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>  
    </span>
    <span style="float: right;max-width: 60%;padding-right: 10px;">
        <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/> 
    </span>
  </div>
</section>
<!--遮罩层-->
 <div class="maskLayer hide"></div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/Common.js"></script>
    <script type="text/javascript" src="/scripts/zqb_stock.js?v=2015060101"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>
