<%@ Page Language="C#" AutoEventWireup="true" CodeFile="receive.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.receive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>领取商品</title>
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="pageReturn" href="myProduct.aspx"></a>
                <h1 class="title">领取商品</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <% if (!string.IsNullOrEmpty(DefAddressId))
           {
        %>
        <a href="addrList.aspx?backurl=<%=GetEncodeBackUrl() %>">
            <div class="address-box bg-fff pl15 pr40 pb13 pos-r">
                <div class="d pt8 pos-r">
                    <p class="f15px c-212121"><span class="id-icon"></span><%= DefName %><span class="f15px c-212121 ml20"><%= DefTelNo %></span></p>
                </div>
                <div class="add pt8 pos-r pl25">
                    <span class="add-icon"></span>
                    <p class="f13px c-212121 line-h20"><%= DefAddress %> </p>
                </div>
                <span class="arrow-r pos-a"></span>
            </div>
        </a>
        <% }
           else
           {
        %>
        <!--当默认没有地址的时候 显示添加地址-->
        <div class="bg-fff text-center pt30 pb30" style="height: 20px; line-height: 20px;">
            <a href="addAddr.aspx?actionType=1&backurl=<%=GetEncodeBackUrl() %>" style="display: block; margin-top: -3%;"><span class="addadd-ico"></span><span class="c-212121 f15px">添加新地址</span></a>
        </div>
        <%
       } %>


        <div class="order-line"></div>
        <div class="bg-fff bb-e6e6e6 bt-e6e6e6">
            <div class="mt10 ml15 pr15 product pt15 bb-e6e6e6 pb25">
                <img src="<%=VipProduct.ImageUrl %>">
                <div class="product-d pos-a">
                    <p class="f15px c-212121"><%=VipProduct.ProductName %></p>
                    <p class="f13px c-808080"><%=ValueStr %></p>
                    <p class="f13px c-808080">数量：×<span class="f13px c-808080" id="s_num"><%=Num %></span></p>
                </div>
            </div>
            <div class="bb-e6e6e6 ml15 pr15 remark pt15 pb15">
                <span class="f13px c-808080">订单备注</span>
                <input type="text" placeholder="选填，可填写您的其他需求" class="ml15 f13px" id="txtRemark">
            </div>
        </div>
        <a href="javascript:;" class="btn btnYellow pos-f pay-but" id="payBut">立即领取</a>

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
    <script type="text/javascript">
        var priceValue = "<%= PriceValue%>";
        var defAddrId = "<%= DefAddressId%>";
        var telNo = "<%= DefTelNo%>";

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


        //立即领取
        $("#payBut").click(function () {
            if (defAddrId) {
                $.ajax({
                    type: "post",
                    url: "/ajaxCross/ajax_mall.ashx",
                    dataType: "json",
                    data: { Cmd: "ReceivePrize", id: "<%= OrderId%>", userName: "<%=DefName%>", telNo: "<%= DefTelNo %>", address: "<%= DefAddress %>", Message: $("#txtRemark").val() },
                    success: function (jsonData) {
                        if (parseInt(jsonData.Status) == 1) {
                            showError("领取成功", "myProduct.aspx", "/imgs/images/ico-success.png");
                        } else {
                            showError(jsonData.Msg);
                        }
                    },
                    error: function () {
                        showError("服务器繁忙，请重试");
                    }
                });
            } else {
                showError("没有添加地址");
            }
        });
    </script>
</asp:Content>
