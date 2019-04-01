﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contractFTB.aspx.cs" Inherits="TuanDai.WXApiWeb.Contract.contractFTB" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>复投宝服务协议</title>
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
    <h3>复投宝服务协议</h3>
    <div class="Number"></div>
    <div class="Contract_t">
        <ul>
            <li>
                <div>甲方（用户）：<span><%= this.subBasicModel.RealName %></span></div>
                <div>乙方（服务方）：<span><%=strCompanyName %></span></div>
            </li>
        </ul>
    </div>
    <div class="Contract_c">
        <p>为了向用户提供高效及资金利用率更高的理财计划，现服务方在其网络平台（以下简称“团贷网”，网址：http://www.tuandai.com ）推出复投宝服务，甲方同意加入本次复投宝项目，并自愿遵守团贷网现有的相关协议及规则。现甲乙双方本着平等自愿、诚实信用的原则，达成如下协议：</p>
        <p class="title">一、产品释义</p>
        <p>1、复投宝是受用户委托并授权服务方系统自动投标、自动复投、到期转让的智能理财计划。“复投宝”智能工具在本协议第二条约定的投标范围内对符合要求的标的进行优先自动投标，并在计划到期后自动转让退出。用户加入复投宝即进入锁定期（为T+5个自然日），用户在锁定期结束之次日起进入持续服务期，持有期内系统自动复投，到期系统自动转让退出。复投宝持有满<%=model.ExitLockMonth %>个月即可申请提前退出，可支持部分提前退出。</p>
        <p>复投宝履行期间由服务方系统实现标的分散投资，且系统所投资的标的均 适用于安全保障计划。用户选择加入复投宝时，已深度理解并知悉服务方系统所设定的交易规则，系统仅会在符合用户授权之范围内代为行使甲方权利，所行使之权利均视为用户自身行为。</p>
        <p>2、资金锁定期限：自用户加入复投宝之时起T+5个自然日，其投入的资金将被冻结在平台个人资金账户中，锁定期间被锁定资金不产生任何利息。若该锁定期限内服务方未能将该笔资金全部投入到匹配的标的当中，剩余资金在锁定期结束后将解除冻结并由用户自行支配。</p>
        <p>3、持续服务期间：本期间自上述T+5日锁定期期满后开始起算（即加入复投宝的第7个自然日）。用户加入复投宝，且在复投宝安排下成功投标后，其具体所投标的所产生的回款及收益（以下统称“该款项”），复投宝针对该款项及该款项后续产生的收益继续提供服务。即复投宝持续服务期间系统代为用户投标所产生的本息回款，系统均会第一时间继续投标直至复投宝期限到期时启动债权转让机制。</p>
        <p>4、投资方式：复投宝锁定期、持续服务期间投出所有标的每月收回的部分本金及利息以及再复投标的回款的本金及利息，复投宝智能工具也会再进行复投。</p>
        <p>5、退出方式：用户本次参加的复投宝，在约定持续服务期间到期后，系统协助用户完成所有债权转让后一次性归还用户；</p>
        <p>6、预期综合年化利率：本次复投宝到期后综合产生的预期年化利率以本协议第二条约定详情为准（根据持有时间不同，故预期收益标准不同）。复投宝智能工具投标的综合利率与用户持有时间相关，持续服务期间越久用户所得利率越高。如退出时实际收益超过预期收益，超出部分作为平台管理费，由平台收取.</p>
        <p>7、投资具体标的借款期限：用户加入本次计划后，以服务方为用户提供自动匹配的具体标的约定的实际借款期限为准（本协议所指期限为复投宝持续服务期间，不应视为复投宝投出后的每个借款标的期限）。</p>
    </div>
</div>
<!--第2页>-->
<div class="Contract">
    <div class="Contract_c">
        <p class="title">二、本次复投宝详情</p>
        <div  class="content">
            <p>1、用户加入详情</p>
            <table cellpadding="0" cellspacing="0" class="tab">
                <tr><td style="width:180px;">名称：</td><td> <%=model.ProductName %></td></tr>
                <tr><td>计划金额：</td><td> <%=ToolStatus.ConvertDetailWanMoney(model.PlanAmount)%></td></tr>
                <tr><td>投资范围：</td><td> <%=GetInvestRange(model.ProjectTypes) %></td></tr>
                <tr><td>复投宝持续服务期限：</td><td> <%=model.Deadline %>个月</td></tr>
                <tr><td>还款方式：</td><td> 到期本息</td></tr>
                <tr><td>开放加入时间：</td><td> <%= model.StartDate.HasValue?model.StartDate.Value.ToString("yyyy-MM-dd HH:mm"):"" %></td></tr>
                <tr><td>计划单位（元/份）：</td><td> <%=Convert.ToDouble(model.UnitAmount) %></td></tr>
                <tr><td>加入份数：</td><td> <%=model.OrderQty %></td></tr>
                <tr><td>加入资金：</td><td> <%=ToolStatus.ConvertDetailWanMoney(model.JoinAmount) %></td></tr>
            </table>
        </div>
        <div  class="content">
            <p>注：上表中复投宝详情依据用户选择加入的具体项目所产生；投资范围所列的项目名称详细解释参见团贷网公布的相关产品介绍。</p>
            <p>2、预期综合年化利率表</p>
            <table cellpadding="0" cellspacing="0" class="tab">
                <tr><td style="width:200px;">持有时间</td><td> 预期年化利率</td></tr>
                <%
                    if (model.Deadline == 36)
                    {
                        for (int i = 0; i < ftbRateList.Count; i++)
                        {
                            var count = ftbRateList.Where(o => o.YearRate == ftbRateList[i].YearRate).Count();
                            if (i > 0 && ftbRateList[i].YearRate == ftbRateList[i - 1].YearRate)
                                continue;
                            if (ftbRateList[i].MonthType < model.ExitLockMonth)
                                continue;
                %>
                       <tr><td>持有满<%= count > 1 ? ftbRateList[i].MonthType.ToString() + "-" + (ftbRateList[i].MonthType + count - 1).ToString() : ftbRateList[i].MonthType.ToString() %>月</td><td><%= ToolStatus.DeleteZero(ftbRateList[i].YearRate) %>%</td></tr>
                      <% }
                    }
                    else
                    {
                        foreach (var item in ftbRateList)
                        {
                            if(item.MonthType < model.ExitLockMonth)
                                continue;
                           %>
                    <tr><td><%=item.MonthType == model.Deadline?"计划到期退出":"持有满"+item.MonthType+"月" %></td><td><%= ToolStatus.DeleteZero(item.YearRate) %>%</td></tr>
                <% 
                        }
                    }%> 
            </table>
        </div>
        <p class="title">三、复投宝的加入</p>
        <p>1、甲方在本次复投宝开放加入时间内根据自己的意愿选择加入份数，确认申请加入，并完成加入资金的全额支付后视为甲方已成功加入本次复投宝，一旦成功加入即不可撤销，资金在锁定期限内不产生任何费用或收益。</p>
        <p>2、甲方在加入本次复投宝的同时，确认同意并接受本协议的所有条款。本协议以团贷网《注册服务协议》为前提，甲方参与本次复投宝的任何行为都应同时遵守团贷网《注册服务协议》和团贷网不时公示之交易规则、说明、公告等涉及甲、乙双方权利义务的法律文件及相关规则，如有违反，甲方应当自行承担相关法律后果。</p>
        <p class="title">四、优先自动投标及复投规则</p>
        <p>1、自用户参加本次复投宝起，服务方系统即按照本协议之约定，依据用户加入复投宝的先后顺序为用户进行优先自动投标。</p>
        <p>2、服务方系统自动协助用户进行合理投标，若系统自动投资后的某借款标发生提前还款的，且复投宝仍在持续服务期间，系统会自动将该笔款项进行再次复投。</p>
        <p>3、复投宝持续服务期间系统投资的某个标的出现借款方逾期情况，则按照用户加入复投宝时会员等级为准进行分别处理。用户加入本次复投宝时为团贷网<%=subBasicModel.Level==2?"超级":"普通" %>会员，故按照下述标准享有相应的权利及义务：</p>
        <p class="text-ind">(1)若用户加入本期复投宝时为团贷网超级会员，发生逾期担保方垫付本息后，系统继续将上述担保方垫付本息款进行复投；</p>
        <p class="text-ind">(2)若用户加入本期复投宝时为团贷网普通会员，发生逾期担保方垫付本金后，系统将继续复投上述担保方垫付的本金；</p>
        <p class="text-ind">(3)上述逾期发生且经担保方进行垫付还款后，借款方履行还款的，则还款资金（包括还款本金、还款利息、滞纳金等）由担保方所有，该资金不再参与复投。</p>
    </div>
</div>

<!--第3页>-->
<div class="Contract">
    <div class="Contract_c">
        <p class="title">五、复投宝的到期或提前退出</p>
        <p>1、到期退出：复投宝到期结束后，系统将为用户统计复投宝持续服务期间所投资的债权，并将计划期间系统代为投标或复投的所有标的自动进行债权转让。</p>
        <p>2、提前退出：持有本次计划满<%=model.ExitLockMonth %>个月后（“月”应按自然月计算，即从持续服务期间开始之日起至下个月份相同日期，若次月没有相同日期，则系统默认前一日，下同），用户可提前申请退出本次计划。即在第<%=model.ExitLockMonth+1%>个月开始可向系统申请债权转让，系统支持全额退出或部分退出本期计划（即用户可一次性全部转让或部分转让在复投宝中由系统自动投资的所有标的）。</p>
        <p>3、转让时效：复投宝的退出只能通过平台以债权转让的形式实现，所持债权转让完成的具体时间，视债权转让实际交易情况而定，即服务方及担保方不对用户转让所持有债权的时效进行兑付承诺。</p>
        <p>4、退出资金处理方式：复投宝到期或提前退出，资金将根据债权转让完成情况陆续返还至用户在团贷网开设的个人账户，但到期或提前退出时，债权转让成功后的回款先行被冻结，用户当次发起转让的债权全部转让完成后，系统再将回款解冻至用户可用余额，同时扣除平台服务费。</p>
        <p class="title">六、甲方的权利和义务</p>
        <p>1、甲方在此无条件且不可撤销地授权：自甲方加入本次复投宝起，即授权乙方通过服务方系统根据本次计划的详情对甲方的加入资金进行优先自动投标，并授权团贷网通过系统以甲方名义自动签署相关借款协议、债权转让协议、相关投资项目的服务协议等，甲方应提前查看并了解相关协议内容；甲方对此等自动投标和自动签署相关借款协议、债权转让协议、相关投资项目的服务协议之安排及内容已充分知悉并理解；该等自动签署的借款协议、债权转让协议、相关投资项目的服务协议均视为甲方真实意思的表示，甲方对该等法律文件的效力均予以认可且无任何异议，并无条件接受该等自动签署的法律文件之约束。</p>
        <p>2、甲方的收益：甲方享有加入本次复投宝后成功实现优先自动投标而产生的收益。甲方的收益根据甲方的加入资金通过优先自动投标参加的具体投资项目而产生，以具体投资项目的投标成功之日起开始计算收益；甲方已经知悉、了解并同意：甲方加入本次复投宝并不代表必然实现优先自动投标，甲方自行承担任何原因所导致的未能优先自动投标的风险；本协议所示参考年回报率不代表甲方最终实际收益率，在实际收益率未达到预期收益率的情况下，甲方仅能收取其实际收益，若甲方提前退出或到期退出后所取得的实际收益高于预期收益则超出部分作为平台服务费由乙方收取；甲方对具体投资项目的出借本金以及相应的利息存在不能够按期收回的风险。</p>
        <p>3、服务费：甲方到期退出或提前退出本次复投宝项目时，系统按照本协议第二条第二款约定的“预期年化综合利率”表结合用户当次实际持有复投宝的期间取值“预期年化利率”标准。若系统在结算后统计出用户当前实际收益利率高于上述系统取值标准，则超出部分作为乙方服务费，按照前述条款约定由系统结算时予以扣除。</p>
        <p>4、税费问题：由甲方自行承担加入本次复投宝所获利息收益的应纳税费。</p>
        <p>5、甲方保证加入复投宝所使用的资金为合法取得，且甲方对该资金拥有完全且无瑕疵的所有权及处分权。</p>
        <p>6、甲方可通过其注册的团贷网账户查询、了解本次复投宝的相关信息及进度，如未及时查询，或由于通讯故障、系统故障以及其他不可抗力等因素影响使甲方无法及时了解相关信息，由此产生的责任和风险由甲方自行承担。</p>
        <p>7、甲方加入本次复投宝的资金所对应的具体投资项目，按照该投资项目的担保方式为其本金或者本息提供保障，乙方不向甲方对具体投资项目的出借本金以及相应的利息作任何承诺与保证。</p>
        <p class="title">七、乙方的权利和义务</p>
        <p>1、甲方通过服务方系统自动投标而签署之借款协议、债权转让协议、相关投资项目的服务协议等法律文件或其中的相关条款生效后，乙方即可依据上述法律文件和本协议相关约定，对甲方的加入资金进行划扣、支付、冻结以及行使其他权利，甲方对此均予以接受和认可。</p>
        <p>2、甲方在加入本次计划后，服务方系统第一时间根据用户加入本次计划的先后顺序自动安排优先投标。</p>
        <p>3、服务方系统根据本次计划的投资范围自动对甲方加入本次计划的资金优先自动投标，但乙方不保证甲方的加入资金能全部投标成功，且乙方不对甲方参加复投宝所对应的具体投资项目出借本金的收回、可获收益金额作出任何承诺、保证。</p>
        <p>4、乙方接受甲方的委托行为所产生的法律后果由甲方承担。如因甲方或其他方（包括但不限于技术问题）造成的延误或错误，乙方不承担任何责任。</p>
        <p>5、资金锁定期限届满后，对于甲方加入本次复投宝的加入资金尚未进行投标的部分，乙方应自动解冻该部分资金到甲方在团贷网开立的个人账户上。</p>
        <p>6、乙方仅在本协议明确规定的责任范围内承担相关责任。</p>
        <p class="title">八、其他</p>
        <p>1、如因司法机关或行政机关对甲方采取强制措施导致其本次复投宝对应的资金被全部或部分扣划，视为甲方提前退出本次复投宝，本协议自动终止。本协议因此而自动终止的，甲方将不再享有相应权利。</p>
        <p>2、由于团贷网及相关第三方的设备、系统故障或缺陷、黑客攻击、计算机病毒侵入或发作、电力中断、因政府管制而造成的暂时性关闭等影响网络正常经营的不可抗力而造成交易中断、延误的，甲、乙双方互不追究责任。甲、乙双方应在条件允许的情况下，采取一切必要的补救措施以减小不可抗力造成的损失。</p>
        <p>3、甲方确认：在签署本协议书以前，乙方已就本协议的全部条款和内容向甲方进行了详细的说明和解释，甲方已认真阅读本协议有关条款，对有关条款不存在任何疑问或异议，并对协议双方的权利、义务、责任与风险有清楚和准确的理解。</p>
        <p class="title">九、争议解决</p>
        <p>因本协议所引起的纠纷，双方应协商解决，协商不成的，任何一方可向乙方所在地的人民法院提起诉讼。</p>
        <p class="title">十、协议成立和生效</p>
        <p>本协议通过团贷网平台电子协议签署的要求签署，适用《中华人民共和国电子签名法》的规定，甲方确认本次复投宝的加入金额、期限和预期收益等内容无误，确认加入后，即视为甲方以电子签名的形式确认本协议成立。本协议自成立起生效，甲方同意接受本协议的全部约定及团贷网上与本协议相关的各项规则的规定。本协议一旦生效，即对甲、乙双方均具有法律约束力。</p>
    </div>
    <div class="Contract_b">
        <p><br /><strong>各方签署：</strong></p>
        <p>甲方：<span><%= this.subBasicModel.RealName %></span></p>
        <p>日期：<em><%=this.model.OrderDate.Year.ToString() %></em>年<em><%=this.model.OrderDate.Month.ToString() %></em>月<em><%=this.model.OrderDate.Day.ToString() %></em>日</p>
        <p>乙方：<span><%=strCompanyName %></span></p>
        <p>日期：<em><%=this.model.OrderDate.Year.ToString() %></em>年<em><%=this.model.OrderDate.Month.ToString() %></em>月<em><%=this.model.OrderDate.Day.ToString() %></em>日</p>
        <!--盖章-->
        <%--<div class="seal-con pos-a">
            <img src="images/hnstrz.png" alt=""/>
        </div>--%>
        <div class="Seal_zhuochen" style="background: url('<%=Sealt_TuanDai%>') center no-repeat; position: relative;"></div>
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

