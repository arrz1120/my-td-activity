<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Invest.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.inviteGetgift.Invest" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>领取条件</title>
    <meta name="Copyright" content="东莞团贷网互联网科技服务有限公司"/>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/page.css">
</head>
<body class="bg-ceeffe">
    <section class="condition-box">
        <h3 class="fz20">388元红包领取条件</h3>
        <div class="main-cn condition-cn position-relative">
            <div class="triangle pos-a">
                <img src="imgs/ico2.png" alt=""/>
            </div>
            <div class="condition-title clearfix">
                <span class="fl t1 fz12">红包金额</span>
                <span class="fl t2 fz12">累计投资金额满</span>
            </div>
            <div class="condition-d">
                <div class="hb-pic">
                    <img src="imgs/sm-5.png" alt=""/>
                </div>
                <div class="m-text">1000元</div>
                <div class="invest-but"><a href="<%=this.IsValidRealName?"/pages/invest/invest_list.aspx":"javascript: RealNameValidShow();" %>">马上投资</a></div>
            </div>

            <div class="condition-d">
                <div class="hb-pic">
                    <img src="imgs/sm-15.png" alt=""/>
                </div>
                <div class="m-text">8000元</div>
                <div class="invest-but"><a href="<%=this.IsValidRealName?"/pages/invest/invest_list.aspx":"javascript: RealNameValidShow();" %>">马上投资</a></div>
            </div>

            <div class="condition-d">
                <div class="hb-pic">
                    <img src="imgs/sm-20.png" alt=""/>
                </div>
                <div class="m-text">20000元</div>
                <div class="invest-but"><a href="<%=this.IsValidRealName?"/pages/invest/invest_list.aspx":"javascript: RealNameValidShow();" %>">马上投资</a></div>
            </div>

            <div class="condition-d">
                <div class="hb-pic">
                    <img src="imgs/sm-160.png" alt=""/>
                </div>
                <div class="m-text">50000元</div>
                <div class="invest-but"><a href="<%=this.IsValidRealName?"/pages/invest/invest_list.aspx":"javascript: RealNameValidShow();" %>">马上投资</a></div>
            </div>

            <div class="condition-d">
                <div class="hb-pic">
                    <img src="imgs/sm-188.png" alt=""/>
                </div>
                <div class="m-text">100000元</div>
                <div class="invest-but"><a href="<%=this.IsValidRealName?"/pages/invest/invest_list.aspx":"javascript: RealNameValidShow();" %>">马上投资</a></div>
            </div>
        </div>
    </section>

    <!--实名认证-->
    <section class="popup-wrap" id="dv1" style="display: none;">
            <div class="popup-box animated pos-a">
                <h3 class="textL fz11 mt10">温馨提示：</h3>
                <p class="c-2aadf1 fz10 textL mt5">为保障您的权益，请先完成实名认证。</p>
                <a href="javascript:closewin('dv1');" class="pos-a close-but"></a>
                <div class="inp-box mt15">
                    <label class="fz10">真实姓名:</label>
                    <input type="text" class="fz10" placeholder="请输入您的真实姓名" id="txtRealName" />
                    <span style="color: red;" id="realnameErr"></span>
                </div>
                <div class="inp-box mt10">
                    <label class="fz10">身份证号:</label>
                    <input type="text" class="fz10" placeholder="请输入您的身份证号" id="txtIdCard" />
                    <span  style="color: red;" id="idcardErr"></span>
                </div>
                <div class="confirm">
                    <a href="javascript:RealNameValid();" class="c-fd5f61">确定</a>
                </div>
            </div>
        </section>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/valid.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150918"></script>
    <script type="text/javascript">
        var now = new Date(Date.parse("<%=DateTime.Now %>"));
    </script>
</body>
</html>
