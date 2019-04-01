<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="simubao_question.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.simubao_question" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>常见问题</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <style type="text/css">
        /*私募宝常见问题*/
        .c-ff0000{color: #FF0000 !important;}
        .c-282828{color: #282828 !important;}
        .c-333{color: #333 !important;}
        .about-simubao .item{border-bottom: 1px solid #d9d9d9;}
        .about-simubao .item p{color: #545454;line-height: 180%;}
    </style>
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">常见问题</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
<div class="about-simubao">
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">1.什么是私募宝?</h3>
        <p class="f13px pb5">私募宝是团贷网新推出的一款以私募基金为投资标的的新型投资产品，分为A、B类两种类型。</p>
        <p class="f13px pb5"><span class="c-ff0000 f14px">A类私募宝</span>是指借款人将其持有的阳光私募基金通过在团贷网质押以向投资者融资借款，借款期间，投资者可享有基金收益权对应的高额浮动收益。该款产品收益与私募基金净值涨跌挂钩，上不封顶，保底收益年化10%。如到期基金实际收益低于年化10%，平台合作担保方将以年化10%的利率回购债权。</p>
        <p class="f13px pb10"><span class="c-ff0000 f14px">B类私募宝</span>是指借款人将其持有的阳光私募基金通过团贷网质押以向投资者融资借款，借款期间私募基金净值涨跌与投资者无关，投资者仅享有与借款人提前约定的收益，到期则按约定利率收回投资本息。投资期间，团贷网合作担保机构承担连带还款责任。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">2、为什么投资私募？</h3>
        <p class="f13px pb5"><span class="c-333 fB f14px">收益高</span>--长期业绩表现优秀，完胜大盘、公募基金及其他股票型投资产品。</p>
        <p class="f13px pb5"><span class="c-333 fB f14px">无惧牛熊</span>--选股和持仓灵活，投资策略多，能灵活应对牛、熊、震荡市。</p>
        <p class="f13px pb5"><span class="c-333 fB f14px">信息透明</span>--阳光私募会定期公开净值，最新净值、过往收益都有数据可查。</p>
        <p class="f13px pb10"><span class="c-333 fB f14px">精英打理</span>--阳光私募汇集公募、券商、保险、民间高手等各路投资精英</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">3、私募宝如何保障投资者收益？</h3>
        <p class="f13px pb5">a、私募宝只选择业绩稳定的老牌顶级阳光私募和有明确盈利空间的私募产品；</p>
        <p class="f13px pb5">b、与基金公司共同完成质押登记，并获得借款人基金收益账户的控制权，确保还款有保障；</p>
        <p class="f13px pb5">c、每期私募产品将定期公布基金净值，多方审核监管，信息公开透明。</p>
    </div>
    <div class="item  ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">4、 投资私募宝安全吗？</h3>
        <p class="f13px pb10">私募宝与团贷网项目标和微团贷一样有担保公司担保，借款人将持有的私募基金质押给团贷网合同担保机构， 借款人如到期没有及时还款，担保机构将根据投资人投资时的会员等级代为偿付本金、利息即浮动收益。A类私募宝，超级会员保本金+10%收益+浮动收益，普通会员保本金（收益部分担保公司追讨成功后再支付）。B类私募宝，超级会员保本息，普通会员保本金。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">5、投资私募宝是否有资产标借款额度？</h3>
        <p class="f13px pb10">投资私募宝后，投资人可获得投资本金80%的资产标借款额度，当投资者需资金周转时，则可在团贷网发布资产标进行融资借款，以保障投资人资产的流通性。投资A类私募宝在满标或者投标结束后可获得资产标借款额度，B类私募宝投资成功即可获得资产标借款额度。</p>
    </div>

    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">6、私募宝怎么计算收益和回款？</h3>
        <p class="f13px pb5">A类私募宝：以满标后第一个工作日的基金净值开始计算收益，按回款日前一个工作日的基金净值计算最终收益，到期一次性收回本金和收益。收益计算公式为：（投资金额/满标后一个工作日的净值）×回款日前一个工作日的净值-投资本金，该收益为扣除服务费前的金额。</p>
        <P class="f13px pb5">B类私募宝：投标后第二天开始计息，到期按投标时约定的利率一次性还本付息。</P>
        <P class="f13px pb10">例如：张三投资私募宝10万元，可获得8万元的借款额度。</P>
    </div>

    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">7、服务费怎么收取？</h3>
        <p class="f13px pb5">A类私募宝：收取超过10%收益部分的40%（例如最终收益35%，收取25%收益部分的40%）；</p>
        <p class="f13px pb10">B类私募宝：收取收益部分的10%。</p>
    </div>

    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">8、基金净值多久公布一次？</h3>
        <p class="f13px pb10">不同的私募基金净值公布周期不一致，以具体项目为准。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">9、为什么借款人会把高收益的私募基金拿来质押 ？</h3>
        <p class="f13px pb10">私募基金都有封闭期，封闭期内不能赎回基金，当借款人需要资金周转时就可以在团贷网将持有的私募基金质押借款。通常借款人也只会把自己持有的私募基金中的一部分拿来抵押。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">10、基金净值多久公布一次？</h3>
        <p class="f13px pb10">不同的私募基金净值公布周期不一致，以具体项目为准。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">11、什么是阳光私募？</h3>
        <p class="f13px pb10">阳光私募基金通常是指由投资顾问公司作为发起人、投资者作为委托人、信托公司作为受托人、银行作为资金托管人、证券公司作为证券托管人，依据《信托法》发行设立的证券投资类信托集合投资产品。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">12、为什么阳光私募收益这么高？</h3>
        <p class="f13px pb10">私募基金经理收益主要来自业绩提成；为投资者创造的收益越多，私募基金经理获得的相应业绩提成也就越可观。这也从根本上保证了基金管理人的利益和投资者利益的一致性，从共赢的角度出发，私募基金经理将不遗余力，最大程度地保证投资者的利益。</p>
    </div>

    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">13、私募宝里面的剩余时间是指？</h3>
        <p class="f13px pb10"> 如到期未满标，以实际所筹金额结束融资，不会流标。</p>
    </div>
    <div class="item ml15 pr10 pt10">
        <h3 class="c-282828 f15px mb10">14、私募宝A的计息净值和结算净值分别指？</h3>
        <p class="f13px pb5">计息净值：基金净值可以理解为基金的单价；满标后一个工作日的基金净值，即是本期私募宝的计息净值。</p>
        <p class="f13px pb10">结算净值：本期私募宝到期前一个工作日的基金净值，即是结算净值；（您的投资额/计息净值）x 结算净值，即是您本期私募宝的最终市值，扣除服务费后即是您的最终回款金额。</p>
    </div>

</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/base.js"></script>
</body>
</html>
