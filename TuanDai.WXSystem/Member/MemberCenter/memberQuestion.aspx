<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberSystemQuestion.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.memberSystemQuestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>帮助中心</title>
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f6f7f8">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="back" href="memberCenter.aspx">返回</a>
                <h1 class="title">帮助中心</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>

        <div class="questionLink bg-fff">
            <ul>
                <li>
                    <a href="memberSystemQuestion.aspx">
                        <div class="question-tit bb-e6e6e6 pl15 pt18 pb18 ques-tit">
                            <p class="c-212121 f17px">会员体系</p>
                            <i class="arrows-r1 rf"></i>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="tuanbiQuestion.aspx">
                        <div class="question-tit bb-e6e6e6 pl15 pb18 pt18 ques-tit">
                            <p class="c-212121 f17px">团币相关</p>
                            <i class="arrows-r1 rf"></i>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="productLotteryQuestion.aspx">
                        <div class="question-tit bb-e6e6e6 pl15 pt18 pb18 ques-tit">
                            <p class="c-212121 f17px">商品抽兑</p>
                            <i class="arrows-r1 rf"></i>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="supperMemberQuestion.aspx">
                        <div class="question-tit bb-e6e6e6 pl15 pb18 pt18 ques-tit">
                            <p class="c-212121 f17px">超级会员</p>
                            <i class="arrows-r1 rf"></i>
                        </div>
                    </a>
                </li>

                <div class="pt15 bg-f6f7f8"></div>
            </ul>
        </div>
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
</asp:Content>
