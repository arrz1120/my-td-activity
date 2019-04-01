﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberSystemQuestion.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.memberSystemQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>团币常见问题</title>
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f6f7f8">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="back" href="memberQuestion.aspx">返回</a>
                <h1 class="title">团币常见问题</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>

        <div class="questionWrap bg-fff">
            <ul>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ90"></i>什么是团币？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15">
                        <p class="c-808080 f15px text-justify">团币是团贷网推出的一种虚拟的激励性积分（即平台为用户设立的福利体系，并非契约型固定收益产品，平台有权对上述规则随时进行适当性调整），用户完成团币任务即可获得团贷网赠送的团币，持有团币的用户可以参与商品免费兑换、转盘抽奖等活动。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">如何赚取团币？</p>
                    </div>
                    <div class="question-txt bg-f6f7f8 bb-e6e6e6 pd15 hide">
                        <p class="c-808080 f15px text-justify">用户完成团币任务即可赚取团币，团币任务目前分为投资任务、日常任务、新手任务三种：</p>
                        <img src="/imgs/member/pic-q6.png?v=20170727001" class="pt15 pb15 block">
                        <p class="c-808080 f15px text-justify">备注：投资赚团币，系统会按计息时所在的会员等级取团币系数计算团币；会员等级未更新，系统会等待等级更新后再计算；团币通常在计息1小时内发放至用户账号。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">通过投资赚取的团币如何发放？</p>
                    </div>
                    <div class="question-txt bg-f6f7f8 bb-e6e6e6 pd15 hide">
                        <p class="c-808080 f15px text-justify">用户在团贷网参与投资（债权转让标除外）均可赚取团币，其中加息奖励部分、团币小数部分不计算。团币按照投资期限平均分摊至每月发放，若该笔投资提前退出，则退出后剩余未发放的团币不再继续发放。</p>
                        <img src="/imgs/member/grantTuanbi.png?v=20170712" class="pt15 pb15 block">                     
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>通过投资赚取的团币会计算小数部分么？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">为方便展示和使用团币，团币小数部分忽略不计。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">如何查询我的团币？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">登录后，在APP发现-会员中心可查看您的团币数量，点击团币数量即可查看您的团币收支明细。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>团币可以转让、兑现吗？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">团币不可以转让，不可以兑换人民币。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">团币可以无限期使用吗？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">团币自赚取或获赠之日起至其次年12月31日内使用有效，未在有效期内使用的团币将自动作废。例如2016年4月15日获赠而未被使用的团币，将会在2017年12月31日后作废。</p>
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
            });
        });
    </script>
</asp:Content>