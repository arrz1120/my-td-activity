<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReadyForStock.aspx.cs" Inherits="TuanDai.WXApiWeb.ReadyForStock" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>股票配资</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/loan.css" /><!--借款-->
</head>
<body>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location='/pages/loan/BorrowMoney.aspx';">返回</div>
        <h1 class="title">股票配资</h1>
    </div>
    <div class="none"></div>
</header>
<div class="imgBox"><img src="/imgs/images/stock_banner.png" alt=""/></div>
<section class="stockMarketMain">
    <div><h3 class="tit">股票配资</h3></div>
    <div class="f12px c-808080 pt5 mb20 lh20">在交纳一笔风险保证金后，团贷网授予保证金2-5倍的借款额度，并分配一个股票账户给您操盘。您的保证金和融资资金划入该操盘账户，由您操作该账户进行证券投资。</div>
    <div class="stockInfo"><i class="c-212121">门槛低：</i>最低1万元保证金，即可申请配资</div>
    <div class="stockInfo"><i class="c-212121">放款快：</i>早满标，早入市，早赚钱</div>
    <div class="stockInfo"><i class="c-212121">高收益：</i>2-5倍配资杠杆，收益最大翻6倍</div>
    <div class="mt20"><h3 class="tit">配资对象</h3></div>
    <div class="f12px c-808080 pt5 mb5 lh20">操盘经验丰富，风险控制能力好的资深股民。</div>
    <div class="text-right"><a href="questions.html" class="c-ff7357 f12px">了解详情 >></a></div>
    
    <!--已登录 S-->
    <%if (this.UserId != Guid.Empty)
      { %>
    <section class="loanBtnBox">
      <input type="button" class="btn btnYellow borderRadius0 h52" value="马上借款" onclick="show()">
    </section>
    <!--已登录 E-->
    <%}
      else
      { %>
    <!--未登录 S-->
    <div class="completeBox loginMain clearfix">
      <span class="btnBox"><a href="/user/Login.aspx" class="btn btnRed h52">登录</a></span>
      <span class="btnBox"><a href="/user/Register.aspx" class="btn btnYellow h52">注册</a></span>
    </div>
    <!--未登录 E-->
    <%} %>
</section>

<!--资料未完善弹窗-->
<section class="automaticwayBox pt15 clearfix" id="informationMain">
  <div class="hbody clearfix">
    <i class="ico-exclamation40 lf mr10"></i>
    <span>申请配资前，请先完成<%=msg%>！</span>
  </div>
  <div class="completeBox clearfix">
    <span class="btnBox"><input type="button" class="btn btnGreen h52" value="取消" onclick="Done()"></span>
    <span class="btnBox"><a href="/Member/safety/safety.aspx" class="btn btnYellow h52">填写</a></span>
  </div>
</section>
<div class="maskLayer hide"></div><!--遮罩层-->
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
<script type="text/javascript">
    function show() {
        if ("<%=this.completeValid %>" != "True") {
            $(".maskLayer").fadeIn();
            $("#informationMain").animate({
                bottom: "0"
            }, 200)
        } else {
            window.location = "/Member/stock/ApplyStock.aspx";
        }
    };
    function Done() {
        $(".maskLayer").fadeOut();
        $("#informationMain").animate({
            bottom: "-430px"
        }, 200)
    }
</script>
</body>
</html>