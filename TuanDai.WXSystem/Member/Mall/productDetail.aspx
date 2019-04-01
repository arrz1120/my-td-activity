﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="productDetail.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.productDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>商品详情</title>
    <link rel="stylesheet" type="text/css" href="/css/list2.css?v=20160406001" />
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=20170424001" />
    <style type="text/css">
        .noClick {
            background: rgb(244,244,244);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5 pb52">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <a class="pageReturn" href="productList.aspx"></a>
                <h1 class="title">商品详情</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>

        <div class="goods-banner">
            <%if (this.LeastLevel > 1)
              {%>
            <div class="zhuanxiang">V<%=this.LeastLevel %>以上专享</div>
            <%} %>
            <img src="<%=VipProduct.ImageUrl %>" />
            <div class="banner-split"></div>
            <%-- 特价状态--%>
            <%if (BuyingProduct != null && BuyingProduct.IsJoin.HasValue && BuyingProduct.IsJoin.Value && BuyingProduct.BuyingEndDate > DateTime.Now)
              {%>
            <div class="detailActivity">
                <div class="clearfix">
                    <div class="lf pl10 pt20">
                        <i class="ico_pai1"></i><span class="f30px c-ffffff"><%=BuyingProduct.BuyingPrice %></span>
                    </div>
                    <div class="rf pt12 pr20">
                        <div class="normalPrice f12px">
                            <i class="ico_pai2"></i><%=CurrSkuPriceValue %>
                            <div class="priceLine"></div>
                        </div>
                        <div class="exchangePeople f11px mt3" id="stock">仅剩<%=VipProduct.ProductValues.FirstOrDefault().Stock %>件</div>
                    </div>
                </div>
                <%if (BuyingProduct.BuyingStartDate < DateTime.Now)
                  {%>
                <div class="detail-time detail-time-start pt5">
                    <p class="c-b55e00 f12px">距结束仅剩</p>
                    <p class="c-b55e00 f12px">
                        <span class="c-b55e00 f13px" id="hour"><%=LeftHour %></span>:<span class="c-b55e00 f13px" id="minute"><%=LeftMinute %></span>:<span class="c-b55e00 f13px" id="second"><%=LeftSecond %></span>
                    </p>
                </div>
                <%}
                  else
                  {%>
                <div class="detail-time detail-time-notstart pt5">
                    <p class="c-626262 f12px">距开始还有</p>
                    <p class="c-626262 f12px">
                        <span class="c-727272 f13px" id="hour"><%=LeftHour %></span>:<span class="c-727272 f13px" id="minute"><%=LeftMinute %></span>:<span class="c-727272 f13px" id="second"><%=LeftSecond %></span>
                    </p>
                </div>
                <%} %>
            </div>
            <%} %>
        </div>

        <%-- 没加入特价状态--%>
        <%if (!(BuyingProduct != null && BuyingProduct.IsJoin.HasValue && BuyingProduct.IsJoin.Value && BuyingProduct.BuyingEndDate > DateTime.Now))
          {%>
        <div class="pt15 pl15 pr15 pb10 clearfix bg-fff">
            <div class="lf c-fd6040 f35px"><%= VipProduct.PriceValue %><span class="f17px c-ababab ml5">团币</span></div>
            <div class="rf c-ababab f17px pt5">
                库存<span class="c-fd6040 f17px">
                    <%=VipProduct.ProductValues.FirstOrDefault().Stock>0?VipProduct.ProductValues.FirstOrDefault().Stock:0 %></span>件
            </div>
            <!--<div class="rf c-808080 f35px"><i class="ico-m2 mr5"></i><%=VipProduct.SaleCounts %></div>-->
        </div>
        <%}%>

        <%if (VipProduct.SubType == 27 && VipProduct.Type == 1)
          {%>
        <div class="pl15 pb10 bg-fff">
            <label style="color: red; display: block" class="f14px">加息特权只能购买一次(包括不同面额)</label></div>
        <%}%>
        <div class="bt-e6e6e6 bb-e6e6e6 bg-fff pl15 pr15 pt20 pb20">
            <p class="c-808080 f13px">商品名称</p>
            <p class="c-212121 f15px"><%=VipProduct.ProductName %></p>
            <p class="c-808080 f13px pt20">商品简介</p>
            <p class="c-212121 f15px text-justify"><%=VipProduct.ShortDescription %></p>
        </div>

        <div class="pt15 pb15 bg-fafafa">
            <div class="webkit-box">
                <div class="box-flex1 c-ababab f12px text-center"><i class="ico-c1"></i>100%正品</div>
                <div class="box-flex1 c-ababab f12px text-center"><i class="ico-c1"></i>免运费</div>
                <div class="box-flex1 c-ababab f12px text-center"><i class="ico-c1"></i>售后保障</div>
                <%if (VipProduct.Type == 1 && VipProduct.SubType == 27)  //1218加息特权特别处理
                  {%>
                <div class="box-flex1 c-ababab f12px text-center"><i class="ico-c1"></i>即时发货</div>
                <%}
                  else
                  {%>
                <div class="box-flex1 c-ababab f12px text-center"><i class="ico-c1"></i>3～5天发货</div>
                <%} %>
            </div>
        </div>

        <div class="mt10 bg-fff pos-r bt-e6e6e6 bb-e6e6e6 click-respond" onclick="javascript:window.location.href='SaleRecord.aspx?productid=<%=VipProduct.Id %>';">
            <a href="javascript:void(0);" class="block pt10 pb10 pl15 f15px">兑换记录</a>
            <span class="f15px c-808080 ex_record"><%=VipProduct.SaleCounts %></span>
            <i class="ico-arrow-r"></i>
        </div>

        <div class="mt10 bg-fff bt-e6e6e6 bb-e6e6e6 pd15 productDetail">
            <p class="c-808080 f13px">商品详情</p>
            <%=this.VipProduct.Description %>
        </div>

        <!--灰色样式：  btnGray ： 商品已下架  -->
        <% if (VipProduct.Upselling && VipProduct.ProductValues.FirstOrDefault().Stock > 0)
           {
               if ((IsExchangeHF && VipProduct.Type == 1 && VipProduct.SubType == 22))
               {%>
        <div class="btn btnGray pos-f" id="buyNow1" style="bottom: 0;">立即购买</div>
        <%}
           else if ((IsExchangeFlow && VipProduct.Type == 1 && VipProduct.SubType == 25))
           {%>
        <div class="btn btnGray pos-f" id="buyNow1" style="bottom: 0;">立即购买</div>
        <%}
           else
           {%>
        <div class="btn btnYellow pos-f" id="buyNow1" style="bottom: 0;">立即购买</div>
        <%}
       }
           else
           {
        %>
        <div class="btn btnGray pos-f" style="bottom: 0;">商品已售罄</div>
        <%
       }%>


        <div class="alert hide z-index1000">
            <div class="alert-con">
                <div class="con_t bb-e6e6e6">
                    <div class="con_t_img">
                        <img src="<%=VipProduct.BigImageUrl %>" /></div>
                    <div class="con_t_name"><%=VipProduct.ShortDescription %></div>
                    <div class="clearfix">
                        <%if (BuyingProduct != null && BuyingProduct.IsJoin.HasValue && BuyingProduct.IsJoin.Value && BuyingProduct.BuyingEndDate > DateTime.Now && BuyingProduct.BuyingStartDate < DateTime.Now)
                          {%>
                        <div class="c-fd6040 pt8 f17px lf" id="maxPriceValue"><%=BuyingProduct.BuyingPrice %><span class="f13px c-ababab ml5">团币</span></div>
                        <%}
                          else
                          {%>
                        <div class="c-fd6040 pt8 f17px lf" id="maxPriceValue"><%=CurrSkuPriceValue %><span class="f13px c-ababab ml5">团币</span></div>
                        <%}%>
                        <div class="rf c-ababab f13px pt10">
                            库存<span class="f13px c-fd6040">
                                <%=this.VipProduct.ProductValues.FirstOrDefault().Stock>0?this.VipProduct.ProductValues.FirstOrDefault().Stock:0 %></span></span>件
                        </div>
                    </div>
                    <div class="close"></div>
                </div>
                <div class="con_m">
                    <% if (Attrs != null && Attrs.Count > 0)
                       {
                           foreach (var a in Attrs)
                           {
                           
                    %>
                    <p class="c-808080 pl15 pt10 pb10"><%=a.Key.Value %></p>
                    <ul class="color_select clearfix pl10 pr10" datavalue="<%=a.Key.Value %>">
                        <% foreach (var v in a.Value)
                           {
                        %>
                        <li attribueid="<%=a.Key.Key %>" valueid="<%=v.ValueId %>" id="<%=v.ValueId %>"><%=v.ValueStr %></li>
                        <%
                           
                       }
                        %>
                    </ul>
                    <%
                       }
                   } %>

                    <div class="mt5 pos-r pb20">
                        <%if (IsJoinBuying && BuyingProduct.BuyingStartDate > DateTime.Now)
                          {%>
                        <p class="c-808080 pl15 pt3">购买数量（<label class="c-fd6040">仅能以原始价格购买</label>）</p>
                        <%}
                          else
                          {%>
                        <p class="c-808080 pl15 pt3">购买数量</p>
                        <%}%>

                        <%if ((VipProduct.Type == 1 && VipProduct.SubType == 22) || (VipProduct.Type == 1 && VipProduct.SubType == 25) || (VipProduct.Type == 1 && VipProduct.SubType == 28))
                          {%>
                        <div class="countBox">
                            <span class="minus_disable"></span>
                            <input disabled="disabled" type="tel" placeholder="购买数量" value="1" id="txtBuyNum" />
                            <span class="add_disable"></span>
                        </div>
                        <%}
                          else
                          {%>
                        <div class="countBox">
                            <span class="minus"></span>
                            <input type="tel" placeholder="购买数量" value="1" id="txtBuyNum" />
                            <span class="add"></span>
                        </div>
                        <%} %>
                    </div>
                    <%if ((VipProduct.Type == 1 && VipProduct.SubType == 22 && IsExchangeHF))
                      { %>
                    <div class="btn btnGray" id="buyNow2">立即购买</div>
                    <%}
                      else if ((VipProduct.Type == 1 && VipProduct.SubType == 25 && IsExchangeFlow))
                      { %>
                    <div class="btn btnGray" id="buyNow2">立即购买</div>
                    <%}
                      else
                      { %>
                    <div class="btn btnYellow" id="buyNow2">立即购买</div>
                    <%}%>
                </div>
            </div>
        </div>

        <div class="watchImg webkit-box box-center hide">
            <p class="f15px"><span class="c-212121 f19px">1/</span>1</p>
            <img src="" />
        </div>

    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=20160420001"></script>
    <script type="text/javascript">
        var AttributesJsonData = <%=this.AttributesJson%>;
        $(".con_m").find('li').css('width', ($(window).width() - 50) / 3);

        function moveFromBottom() {
            $(".alert").removeClass('hide');
            $(".alert-con").removeClass('moveToBottom').addClass('moveFromBottom');
        }
        function moveToBottom() {
            $(".alert-con").removeClass('moveFromBottom').addClass('moveToBottom');
            setTimeout(function () {
                $(".alert").addClass('hide');
            }, 300);
        }

        $("#buyNow1").click(function () {
            if(!$(this).hasClass("btnGray")){
                moveFromBottom();
            }
        });
        $(".alert").click(function () {
            moveToBottom();
        });
        $(".alert-con").click(function () {
            return false;
        });
        $(".close").click(function () {
            moveToBottom();
        });

        $(".goods-banner").click(function () {
            var watchImg = $(".watchImg");
            watchImg.find('img').attr('src', $(this).find('img').attr('src'));
            watchImg.removeClass('hide');
        });
        $(".watchImg").click(function() {
            $(this).addClass('hide');
        });

        //选择商品属性
        $(".con_m ul li").click(function() {
            if($(this).hasClass("noClick")) return false;
            $(this).parent().find("li").removeClass("selected");
            $(this).addClass("selected");
            var valueId = $(this).attr("valueId");
            LoadPrice();
            if ($(this).hasClass("selected"))
            {
                //var arrayObj = new Array();
                //循环找出SKU
                var arraySku = new Array();
                $(AttributesJsonData).each(function (index, item) {
                    if (item.ValueId == valueId) {
                        arraySku.push(item.SkuId);
                        //skuIds+=item.SkuId+","
                        //$("#" + valueId).addClass("unenable-sec");
                    }
                });
                var arrayValue = new Array();
                //循环找出ValueId
                $(arraySku).each(function (skuindex, skuitem) {
                    $(AttributesJsonData).each(function (index, item) {
                        if (skuitem == item.SkuId) {
                            if ($.inArray(item.ValueId, arrayValue) == -1) {
                                arrayValue.push(item.ValueId);
                            }
                        }
                    });
                });
                var _currAttrubuteId = $(this).attr("attribueId");

                //找出不可选的valueId
                var _currentUnableSec = $(".noClick");
            
                var arrayUnEnable = new Array();
            
                $(_currentUnableSec).each(function (index, element) {
                    if ($(element).hasClass("noClick") && $.inArray($(element).attr("valueId"), arrayValue)==-1) {
                        arrayUnEnable.push($(element).attr("valueId"));
                    }
                });
            
                //设置成全都不可点击
                $(".con_m ul li").each(function (index, element) {
                    if ($(element).attr("attribueId") != _currAttrubuteId)
                    {
                        $(this).addClass("noClick");
                    }
                });

                $(arrayValue).each(function (index, item)
                {
                    $("#" + item).removeClass("noClick");
                });
                //添加原来不可用元素actionbtn
                $(arrayUnEnable).each(function (index, item) {
                
                    if($.inArray($("#"+item).attr("valueId"), arrayValue)!=-1){
                        $("#" + item).addClass("noClick");
                    }
                  
                });
                LoadPrice();
            }
        });
        var skuId = "<%= VipProduct.SkuId%>";
        LoadPrice();
        //获取已选商品属性对应的价格
        function LoadPrice() {
            var li = $(".con_m ul li");
            var maxPrice = 0;
            var temp = [];//选中属性对应的AttributesJsonData
            var tempi = 0;//有几个被选中的属性
            $(li).each(function(index, item) {
                if ($(item).hasClass("selected")) {
                    tempi ++;
                    var attribueId = $(item).attr("attribueId");
                    var valueId = $(item).attr("valueId");
                    $(AttributesJsonData).each(function(ind,data) {
                        if (data.AttributeId == attribueId && data.ValueId == valueId) {
                            temp.push(data);
                        }
                    });
                }
            });
            if (temp.length > 0) {
                var curri = 0;
                $(temp).each(function(ind,item) {
                    curri =0;
                    $(temp).each(function(indx, ite) {
                        if (item.SkuId == ite.SkuId) {
                            curri++;
                            if (curri == tempi) {
                                maxPrice = ite.PriceValue;
                                skuId = ite.SkuId;
                            }
                        }
                    });
                });
            }
            if(maxPrice >0)
                $("#maxPriceValue").html(maxPrice+'<span class="f13px c-ababab ml5">团币</span>');
        }

        //alert(skuId);
        //减
        $(".countBox .minus").bind("click", function() {
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
        });
        //加
        $(".countBox .add").bind("click", function() {
            var buyNum = $("#txtBuyNum").val();
            if (buyNum == "" || isNaN(parseInt(buyNum))) {
                buyNum = 1;
                $("#txtBuyNum").val(buyNum);
                return false;
            } else {
                var limitNum='<%=LimitNum%>';
            if(limitNum != '0'&&parseInt(buyNum)>=parseInt(limitNum)){                               
                return false;
            }               
        }
           
        buyNum =parseInt(buyNum) + 1;

        $("#txtBuyNum").val(buyNum);
    });
    
    //数量blur
    $("#txtBuyNum").bind("blur", function() {
        var buyNum = $("#txtBuyNum").val();
        if (buyNum == "" || isNaN(parseInt(buyNum))) {
            buyNum = 1;
            $("#txtBuyNum").val(buyNum);
            return false;
        }        
    });
    //数量限制
    $("#txtBuyNum").keyup(function(){
        var buyNum = $("#txtBuyNum").val();
        var limitNum='<%=LimitNum%>';
        if(limitNum != '0'&&parseInt(buyNum)>=parseInt(limitNum)){
            $("#txtBuyNum").val(limitNum);
            return false;
        }
        if(parseInt(buyNum)==0){
            $("#txtBuyNum").val(1);
        }
    });
    //立即购买跳转
    $("#buyNow2").bind("click", function() {
        var isError = false;
        var value = "";
        var ul = $(".con_m ul");
        if (ul.length > 0) {
            $(ul).each(function(index, item) {
                var flag = false;
                $(item.children).each(function(ind, it) {
                    if ($(it).hasClass("selected")) {
                        flag = true;
                    }
                });
                if (!flag) {
                    value = $(item).attr("dataValue");
                    isError = true;
                    return;
                }
            });
        }
        if (isError) {
            $("body").showMessage({showCancel:false,okString:"好的",message:value+"未选择"});
            //alert(value+"未选择");
            return false;
        }
        window.location.href = "ConfirmPay.aspx?skuid="+skuId+"&num="+parseInt($("#txtBuyNum").val())+"&productid=<%= VipProduct.Id%>";
    });
    
    //去掉商品详情的换行符
    $(function(){
        var br = $(".productDetail").find('br').remove();
    })

    //倒计时
    function pad(n) {
        return (n < 10 ? '0' : '') + n;
    }

    function time(target_time, hourId, minuteId, secondId) {
        target_time = new Date(target_time);
        var $hour = $(hourId),
            $minute = $(minuteId),
            $second = $(secondId);

        getCountdown();

        var timeout = setInterval(function () {
            getCountdown();
        }, 1000);

        function getCountdown() {
            var now_time = new Date().getTime();
            var left_time = (target_time - now_time) / 1000;
            if (left_time <= 0) {
                window.location.reload();
                return;
            }
            //left_time = left_time % 86400;
            hours = pad(parseInt(left_time / 3600));
            left_time = left_time % 3600;
            minutes = pad(parseInt(left_time / 60));
            seconds = pad(parseInt(left_time % 60));	        

            $hour.html(hours);
            $minute.html(minutes);
            $second.html(seconds);
        }
    }

    <%if (BuyingProduct != null && BuyingProduct.IsJoin.HasValue && BuyingProduct.IsJoin.Value && BuyingProduct.BuyingEndDate > DateTime.Now)
      {
          if (BuyingProduct.BuyingStartDate > DateTime.Now)
          {%>
        time('<%=BuyingProduct.BuyingStartDate%>',"#hour","#minute","#second");
    <%}
          else
          {%>
        time('<%=BuyingProduct.BuyingEndDate%>',"#hour","#minute","#second");
        <%}
      }%>   
    </script>
</asp:Content>