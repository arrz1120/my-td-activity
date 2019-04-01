﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addrList.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.addrList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>收货地址</title>
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="pageReturn" href="<%= GoBackUrl%>"></a>
                <h1 class="title">收货地址</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <div style="margin-bottom: 45px;">
            <% if (Alist != null && Alist.Count > 0)
               {
                   foreach (var addr in Alist)
                   {
            %>
            <div class="bb-e6e6e6 bt-e6e6e6 bg-fff mb10">
                <div class="ml15 pr15 pt15 pb15 bb-e6e6e6 addrdiv" addrid="<%=addr.Id %>">
                    <p class="f15px c-212121"><%=addr.ShipTo %>　<span class="f15px c-212121"><%=addr.CellPhone %></span></p>
                    <p class="f13px c-212121 pt10">
                        <%=bll.GetPrivinceById(Convert.ToString(addr.Privince)) +
                                   bll.GetCityById(Convert.ToString(addr.City)) +
                                   bll.GetAreaById(Convert.ToString(addr.Area))+addr.Address %>
                    </p>
                </div>
                <div class="pos-r pl15 pr15 pt15 pb15">
                    <p class="f13px c-808080"><span class="setDefault" attrid="<%=addr.Id %>"><span class="default-add <%=addr.IsDefault?"":"default-set" %> mr10"></span><%= addr.IsDefault?"默认地址":"设为默认"%></span></p>
                    <div class="pos-a operation-but">
                        <a href="addAddr.aspx?actionType=2&backurl=<%= GetEncodeBackUrl()%>&addrid=<%=addr.Id %>" class="edit f13px c-808080"><i></i>编辑</a>
                        <a class="del ml15 f13px c-808080" attrid="<%=addr.Id %>"><i></i>删除</a>
                    </div>
                </div>
            </div>
            <%
       }
   } %>
        </div>
        <a href="addAddr.aspx?actionType=1&backurl=<%= backurlstring %>" class="btn btnYellow pos-f add-address" id="addAddress"><i></i>新增地址</a>
        <!--添加地址弹窗-->
        <div class="alert z-index1000 webkit-box box-center add-alert hide">
            <div class="add-alert-box">
                <img src="/imgs/member/mall/yx.png">
                <p class="f15px c-ffffff pt15">请填写收货地址</p>
            </div>
        </div>
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js"></script>
    <script type="text/javascript">
        //显示弹窗
        function showError(msg, url, imgUrl) {
            $(".add-alert p").html(msg);
            $(".add-alert").removeClass('hide').bind("touchmove", function (e) {
                e.preventDefault();
            });
            if (url)
                $(".add-alert").attr("dataurl", url);
            if (imgUrl)
                $(".add-alert img").attr("src", imgUrl);
            setTimeout(function () {
                $(".add-alert").addClass('hide');
                if (url)
                    window.location.href = url;
            }, 2000);
        }
        //关闭弹窗
        $(".add-alert img").bind("click", function () {
            $(".add-alert").addClass('hide');
            var url = $(".add-alert").attr("dataurl");
            if (url && url.length > 0)
                window.location.href = url;
        });
        //选择地址
        $(".addrdiv").bind("click", function () {
            var id = $(this).attr("addrid");
            showError("选择地址成功", "<%=Regex.Replace(GoBackUrl,@"addrid=[^&]*&?",string.Empty) %>&addrid=" + id, "/imgs/images/ico-success.png");
        });
        //设置默认
        $(".setDefault").click(function () {
            if ($(this).children().hasClass("default-set")) {
                var attrid = $(this).attr("attrid");
                $.ajax({
                    url: "/ajaxCross/ajax_mall.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "SetDefault", id: attrid },
                    success: function (jsonData) {
                        if (parseInt(jsonData.Status) == 1) {
                            showError("设置成功", "<%= GoBackUrl%>", "/imgs/images/ico-success.png");
                    } else {
                        showError("设置失败，请重试");
                    }
                }, error: function () {

                }
            });
        }
    });
    //删除
    $(".del").click(function () {
        var attrid = $(this).attr("attrid");
        $("body").showMessage({
            message: "确定删除该地址吗？", okbtnEvent: function () {
                $("#divPopTips").fadeOut(300);
                $.ajax({
                    url: "/ajaxCross/ajax_mall.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "DeleteAddr", id: attrid },
                    success: function (jsonData) {
                        if (parseInt(jsonData.Status) == 1) {
                            showError('删除成功', window.location.href, "/imgs/images/ico-success.png");
                        } else {
                            showError("删除失败，请重试");
                        }
                    }, error: function () {

                    }
                });
            }
        });
    });
    </script>
</asp:Content>
