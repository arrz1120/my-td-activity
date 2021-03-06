﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContractType100.aspx.cs" Inherits="TuanDai.WXApiWeb.Contract.ContractType100" %>

<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>We计划[分期宝]服务合同</title>
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
            <h1 class="title">We计划[分期宝]服务合同</h1>
        </div>
    </header>
    <% if (model.TypeWord.ToLower().Contains("y7") || model.TypeWord.ToLower().Contains("z7"))
       {
    %>
    <div class="nav pos-f webkit-box bb-c7c7ca">
        <a class="box-flex1 active"><span>合同一</span></a>
        <a href="contractTypeIP7.aspx?key=<%=key %>" class="box-flex1"><span>合同二</span></a>
    </div>
    <%
       } %>

    <div class="Contract" style="margin-top: 0.1rem;">
        <div class="title">
            We计划[分期宝]服务合同
        </div>
        <div class="bold">
            <div class="font">
                甲方（用户）： <%= this.subBasicModel.RealName %>
            </div>
        </div>
        <div class="bold">
            <div class="font">
                乙方（服务方）： <%=strCompanyName %>
            </div>
        </div>
        <br />
        <div class="content">
            乙方为了向甲方提供效率及资金利用率更高的理财计划，现在其网络平台（以下简称“团贷网”，网址：http://www.tuandai.com ）推出We理财计划[分期宝]服务，甲方同意加入本次We计划[分期宝]项目，并自愿遵守团贷网现有的相关协议及规则。现甲乙双方本着平等自愿、诚实信用的原则，达成如下协议：
        </div>
        <div class="font1 subtitle">
            一、产品释义
        </div>
        <div class="content">
            1、We计划[分期宝]（以下简称“本计划”）是服务方针对分期宝专区标的而推出的自动投标、自动复投、自动债权转让的高效便捷、智能投标工具。即用户加入本计划后服务方在用户认可的标的范围内（详见本协议第二条款约定范围）对符合要求的标的进行自动投标；且回款本息或回款本金在本计划服务期限内自动复投；本计划服务期满时系统自动将本计划期间内由系统投资的所有债权予以转让。
        </div>
        <div class="content">
            本计划履行期间内由服务方系统实现标的分散投资，且系统所投资的标的均 适用于团贷网用户权益保障机制。用户选择加入本计划时，已深度理解并知悉服务方系统所设定的交易规则，系统仅会在符合用户授权之范围内代为行使甲方权利，所行使之权利均视为用户自身行为。
        </div>
        <div class="content">
            2、资金锁定期限：自用户加入本计划之时起T+5个自然日内，其投入的资金将被冻结在平台个人资金账户中，由服务方根据用户加入本计划的详情进行优先自动投标。若该锁定期限内服务方未能将该笔资金全部投入到匹配的标的当中，剩余资金将解除冻结由用户自行支配。
        </div>
        <div class="content">
            3、持续服务期间：本期间自上述T+5日锁定期期满后开始起算（即资金锁定期结束次日）。用户加入本计划，且在本计划安排下成功投标后，其具体所投标的所产生的回款及收益（以下统称“该款项”），本计划针对该款项及该款后续项产生的收益继续提供服务。即本计划持续服务期间系统代为用户投标所产生本金回款或本息回款，系统均会第一时间继续投标直至本计划期限到期时启动债权转让机制。
        </div>
        <div class="content">
            4、复投方式： 本次计划提供以下两种收益处理方式：即每月收回本金与利息再投资（本息复投模式）或本金复投利息提取至用户的平台个人资金账户可用余额（本金复投模式）。用户在加入计划时可自行选择复投方式，复投方式一经选择，在计划结束前不得修改。 
        </div>
        <div class="content">
            5、还款方式：按照用户加入本次计划时选择的复投方式对应不同的还款方式如下：
            <div class="content">
                本息复投，还款方式：到期一次性还本付息；
            </div>
            <div class="content">
                本金复投，还款方式：每月付息，到期还本；
            </div>
        </div>
        <div class="content">
            6、预期综合年化利率：为用户在本计划安排下成功投标所产生的收益及本金复投/本息复投所产生的收益之和换算而成的综合利率，该综合利率为预期收益，最终收益按实际所投标的产生的收益为准。
        </div>
        <div class="content">
            7、投资具体标的借款期限：用户加入本次计划后，以服务方为用户提供自动匹配的具体标的约定的实际借款期限为准。
        </div>
    </div>
    <div class="Contract">
        <div class="font1 subtitle">
            二、本次We计划详情
        </div>
        <div class="content">
            <table cellpadding="0" cellspacing="0" class="tab">
                <tr>
                    <td style="width: 160px;">名称：</td>
                    <td><%=model.ProductName %></td>
                </tr>
                <tr>
                    <td>计划金额：</td>
                    <td><%=ToolStatus.ConvertDetailWanMoney(model.PlanAmount)%></td>
                </tr>
                <tr>
                    <td>投资范围：</td>
                    <td><%=GetInvestRange(model.ProjectTypes) %></td>
                </tr>
                <tr>
                    <td>本计划持续服务期限：</td>
                    <td><%=model.Deadline %>个月</td>
                </tr>
                <tr>
                    <td>复投方式：</td>
                    <td><%=model.RepeatInvestType==1?"本息复投":"本金复投" %></td>
                </tr>
                <tr>
                    <td>还款方式：</td>
                    <td>到期还本付息（本息复投）/每月付息，到期还本（本金复投）</td>
                </tr>
                <tr>
                    <td>本计划期满后预期<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;综合年化利率：
                    </td>
                    <td><%=ToolStatus.DeleteZero(model.YearRate) %>%</td>
                </tr>
                <tr>
                    <td>开放加入时间：</td>
                    <td><%= model.StartDate.HasValue?model.StartDate.Value.ToString("yyyy-MM-dd HH:mm"):"" %></td>
                </tr>
                <tr>
                    <td>计划单位（元/份）：</td>
                    <td><%=Convert.ToDouble(model.UnitAmount) %></td>
                </tr>
                <tr>
                    <td>加入份数：</td>
                    <td><%=model.OrderQty %></td>
                </tr>
                <tr>
                    <td>加入资金：</td>
                    <td><%=ToolStatus.ConvertDetailWanMoney(model.JoinAmount) %></td>
                </tr>
            </table>
        </div>
        <div class="content">
            注：上表中We计划详情依据用户选择加入的具体We计划项目产生；投资范围所列的项目名称详细解释参见团贷网公布的相关产品介绍。
        </div>
        <div class="font1 subtitle">
            三、We计划的加入
        </div>
        <div class="content">
            1、甲方在本次We计划开放加入时间内根据自己的意愿选择加入份数，确认申请加入，并完成加入资金的全额支付后视为甲方已成功加入本次We计划，一旦成功加入即不可撤销，资金锁定期限内未成功投标的资金不产生任何费用或收益。
        </div>
        <div class="content">
            2、甲方在加入本次We计划的同时，确认同意并接受本协议的所有条款。本协议以团贷网《注册服务协议》为前提，甲方参与本次We计划的任何行为都应同时遵守团贷网《注册服务协议》和团贷网不时公示之交易规则、说明、公告等涉及甲、乙双方权利义务的法律文件及相关规则，如有违反，甲方应当自行承担相关法律后果。
        </div>
        <div class="font1 subtitle">
            四、优先自动投标及复投规则
        </div>
        <div class="content">
            1、自用户参加本次We计划起，服务方系统即按照本协议之约定，依据用户加入本计划的先后顺序为用户进行优先自动投标。
        </div>
        <div class="content">
            2、服务方系统自动根据用户选择的投资方式（即本息复投或本金复投方式）进行合理投标，若系统自动投资后的某借款标发生提前还款的，且本计划仍在持续服务期间，系统会自动将该笔款项进行再次复投。
        </div>
        <div class="content">
            3、本计划持续服务期间系统投资的某个标出现借款方逾期情况，则按照用户加入本计划系统投资具体标的时是否为团贷网超级会员而分别处理：
            <div class="content">
                (1)若系统自动投标时用户为团贷网超级会员，发生逾期担保方垫付本息后，系统继续将上述担保方垫付本息款进行复投；
            </div>
            <div class="content">
                (2)若系统自动投标时用户为团贷网普通会员，发生逾期担保方垫付本金后，系统将继续复投上述担保方垫付的本金；
            </div>
            <div class="content">
                (3)上述逾期发生且经担保方进行垫付还款后，借款方履行还款的，则还款资金（包括还款本金、还款利息、滞纳金等）由担保方所有，该资金不再参与复投。
            </div>
        </div>
    </div>
    <div class="Contract">
        <div class="font1 subtitle">
            五、本计划的到期或提前退出
        </div>
        <div class="content">
            1、到期退出：本计划到期结束后，系统将为用户统计本计划期间所投资的债权，并将计划期间系统代为投标或复投的所有标的自动进行债权转让。用户因本计划到期后由系统触发债权转让机制的，服务方将不收取任何服务费。
        </div>
        <div class="content">
            2、提前退出：加入本次计划满3个月后（“月”应按自然月计算，即从资金锁定期结束次日起至下个月份相同日期为止，若次月无相同日期，则系统默认前一日，下同），用户可提前申请退出本次计划，即在第4个月开始可向系统申请债权转让，系统支持全额退出本期计划（即用户必须一次性全部转让在本计划中由系统自动投资的所有标的）。但用户需要向服务方支付债权转让管理费，即每成功转让一笔债权，系统均会在到帐金额中直接扣除0.5%的管理费。 
        </div>
        <div class="content">
            3、 转让时效：本计划的退出只能通过平台以债权转让的形式实现，所持债权转让完成的具体时间，视债权转让实际交易情况而定，即服务方及担保方不对用户转让所持有债权的时效进行兑付承诺。
        </div>
        <div class="content">
            4、退出资金处理方式：本计划到期或提前退出，资金将根据债权转让完成情况陆续返还至用户在团贷网开设的个人账户，且用户可在账户上实时查询转让进度。 
        </div>
        <div class="font1 subtitle">
            六、甲方的权利和义务
        </div>
        <div class="content">
            1、甲方在此无条件且不可撤销地授权：自甲方加入本次We计划起，即授权乙方通过服务方系统根据本次计划的详情对甲方的加入资金进行优先自动投标，并授权团贷网通过系统以甲方名义自动签署相关借款协议、债权转让协议、相关投资项目的服务协议等，甲方应提前查看并了解相关协议内容；甲方对此等自动投标和自动签署相关借款协议、债权转让协议、相关投资项目的服务协议之安排及内容已充分知悉并理解；该等自动签署的借款协议、债权转让协议、相关投资项目的服务协议均视为甲方真实意思的表示，甲方对该等法律文件的效力均予以认可且无任何异议，并无条件接受该等自动签署的法律文件之约束。
        </div>
        <div class="content">
            2、甲方的收益：甲方享有加入本次We计划后成功实现优先自动投标而产生的收益。甲方的收益根据甲方的加入资金通过优先自动投标参加的具体投资项目而产生，以具体投资项目的投标成功之日起开始计算收益；甲方已经知悉、了解并同意：甲方加入本次We计划并不代表必然实现优先自动投标，甲方自行承担任何原因所导致的未能优先自动投标的风险；本协议所示参考年回报率不代表甲方最终实际收益率，在实际收益率未达到预期收益率的情况下，甲方仅能收取其实际收益；甲方对具体投资项目的出借本金以及相应的利息存在不能够按期收回的风险。
        </div>
        <div class="content">
            3、服务费：甲方加入本计划时不需支付服务费（提前申请退出本计划的除外），但甲方应自行承担由具体投资项目所引起的相关费用（如有）。
        </div>
        <div class="content">
            4、税费问题：由甲方自行承担加入本次We计划所获利息收益的应纳税费。
        </div>
        <div class="content">
            5、甲方保证加入We计划所使用的资金为合法取得，且甲方对该资金拥有完全且无瑕疵的所有权及处分权。
        </div>
    </div>

    <div class="Contract">

        <div class="content">
            6、甲方可通过其注册的团贷网账户查询、了解本次We计划的相关信息及进度，如未及时查询，或由于通讯故障、系统故障以及其他不可抗力等因素影响使甲方无法及时了解相关信息，由此产生的责任和风险由甲方自行承担。
        </div>
        <div class="content">
            7、甲方加入本次We计划的资金所对应的具体投资项目，按照该投资项目的担保方式为其本金或者本息提供保障，乙方不向甲方对具体投资项目的出借本金以及相应的利息作任何承诺与保证。
        </div>
        <div class="font1 subtitle">
            七、乙方的权利和义务
        </div>
        <div class="content">
            1、甲方通过服务方系统自动投标而签署之借款协议、债权转让协议、相关投资项目的服务协议等法律文件或其中的相关条款生效后，乙方即可依据上述法律文件和本协议相关约定，对甲方的加入资金进行划扣、支付、冻结以及行使其他权利，甲方对此均予以接受和认可。
        </div>
        <div class="content">
            2、甲方在加入本次计划后，服务方系统第一时间根据用户加入本次计划的先后顺序自动安排优先投标。
        </div>
        <div class="content">
            3、服务方系统根据本次计划的投资范围自动对甲方加入本次计划的资金优先自动投标，但乙方不保证甲方的加入资金能全部投标成功，且乙方不对甲方参加本计划所对应的具体投资项目出借本金的收回、可获收益金额作出任何承诺、保证。
        </div>
        <div class="content">
            4、乙方接受甲方的委托行为所产生的法律后果由甲方承担。如因甲方或其他方（包括但不限于技术问题）造成的延误或错误，乙方不承担任何责任。
        </div>
        <div class="content">
            5、资金锁定期限届满后，对于甲方加入本次We计划的加入资金尚未进行投标的部分，乙方应自动退回该部分资金到甲方在团贷网开立的个人账户上。
        </div>
        <div class="content">
            6、乙方仅在本协议明确规定的责任范围内承担相关责任。
        </div>
        <div class="font1 subtitle">
            八、其他
        </div>
        <div class="content">
            1、如因司法机关或行政机关对甲方采取强制措施导致其本次We计划对应的资金被全部或部分扣划，视为甲方提前退出本次We计划，本协议自动终止。本协议因此而自动终止的，甲方将不再享有相应权利。
        </div>
        <div class="content">
            2、由于团贷网及相关第三方的设备、系统故障或缺陷、黑客攻击、计算机病毒侵入或发作、电力中断、因政府管制而造成的暂时性关闭等影响网络正常经营的不可抗力而造成交易中断、延误的，甲、乙双方互不追究责任。甲、乙双方应在条件允许的情况下，采取一切必要的补救措施以减小不可抗力造成的损失。
        </div>
        <div class="content">
            3、甲方确认：在签署本协议书以前，乙方已就本协议的全部条款和内容向甲方进行了详细的说明和解释，甲方已认真阅读本协议有关条款，对有关条款不存在任何疑问或异议，并对协议双方的权利、义务、责任与风险有清楚和准确的理解。
        </div>
        <div class="font1 subtitle">
            九、争议解决
        </div>
        <div class="content">
            因本协议所引起的纠纷，双方应协商解决，协商不成的，任何一方可向乙方所在地的人民法院提起诉讼。
        </div>
    </div>

    <div class="Contract pos-r gzWrap">
        <div class="font1 subtitle">
            十、协议成立和生效
        </div>
        <div class="content">
            本协议通过团贷网平台电子协议签署的要求签署，适用《中华人民共和国电子签名法》的规定，本次We计划甲方点击“立即加入”后，可再次确认加入的金额、期限和预期收益等内容，确认无误后甲方即可点击“确认加入”，即视为甲方以电子签名的形式确认本协议成立。本协议自成立起生效，甲方同意接受本协议的全部约定及团贷网上与本协议相关的各项规则的规定。本协议一旦生效，即对甲、乙双方均具有法律约束力。
        </div>
        <table cellpadding="0" cellspacing="0" border="0" style="margin-top: 20px; width: 100%;">
            <tr>
                <td style="font-size: 0.28rem; width: 50%">甲方：<%= this.subBasicModel.RealName %></td>
                <td style="font-size: 0.28rem">乙方：<%=strCompanyName %></td>
            </tr>
            <tr>
                <td style="font-size: 15px;">日期：<em><%=this.model.OrderDate.Year.ToString() %></em>年<em><%=this.model.OrderDate.Month.ToString() %></em>月<em><%=this.model.OrderDate.Day.ToString() %></em>日</td>
                <td style="font-size: 15px;">日期：<em><%=this.model.OrderDate.Year.ToString() %></em>年<em><%=this.model.OrderDate.Month.ToString() %></em>月<em><%=this.model.OrderDate.Day.ToString() %></em>日</td>
            </tr>
        </table>
        <div class="Seal_zhuochen" style="background: url('<%=Sealt_TuanDai%>') center no-repeat"></div>
        <!--盖章-->
        <!--<div class="seal-con pos-a weplan-seal">
        <img src="images/hnstrz.png" alt=""/>
    </div>-->

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
