﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContractType18.aspx.cs" Inherits="TuanDai.WXApiWeb.Contract.ContractType18" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>私募宝借贷合同</title>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <link rel="stylesheet" href="css/style.css?v=2016061600001" />
    <script>
        (function (doc, win) {
            var docEl = doc.documentElement,
                    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                    recalc = function () {
                        var clientWidth = docEl.clientWidth;
                        if (!clientWidth) return;
                        docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);

        document.oncontextmenu = function (e) { return false; }

        var omitformtags = ["input", "textarea", "select"]
        omitformtags = omitformtags.join("|")
        function disableselect(e) {
            if (omitformtags.indexOf(e.target.tagName.toLowerCase()) == -1)
                return false
        }
        function reEnable() {
            return true
        }
        if (typeof document.onselectstart != "undefined")
            document.onselectstart = new Function("return false")
        else {
            document.onmousedown = disableselect
            document.onmouseup = reEnable
        }
    </script>
</head>
<body>
    <header class="headerMain" id="header">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">私募宝借贷合同</h1>
        </div>
    </header>

    <%if (ProjectsmEntity.ProfitTypeId == 1)
      {%>
    <!--第1页>-->
    <div class="Contract">
        <h3>私募宝借贷合同</h3>
        <div class="Number">合同编号：<%=Key %></div>

        <div class="Contract_t">
            <ul>
                <li>
                    <div>甲方（投资方）：<span><%=subBasicModel.RealName %></span></div>
                    <div>证件号码：<span><%=subBasicModel.IdentityCard %></span></div>
                </li>
                <li>
                    <div>乙方（借款方）：<span><%=publisherModel.RealName %></span></div>
                    <div>证件号码：<span><%=publisherModel.IdentityCard %></span></div>
                </li>
                <li>
                    <div>丙方（担保方）：<span><%=AssureModel.FullName %></span></div>
                </li>
            </ul>

        </div>
        <div class="Contract_c">
            <p>
                特别提示：<br />
                甲、乙、丙三方请认真仔细阅读本合同项下的全部条款。三方一旦签订本合同，即视为三方已充分理解并完全同意本合同项下的所有条款及内容。
                <br />
                由<%=companyName %>（以下称“团贷网”）为甲、乙方的借款相关事宜提供融资平台，双方自愿遵守本协议、团贷网平台用户服务协议以及团贷网通过网站平台公布的各项业务规则。
                <br />
                团贷网平台公布的相关业务规则、每一借款标的发标页面、投资界面所载相关条件及其他相关单据、凭证构成甲、乙、丙通过团贷网平台达成的具体单项的借款合同的全部条款，各方在平等自愿的基础上达成如下借款合同，以兹共同遵守执行。若因相关页面、宣传等与本协议内容出现冲突或解释不一致的，以本协议内容为准。
            </p>
            <p>
                一、借款条款<br />
                1、借款金额：乙方因资金周转需要，现向甲方借款￥<span><%=submodel.Amount.Value.ToString("N") %></span>元（大写人民币：<span><%=Tool.ChineseNum.GetUpperMoney(Convert.ToDouble(submodel.Amount)) %></span>）<br />
                2、借款期限：<span><%=proModel.Deadline??0 %></span>个月，自甲方在团贷网平台投资乙方发布的借款标，满标之日起开始计算。<br />
                3、借款利率：在合同规定的借款期内，年化利率为  <%=ProjectsmEntity.PreProfitRate_S %> %。<br />
                4、逾期利息：乙方如未按期、足额归还本息，则逾期部分的利息（以下简称“逾期利息”）按自逾期之日起的 0.03 %/日计算。<br />
                5、还款方式：<%=RepaymentTypeDesc %>。<br />
                6、提前还款：本次借款期间，乙方有权提前一次性结清本次债务。若乙方选择等额本息的还款方式，利息应按照实际借款期间足月计算(即不足一个月的按一个月计算)。 若乙方选择每月付息且到期本金的还款方式，在乙方提前结清本次借款时侯，应向甲方支付实际已产生的利息（即按照实际用款天数折比365个自然日计算）。
            </p>
            <p>
                二、质物收益的赠与<br />
                1、借款期内，乙方为对甲方的出借行为表示感谢，乙方将乙方所有且质押于丙方的私募基金份额（以下简称“质物”）的部分收益（该部分收益统称为“赠与收益”）赠与甲方。
            </p>
        </div>
    </div>
    <!--第2页>-->
    <div class="Contract">
        <div class="Contract_c">
            <p>
                2、甲方享有的质物份额产生的所有收益在扣除甲乙间就本借款合同实际发生的利息后仍有剩余的部分为乙方给予甲方的“赠与收益”。<br />
                3、甲方凭借本合同项下出借金额享有等额市值的质物份额所产生的“赠与收益”，质物的初始市值按本条第4款规定执行。<br />
                4、“赠与收益”的结算节点以乙方发起该特定借款标满标后的第一个交易日核算质物初始市值，待乙方实际还款前的一个交易日核算质物最终市值，综合上述市值数据结算涨幅或亏损。<br />
                5、甲方不对乙方所有的质物发生亏损承担责任。因乙方对甲方的收益赠与是基于乙方向甲方出借行为表示感谢的无偿赠与，所以乙方不对上述质物因产生亏损而无实际收益可赠与，导致最终借款偿还后甲方不能取得乙方的质物收益赠与承担任何责任，乙方也不对收益赠与的可分配与否或额度进行承诺；因质物实际收益亏损或不足以进行赠与分配的，不视为乙方违约。<br />
                6、甲方同意根据团贷网平台规则及与团贷网融资信息中介服务的相关约定，将享有的“赠与收益”的<%=ProjectsmEntity.InvestFeeRate.ToString("N")%> %作为团贷网平台的中介服务费。若因乙方的质物亏损或相应的收益不足扣除本合同所支付的利息，导致甲方未能享有到“赠与收益”的，则甲方无需向团贷网平台支付中介服务费。
            </p>
            <p>
                三、债的担保<br />
                1、乙方到期未及时归还甲方出借之本息，由丙方承担保证责任。乙方愿意以其购买的<%=ProjectsmEntity.ProductName %>私募基金（质押当日总市值不得低于：¥<%=proModel.Amount.Value.ToString("N")%>元），将其合法持有的该私募基金份额及日后收益权作为反担保财产质押给丙方。<br />
                2、乙方承诺若到期未按规定归还借款本息，丙方应代为偿付本金、利息及“赠与收益”（丙方垫付标准按本条第3款执行）。丙方承担保证责任后可处置或代位求偿上述反担保质押财产，所得的价款用于清偿本合同项下丙方垫付的本息及因本合同借款出现逾期而产生的其他费用。<br />
                3、乙方到期未及时归还甲方出借之本息，丙方应及时承担保证责任，垫付标准以甲方投资时其在团贷网平台的会员等级制度执行。若甲方投资时为普通会员，则出现前述情况下丙方仅向甲方垫付借款本金，利息及“赠与收益”（如有）由甲方自行向乙方追偿；若甲方出借时为超级会员，出现上述情况下丙方全额垫付本金、利息及“赠与收益”（如有）。<br />
                4、若丙方处置该质押财产所得价款不足以支付的，丙方有权向乙方继续进行追讨。
            </p>
        </div>
    </div>
    <!--第3页-->
    <div class="Contract">
        <div class="Contract_c">
            <p>
                5、甲、乙、丙三方协商一致，可以变更合同。如果甲乙双方未经丙方同意擅自变更合同的，则变更合同对丙方不发生效力，自合同变更之日起，丙方不再承担保证责任。
            </p>
            <p>
                四、追索费用<br />
                如果乙方到期未归还借款本金及利息从而引致甲方或丙方向乙方追索的，则甲方或丙方因行使追索权而产生的包括但不限于诉讼费用、仲裁费用、诉前/诉讼保全费/诉讼保全担保费/担保费、律师费用等在内的一切费用和开支，一概均由乙方负责承担。
            </p>
            <p>
                五、违约责任<br />
                本合同签定后，甲、乙、丙三方必须全面适当地履行本合同项下各自的义务及责任。任何一方对本合同项下任一条款之违反，即被视为违约，违约方须向对方承担相应之违约责任，赔偿对方因违约而遭致的一切经济损失。如果乙方违约，甲方或丙方有权向有关个人征信系统予以披露，有权通过社会公告等形式追究其违约责任。
            </p>
            <p>
                六、争议解决方式<br />
                因本合同发生的任何争议，由各方协商解决，协商不成的，任何一方可提交湛江仲裁委员会在东莞仲裁，并按其当时有效的仲裁规则适用简易程序进行仲裁。仲裁裁决是终局的，对各方均有约束力。
            </p>
            <p>
                七、生效及其他<br />
                本合同对各方均有约束力，本合同自甲、乙、丙三方在团贷网提供的融资平台点击确认后立即生效。
            </p>
        </div>
        <div class="Contract_b">
            <p>
                <br />
                <strong>各方签署：</strong>
            </p>
            <p>
                甲方：<span><%=subBasicModel.RealName %></span>
            </p>
            <p>
                乙方：<span><%=publisherModel.RealName %></span>
            </p>
            <p>
                丙方：<span><%=AssureModel.FullName %></span>
            </p>
            <p>
                协议签署日期：<em><%=submodel.AddDate.Value.Year %></em>年<em><%=submodel.AddDate.Value.Month %></em>月<em><%=submodel.AddDate.Value.Day %></em>日
            </p>
            <p>
                协议签订地：<span>广东省东莞市南城区</span>
            </p>
            <div class="Seal_zhuochen" style="background: url('<%=this.AssureModel.image %>') no-repeat scroll left center transparent"></div>

            </div>
        </div>
        <div class="clearfix mt20"></div>
        <%} %>

        <%if (ProjectsmEntity.ProfitTypeId == 2)
          {%>
        <!--第1页>-->
        <div class="Contract">
            <h3>私募宝借贷合同</h3>
            <div class="Number">合同编号：<%=Key %></div>

            <div class="Contract_t">
                <ul>
                    <li>
                        <div>甲方（投资方）：<span><%=subBasicModel.RealName %></span></div>
                        <div>证件号码：<span><%=subBasicModel.IdentityCard %></span></div>
                    </li>
                    <li>
                        <div>乙方（借款方）：<span><%=publisherModel.RealName %></span></div>
                        <div>证件号码：<span><%=publisherModel.IdentityCard %></span></div>
                    </li>
                    <li>
                        <div>丙方（担保方）：<span><%=AssureModel.FullName %></span></div>
                    </li>
                </ul>

            </div>
            <div class="Contract_c">
                <p>
                    特别提示：<br />
                    甲、乙、丙三方请认真仔细阅读本合同项下的全部条款。三方一旦签订本合同，即视为三方已充分理解并完全同意本合同项下的所有条款及内容。
                <br />
                    由<%=companyName %>（以下称“团贷网”）为甲、乙方的借款相关事宜提供融资平台，双方自愿遵守本协议、团贷网平台用户服务协议以及团贷网通过网站平台公布的各项业务规则。
                <br />
                    团贷网平台公布的相关业务规则、每一借款标的发标页面、投资界面所载相关条件及其他相关单据、凭证构成甲、乙、丙通过团贷网平台达成的具体单项的借款合同的全部条款，各方在平等自愿的基础上达成如下借款合同，以兹共同遵守执行。
                </p>
                <p>
                    一、借款条款<br />
                    1、借款金额：乙方因资金周转需要，现向甲方借款￥<span><%=submodel.Amount.Value.ToString("N") %></span>元（大写人民币：<span><%=Tool.ChineseNum.GetUpperMoney(Convert.ToDouble(submodel.Amount)) %></span>）<br />
                    2、借款期限：<span><%=proModel.Deadline %></span>个月，自甲方在团贷网平台投资乙方发布的借款标时即开始计算。
                    <br />
                    3、借款利率：在合同规定的借款期内，年化利率为<%=proModel.InterestRate %>%<br />
                    4、逾期利息：乙方如未按期、足额归还本息，则逾期部分的利息（以下简称“逾期利息”）按自逾期之日起每日万分之三计算。<br />
                    5、还款方式：<%=RepaymentTypeDesc %>。<br />
                    6、提前还款：本次借款期间，乙方有权提前一次性结清本次债务。若乙方选择等额本息的还款方式，利息应按照实际借款期间足月计算(即不足一个月的按一个月计算)。 若乙方选择每月付息且到期本金的还款方式，在乙方提前结清本次借款时侯，应向甲方支付实际已产生的利息（即按照实际用款天数折比365个自然日计算）。
                </p>
            </div>
        </div>
        <!--第2页>-->
        <div class="Contract">
            <div class="Contract_c">
                <p>
                    二、债的担保<br />
                    1、乙方到期未及时归还甲方出借之本息，由丙方承担保证责任。乙方愿意以其购买 <%=ProjectsmEntity.ProductName %> 私募基金（质押当日总市值不低于：¥<%=proModel.Amount.Value.ToString("N")%>元），将其合法持有的该私募基金份额及日后收益权作为反担保财产质押给丙方。<br />
                    2、乙方承诺若到期未按规定归还借款本息，丙方代为偿付本金及利息后可处置上述反担保质押财产，所得的价款清偿本合同项下丙方垫付的本息及因本合同借款出现逾期而产生的其他费用。<br />
                    3、乙方到期未及时归还甲方出借之本息，丙方应及时承担保证责任，垫付标准以甲方投资时其在团贷网平台的会员等级制度执行。若甲方投资时为普通会员，则出现前述情况下丙方仅向甲方垫付借款本金，利息由甲方自行向乙方追偿；若甲方出借时为超级会员，出现上述情况下丙方全额垫付本息。<br />
                    4、若丙方处置该质押财产所得价款不足以支付的，丙方有权向乙方继续进行追讨。<br />
                    5、甲、乙、丙三方协商一致，可以变更合同。如果甲乙双方未经丙方同意擅自变更合同的，则变更合同对丙方不发生效力，自合同变更之日起，丙方不再承担保证责任。
                </p>
                <p>
                    三、追索费用<br />
                    如果乙方到期未归还借款本金及利息从而引致甲方或丙方向乙方追索的，则甲方或丙方因行使追索权而产生的包括但不限于诉讼费用、仲裁费用、诉前/诉讼保全费/诉讼保全担保费/担保费、律师费用等在内的一切费用和开支，一概均由乙方负责承担。
                </p>
                <p>
                    四、违约责任<br />
                    本合同签定后，甲、乙、丙三方必须全面适当地履行本合同项下各自的义务及责任。任何一方对本合同项下任一条款之违反，即被视为违约，违约方须向对方承担相应之违约责任，赔偿对方因违约而遭致的一切经济损失。如果乙方违约，甲方或丙方有权向有关个人征信系统予以披露，有权通过社会公告等形式追究其违约责任。
                </p>
                <p>
                    五、争议解决方式<br />
                    因本合同发生的任何争议，由各方协商解决，协商不成的，任何一方可提交湛江仲裁委员会在东莞仲裁，并按其当时有效的仲裁规则适用简易程序进行仲裁。仲裁裁决是终局的，对各方均有约束力。
                </p>
            </div>
        </div>
        <!--第3页-->
        <div class="Contract">
            <div class="Contract_c">
                <p>
                    六、生效及其他<br />
                    本合同对各方均有约束力，本合同自甲、乙、丙三方在团贷网提供的融资平台点击确认后立即生效。
                </p>
            </div>
            <div class="Contract_b">
                <p>
                    <br />
                    <strong>各方签署：</strong>
                </p>
                <p>
                    甲方：<span><%=subBasicModel.RealName %></span>
                </p>
                <p>
                    乙方：<span><%=publisherModel.RealName %></span>
                </p>
                <p>
                    丙方：<span><%=AssureModel.FullName %></span>
                </p>
                <p>
                    协议签署日期：<em><%=submodel.AddDate.Value.Year %></em>年<em><%=submodel.AddDate.Value.Month %></em>月<em><%=submodel.AddDate.Value.Day %></em>日
                </p>
                <p>
                    协议签订地：<span>广东省东莞市南城区</span>
                </p>
                 <div class="Seal_zhuochen" style="background: url('<%=this.AssureModel.image %>') no-repeat scroll left center transparent"></div>
                <!--盖章-->
                <!--<div class="seal-con pos-a">
                <img src="images/hnstrz.png" alt=""/>
            </div>-->
            </div>
        </div>
        <div class="clearfix mt20"></div>
        <%} %>
        <script type="text/javascript">
            var url = window.location.href;
            if (url.indexOf("type=mobileapp") >= 0) {
                document.getElementById("header").style.display = "none";
            }
        </script>
</body>
</html>