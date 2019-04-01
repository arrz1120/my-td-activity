<%@ Page Language="C#" AutoEventWireup="true" CodeFile="missionDetail.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.missionDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>任务详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/missionDetail.css" />
    <!--任务详情-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body>
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header">
                <div class="back" onclick="javascript:history.go(-1);">返回</div>
                <h1 class="title">任务详情</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>

        <div class="missionDetail">
            <section id="xinshou" name="xinshou">
                <div class="title">
                    新手任务
                </div>
                <div class="table">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr class="th">
                            <td class="tdL">任务</td>
                            <td class="tdR">分值</td>
                        </tr>
                        <tr>
                            <td class="tdL">首次实名认证成功</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr class="bgGray">
                            <td class="tdL">首次绑定手机</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr>
                            <td class="tdL">首次绑定银行卡</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr class="bgGray">
                            <td class="tdL">首次修改交易密码</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr>
                            <td class="tdL">首次完善所有个人资料</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr class="bgGray">
                            <td class="tdL">首次成功充值</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr class="trLast">
                            <td style="border-bottom: none;" class="tdL">首次设置自动投标并成功投资</td>
                            <td style="border-bottom: none;" class="tdR">100分</td>
                        </tr>
                    </table>
                </div>
            </section>
            <section id="richang" name="richang">
                <div class="title">
                    日常任务
                </div>
                <div class="table">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr class="th">
                            <td class="tdL">任务</td>
                            <td class="tdR">分值</td>
                        </tr>
                        <tr>
                            <td class="tdL">团贷官网每日首次登录</td>
                            <td class="tdR">10分</td>
                        </tr>
                        <tr class="bgGray">
                            <td class="tdL">团贷APP签到</td>
                            <td class="tdR">10分</td>
                        </tr>
                        <tr>
                            <td class="tdL">成功推荐好友并且好友累计投资1000元以上</td>
                            <td class="tdR">100分</td>
                        </tr>
                        <tr class="bgGray">
                            <td style="border-bottom: none;" class="tdL">成功购买一个月的VIP</td>
                            <td style="border-bottom: none;" class="tdR">100分</td>
                        </tr>
                    </table>
                </div>
            </section>
        </div>
        <!--end-->


    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript">
        function getTager(tager) {
            $('html,body').animate({ scrollTop: $(tager).offset().top - 20 }, 250);
            return false;
        }
    </script>
</asp:Content>
