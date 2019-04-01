﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.App.safeguard.index" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>五心保障体系</title>
    <link rel="stylesheet" type="text/css" href="css/main.css?v=<%=GlobalUtils.Version %>">
</head>
<body>
    <%= this.GetNavStr()%>
    <header>
        <img src="/pages/App/safeguard/imgs/banner.png?v=20180207">
    </header>
    
    <section class="wrap">
        <div class="con pos-r bb-e6e6e6" id="show1">
            <img src="/pages/App/safeguard/imgs/ico1.png">
            <div class="con-des">
                <p>省心－资金存管</p>
                <p>平台资金银行存管</p>
            </div>
            <i class="arrows pos-a"></i>
        </div>

        <div class="con pos-r bb-e6e6e6" id="show2">
            <img src="/pages/App/safeguard/imgs/ico4.png">
            <div class="con-des">
                <p>安心－大数据系统</p>
                <p>大数据天秤系统、云镜系统</p>
            </div>
            <i class="arrows pos-a"></i>
        </div>


        <div class="con pos-r bb-e6e6e6" id="show3">
            <img src="/pages/App/safeguard/imgs/ico3.png">
            <div class="con-des">
                <p>用心－严格风控流程</p>
                <p>专业风控团队，用专业铸造信赖</p>
            </div>
            <i class="arrows pos-a"></i>
        </div>

        <div class="con pos-r bb-e6e6e6" id="show4">
            <img src="/pages/App/safeguard/imgs/ico2.png">
            <div class="con-des">
                <p>放心－公安部信息安全认证</p>
                <p>强有力的信息安全保障认证</p>
            </div>
            <i class="arrows pos-a"></i>
        </div>

        <div class="con pos-r" id="show5">
            <img src="/pages/App/safeguard/imgs/ico5.png">
            <div class="con-des">
                <p>贴心－法律护航</p>
                <p>专业法律支撑，平台合规经营</p>
            </div>
            <i class="arrows pos-a"></i>
        </div>

    </section>
   <!--  <footer>
        <p><i class="umbrella"></i>安全保障服务由第三方担保公司提供</p>
    </footer> -->

    <!--链接对应的滑层弹窗内容-->

    <!--第三方担保专款垫付-->
    <section class="alert alert-roll hide" id="alert1">
        <h3 class="title">资金存管<span>省心</span></h3>
        <div class="alert-con item_ani ani_delay01">
            <i class="bh bh1"></i>
            <h3>- 平台资金银行存管 -</h3>
            <p>团贷网携手厦门银行，成功上线银行存管系统，银行对用户资金进行独立管理与监督，平台无法触碰，实现平台资金与用户资金隔离。</p>
        </div>
    </section>
    <section class="pos-f alert-roll-b hide" id="alertRoll1">
        <div class="opa_cover"></div>
        <div class="alert-close" id="close1"></div>
    </section>


    <!--严格风控流程-->
    <section class="alert alert-roll hide" id="alert2">
        <h3 class="title">大数据系统<span>安心</span></h3>
        <div class="alert-con item_ani ani_delay01">
            <i class="bh bh1"></i>
            <h3>- 天秤系统 -</h3>
            <p>天秤是由一系列系统平台组成的互联网金融大数据智能风控系统。该系统涵盖了反欺诈、综合评估、贷后监控等功能，既可提供单个数据产品服务，又可提供整套的风控解决方案，以满足小额信贷、消费金融、P2P、垂直金融等平台在风险控制方面的需求。<a href="https://hd.tuandai.com/weixin/20170315tiancheng/index.aspx">查看“天秤系统”>></a></p>
        </div>
        <div class="alert-con item_ani ani_delay02">
            <i class="bh bh2"></i>
            <h3>- 云镜系统 -</h3>
            <p>云镜系统是一款专注于电商借款的大数据风控系统，通过切入电商供应链交易环节，接入电商平台的信息流、现金流、物流数据进行交叉验证。系统通过对信用数据和非信用数据模型的分析，结合电商行业数据分析模型，实现还原借贷人真实模型，从而完成智能风控评审。系统全实时动态追踪，将风险止于初期。<a href="https://hd.tuandai.com/weixin/20170320yunjing/index.aspx">查看“云镜系统”>></a></p>
        </div>
    </section>

    <section class="pos-f alert-roll-b hide" id="alertRoll2">
        <div class="opa_cover"></div>
        <div class="alert-close" id="close2"></div>
    </section>

    <!--资金安全  -->
    <section class="alert alert-roll hide" id="alert3">
        <h3 class="title">严格风控流程<span>用心</span></h3>
        <div class="alert-con item_ani ani_delay01">
            <i class="bh bh1"></i>
            <h3>- 合作资产端的七步审核工序 -</h3>
            <p>在借款人提交申请之后，合作资产端将对借款人进行七步初审工序，资料收集、信息核实、现场勘查、小组初议、小组再议、提上审贷会、落实执行严格，再对借款项目进行全面、专业的实地尽职调查，保证每笔借款优质可靠。</p>
        </div>
        <div class="alert-con item_ani ani_delay02">
            <i class="bh bh2"></i>
            <h3>- 专业风控团队，用专业铸造信赖 -</h3>
            <p>团贷网依托互联网技术，应用人工智能与大数据，通过搭建可视化风控模型“天秤系统”、“云镜系统”，配置专业风控团队层层把关和多层业务架构严格审核，多方位保障用户的投资安全。</p>
        </div>
        <div class="alert-con item_ani ani_delay03">
            <i class="bh bh3"></i>
            <h3>- 抵押担保物 还款有保障 -</h3>
            <p>团贷网所有项目借款由第三方担保机构提供担保，更有部分项目借款人提供足额抵押物进行担保，抵押额度一般为其评估价值的70%，以降低抵押物价值波动的风险。</p>
        </div>
    </section>

    <section class="pos-f alert-roll-b hide" id="alertRoll3">
        <div class="opa_cover"></div>
        <div class="alert-close" id="close3"></div>
    </section>

    <!--法律护航-->

    <section class="alert alert-roll hide" id="alert4">
        <h3 class="title">国家公安部信息安全三级认证<span>放心</span></h3>
        <div class="alert-con item_ani ani_delay01">
            <i class="bh bh1"></i>
            <h3>- 信息安全等级第三级认证 -</h3>
            <p>团贷网已成功通过中华人民共和国公安部信息安全等级第三级认证，为用户资金信息及个人信息提供强有力的安全保障。</p>
        </div>
        <div class="alert-con item_ani ani_delay02">
            <i class="bh bh2"></i>
            <h3>- 可信网站认证&企业信用认证 -</h3>
            <p>团贷网获得了由商务部和国资委认可的中国电子商务协会颁发的《企业信用评价等级证书》（信用级别为3A）和由iTrust互联网信用评价中心颁发的《企业信用评价证书》。</p>
        </div>
        <div class="alert-con item_ani ani_delay03">
            <i class="bh bh3"></i>
            <h3>- 百人技术团队保驾护航 -</h3>
            <p>团贷网建立了专业的百人技术团队，从技术层面、内部建设和隐私管理等方面，为广大用户提供24小时在线技术支撑服务。</p>
        </div>
    </section>

    <section class="pos-f alert-roll-b hide" id="alertRoll4">
        <div class="opa_cover"></div>
        <div class="alert-close" id="close4"></div>
    </section>


    <!--银行级网站技术-->
    <section class="alert alert-roll hide" id="alert5">
        <h3 class="title">法律护航<span>贴心</span></h3>
        <div class="alert-con item_ani ani_delay01">
            <i class="bh bh1"></i>
            <h3>- 专业法律支持 -</h3>
            <p>团贷网聘用了法仕律师事务所作为公司的常年法律顾问。团贷网所有业务活动以及相关合同和协议均咨询法仕事务所，确保其符合相关法律法规，团贷网合法守信经营，让团贷网的用户权益受国家法律保护。</p>
        </div>
        <div class="alert-con item_ani ani_delay02">
            <i class="bh bh2"></i>
            <h3>- 平台合规经营 -</h3>
            <p>根据《合同法》第23章关于“居间合同”的规定，特别是第424条规定的“居间合同是居间人向委托人报告订立合同的机会或者提供订立合同的媒介服务，委托人支付报酬的合同”，团贷网平台作为合法设立的中介服务机构，为民间借贷提供撮合，使借贷双方形成借贷关系并收取相关报酬的居间服务有着明确的法律基础。</p>
        </div>
    </section>

    <section class="pos-f alert-roll-b hide" id="alertRoll5">
        <div class="opa_cover"></div>
        <div class="alert-close" id="close5"></div>
    </section>

</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript">

    var scrollT = "";
    function moveToTop(open, target) {
        $(open).click(function () {
            scrollT = $(window).scrollTop();
            $(target).removeClass('hide').removeClass('moveToBottom').addClass('moveToTop');
            $('.alert').stop().animate({ scrollTop: 0 }, 10);
            setTimeout(function () {
            }, 400);
        });
    }

    function moveToBottom(close, target) {
        $(close).click(function () {
            $(window).scrollTop(scrollT);
            $(target).removeClass('moveToTop').addClass('moveToBottom');
            setTimeout(function () {
                $(target).addClass('hide');
            }, 400);
        })
    }
    moveToTop("#show1", '#alert1,#alertRoll1');
    moveToBottom('#close1', '#alert1,#alertRoll1');
    moveToTop("#show2", '#alert2,#alertRoll2');
    moveToBottom('#close2', '#alert2,#alertRoll2');
    moveToTop("#show3", '#alert3,#alertRoll3');
    moveToBottom('#close3', '#alert3,#alertRoll3');
    moveToTop("#show4", '#alert4,#alertRoll4');
    moveToBottom('#close4', '#alert4,#alertRoll4');
    moveToTop("#show5", '#alert5,#alertRoll5');
    moveToBottom('#close5', '#alert5,#alertRoll5');

</script>
</html>
