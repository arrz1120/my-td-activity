﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="growUpSystem.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.growUpSystem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <title>特权详情</title>
    <link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css?v=20161223001" />
    <body class="bg-fff">
        <%=GetNavStr() %>
        <div class="asset-top clearfix">
            <div class="lf w50p">
                <div class="asset-con cur" id="preMonth">
                    <p class="c-b3b3b3 text-center"><%=CurrYYMM %>月日均净资产</p>
                    <p class="text-center f18px pt5"><%=ToolStatus.ConvertLowerMoney(CurrAvgDailyAsset)  %></p>
                </div>
                <div class="asset-br"></div>
            </div>
            <div class="lf w50p">
                <div class="asset-con">
                    <p class="c-b3b3b3 text-center"><%=CurrYYMM -1 ==0?12:CurrYYMM-1 %>月日均净资产</p>
                    <p class="text-center f18px pt5"><%=ToolStatus.ConvertLowerMoney(PreAvgDailyAsset) %></p>
                </div>
            </div>
        </div>
        <div class="bt-e6e6e6"></div>

        <!--本月特权详情-->
        <div id="container1" onclick="JAVASCRIPT:window.location.href='/Member/MemberCenter/dailyAsset.aspx?tab=cur';">
            <div class="asset-link c-b3b3b3 pos-r">
                <% if (nextMonthLevel < 8)
                   {
                %>
            预估下月会员等级为V<%= nextMonthLevel %>，距离V<%= nextMonthLevel + 1 %>还差<%= ToolStatus.ConvertLowerMoney(nextLevelAsset - CurrAvgDailyAsset) %>元
            <%
               }
                   else
                   {
            %>
            预估下月会员等级为V8，本月日均资产为<%=ToolStatus.ConvertLowerMoney(CurrAvgDailyAsset) %>元
            <%
               }%>

                <div class="ico_arrow_abs"></div>
            </div>
        </div>
        <!--上月特权详情-->
        <div id="container2" style="display: none;" onclick="JAVASCRIPT:window.location.href='/Member/MemberCenter/dailyAsset.aspx?tab=pre';">
            <div class="asset-link c-b3b3b3 pos-r">
                <%=CurrYYMM -1 ==0?12:CurrYYMM-1 %>月日均净资产<%=ToolStatus.ConvertLowerMoney(PreAvgDailyAsset)  %>元，<%=CurrYYMM %>月会员等级为V<%=UserVipInfo.Level %>
                <div class="ico_arrow_abs"></div>
            </div>
        </div>

        <div id="detail">
            <div class="swiper-container" id="swiper-level">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="level-slide slide-first"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l11.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l1.png" /></div>
                        <div class="level-amo">0</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l22.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l2.png" /></div>
                        <div class="level-amo">1万</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l33.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l3.png" /></div>
                        <div class="level-amo">5万</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l44.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l4.png" /></div>
                        <div class="level-amo">10万</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l55.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l5.png" /></div>
                        <div class="level-amo">20万</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l66.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l6.png" /></div>
                        <div class="level-amo">50万</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l77.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l7.png" /></div>
                        <div class="level-amo">100万</div>
                    </div>
                    <div class="swiper-slide">
                        <div class="level-slide slide-last"></div>
                        <div class="levelImg1 level-img00">
                            <img src="/imgs/memberCenter/l88.png" /></div>
                        <div class="levelImg2 level-img01">
                            <img src="/imgs/memberCenter/l8.png" /></div>
                        <div class="level-amo">300万</div>
                    </div>
                </div>
            </div>

            <div class="linePoint"></div>

            <div class="tqBox pl10 pr10">
                <div class="clearfix">
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/tuanbixishuPrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">团币系数</p>
                            <p class="f12px c-b3b3b3">投资送团币</p>
                        </div>
                    </div>
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/tixianquanPrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">免费提现券</p>
                            <p class="f12px c-b3b3b3">每月赠送提现券</p>
                        </div>
                    </div>
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/jiekuandiscountPrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">借款费用减免</p>
                            <p class="f12px c-b3b3b3">资产标管理费优惠</p>
                        </div>
                    </div>
                </div>
                <div class="clearfix mt20">
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/birthdayPrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">生日红包</p>
                            <p class="f12px c-b3b3b3">生日送投资红包</p>
                        </div>
                    </div>
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/giftPrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="/imgs/memberCenter/5.png">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">节日贺礼</p>
                            <p class="f12px c-b3b3b3">传统佳节赠好礼</p>
                        </div>
                    </div>
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/customertelPrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="/imgs/memberCenter/6_6.png">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">贵宾客服专线</p>
                            <p class="f12px c-b3b3b3">专属客服热线</p>
                        </div>
                    </div>
                </div>
                <div class="clearfix mt20">
                    <div class="tq text-center pb40 lf" onclick="javascript:window.location.href='/Member/MemberCenter/Privilege/servicePrivilege.aspx';">
                        <div class="tq_center webkit-box box-center"></div>
                        <img src="/imgs/memberCenter/7_7.png">
                        <div class="tq_txt">
                            <p class="f15px c-4d4d4d">高级专属服务</p>
                            <p class="f12px c-b3b3b3">独享团贷专属服务</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--弹窗-->
        <div class="alert z-index1000 webkit-box box-center hide">
            <div class="alert-box pos-r bg-fff growup-con">
                <h3 class="f17px c-212121 pt30">升级规则</h3>
                <div class="pt30 pl25 pr25">
                    <p class="f15px text-left c-808080 pos-r bd-e6e6e6 pb15">团贷网每月1号会根据用户的上月日均净资产，将用户划分为8个不同的等级，不同等级的用户可享不同的特权。</p>
                </div>
                <div class="text-left c-ababab f15px pt15 pr25 gongshi">
                    <p class="pos-a c-ababab f15px">净资产 =</p>
                    账户余额+待收本息+待投资金+冻结资金-待还本息</div>
                <div class="text-left c-ababab f15px pt15 pb30 pl25 pr25">月日均资产为该自然月内每日净资产的平均值</div>
                <a href="javascript:;" class="bt-e6e6e6" id="knowBut">我知道了</a>
            </div>
        </div>



    </body>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var levelData = [
			//等级1
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span></p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="c-969696 tq_p2 pb15">¥3</p>',
				    imgSrc: '/imgs/memberCenter/2_2.png'
				},
				{
				    txtCon: '<p class="c-8a8a8a tq_p3 pb15">7折</p>',
				    imgSrc: '/imgs/memberCenter/3_3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="c-ffffff tq_p4 pb15">¥28</p>',
				    imgSrc: '/imgs/memberCenter/4_4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/5_5.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/6_6.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/7_7.png'
				},
			],
			//等级2
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.05</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥3</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
				{
				    txtCon: '<p class="tq_p3 c-8a8a8a pb15">7折</p>',
				    imgSrc: '/imgs/memberCenter/3_3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="c-ffffff tq_p4 pb15">¥28</p>',
				    imgSrc: '/imgs/memberCenter/4_4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/5_5.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/6_6.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/7_7.png'
				},
			],
			//等级3
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.1</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥5</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
			    {
			        txtCon: '<p class="tq_p3 c-8a8a8a pb15">7折</p>',
			        imgSrc: '/imgs/memberCenter/3_3.png',
			        tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
			    },
				{
				    txtCon: '<p class="tq_p3">¥18</p>',
				    imgSrc: '/imgs/memberCenter/4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/5_5.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/6_6.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/7_7.png'
				},
			],
			//等级4
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.15</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥8</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
				{
				    txtCon: '<p class="tq_p3 pb15">7折</p>',
				    imgSrc: '/imgs/memberCenter/3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="tq_p3">¥28</p>',
				    imgSrc: '/imgs/memberCenter/4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/5.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/6_6.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/7_7.png'
				},
			],
			//等级5
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.2</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥13</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
				{
				    txtCon: '<p class="tq_p3 pb15">6.5折</p>',
				    imgSrc: '/imgs/memberCenter/3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="tq_p3">¥48</p>',
				    imgSrc: '/imgs/memberCenter/4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/5.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/6.png'
				},
				{
				    txtCon: '',
				    imgSrc: '/imgs/memberCenter/7_7.png'
				},
			],
			//等级6
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.25</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥20</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
				{
				    txtCon: '<p class="tq_p3 pb15">5.5折</p>',
				    imgSrc: '/imgs/memberCenter/3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="tq_p3">¥68</p>',
				    imgSrc: '/imgs/memberCenter/4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/5.png'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/6.png'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/7_7.png'
				},
			],
			//等级7
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.3</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥30</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
				{
				    txtCon: '<p class="tq_p3 pb15">4.5折</p>',
				    imgSrc: '/imgs/memberCenter/3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="tq_p3">¥98</p>',
				    imgSrc: '/imgs/memberCenter/4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/5.png'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/6.png'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/7.png'
				},
			],
			//等级8
			[
				{
				    txtCon: '<p class="tq_p1 pb20"><span>1</span>.35</p>',
				    imgSrc: '/imgs/memberCenter/1.png'
				},
				{
				    txtCon: '<p class="tq_p2 pb15">¥60</p>',
				    imgSrc: '/imgs/memberCenter/2.png'
				},
				{
				    txtCon: '<p class="tq_p3 pb15">3.5折</p>',
				    imgSrc: '/imgs/memberCenter/3.png',
				    tq_txt: '<p class="f15px c-4d4d4d">借款费用减免</p><p class="f12px c-b3b3b3">资产标管理费优惠</p>'
				},
				{
				    txtCon: '<p class="tq_p3">¥128</p>',
				    imgSrc: '/imgs/memberCenter/4.png',
				    tq_txt: '<p class="f15px c-4d4d4d">生日红包</p><p class="f12px c-b3b3b3">生日送投资红包</p>'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/5.png'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/6.png'
				},
				{
				    txtCon: '<p></p>',
				    imgSrc: '/imgs/memberCenter/7.png'
				}
			]
            ]

            //我的等级
            var myLevel = parseInt("<%=UserVipInfo.Level%>");

            function initSwiper() {
                var swiper = new Swiper('#swiper-level', {
                    initialSlide: myLevel - 1,
                    slidesPerView: 'auto',
                    speed: 300,
                    centeredSlides: true,
                    onSlideChangeStart: function (swiper) {
                        slideCallback(swiper.activeIndex);
                    }
                });
            }

            //高亮显示我的等级已激活的特权
            function lightLevel() {
                var slide = $("#swiper-level").find(".swiper-slide");
                $("#swiper-level").find(".swiper-slide").each(function (i, item) {
                    if (myLevel < (i + 1)) {
                        $(item).find('.levelImg1').show();
                        $(item).find('.levelImg2').hide();
                    } else {
                        $(item).find('.levelImg1').hide();
                        $(item).find('.levelImg2').show();
                    }
                });
            }

            //显示每个等级对应的特权
            function slideCallback(index) {
                var tq = $(".tqBox").find(".tq");
                for (var i = 0; i < levelData[index].length; i++) {
                    tq.eq(i).find('.tq_center').html(levelData[index][i].txtCon);
                    tq.eq(i).find('img').attr('src', levelData[index][i].imgSrc);
                    if (levelData[index][i].tq_txt != undefined) {
                        tq.eq(i).find('.tq_txt').html(levelData[index][i].tq_txt);
                    }
                }
            }

            //本月上月特权详情切换
            function containerTab() {
                var assetCon = $(".asset-top").find(".asset-con");
                assetCon.each(function (i, item) {
                    $(item).click(function () {
                        if (i == 0) {
                            assetCon.eq(0).addClass('cur');
                            assetCon.eq(1).removeClass('cur');
                            $("#container1").show();
                            $("#container2").hide();
                            if (new Date().getDate() == 1) {
                                $("#container1").html('<div class="norecord"><img src="/imgs/memberCenter/norecord.png" alt="" /></div><div class="f15px c-b3b3b3 text-center mt15">暂无相关记录</div>');
                                $("#detail").hide();
                            }
                            window.location.href = '/Member/MemberCenter/growUpSystem.aspx?tab=cur';
                        } else {
                            assetCon.eq(0).removeClass('cur');
                            assetCon.eq(1).addClass('cur');
                            $("#container1").hide();
                            $("#container2").show();
                            $("#detail").show();
                            window.location.href = '/Member/MemberCenter/growUpSystem.aspx?tab=pre';
                        }
                    });
                });
            }

            containerTab();
            initSwiper();
            lightLevel();
            slideCallback(myLevel - 1);

            if (new Date().getDate() == 1 && $("#preMonth").hasClass("cur")) {
                $("#container1").html('<div class="norecord"><img src="/imgs/memberCenter/norecord.png" alt="" /></div><div class="f15px c-b3b3b3 text-center mt15">暂无相关记录</div>');
                $("#detail").hide();
            } else {
                $("#detail").show();
            }

            var tab = "<%=tab%>";
            if (tab == "cur") {
                var assetCon = $(".asset-top").find(".asset-con");
                assetCon.eq(0).addClass('cur');
                assetCon.eq(1).removeClass('cur');
                $("#container1").show();
                $("#container2").hide();
                if (new Date().getDate() == 1) {
                    $("#container1").html('<div class="norecord"><img src="/imgs/memberCenter/norecord.png" alt="" /></div><div class="f15px c-b3b3b3 text-center mt15">暂无相关记录</div>');
                    $("#detail").hide();
                }
            } else {
                var assetCon = $(".asset-top").find(".asset-con");
                assetCon.eq(0).removeClass('cur');
                assetCon.eq(1).addClass('cur');
                $("#container1").hide();
                $("#container2").show();
                $("#detail").show();
            }
        })
    </script>
</asp:Content>