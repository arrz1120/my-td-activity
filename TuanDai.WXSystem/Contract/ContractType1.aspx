﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContractType1.aspx.cs" Inherits="TuanDai.WXApiWeb.Contract.ContractType1" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>商友贷合同</title>
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
            <h1 class="title">商友贷合同</h1>
        </div>
    </header>
    <!--第1页>-->
    <div class="Contract">
        <h3>
            商友贷合同</h3>
        <div class="Number">合同编号：<%=Key%></div>
        <div class="Contract_t">
            <ul>
                <li>
                    <div>甲方（出借人）：<span><%=subBasicModel.RealName %></span></div>
                    <div>身份证号码：<span><%=subBasicModel.IdentityCard %></span></div>
                </li>
                <li>
                    <div>乙方（借入人）：<span><%=publisherModel.RealName %></span></div>
                    <div><%=publisherModel.UserTypeId==1?"身份证号码":"工商注册号" %>：<span><%=publisherModel.IdentityCard %></span></div>
                </li>
                <li>
                    <div>丙方（担保人）：<span><%=this.assureModel.FullName%></span></div>
                </li>
            </ul>
        </div>
        <div class="Contract_c">
            <p>
                特别提示：<br />
                甲、乙、丙三方请认真仔细阅读本合同项下的全部条款。甲、乙、丙三方通过东莞团贷网互联网科技服务有限公司（以下简称“团贷网平台”），在平等自愿、协商一致的基础上，达成如下借款合同，以兹共同遵守执行。</p>
            <p>
                一、借款条款<br />
                1、借款金额：乙方因资金周转需要，现向甲方借款￥<span><%=submodel.Amount.Value.ToString("N") %></span>元（大写人民币：<span><%=Tool.ChineseNum.GetUpperMoney(double.Parse(this.submodel.Amount.Value.ToString()))%></span>）<br />
                2、借款期限：<span><%=proModel.Deadline %></span>个月，自甲方出借之日起计算。<br />
                3、借款利息：在合同规定的借款期内，年利率为<span><%=proModel.InterestRate %>%</span>。乙方如果不按期归还借款，导致丙方代为偿付应还借款本息或本金时，自丙方垫付之日起，乙方除向丙方支付上述标准的利息（年利率折算成天计算）外还应额外承担垫付金额每日万分之三的违约金。<br />
                4、还款方式：<%=RepaymentTypeDesc %>。</p>
            <p>
                二、保证担保<br />
                1、乙方应向丙方支付担保费用并且向团贷网支付居间服务费用，在乙方足额支付上述费用后，丙方愿意按照本合同的约定为本合同项下的借款本金或本息（垫付标准依据甲方出借时其在团贷网平台的会员等级制度为准）提供连带保证责任。<br />
               2、乙方到期未及时归还甲方出借之本息，丙方应及时承担保证责任，垫付标准以甲方出借时其在团贷网平台的会员等级制度执行。若甲方出借时为普通会员，则出现前述情况下丙方仅向甲方垫付借款本金；若甲方出借时为超级会员，出现上述情况下丙方全额垫付本息。<br />
              3、自丙方代乙方清偿其逾期的借款本金或本息时，丙方有权向乙方追偿已垫付的借款本息及垫付后产生的利息。<br />
              </p>
        </div>
    </div>
    <!--第2页>-->
    <div class="Contract">
        <div class="Contract_c">
            <p>
            4、甲、乙、丙三方协商一致，可以变更合同。如果甲乙双方未经丙方同意擅自变更合同的，则变更合同对丙方不发生效力，自合同变更之日起，丙方不再承担保证责任。<br />
                三、追索费用<br />
                如果乙方到期未归还借款本金及利息从而引致甲方或者丙方向乙方追索的，则甲方或者丙方因行使追索权而产生的包括但不限于诉讼费、仲裁费、保全费、保全担保费、律师费等在内的一切费用和开支，一概均由乙方负责承担。</p>
            <p>
                四、违约责任<br />
              本合同签定后，甲、乙、丙各方必须全面适当地履行本合同项下各自的义务及/或责任。任何一方对本合同项下任一条款之违反，即被视为违约，违约方须对非违约方承担相应之违约责任，赔偿非违约方因违约而遭致的一切经济损失。如果乙方违约，甲方或者丙方有权向有关个人征信系统予以披露，有权通过社会公告等形式追究其违约责任。</p>
            <p>
                五、争议解决方式<br />
                合同履行过程中如果发生争议，协商解决，协商不成的，任何一方可提交湛江仲裁委员会在东莞仲裁，并按其当时有效的仲裁规则适用简易程序进行仲裁。仲裁裁决为终局裁决，对各方均有约束力。</p>
            <p>
                六、生效及其他<br />
                本电子合同适用《中华人民共和国电子签名法》的规定，本合同自甲、乙、丙三方以电子签名或盖章的形式确认后立即生效，对各方均产生约束力。</p>
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
                丙方：<span><%=this.assureModel.FullName %></span></p>
            <p>
                协议签订地：<span>广东省东莞市南城区</span></p>
            <p>
                协议签署日期：<em><%=submodel.AddDate.Value.Year %></em>年<em><%=submodel.AddDate.Value.Month %></em>月<em><%=submodel.AddDate.Value.Day %></em>日</p>
               <div class="Seal_zhuochen" style="background: url('<%=this.assureModel.image %>') no-repeat scroll left center transparent"> </div>
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
