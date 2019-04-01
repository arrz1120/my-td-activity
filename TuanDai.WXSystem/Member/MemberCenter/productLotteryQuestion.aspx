﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberSystemQuestion.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.memberSystemQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>商品兑换常见问题</title>
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f6f7f8">
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <div class="back" onclick="javascript:history.go(-1);">返回</div>
                <h1 class="title">商品兑换常见问题</h1>
            </div>
            <div class="none"></div>
        </header>

        <div class="questionWrap bg-fff">
            <ul>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ90"></i>使用团币可以兑换哪些商品？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15">
                        <p class="c-808080 f15px text-justify">团币可兑换的商品分实物商品和虚拟商品两种，其中实物商品以市场热售商品为主，如电饭煲、移动电源等，虚拟商品主要为团贷网内部提供的投资红包、提现抵扣券、超级会员等商品。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">如何查看我兑换过的或获赠的商品？</p>
                    </div>
                    <div class="question-txt bg-f6f7f8 bb-e6e6e6 pd15 hide">
                        <p class="c-808080 f15px text-justify">登录后，前往APP-我-我的会员-会员商城，点击【我的商品】，即可查询您兑换过或获赠的商品明细。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>如何查看团币抽奖的中奖纪录？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">登录后，用户可在团贷个人中心团宝箱中查看到自己抽中的团贷内部虚拟商品，其他实物商品或外部虚拟商品（如电影票等）可在团贷会员>个人中心>我的商品中查看。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">我兑换或抽中的商品什么时候发货？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">团贷内部虚拟商品（如投资红包等）一般即时发货，其他实物商品或外部虚拟商品（如电影票等）一般在订单提交后的3～5个工作日内发货。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>商品下单后，久未发货，怎么办？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">商品下单后久未发货，有可能是商品缺货需要采购，您可以主动联系客服了解相关进度。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">没有我喜欢的商品，怎么办？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">用户没找到自己喜欢的商品时，可以在团贷会员首页下方的许愿池板块提交您想要的商品，或前往团贷社区团贷会员板块留言，我们会定期收集用户的反馈，采购并上架关注度较高的商品。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">我兑换或抽中的商品有发票提供吗？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">团币兑换商品或团币抽奖并非现金买卖商品，而是团贷网为答谢用户所提供的回馈服务，不提供发票。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">商品存在质量问题，我该如何处理？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">除商品在运送途中发生损毁或本身存在质量瑕疵以外，恕不允许退货或换货。符合退换货条件的用户， 请在商品签收后及时与客服联系退换货。残次商品寄回时，请务必保留原包装、内附说明书及相关文件。</p>
                    </div>
                </li>

                <div class="pt15 bg-f6f7f8"></div>
            </ul>
        </div>


    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript">
        $(function () {

            $(".questionWrap").find('li').click(function () {
                var box = $(this).find('.question-txt');
                var ico = $(this).find('.icon-triagle-r');
                if (box.hasClass('hide')) {
                    if (ico.hasClass('rotateZ90')) {
                        ico.removeClass('rotateZ90').addClass('rotateZ0');
                    } else {
                        ico.removeClass('rotateZ0').addClass('rotateZ90');
                    }
                    box.removeClass('hide');
                } else {
                    if (ico.hasClass('rotateZ90')) {
                        ico.removeClass('rotateZ90').addClass('rotateZ0');
                    } else {
                        ico.removeClass('rotateZ0').addClass('rotateZ90');
                    }
                    box.addClass('hide');
                }
            })
        });
    </script>
</asp:Content>