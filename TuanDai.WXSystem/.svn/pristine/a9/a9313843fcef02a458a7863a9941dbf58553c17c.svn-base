<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Explain.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.inviteGetgift.Explain" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>红包使用说明</title>
    <meta name="Copyright" content="东莞团贷网互联网科技服务有限公司" />
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财" />
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。" />
    <link rel="stylesheet" type="text/css" href="css/page.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/valid.js?v=20150917001"></script>
</head>
<body class="bg-ceeffe">
    <section class="explain-box">
        <div class="explain-cn main-cn clearfix">
            <img src="imgs/hb10.png" alt="fl" />
            <div class="explain-text fr">
                <p class="fz10"><span class="fz12">使用说明：</span>攒了一些投资红包和体验金，分享给你体验一下~~收益还挺高的！</p>
                <div class="use mt10 clearfix">
                    <a href="<%=this.IsValidRealName?"/pages/invest/invest_list.aspx":"javascript: RealNameValidShow();" %>" class="fz12 fr">马上使用</a>
                </div>
            </div>
        </div>

        <div class="explain-cn main-cn clearfix">
            <img src="imgs/hb388.png" alt="fl" />
            <div class="explain-text fr">
                <p class="fz10"><span class="fz12">使用说明：</span>此红包由5元，15元，20元，160元，188元5个红包组成，累计投资达到一定的金额即可领取相应红包。</p>
                <div class="use mt10 clearfix">
                    <a href="Invest.aspx" class="fz12 fr">马上使用</a>
                </div>
            </div>
        </div>

        <div class="explain-cn main-cn clearfix">
            <img src="imgs/hb2000.png" alt="fl" />
            <div class="explain-text fr">
                <p class="fz10"><span class="fz12">使用说明：</span>2000元体验金完成实名认证即可领取，投资体验标所得收益全部由投资人享受。</p>
            </div>
            <div class="use-dif mt10 clearfix">
                <div class="fl">
                    <p class="c-906a42 fz09">【体验金专享标】</p>
                    <p class="c-ff6600 fz09 mt10">借款金额200万   利率15%   期限 6天</p>
                </div>
                <a href="<%=this.IsValidRealName?"javascript:InvestExperienceGold();":"javascript: RealNameValidShow();" %>" class="fz12 fr mt15">马上使用</a>
            </div>
        </div>

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

        <!--认证成功-->
        <section class="popup-wrap" id="dv2" style="display: none">
            <div class="popup-box animated pos-a">
                <img src="imgs/ico1.png" alt="" />
                <p class="c-2aadf1 fz12">恭喜你，认证成功！</p>
                <a href="javascript:closewin('dv2');" class="pos-a close-but"></a>
                <div class="confirm">
                    <a href="closewin('dv2');" class="c-fd5f61">确定</a>
                </div>
            </div>
        </section>

        <!--您已领取2000元-->
        <section class="popup-wrap" id="dv3" style="display: none">
            <div class="popup-box animated pos-a">
                <img src="imgs/ico1.png" alt="" />
                <p class="c-2aadf1 fz11">您已领取2000元体验金<br />
                    马上投资吧！</p>
                <a href="javascript:closewin('dv3');" class="pos-a close-but"></a>
                <div class="confirm">
                    <a href="" class="c-fd5f61">确定</a>
                </div>
            </div>
        </section>
    </section>
    <script  type="text/javascript">
        var now = new Date(Date.parse("<%=DateTime.Now %>"));
    </script>
</body>
</html>
