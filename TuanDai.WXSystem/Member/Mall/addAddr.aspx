<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addAddr.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.addAddr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title><%=actionType=="1"?"新建":"修改" %>收货地址</title>
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <div class="indexPage">
            <%= this.GetNavStr()%>
            <header class="headerMain">
                <div class="header bb-e6e6e6">
                    <div class="pageReturn" onclick="javascript:history.go(-1);"></div>
                    <h1 class="title"><%=actionType=="1"?"新建":"修改" %>收货地址</h1>
                </div>
                <%= this.GetNavIcon()%>
                <div class="none"></div>
            </header>

            <div class="bb-e6e6e6 bt-e6e6e6 bg-fff add-data">
                <div class="ml15  pr15 pt15 pb15 bb-e6e6e6">
                    <span class="pos-a">收货人</span>
                    <input type="text" id="txtName" placeholder="收货人姓名" />
                </div>

                <div class="ml15 pr15 pt15 pb15 bb-e6e6e6">
                    <span class="pos-a">手机号码</span>
                    <input type="tel" id="txtTelNo" placeholder="请输入手机号码" />
                </div>

                <div class="ml15 pr15 pt15 pb15 bb-e6e6e6" id="placeSelect">
                    <span class="pos-a">所在地区</span>
                    <span id="selectedPlace" class="selectedPlace">请选择</span>
                    <span class="ico_arrow_r3 pos-a"></span>
                </div>

                <div class="ml15 pr15 pt15 pb15 bb-e6e6e6">
                    <span class="pos-a">详细地址</span>
                    <input type="text" placeholder="街道、楼牌号等" id="txtAddress" />
                </div>

                <%--<div class="ml15 pr15 pt15 pb15 pos-r clearfix ">
                <span class="pos-a">设为默认地址</span>
                <div class="states rf">
                    <input type="checkbox" class="switch" name="time3" id="time3">
                    <label for="time3"></label>
                </div>
            </div>--%>
            </div>

        </div>


        <!--省选择-->
        <div class="z-index1000 provinceBox hide">
            <div class="header bb-e6e6e6 pos-r">
                <div class="pageReturn" id="province-close"></div>
                <h1 class="title">选择省份</h1>
            </div>
            <div class="placelist-box pos-r">
                <div class="provinceList">
                    <ul>
                        <% if (Addrlist != null && Addrlist.Count > 0)
                           {
                               foreach (var addr in Addrlist)
                               {
                        %>
                        <li class="bb-e6e6e6" proid="<%=addr.ProId %>"><%=addr.ProName %></li>
                        <%
                               }
                           }%>
                    </ul>
                </div>
            </div>
        </div>
        <!--市选择-->
        <div class="z-index1000 cityBox hide">
            <div class="header bb-e6e6e6 pos-r">
                <div class="pageReturn" id="city-close"></div>
                <h1 class="title">选择城市</h1>
            </div>
            <div class="placelist-box pos-r">
                <div class="cityList">
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
        <!--区域选择-->
        <div class="z-index1000 areaBox hide">
            <div class="header bb-e6e6e6 pos-r">
                <div class="pageReturn" id="area-close"></div>
                <h1 class="title">选择区（县）</h1>
            </div>
            <div class="placelist-box pos-r">
                <div class="areaList">
                    <ul>
                        <li class="bb-e6e6e6">广州市</li>
                    </ul>
                </div>
            </div>
        </div>
        <a href="javascript:;" class="btn btnYellow pos-f add-address" id="saveBut">保存并使用</a>

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

        $(function () {
            var provinceId = 0;
            var cityId = 0;
            var areaId = 0;
            var actionType = "<%= actionType%>";
            var addrid = "<%= addressId%>";
            var tempProId = 0;
            var tempCityId = 0;
            var tempAreaId = 0;
            var proStr = "";
            var cityStr = "";
            var areaStr = "";
            if (addrid != "" && actionType == "2") {
                $.ajax({
                    url: "/ajaxCross/ajax_mall.ashx",
                    type: "get",
                    async: false,
                    data: { Cmd: "GetAddress", addrid: addrid },
                    dataType: "json",
                    success: function (jsonData) {
                        if (jsonData.Id) {
                            $("#txtName").val(jsonData.ShipTo);
                            $("#txtTelNo").val(jsonData.CellPhone);
                            $("#selectedPlace").html(jsonData.TelPhone);
                            $("#txtAddress").val(jsonData.Address);
                            provinceId = jsonData.Privince;
                            cityId = jsonData.City;
                            areaId = jsonData.Area;
                        } else {
                            showError("编辑出错", "<%= GoBackUrl%>");
                        return false;
                    }
                },
                error: function () { }
            });
        }
            //省市选择弹框
            function moveToLeft(ele) {
                $(ele).removeClass('moveToRight').removeClass('hide').addClass('moveToLeft');
            }
            function moveToRight(ele) {
                $(ele).removeClass('moveToLeft').addClass('moveToRight');
                setTimeout(function () {
                    $(ele).addClass('hide');
                }, 300);
            }

            var place = "";
            function setPlace() {
                if (place != "") {
                    $("#selectedPlace").removeClass('c-ababab').addClass('c-212121').html(place);
                    place = "";
                    provinceId = tempProId;
                    cityId = tempCityId;
                    areaId = tempAreaId;
                }
            }

            //显示省的选择
            $("#placeSelect").click(function () {
                moveToLeft(".provinceBox");
                setTimeout(function () {
                    $(".indexPage").addClass('hide');
                }, 300);
                place = "";
            });
            //隐藏省的选择
            $("#province-close").click(function () {
                $(".indexPage").removeClass('hide');
                moveToRight(".provinceBox");
            });

            //选择省份后
            $(".provinceBox").find('li').click(function () {
                proStr = $(this).html();
                tempProId = $(this).attr("proid");
                $.ajax({
                    url: "/ajaxCross/ajax_mall.ashx",
                    type: "get",
                    async: false,
                    data: { Cmd: "GetCityList", proid: tempProId },
                    dataType: "json",
                    success: function (jsonData) {
                        $(".cityList ul").html("");
                        if (parseInt(jsonData.Status) == 1) {
                            $(jsonData.addrList).each(function (index, item) {
                                $(".cityList ul").append('<li proid="' + item.ProId + '" class="bb-e6e6e6">' + item.ProName + '</li>');
                            });
                        }

                        //选择市后
                        $(".cityBox .cityList ul li").bind("click", function () {
                            cityStr = $(this).html();
                            tempCityId = $(this).attr("proid");
                            $.ajax({
                                url: "/ajaxCross/ajax_mall.ashx",
                                type: "get",
                                async: false,
                                data: { Cmd: "GetAreaList", proid: tempCityId },
                                dataType: "json",
                                success: function (jsonData) {
                                    $(".areaList ul").html("");
                                    if (parseInt(jsonData.Status) == 1) {
                                        $(jsonData.addrList).each(function (index, item) {
                                            $(".areaList ul").append('<li proid="' + item.ProId + '" class="bb-e6e6e6">' + item.ProName + '</li>');
                                        });
                                    }

                                    //选择区域后
                                    $(".areaBox").find('li').click(function () {
                                        areaStr = $(this).html();
                                        tempAreaId = $(this).attr("proid");
                                        $(".indexPage").removeClass('hide');
                                        moveToRight(".areaBox");
                                        place = proStr + cityStr + areaStr;
                                        setPlace();
                                    });
                                },
                                error: function () {

                                }
                            });
                            moveToLeft(".areaBox");
                            $(".indexPage").removeClass('hide');
                            moveToRight(".cityBox");
                        });
                    },
                    error: function () {

                    }
                });
                moveToLeft(".cityBox");
                setTimeout(function () {
                    $(".provinceBox").addClass('hide');
                }, 300);
            });


            //隐藏市
            $('#city-close').click(function () {
                $(".indexPage").removeClass('hide');
                moveToRight(".cityBox");
                moveToLeft(".provinceBox");
            });

            //隐藏区域
            $('#area-close').click(function () {
                $(".indexPage").removeClass('hide');
                moveToRight(".areaBox");
                moveToLeft(".cityBox");
            });
            //保存
            $("#saveBut").click(function () {
                var name = $("#txtName").val();
                if (name.trim().length <= 0) {
                    showError("收货人不能为空");
                    return false;
                }
                var tel = $("#txtTelNo").val();
                if (tel.trim().length <= 0) {
                    showError("手机号码不能为空");
                    return false;
                }
                var phoneRegex = /^(?:13\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
                if (!phoneRegex.test(tel)) {
                    showError("手机号码格式不正确");
                    return false;
                }

                var selectedPlace = $("#selectedPlace").html();
                if (selectedPlace == "请选择") {
                    showError("所在区域选择有误");
                    return false;
                }
                var address = $("#txtAddress").val();
                if (address.trim().length <= 0) {
                    showError("详细地址不能为空");
                    return false;
                }
                if (actionType == "1") {//添加地址
                    $.ajax({
                        url: "/ajaxCross/ajax_mall.ashx",
                        type: "post",
                        async: false,
                        data: { Cmd: "AddAddr", name: name, phone: tel, province: provinceId, city: cityId, area: areaId, address: address },
                        dataType: "json",
                        success: function (jsonData) {
                            var status = parseInt(jsonData.Status);
                            if (status == 1) {
                                showError("地址添加成功", "<%= GoBackUrl%>", "/imgs/images/ico-success.png");
                            return false;
                        } else if (status == -99) {
                            showError(jsonData.Msg);
                            return false;
                        } else {
                            showError(jsonData.Msg);
                            return false;
                        }
                    },
                    error: function () { }
                });
            } else { //修改地址
                $.ajax({
                    url: "/ajaxCross/ajax_mall.ashx",
                    type: "post",
                    async: false,
                    data: { Cmd: "UpdateAddr", id: addrid, name: name, phone: tel, province: provinceId, city: cityId, area: areaId, address: address },
                    dataType: "json",
                    success: function (jsonData) {
                        var status = parseInt(jsonData.Status);
                        if (status == 1) {
                            showError("地址修改成功", "<%= GoBackUrl%>", "/imgs/images/ico-success.png");
                            return false;
                        } else if (status == -99) {
                            showError(jsonData.Msg);
                            return false;
                        } else {
                            showError(jsonData.Msg);
                            return false;
                        }
                    },
                    error: function () { }
                });
            }

        });
        });


    </script>
</asp:Content>
