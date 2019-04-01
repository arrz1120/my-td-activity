﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="allTask.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.allTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>全部任务</title>
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <div class="pageReturn" onclick="javascript:window.location.href='mallindex.aspx';"></div>
                <h1 class="title">全部任务</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <h3 class="pl15 c-808080 f15px pt10 pb8">投资任务</h3>

        <div class="bg-fff bb-e6e6e6 bt-e6e6e6" id="invest">
            <div class="ml15 pr15 pt15 pb15 pos-r">
                <div class="bg-ffcf1f circle-th task-con-l pt10">
                    <span class="alltask-sprite task1"></span>
                </div>
                <div class="pos-a task-con">
                    <p>投资赚团币<span class="ico ml10" id="showPop"></span></p>
                    <p>投资指定标的即可赚取团币</p>
                </div>
            </div>
        </div>

        <h3 class="pl15 c-808080 f15px pt10 pb8">日常任务</h3>
        <div class="bg-fff bb-e6e6e6 bt-e6e6e6" onclick="javascript:window.location.href='http://hd.tuandai.com/weixin/Invite/InviteIndex.aspx';">
            <div class="ml15 pr15 pt15 pb15 pos-r">
                <div class="bg-5fe15d circle-th task-con-l">
                    <span class="alltask-sprite task2"></span>
                </div>
                <div class="pos-a task-con">
                    <p>邀请好友投资</p>
                    <p>邀请1名好友注册并投资团贷网</p>
                </div>
                <span class="pos-a task-con-r c-fab600">+100团币</span>
            </div>
        </div>

        <h3 class="pl15 c-808080 f15px pt10 pb8">新手任务</h3>
        <div class="bg-fff bb-e6e6e6 bt-e6e6e6 mb20">
            <div class="bb-e6e6e6 ml15 pr15 pt15 pb15 personal">
                <div class="bg-4ac6ff circle-th task-con-l pt15">
                    <span class="alltask-sprite task3"></span>
                </div>
                <div class="pos-a task-con">
                    <p>实名认证</p>
                    <p>完成实名认证，保证投资合法权益</p>
                </div>
                <% if (IsRealName)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

            <div class="bb-e6e6e6 ml15 pr15 pt15 pb15 personal">
                <div class="bg-fe787d circle-th task-con-l">
                    <span class="alltask-sprite task4"></span>
                </div>
                <div class="pos-a task-con">
                    <p>绑定手机</p>
                    <p>完成手机绑定，提升投资服务体验</p>
                </div>
                <% if (IsBindPhone)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

            <div class="bb-e6e6e6 ml15 pr15 pt15 pb15 bandCard">
                <div class="bg-fe787d circle-th task-con-l pt15">
                    <span class="alltask-sprite task10"></span>
                </div>
                <div class="pos-a task-con">
                    <p>绑定银行卡</p>
                    <p>绑定银行卡，资金提现快人一步</p>
                </div>
                <% if (IsBindBankCard)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

            <div class="bb-e6e6e6 ml15 pr15 pt15 pb15 personal">
                <div class="bg-ffcf1f circle-th task-con-l">
                    <span class="alltask-sprite task6"></span>
                </div>
                <div class="pos-a task-con">
                    <p>设置交易密码</p>
                    <p>设置交易密码，保障资金安全</p>
                </div>
                <% if (IsSetPayPassword)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

            <div class="bb-e6e6e6 ml15 pr15 pt15 pb15 nopersonal">
                <div class="bg-4ac6ff circle-th task-con-l">
                    <span class="alltask-sprite task7"></span>
                </div>
                <div class="pos-a task-con">
                    <p>完善个人信息</p>
                    <p>完善个人信息</p>
                </div>
                <% if (IsFinishPersonal)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

            <div class="bb-e6e6e6 ml15 pr15 pt15 pb15 recharge">
                <div class="bg-ffcf1f circle-th task-con-l pt15">
                    <span class="alltask-sprite task8"></span>
                </div>
                <div class="pos-a task-con">
                    <p>首次充值</p>
                    <p>充值才能进行投资哦！</p>
                </div>
                <% if (IsRecharge)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

            <div class="ml15 pr15 pt15 pb15 pos-r setAuto">
                <div class="bg-ffcf1f circle-th task-con-l">
                    <span class="alltask-sprite task9"></span>
                </div>
                <div class="pos-a task-con">
                    <p>首次自动投标</p>
                    <p>开启自动投标并投资成功</p>
                </div>
                <% if (IsSetAuto)
                   {
                %>
                <span class="pos-a task-con-r c-808080">已完成</span>
                <%
               }
                   else
                   {
                %>
                <span class="pos-a task-con-r c-fab600">+10团币</span>
                <%
               } %>
            </div>

        </div>

        <!--弹窗-->
        <div class="alert z-index1000 webkit-box box-center showAlert" style="display: none;">
            <div class="alert-box pos-r bg-fff alltask-con">
                <div class="text-center c-808080 f15px pb30 pt30 pl25 pr25">
                    投资小微企业、微团贷、分期宝、供应链、项目宝B均可赚取团币，用户等级越高可赚取的团币越多
                </div>
                <a href="javascript:;" class="bt-e6e6e6 closeAlert">我知道了</a>
            </div>
        </div>

    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/jsbridge.js?<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var isApp = "<%=IsApp%>";
        $(function () {
            $("#invest").bind("click", function () {
                if (isApp == "True") {
                    Jsbridge.toAppInvestList();
                } else {
                    window.location.href = '/pages/invest/invest_list.aspx';
                }

            });
            $("#showPop").click(function (e) {
                ShowAlert('投资小微企业、微团贷、分期宝、供应链、项目宝B均可赚取团币，用户等级越高可赚取的团币越多');
                e.stopPropagation();
            });

            $(".closeAlert").click(function () {
                $(".showAlert").fadeOut();
            });
            function ShowAlert(msg) {
                $(".showAlert div div").html(msg);
                $(".showAlert").fadeIn();
            }

            $(".personal").bind("click", function () {
                var des = $(this).find(".task-con-r").html();
                if (des == "已完成") {
                    ShowAlert("已完成验证");
                } else {
                    if (isApp == "True") {
                        Jsbridge.toAppSecurityCenter();
                    } else {
                        window.location.href = "/Member/my_userdetailinfo.aspx#safe";
                    }

                }
            });
            $(".bandCard").bind("click", function () { //绑卡
                var des = $(this).find(".task-con-r").html();
                if (des == "已完成") {
                    ShowAlert("已完成");
                } else {
                    if (isApp == "True") {
                        Jsbridge.toAppSecurityCenter();
                    } else {
                        window.location.href = "/Member/Bank/recharge_bindCardagreement.html?v=20160420001";
                    }

                }
            });
            $(".nopersonal").bind("click", function () {//完善详细资料
                var des = $(this).find(".task-con-r").html();
                if (des == "已完成") {
                    ShowAlert("已完成验证");
                } else {
                    if (isApp == "True") {
                        Jsbridge.toAppPersonalCenter();
                    } else {
                        window.location.href = "/Member/my_userdetailinfo.aspx";
                    }

                }
            });
            $(".recharge").bind("click", function () {
                var des = $(this).find(".task-con-r").html();
                if (des == "已完成") {
                    ShowAlert("已完成充值");
                } else {
                    if (isApp == "True") {
                        Jsbridge.toAppRecharge();
                    } else {
                        window.location.href = "/Member/Bank/Recharge.aspx";
                    }
                }
            });
            $(".setAuto").bind("click", function () {
                var des = $(this).find(".task-con-r").html();
                if (des == "已完成") {
                    ShowAlert("已完成");
                } else {
                    if (isApp == "True") {
                        Jsbridge.toAppAutoBid();
                    } else {
                        window.location.href = "/Member/setAuto/auto_invest.aspx";
                    }
                }
            });
        });
    </script>
</asp:Content>