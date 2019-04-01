<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customertelPrivilege.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.Privilege.customertelPrivilege" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>贵宾客服专线</title>
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="pageReturn" href="/Member/MemberCenter/MemberCenter.aspx"></a>
                <h1 class="title">贵宾客服专线</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <section class="privMain">
            <div class="imgBox">
                <img src="/imgs/member/priv2.png?v=20170531001"></div>
            <div class="bt-e6e6e6 bb-e6e6e6 nav-box">
                <div class="clearfix nav ">
                    <div class="lf">
                        <p class="f17px c-808080 p-pri"><%=vipInfo.Level >=5 ?"已获得特权":"未获得特权" %></p>
                    </div>
                    <div class="rf btn-pri c-ababab f13px">我的等级<span class="ml5 c-212121 f17px">V<%= vipInfo.Level%></span></div>
                </div>
            </div>

            <div class="pl15 pr15 mt10 bg-fff pb20 bb-e6e6e6 bt-e6e6e6">
                <p class="f17px c-212121 pt15">特权说明</p>
                <p class="f13px c-808080 pt10 pb20">拨打1010-1218客服热线，可享专属贵宾服务。</p>
                <div class="bm-table">
                    <table class="">
                        <tbody>
                            <tr>
                                <th class="bb-e6e6e6 br-e6e6e6-before">会员等级</th>
                                <th class="bb-e6e6e6">特权</th>
                            </tr>
                            <tr class="bg-fff">
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V1.png" /></td>
                                <td class="bb-e6e6e6">无</td>
                            </tr>
                            <tr>
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V2.png" /></td>
                                <td class="bb-e6e6e6">无</td>
                            </tr>
                            <tr class="bg-fff">
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V3.png" /></td>
                                <td class="bb-e6e6e6">无</td>
                            </tr>
                            <tr>
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V4.png" /></td>
                                <td class="bb-e6e6e6">无</td>
                            </tr>
                            <tr class="bg-fff">
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V5.png" /></td>
                                <td class="bb-e6e6e6">有</td>
                            </tr>
                            <tr>
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V6.png" /></td>
                                <td class="bb-e6e6e6">有</td>
                            </tr>
                            <tr class="bg-fff">
                                <td class="bb-e6e6e6 br-e6e6e6-before">
                                    <img src="/imgs/images/V7.png" /></td>
                                <td class="bb-e6e6e6">有</td>
                            </tr>
                            <tr>
                                <td class="br-e6e6e6-before">
                                    <img src="/imgs/images/V8.png" /></td>
                                <td class="">有</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </section>
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
</asp:Content>
