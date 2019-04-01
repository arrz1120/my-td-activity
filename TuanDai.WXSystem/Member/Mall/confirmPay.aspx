﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="confirmPay.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.confirmPay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>订单支付</title>
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="pageReturn" href="productDetail.aspx?id=<%= productId %>"></a>
                <h1 class="title">订单支付</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <%if (this.VipProduct.SubType == 9 || this.VipProduct.SubType == 29) 
          {
              if (!string.IsNullOrEmpty(DefAddressId))
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
          <%} %>     

        <div class="bg-fff bb-e6e6e6 bt-e6e6e6">
            <div class="ml15 pr15 product pt15 bb-e6e6e6 pb15">
                <img src="<%=VipProduct.ImageUrl %>">
                <div class="product-d pos-a">
                    <p class="f15px c-212121"><%=VipProduct.ProductName %></p>
                    <p class="f13px c-808080"><%=ValueStr %></p>
                    <p class="f13px c-808080">数量：×<span class="f13px c-808080" id="s_num"><%=Num %></span></p>
                </div>
            </div>
            <div class="pt15 con_m">
                <div class="pos-r ml15 pb20 pr15 bb-e6e6e6">
                    <p class="f13px c-808080">购买数量</p>
                    <%if ((VipProduct.Type == 1 && VipProduct.SubType == 22) || (VipProduct.Type == 1 && VipProduct.SubType == 25)
                      || (VipProduct.Type == 1 && VipProduct.SubType == 28))   //22充值卡 25 流量包 28第三方虚拟商品
                      {%>
                    <div class="countBox">
                        <span class="minus_disable"></span>
                        <input disabled="disabled" type="tel" placeholder="输入数量" value="<%=Num %>" id="txtBuyNum">
                        <span class="add_disable"></span>
                    </div>
                    <%}
                      else
                      {%>
                    <div class="countBox">
                        <span class="minus"></span>
                        <input type="tel" placeholder="输入数量" value="<%=Num %>" id="txtBuyNum">
                        <span class="add"></span>
                    </div>
                    <%} %>
                </div>
            </div>

            <div class="bb-e6e6e6 ml15 pr15 remark pt15 pb15">
                <span class="f13px c-808080">订单备注</span>
                <input type="text" placeholder="选填，可填写您的其他需求" class="ml15 f13px" id="txtRemark">
                <a href="javascript:;" class="pos-a clear-beizhu hide" id="clearBeizhu"><i></i></a>
            </div>

            <div class="pos-r ml15 pr15 total  pt15 pb15">
                <span class="f13px c-808080">商品合计</span>
                <p class="c-fd6040 f30px pos-a"><span class="c-fd6040 f30px" id="s_totalValue"><%=PriceValue*Num %></span><span class="c-808080 f15px">团币</span></p>
            </div>
        </div>
        <a href="javascript:;" class="btn btnYellow pos-f pay-but" id="payBut">立即支付</a>

        <!--添加地址弹窗-->
        <div class="alert z-index1000 webkit-box box-center add-alert hide">
            <div class="add-alert-box">
                <img src="/imgs/member/mall/yx.png">
                <p class="f15px c-ffffff pt15">请填写收货地址</p>
            </div>
        </div>

        <!--兑换成功弹窗-->
        <div class="alert z-index1000 webkit-box box-center hide success">
            <div class="alert-box pos-r bg-fff">
                <img src="/imgs/member/mall/yes.png">
                <div class="text-center c-808080 f15px pb30 pl25 pr25">恭喜你，成功兑换<%=VipProduct.ProductName %>×<span class="f15px c-fab600">3</span>！请耐心等待系统为您配送～</div>
                <div class="clearfix bt-e6e6e6">
                    <div class="lf w50p br-e6e6e6">
                        <a class="btn c-808080 f17px br-e6e6e6" href="productList.aspx">查看其他商品</a>
                    </div>
                    <div class="rf w50p">
                        <a class="btn c-fab600 f17px" id="OrderDetail">查看订单</a>
                    </div>
                </div>
            </div>
        </div>
        <!--团币不足弹窗-->
        <div class="alert z-index1000 webkit-box box-center hide buzu">
            <div class="alert-box pos-r bg-fff">
                <div class="text-center c-808080 f15px pb30 pl25 pr25" style="height: 100px; padding: 20px;">您的账户还剩余<span class="f15px c-fab600">0</span>个团币，不足以购买本次商品，谢谢关注！</div>
                <div class="clearfix bt-e6e6e6">
                    <div class="lf w50p br-e6e6e6">
                        <a class="btn c-808080 f17px br-e6e6e6" href="productList.aspx">我知道了</a>
                    </div>
                    <div class="rf w50p">
                        <a class="btn c-fab600 f17px" id="toInvestList">投资赚团币</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/jsbridge.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var priceValue = "<%= PriceValue%>";
        var defAddrId = "<%= DefAddressId%>";
        var skuId = "<%= SkuId%>";
        var productId = "<%= productId%>";
        var telNo = "<%= DefTelNo%>";
        var subType = parseInt("<%= VipProduct.SubType%>");
        var isApp = "<%= IsInApp%>";
        //兑换成功弹窗方法
        function showAlert(id) {
            $("#OrderDetail").attr("href", "orderDetail.aspx?orderId=" + id);
            if (subType == 2 || subType == 3 || subType == 4 || subType == 13 || subType == 18) {
                if (isApp == "True") {
                    $(".success div div .rf a").html("查看团宝箱").click(function () {
                        Jsbridge.toAppTBX();
                    });
                } else {
                    $(".success div div .rf a").html("查看团宝箱").attr("href", "/Member/UserPrize/Index.aspx");
                }

            }
            if (subType == 8) {
                $(".success div div .rf a").html("查看超级会员").attr("href", "/Member/MemberCenter/memberCenter.aspx");
            }
            $(".alert .alert-box .text-center span").html($("#txtBuyNum").val());
            $(".success").removeClass('hide').bind("touchmove", function (e) {
                e.preventDefault();
            });
            $(".alert-box").removeClass('moveToBottom').addClass('moveFromBottom');
        }
        //显示团币不足
        function showBuAlert(num) {
            $(".alert .alert-box .text-center span").html(num);
            $(".buzu").removeClass('hide').bind("touchmove", function (e) {
                e.preventDefault();
            });
            $(".alert-box").removeClass('moveToBottom').addClass('moveFromBottom');
        }

        //显示弹窗
        function showError(msg, url) {
            $(".add-alert p").html(msg);
            $(".add-alert").removeClass('hide').bind("touchmove", function (e) {
                e.preventDefault();
            }).fadeIn(100);
            if (url)
                $(".add-alert").attr("dataurl", url);
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

        //减
        $(".countBox .minus").bind("click", function () {
            var buyNum = $("#txtBuyNum").val();
            if (buyNum == "")
                buyNum = 1;
            else
                buyNum = parseInt(buyNum);

            if (buyNum <= 1 || isNaN(buyNum))
                buyNum = 1;
            else
                buyNum = buyNum - 1;

            $("#txtBuyNum").val(buyNum);
            $("#s_num").html(buyNum);
            $("#s_totalValue").html(buyNum * parseInt(priceValue));
        });
        //加
        $(".countBox .add").bind("click", function () {
            var buyNum = $("#txtBuyNum").val();
            if (buyNum == "" || isNaN(parseInt(buyNum))) {
                buyNum = 1;
                $("#txtBuyNum").val(buyNum);
                return false;
            } else {
                buyNum = parseInt(buyNum);
                var limitNum = '<%=LimitNum%>';
                if (limitNum != '0' && buyNum >= parseInt(limitNum)) {
                    return false;
                }
            }

            buyNum = buyNum + 1;

            $("#txtBuyNum").val(buyNum);
            $("#s_num").html(buyNum);
            $("#s_totalValue").html(buyNum * parseInt(priceValue));
        });
        //数量blur
        $("#txtBuyNum").bind("blur", function () {
            var buyNum = $("#txtBuyNum").val();
            if (buyNum == "" || isNaN(parseInt(buyNum))) {
                buyNum = 1;
                $("#txtBuyNum").val(buyNum);
                $("#s_num").html(buyNum);
                $("#s_totalValue").html(buyNum * parseInt(priceValue));
                return false;
            }
            $("#s_num").html(buyNum);
            $("#s_totalValue").html(parseInt(buyNum) * parseInt(priceValue));
        });

        //数量限制
        $("#txtBuyNum").keyup(function () {
            var buyNum = $("#txtBuyNum").val();
            var limitNum = '<%=LimitNum%>';
            if (limitNum != '0' && parseInt(buyNum) >= parseInt(limitNum)) {
                $("#txtBuyNum").val(limitNum);
                return false;
            }
            if (parseInt(buyNum) == 0) {
                $("#txtBuyNum").val(1);
            }
        });

        //清空备注
        $(function () {
            $("#txtRemark").focus(function () {
                $("#clearBeizhu").show();
            });
            $('#clearBeizhu').click(function () {
                $("#txtRemark").val("");
                $(this).hide();
            });
        });
        //投资赚团币
        $("#toInvestList").click(function () {
            if (isApp == "True") {
                Jsbridge.toAppInvestList();
            } else {
                window.location.href = '/pages/invest/invest_list.aspx';
            }
        });
        //立即支付
        var click = true;
        $("#payBut").click(function () {
            if (!click) {
                return false;
            }
            click = false;
            var num = $("#txtBuyNum").val();
            if (parseInt(num) < 1)
                num = "1";
            $.ajax({
                type: 'post',
                url: "/ajaxCross/ajax_mall.ashx",
                data: { Cmd: "ExchangeSubmit", AddressId: defAddrId, productId: productId, SkuId: skuId, UserNote: $("#txtRemark").val(), Num: num, TelNo: telNo },
                dataType: 'json',
                success: function (data) {
                    click = true;
                    //--1保存成功,-1程序异常,-2会员信息不存在,-3团币不足,-4异动团币数据失败,-99未登录，-5商品信息不存在，-6收货地址不能为空
                    if (data.Status == -3) {//团币不足
                        showBuAlert(data.ValidTuanBi);
                    } else if (data.Status == 1) {
                        //购买成功
                        showAlert(data.ExchangeId);
                    } else if (data.Status == -99 || data.Status == -2) {//未登录
                        showError("您还未登录", "/user/login.aspx?ReturnUrl=" + window.location.href);
                    } else if (data.Status == -5) {//商品信息不存在
                        showError("您购买的商品不存在");
                    } else if (data.Status == -6) {//请填写收货地址
                        showError("您的收货地址为空");
                    } else if (data.Status == -4 || data.Status == -1) { //团币异动失败
                        showError("购买失败，请重试");
                    }
                    else if (data.Status == -8 || data.Status == -9 || data.Status == -11) {
                        showError(data.Msg);
                    }
                    else {
                        showError("购买失败，请重试");
                    }
                },
                error: function (a, b, c) {
                    click = true;
                    showError("购买失败，请重试");
                }
            });
        });
    </script>
</asp:Content>
