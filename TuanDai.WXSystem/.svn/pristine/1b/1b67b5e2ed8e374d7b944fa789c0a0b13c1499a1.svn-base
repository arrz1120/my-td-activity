<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberSystemQuestion.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.memberSystemQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>超级会员常见问题</title>
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f6f7f8">
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <div class="back" onclick="javascript:history.go(-1);">返回</div>
                <h1 class="title">超级会员常见问题</h1>
            </div>
            <div class="none"></div>
        </header>

        <div class="questionWrap bg-fff">
            <ul>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ90"></i>超级会员与普通会员有什么区别？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15">
                        <p class="c-808080 f15px text-justify">超级会员可享受普通会员无法享受到权利，如0.05%提现手续费率，提现手续费200元封顶、自动投标比普通会员优先等。详见：<a href="../upgradeaccount.aspx" class="f15px">查看详情</a></p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">如何成为超级会员？</p>
                    </div>
                    <div class="question-txt bg-f6f7f8 bb-e6e6e6 pd15 hide">
                        <p class="c-808080 f15px text-justify">目前成为团贷网超级会员有三种方式，第一种：在手机App签到的宝箱中有机会获得超级会员；第二种：使用团币兑换超级会员；第三种：使用可用余额直接购买超级会员。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
                        <p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>如何查询自己的超级会员记录？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">用户可以前往团贷网官网(电脑版)，登录后在我的账户-个人设置-超级会员查询相关记录。</p>
                    </div>
                </li>
                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">超级会员提现手续费是多少？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">用户提现时是超级会员的，每笔提现的手续费为提现金额的0.05%,200元封顶；提现时是普通会员每笔提现的手续费为提现金额的0.15%，不封顶。</p>
                    </div>
                </li>

                <li>
                    <div class="question-tit bb-e6e6e6 pl15 pb18 pt18">
                        <i class="icon-triagle-r rotateZ0 lf mt6"></i>
                        <p class="c-212121 f17px pl20 pr15 text-justify">投标时是超级会员，会员到期后该标还能享有超级会员权利吗？</p>
                    </div>
                    <div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15 hide">
                        <p class="c-808080 f15px text-justify">如您在投标时会员状态为超级会员，则在您投的这个标存续期间，您在这个标上都享受超级会员待遇，包括逾期保利，优先赔付等。 即使您的超级会员已经到期，您依旧可以享受如上的超级会员待遇（提现优惠除外）。当然，如您在投标时的状态为普通会员，您无法享受超级会员的待遇。</p>
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
