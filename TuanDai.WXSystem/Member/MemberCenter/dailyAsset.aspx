﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dailyAsset.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.dailyAsset" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>日均净资产</title>
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f6f7f8">
        <div class="asset-t clearfix pl15 pr15">
            <p class="lf"><%=tab=="cur"?CurrYYMM:CurrYYMM-1==0?12:CurrYYMM-1 %>月日均净产值 <a href="javascript:;" class="ico-question" id="show_jzc">
                <img src="/imgs/member/ico-question.png" alt=""></a></p>
            <p class="rf"><%=tab=="cur"?ToolStatus.ConvertLowerMoney(CurrAvgDailyAsset):ToolStatus.ConvertLowerMoney(PreAvgDailyAsset) %></p>
        </div>

        <div class="bg-fff">
            <%=GetNavStr() %>
            <div class="bb-e6e6e6" style="display: none;">
                <div class="ml15 asset-con" id="thelist">
                    <%--<div class="bb-e6e6e6">
				<p>2016－07－31</p>
				<p class="pos-a">9,000.00</p>
			</div>
			<div class="bb-e6e6e6">
				<p>2016－07－30</p>
				<p class="pos-a">10,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－29</p>
				<p class="pos-a">10,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－28</p>
				<p class="pos-a">9,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－27</p>
				<p class="pos-a">9,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－26</p>
				<p class="pos-a">9,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－25</p>
				<p class="pos-a">9,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－24</p>
				<p class="pos-a">9,000.00</p>
			</div>

			<div class="bb-e6e6e6">
				<p>2016－07－24</p>
				<p class="pos-a">9,000.00</p>
			</div>--%>
                </div>
            </div>
        </div>


        <!--数据尚未更新的时候显示-->
        <div class="text-center no-update bg-f6f7f8" style="display: none;">
            <img src="/imgs/member/pic-asset2.png" alt="">
            <p class="f15px pt15">暂无相关记录</p>
        </div>

        <div class="text-center pt15 pb13 bg-fff" id="btn" style="display: none;">
            <!--这里有两种状态、查看全部和收起-->
            <a class="c-f2bf24 f15px" id="btnPart" style="display: none">收起</a>
            <a class="c-f2bf24 f15px" id="btnAll">查看全部记录</a>
        </div>

        <!--净值产说明 弹窗-->
        <div class="alert z-index1000 webkit-box box-center" id="jzc_ans" style="display: none;">
            <div class="alert-box pos-r bg-fff jzc-con comonAni">
                <div class="pt30 pl25 pr25">
                    <p class="f15px text-left c-808080 pos-r">日均净资产为该月内每日净资产的平均值</p>
                </div>
                <div class="text-left c-ababab f15px pt15 pr25 gongshi pb30">
                    <p class="pos-a c-ababab f15px">净资产 =</p>
                    账户余额+待收本息+冻结资金-待还本息</div>
                <a href="javascript:;" class="bt-e6e6e6" id="knowBut">我知道了</a>
            </div>
        </div>
    </body>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript">


        $(function () {
            $("#show_jzc").click(function () {
                showAniFadeIn("#jzc_ans");
                disableScrolling();
            });

            $("#knowBut").click(function () {
                hideAniFadeOut("#jzc_ans");
                enableScrolling();
            });

            //加载数据
            function LoadData(flag) {
                $("#list").html("");
                $.ajax({
                    type: "get",
                    dataType: "json",
                    url: "/ajaxCross/ajax_mall.ashx",
                    data: { Cmd: "GetDailyAsset", flag: flag },
                    success: function (jsonData) {
                        if (jsonData && jsonData.length > 0) {
                            var i = 0;
                            $(jsonData).each(function (ind, item) {
                                var css = 'row hide';
                                if (i < 8)
                                    css = "";
                                var row = '<div class="bb-e6e6e6 ' + css + '">' +
                                    '<p>' + item.ReportDate.substring(0, 10) + '</p>' +
                                    '<p class="pos-a">' + addCommas(item.NetAssets) + '</p>' +
                                    '</div>';
                                $("#thelist").append(row);
                                i++;
                            });

                            $(".no-update").hide();//切换时去掉
                            $("#thelist").parent().show();
                            if (i >= 8)
                                $("#btn").show();
                            else {
                                $("#btn").hide();
                            }
                        } else {
                            $(".no-update").show();//切换时去掉
                            $("#btn").hide();
                            $("#thelist").parent().hide();
                        }
                    }, error: function () {
                        $(".no-update").show();//切换时去掉
                        $("#btn").hide();
                        $("#thelist").parent().hide();
                    }
                });
            }

            var tab = "<%= tab%>";
            LoadData(tab);

            $("#btnAll").click(function () {
                $(this).hide();
                $("#btnPart").show();
                $(".row").removeClass("hide");
            });
            $("#btnPart").click(function () {
                $(this).hide();
                $("#btnAll").show();
                $(".row").addClass("hide");
            });
        });
        //每三位隔开数字
        function addCommas(nStr) {
            nStr += '';
            var x = nStr.split('.');
            var x1 = x[0];
            var x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }
        //弹窗阻止滚动
        function scrolling(e) {
            preventDefault(e);
        }

        function preventDefault(e) {
            e = e || window.event;
            if (e.preventDefault) {
                e.preventDefault();
            }
            e.returnValue = false;
        }

        function disableScrolling() {
            if (window.addEventListener) {
                window.addEventListener('DOMMouseScroll', scrolling, false);
                window.addEventListener('touchmove', scrolling, false);
                window.onmousewheel = document.onmousewheel = scrolling;
            }
        }

        function enableScrolling() {
            if (window.removeEventListener) {
                window.removeEventListener('DOMMouseScroll', scrolling, false);
                window.removeEventListener('touchmove', scrolling, false);
            }
            window.onmousewheel = document.onmousewheel = null;
        }


    </script>
</asp:Content>
