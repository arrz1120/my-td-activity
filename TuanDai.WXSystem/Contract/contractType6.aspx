﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contractType6.aspx.cs" Inherits="TuanDai.WXApiWeb.Contract.contractType6" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>借款合同</title>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <link rel="stylesheet" href="css/style.css?v=2016061600001"/>
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
        <h1 class="title">借款合同</h1>
    </div>
</header>

    <!--第1页>-->
    <div class="Contract">
        <h3>
            借款合同</h3>
        <div class="Number">合同编号：<%=Key %></div>

        <div class="Contract_t">
            <ul>
                <li>
                    <div>甲方（投资方）：<span><%=subBasicModel.RealName %></span></div>
                    <div>证件号码：<span><%=subBasicModel.IdentityCard %></span></div>
                </li>
                <li>
                    <div>乙方（借款方）：<span><%=publisherModel.RealName %></span></div>
                    <div><%=publisherModel.UserTypeId==1?"证件号码":"工商注册号"%>：<span><%=publisherModel.IdentityCard %></span></div>
                </li>
                <li>
                    <div>丙方（担保方）：<span><%=AssureModel.FullName %></span></div>
                </li>
            </ul>

        </div>

        <div class="Contract_c">
            <p>
                特别提示：<br />
                &ensp;&ensp;&ensp;&ensp; 甲、乙、丙三方请认真仔细阅读本合同项下的全部条款。三方一旦签订本合同，即视为三方已充分理解并完全同意本合同项下的所有条款及内容。<br />
                &ensp;&ensp;&ensp;&ensp;由<%=companyName %>（以下称“团贷网”）为甲、乙、丙三方的借款相关事宜提供融资平台，各方在平等自愿的基础上达成如下借款合同，以兹共同遵守执行。
            </p>
            <p>
                <br /><b>一、借款条款</b>
                <br />
                &ensp;&ensp;&ensp;&ensp;1、借款金额：乙方因资金周转需要，现向甲方借款￥<span><%=submodel.Amount.Value.ToString("N") %></span>元（大写：人民币<span><%=Tool.ChineseNum.GetUpperMoney(Convert.ToDouble(submodel.Amount)) %></span>）
                <br />
                &ensp;&ensp;&ensp;&ensp;2、借款期限：<span><%=proModel.Deadline %></span><%=proModel.DeadType==1?"个月":"天" %>，自甲方出借之日（甲方在团贷网平台投资乙方发布的借款标之日）起计算。 
                。
                <br />
                &ensp;&ensp;&ensp;&ensp;3、借款利率：在合同规定的借款期内，年化利率为<span><%=proModel.InterestRate %>%</span>。
                <br />
                &ensp;&ensp;&ensp;&ensp;4、逾期利息：乙方如未按期、足额归还本息，则逾期部分的利息（以下简称“逾期利息”）按自逾期之日起的<span><%= (proModel.InterestRate.Value / 365 + 0.3m).ToString("F2")%></span>%/日计算。
                <br />
                &ensp;&ensp;&ensp;&ensp;5、还款方式：<span><%=RepaymentTypeDesc %></span>。
                <br />
                &ensp;&ensp;&ensp;&ensp;6、提前还款：提前还款：借款期限为1个月以内（含1个月）的借款，自借款项目发布时起，持有14天以上，乙方可申请提前结清借款；借款期限为1个月以上的借款，乙方可于借款期间内随时申请提前结清借款。乙方在借款期限届满前一个月及以上提前还款的，除应向甲方支付已产生的相应利息（按天计算）、剩 余本金外，还应向甲方额外支付一个月的利息作为提前还款的补偿；若乙方在借款期限届满前一个月内提前还款的，则仍需按照本合同约定向甲方支付所有借款本金及利息。</p>
            <p><b>二、债的担保</b>
                <br />
                &ensp;&ensp;&ensp;&ensp;1、乙方到期未及时归还甲方借款本息的，由丙方承担保证责任，担保范围根据甲方投资时在团贷网平台的会员等级而定（按本合同第三条执行）。<br />
                &ensp;&ensp;&ensp;&ensp;2、乙方向丙方提供以下单种或多种反担保质押方式：<br />
                &ensp;&ensp;&ensp;&ensp;（1）乙方愿意以其持有的有价证券（包括但不限于股份制公司股权、银行票据、商业承兑汇票等）作为反担保物质押给丙方。
                
        </div>
    </div>
    <!--第2页>-->
    <div class="Contract">
        <div class="Contract_c">
            <p>
                &ensp;&ensp;&ensp;&ensp;（2）乙方在团贷网平台上已出借且待收回的本息款项（以下简称“待收款项”），乙方愿意以该待收款项作为反担保质押给丙方。同时授权团贷网平台在其待收款项回款后将回款资金中的￥<%=PrincipalInterest.ToString("N") %>元（大写:人民币<%=Tool.ChineseNum.GetUpperMoney(Convert.ToDouble(PrincipalInterest)) %>）划转至甲方在团贷网平台开立的账户（以下简称“甲方平台账户”）。若待收款项回款日期早于本借款合同约定的借款期限，乙方同意团贷网平台对该回款资金进行冻结，乙方在本合同借款期限届满前不得提现，并于借款期限届满之日起将￥<%=PrincipalInterest.ToString("N") %>元（大写：人民币<%=Tool.ChineseNum.GetUpperMoney(Convert.ToDouble(PrincipalInterest)) %>）自动划转至甲方平台账户。若乙方因本合同借款出现逾期而产生逾期利息或违约金的，逾期利息与违约金一并从待收款项中扣除。<br />
                &ensp;&ensp;&ensp;&ensp;3、乙方承诺若到期未按规定归还借款本金及利息，丙方代为偿付后可处置上述反担保质押物，所得的价款清偿本合同项下丙方垫付的本金、利息及因本合同借款出现逾期而产生的逾期利息、违约金及平台逾期催收管理费等。若丙方处置上述反担保质押物所得价款不足以支付的，丙方有权向乙方继续进行追讨。<br />
               <br />
               <b>三、逾期</b><br />
               &ensp;&ensp;&ensp;&ensp;1、本金逾期未超过30天情形（含第30天）<br />
               &ensp;&ensp;&ensp;&ensp;自逾期之日起，乙方应向投资时为特权会员的甲方按日缴纳剩余未还款项（包括乙方应还未还的本息）0.2%的违约金；乙方应向按照团贷网平台标规则，每日缴纳其对特权会员甲方的剩余未还款项的0.1%和其对普通会员甲方的剩余未还款项的0.3%，作为平台逾期催收管理费。<br />
               &ensp;&ensp;&ensp;&ensp;2、本金逾期超过30天情形<br />
               &ensp;&ensp;&ensp;&ensp;（1）丙方根据甲方投资时的会员等级，在乙方本金逾期的第31日进行垫付：若甲方为特权会员，则垫付甲方应收未收的本息和违约金；若甲方为普通会员，则垫付甲方应收未收的本金；自丙方垫付后，乙方对甲方（普通会员）借款本金自逾期之日产生的逾期利息与违约金归丙方所有，丙方有权向乙方追讨。<br />
               &ensp;&ensp;&ensp;&ensp;3、自丙方垫付符合垫付条件的逾期资产担保标之日起，乙方应立即向丙方归还已垫付的所有款项，否则应向丙方支付其所垫付款项0.4%/日的违约金。<br />
            </p>  
        </div>
    </div>
    <div class="Contract">
        <div class="Contract_c">
        <p>
            <b>四、居间服务</b><br />
                &ensp;&ensp;&ensp;&ensp;1、居间方提供融资平台，甲、乙双方在融资平台注册用户进行借贷活动，借贷活动中的资金投入和提现均托管于第三方支付平台。<br />
                &ensp;&ensp;&ensp;&ensp;2、乙方在借入成功后，乙方应向居间方交付成交管理费，甲方在收回借款时，甲方应向居间方交付成交管理费，具体以居间方在融资平台公布的收费标准执行。<br />
                <br /><b>五、追索费用</b>
                <br />
            </p>
           <p>
                &ensp;&ensp;&ensp;&ensp;如果乙方到期未归还借款本金及利息从而引致甲方或丙方向乙方追索的，则甲方或丙方因行使追索权而产生的包括但不限于诉讼费用、仲裁费用、诉前/诉讼保全费/诉讼保全担保费/担保费、律师费用等在内的一切费用和开支，一概均由乙方负责承担。<br />
                <br /><b>六、违约责任</b>
                <br />
                &ensp;&ensp;&ensp;&ensp;本合同签定后，甲、乙、丙三方必须全面适当地履行本合同项下各自的义务及责任。任何一方对本合同项下任一条款之违反，即被视为违约，违约方须向对方承担相应之违约责任，赔偿对方因违约而遭致的一切经济损失。如果乙方违约，甲方或丙方有权向有关个人征信系统予以披露，有权通过社会公告等形式追究其违约责任。
            </p>
            <p>
                <br /><b>七、争议解决方式</b>
                <br />
                &ensp;&ensp;&ensp;&ensp;因本合同发生的任何争议，由各方协商解决，协商不成的，任何一方可提交湛江仲裁委员会在东莞仲裁，并按其当时有效的仲裁规则适用简易程序进行仲裁。仲裁裁决是终局的，对各方均有约束力。
            </p>
            <p>
                <br /><b>八、生效及其他</b>
                <br />
                &ensp;&ensp;&ensp;&ensp;本合同对各方均有约束力，本合同自甲、乙、丙三方在团贷网提供的融资平台点击确认后立即生效。  
            </p>
        </div>
        <div class="Contract_b">
            <p>
                <br />
                <strong>各方签署：</strong></p>
            <p>
                甲方：<span><%=subBasicModel.RealName %></span></p>
            <p>
                乙方：<span><%=publisherModel.RealName %></span></p>
            <p>
                丙方：<span><%=AssureModel.FullName %></span></p>
            <p>
                协议签署日期：<em><%=submodel.AddDate.Value.Year %></em>年<em><%=submodel.AddDate.Value.Month %></em>月<em><%=submodel.AddDate.Value.Day %></em>日</p>
            <p>合同签订地：广东省东莞市南城区</p>
             <div class="Seal_zhuochen" style="background: url('<%=this.AssureModel.image %>') no-repeat scroll left center transparent"> </div>
            <!--盖章-->
            <!--<div class="seal-con pos-a">
                <img src="images/hnstrz.png" alt=""/>
            </div>-->
        </div>
    </div>
    <div class="clearfix mt20"></div>
    <script type="text/javascript">
        var url = window.location.href;
        if (url.indexOf("type=mobileapp") >= 0) {
            document.getElementById("header").style.display = "none";
        }
    </script>
</body>
</html>