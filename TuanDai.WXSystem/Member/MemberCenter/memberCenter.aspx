﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="memberCenter.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.memberCenter" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>会员中心</title>
    <link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/myMerber.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-fff">
        <%=GetNavStr() %>
        <div class="m_banner pos-r">
            <div class="m_b_con webkit-box">
                <div class="m_b_l box-flex1" onclick="javascript:window.location.href='/Member/MemberCenter/growUpSystem.aspx?tab=pre';">
                    <p class="m_b_p1 c-4d4d4d f18px"><i class="ico_b1"></i>V<%=vipInfo.Level %></p>
                    <p class="m_b_p2 pt5"><a href="javascript:void(0);" class="c-b3b3b3">会员等级<i class="ico_arrow_inline"></i></a></p>
                </div>
                <div class="m_b_m pos-a">
                    <img src="<%=string.IsNullOrEmpty(vipInfo.HeadImage)?"/imgs/bav_head.gif":vipInfo.HeadImage %>" />
                </div>
                <div class="m_b_r box-flex1" onclick="javascript:window.location.href='/member/mall/tuanbiDetail.aspx';">
                    <p class="m_b_p1 c-4d4d4d f18px"><%=vipInfo.ValidTuanBi %><i class="ico_b2"></i></p>
                    <p class="m_b_p2 c-b3b3b3 pt5"><a href="javascript:void(0);" class="c-b3b3b3">我的团币<i class="ico_arrow_inline"></i></a></p>
                </div>
            </div>
            <div class="f15px c-4d4d4d text-center pt17 mt20"><%=string.IsNullOrEmpty(vipInfo.NickName)?vipInfo.UserName:vipInfo.NickName %></div>
        </div>
        <div class="pt10 bg-f6f7f8"></div>

        <div class="clearfix m_nav">
            <div class="w50p lf m_n_item br-e6e6e6" onclick="JAVASCRIPT:window.location.href='/Member/upgradeaccount.aspx<%=IsInApp?"?type=mobileapp":"" %>';">
                <span>
                    <img src="/imgs/memberCenter/ico1.png" /></span>
                <p class="f15px c-4d4d4d">超级会员</p>
                <p class="c-b3b3b3 pt3"><%=IsSuper?LevelEndDate+"到期":"尚未成为超级会员" %></p>
            </div>
            <div class="w50p lf m_n_item" onclick="javascript:window.location.href='/member/mall/mallindex.aspx';">
                <span>
                    <img src="/imgs/memberCenter/ico2.png" /></span>
                <p class="f15px c-4d4d4d">会员商城</p>
                <p class="c-b3b3b3 pt3">团币兑换红包等</p>
            </div>
        </div>
        <div class="pt10 bg-f6f7f8"></div>

        <div class="pl15 pr15 pt15 clearfix">
            <div class="lf">
                <%if (DateTime.Now.Day == 1)
                  {%>
                <p class="f15px c-b3b3b3">本月日均净资产:<span class="ml10 f15px c-f2bf24"><%=DateTime.Now.Month %>月2日0点后更新</span><i class="ico_doubt ml10" onclick="JAVASCRIPT:showAniFadeIn('#jzc_ans');"></i></p>
                <%}
                  else
                  {%>
                <p class="f15px c-b3b3b3">本月日均净资产:<span class="ml10 f15px c-f2bf24"><%=ToolStatus.ConvertLowerMoney(currAvgDaily) %></span><i class="ico_doubt ml10" onclick="JAVASCRIPT:showAniFadeIn('#jzc_ans');"></i></p>
                <%} %>
            </div>
            <div class="rf">
                <a href="/Member/MemberCenter/growUpSystem.aspx?tab=cur" class="c-b3b3b3">更多<i class="ico_arrow_inline"></i></a>
            </div>
        </div>

        <div class="progress pos-r pl15 pr15 pb25">
            <div id="levelBar">
                <div class="bar">
                    <img id="levelImg" src="" /></div>
                <div class="lable c-b3b3b3">
                    <%if (DateTime.Now.Day != 1)
                      {%>
                    <i class="ico_level"></i>预估下月等级：<span class="c-4d4d4d ml5" id="levelTxt"></span>
                    <%}%>
                </div>
            </div>
            <% if ((nextLevel + 1) <= 8)
               {
            %>
            <%if (DateTime.Now.Day != 1)
              {%>
            <div class="f15px c-b3b3b3 text-center mt10"><i class="ico_distance"></i>距离V<%=nextLevel+1 %>会员还差<%=ToolStatus.ConvertLowerMoney(nextLevelAsset- currAvgDaily)%>元</div>
            <%}%>
            <%
               }%>
        </div>

        <div class="pt10 bg-f6f7f8"></div>
        <a href="/Member/MemberCenter/growUpSystem.aspx?tab=pre" class="block m_tit pl15 pr15 clearfix">
            <div class="lf c-4d4d4d f15px"><i class="ico_tit1"></i>我的特权</div>
            <div class="rf c-b3b3b3">更多<i class="ico_arrow_inline"></i></div>
        </a>
        <div class="bt-e6e6e6"></div>
        <div class="swiper-container" id="swiper">
            <div class="swiper-wrapper tq-box">
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
                <div class="tq text-center swiper-slide">
                    <div class="pl10 tq_center webkit-box box-center"></div>
                    <img src="" />
                    <p class="f15px c-b3b3b3 tq_txt"></p>
                </div>
            </div>
        </div>

        <div class="pt10 bg-f6f7f8"></div>
        <a href="memberQuestion.aspx" class="block m_tit pl15 pr15 clearfix">
            <div class="lf c-4d4d4d f15px"><i class="ico_tit2"></i>常见问题</div>
            <div class="rf c-b3b3b3">更多<i class="ico_arrow_inline"></i></div>
        </a>
        <div class="bb-e6e6e6 w100p"></div>
        <div class="pl15 tab_wrap">
            <div class="tab_tit f15px bb-e6e6e6">会员等级是如何计算的？<span class="ico_arrow_abs rotateZ90"></span></div>
            <div class="tab_con c-b3b3b3 f13px bb-e6e6e6">
                团贷网每月1号3点根据上月日均净资产计算用户的会员等级，用户上月日均净资产越高会员等级越高。根据上月日均净资产的不同，团贷的会员一共分为8个等级：
			<div class="ques-table mt10">
                <table class="">
                    <tbody>
                        <tr>
                            <th class="bb-e6e6e6 br-e6e6e6-before">用户等级</th>
                            <th class="bb-e6e6e6">上月日均净资产</th>
                        </tr>
                        <tr class="bg-fff">
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V1.png"></td>
                            <td class="bb-e6e6e6">0≤上月日均净资产＜10,000</td>
                        </tr>
                        <tr>
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V2.png"></td>
                            <td class="bb-e6e6e6">10,000≤上月日均净资产＜50,000</td>
                        </tr>
                        <tr class="bg-fff">
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V3.png"></td>
                            <td class="bb-e6e6e6">50,000≤上月日均净资产＜100,000</td>
                        </tr>
                        <tr>
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V4.png"></td>
                            <td class="bb-e6e6e6">100,000≤上月日均净资产＜200,000</td>
                        </tr>
                        <tr class="bg-fff">
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V5.png"></td>
                            <td class="bb-e6e6e6">200,000≤上月日均净资产＜500,000</td>
                        </tr>
                        <tr>
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V6.png"></td>
                            <td class="bb-e6e6e6">500,000≤上月日均净资产＜1,000,000</td>
                        </tr>
                        <tr class="bg-fff">
                            <td class="bb-e6e6e6 br-e6e6e6-before">
                                <img src="/imgs/images/V7.png"></td>
                            <td class="bb-e6e6e6">1,000,000≤上月日均净资产＜3,000,000</td>
                        </tr>
                        <tr>
                            <td class="br-e6e6e6-before">
                                <img src="/imgs/images/V8.png"></td>
                            <td class="">上月日均净资产≥3,000,000</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </div>
        </div>
        <div class="pl15 tab_wrap">
            <div class="tab_tit f15px bb-e6e6e6">团贷会员享有哪些特权？<span class="ico_arrow_abs rotateZ90"></span></div>
            <div class="tab_con c-b3b3b3 f13px bb-e6e6e6">
                团贷网会员可以享受团币系数、提现优惠券、借款费用减免、生日投资红包、节日礼物赠送、贵宾客服专线、高端专属服务7项特权，会员等级与会员特权关系如下：
				<div class="table-wrap mt10 pos-r bl-e6e6e6 br-e6e6e6">
                    <div class="pos-a shadow"></div>
                    <div class="table-left pos-a br-e6e6e6">
                        <p class="bt-e6e6e6 bb-e6e6e6"></p>
                        <p class="bb-e6e6e6">团币系数</p>
                        <p class="bb-e6e6e6">提现优惠券</p>
                        <p class="bb-e6e6e6">借款费用减免</p>
                        <p class="bb-e6e6e6">生日投资红包</p>
                        <p class="bb-e6e6e6">节日礼物赠送</p>
                        <p class="bb-e6e6e6">贵宾客服专线</p>
                        <p class="bb-e6e6e6">高级专属服务</p>
                    </div>
                    <div class="swiper-container table-right swiper-container-horizontal swiper-container-android" id="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide swiper-slide-active">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V1.png"></p>
                                <p class="bb-e6e6e6">1</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                            </div>
                            <div class="swiper-slide swiper-slide-next">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V2.png"></p>
                                <p class="bb-e6e6e6">1.05</p>
                                <p class="bb-e6e6e6">3元优惠券x1</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V3.png"></p>
                                <p class="bb-e6e6e6">1.10</p>
                                <p class="bb-e6e6e6">5元优惠券x1</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">18元投资红包</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V4.png"></p>
                                <p class="bb-e6e6e6">1.15</p>
                                <p class="bb-e6e6e6">8元优惠券x1</p>
                                <p class="bb-e6e6e6">7折</p>
                                <p class="bb-e6e6e6">28元投资红包</p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">-</p>
                                <p class="bb-e6e6e6">-</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V5.png"></p>
                                <p class="bb-e6e6e6">1.20</p>
                                <p class="bb-e6e6e6">13元优惠券x1</p>
                                <p class="bb-e6e6e6">6.5折</p>
                                <p class="bb-e6e6e6">48元投资红包</p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">-</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V6.png"></p>
                                <p class="bb-e6e6e6">1.25</p>
                                <p class="bb-e6e6e6">20元优惠券x1</p>
                                <p class="bb-e6e6e6">5.5折</p>
                                <p class="bb-e6e6e6">68元投资红包</p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">-</p>
                            </div>
                            <div class="swiper-slide">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V7.png"></p>
                                <p class="bb-e6e6e6">1.3</p>
                                <p class="bb-e6e6e6">30元优惠券x1</p>
                                <p class="bb-e6e6e6">4.5折</p>
                                <p class="bb-e6e6e6">98元投资红包</p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                            </div>
                            <div class="swiper-slide">
                                <p class="bt-e6e6e6 bb-e6e6e6">
                                    <img src="/imgs/images/V8.png"></p>
                                <p class="bb-e6e6e6">1.35</p>
                                <p class="bb-e6e6e6">60元优惠券x1</p>
                                <p class="bb-e6e6e6">3.5折</p>
                                <p class="bb-e6e6e6">128元投资红包</p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                                <p class="bb-e6e6e6">
                                    <img src="/imgs/member/mall/ico-gx.png" class="you"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="pl15 tab_wrap">
            <div class="tab_tit f15px bb-e6e6e6">如何赚取团币？<span class="ico_arrow_abs rotateZ90"></span></div>
            <div class="tab_con c-b3b3b3 f13px bb-e6e6e6">
                用户完成团币任务即可赚取团币，团币任务目前分为投资任务、日常任务、新手任务三种：<br />
                <img src="/imgs/member/pic-q6.png?v=20170727001" class="pt15 pb15 block mb10">
                备注：投资赚团币，系统会按计息时所在的会员等级取团币系数计算团币；会员等级未更新，系统会等待等级更新后再计算；团币通常在计息1小时内发放至用户账号。
            </div>
        </div>
        <div class="pl15 tab_wrap">
            <div class="tab_tit f15px bb-e6e6e6">团币可以兑换哪些商品？<span class="ico_arrow_abs rotateZ90"></span></div>
            <div class="tab_con c-b3b3b3 f13px bb-e6e6e6">团币可兑换的商品分实物商品和虚拟商品两种，其中实物商品以市场热售商品为主，如iPhone 6s，虚拟商品主要为团贷网内部提供的投资红包、提现抵扣券、超级会员等商品。</div>
        </div>
        <div class="tab_tit bg-f6f7f8"></div>


        <!--净值产说明 弹窗-->
        <div class="alert z-index1000 webkit-box box-center" id="jzc_ans" style="display: none;">
            <div class="alert-box pos-r bg-fff jzc-con comonAni">
                <div class="pt30 pl25 pr25">
                    <p class="f15px text-left c-808080 pos-r">日均净资产为该月内每日净资产的平均值</p>
                </div>
                <div class="text-left c-ababab f15px pt15 pr25 gongshi pb30">
                    <p class="pos-a c-ababab f15px">净资产 =</p>
                    账户余额+待收本息+冻结资金-待还本息</div>
                <a href="javascript:hideAniFadeOut('#jzc_ans');" class="bt-e6e6e6" id="knowBut">我知道了</a>
            </div>
        </div>
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
    <script type="text/javascript">
        var swiper = new Swiper('#swiper', {
            slidesPerView: 'auto'
        });

        var swiper2;
        function initSwiper() {
            swiper2 = new Swiper('#swiper-container', {
                initialSlide: 0,
                slidesPerView: 'auto'
            });
        }
        function destroySwiper() {
            swiper2.destroy(false, true);
        }

        //不同等级显示不同图片
        var level = parseInt("<%= vipInfo.Level%>");
	    $("#levelImg").attr('src', '/imgs/memberCenter/bar' + level + '.png');
	    var nextMonthLevel = parseInt("<%= nextLevel%>");
	    //		var nextMonthLevel = level;
	    //预计下个月是什么等级
	    $("#levelTxt").html('V' + nextMonthLevel);
	    $(".lable").addClass('lable' + nextMonthLevel);

	    var levelData = [
		//等级1
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span></p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="c-969696 tq_p2">¥3</p>',
			    imgSrc: '/imgs/memberCenter/2_2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="c-8a8a8a tq_p3">7折</p>',
			    imgSrc: '/imgs/memberCenter/3_3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="c-ffffff tq_p4">¥28</p>',
			    imgSrc: '/imgs/memberCenter/4_4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/5_5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/6_6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/7_7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级2
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.05</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥3</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p3 c-8a8a8a">7折</p>',
			    imgSrc: '/imgs/memberCenter/3_3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="c-ffffff tq_p4">¥28</p>',
			    imgSrc: '/imgs/memberCenter/4_4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/5_5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/6_6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/7_7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级3
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.1</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥5</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p4">¥18</p>',
			    imgSrc: '/imgs/memberCenter/4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '<p class="tq_p3 c-8a8a8a">7折</p>',
			    imgSrc: '/imgs/memberCenter/3_3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/5_5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/6_6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/7_7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级4
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.15</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥8</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p3">7折</p>',
			    imgSrc: '/imgs/memberCenter/3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="tq_p4">¥28</p>',
			    imgSrc: '/imgs/memberCenter/4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/6_6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/7_7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级5
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.2</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥13</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p3">6.5折</p>',
			    imgSrc: '/imgs/memberCenter/3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="tq_p4">¥48</p>',
			    imgSrc: '/imgs/memberCenter/4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '',
			    imgSrc: '/imgs/memberCenter/7_7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级6
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.25</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥20</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p3">5.5折</p>',
			    imgSrc: '/imgs/memberCenter/3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="tq_p4">¥68</p>',
			    imgSrc: '/imgs/memberCenter/4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/7_7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级7
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.3</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥30</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p3">4.5折</p>',
			    imgSrc: '/imgs/memberCenter/3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="tq_p4">¥98</p>',
			    imgSrc: '/imgs/memberCenter/4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/7.png',
			    bot_txt: '高级专属服务'
			},
		],
		//等级8
		[
			{
			    txtCon: '<p class="tq_p1"><span>1</span>.35</p>',
			    imgSrc: '/imgs/memberCenter/1.png',
			    bot_txt: '团币系数'
			},
			{
			    txtCon: '<p class="tq_p2">¥60</p>',
			    imgSrc: '/imgs/memberCenter/2.png',
			    bot_txt: '免费提现券'
			},
			{
			    txtCon: '<p class="tq_p3">3.5折</p>',
			    imgSrc: '/imgs/memberCenter/3.png',
			    bot_txt: '借款费用减免'
			},
			{
			    txtCon: '<p class="tq_p4">¥128</p>',
			    imgSrc: '/imgs/memberCenter/4.png',
			    bot_txt: '生日红包'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/5.png',
			    bot_txt: '节日贺礼'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/6.png',
			    bot_txt: '贵宾客服专线'
			},
			{
			    txtCon: '<p></p>',
			    imgSrc: '/imgs/memberCenter/7.png',
			    bot_txt: '高级专属服务'
			}
		]
	    ]

	    var tq = $(".tq-box").find(".tq");
	    for (var i = 0; i < levelData[level - 1].length; i++) {
	        tq.eq(i).find('div').html(levelData[level - 1][i].txtCon);
	        tq.eq(i).find('img').attr('src', levelData[level - 1][i].imgSrc);
	        tq.eq(i).find('.tq_txt').html(levelData[level - 1][i].bot_txt);

	    }

	    $(".tab_wrap").each(function (i, item) {
	        var tit = $(item).find('.tab_tit');
	        var arrow = tit.find('span');
	        var con = $(item).find('.tab_con');
	        tit.click(function () {
	            if (arrow.hasClass('rotateZ90')) {
	                arrow.removeClass('rotateZ90').addClass('rotateZ_90');
	                con.show();
	                if (i == 1) {
	                    initSwiper();
	                }
	            } else {
	                arrow.removeClass('rotateZ_90').addClass('rotateZ90');
	                con.hide();
	                if (i == 1) {
	                    destroySwiper();
	                }
	            }
	        });
	    });

    </script>
</asp:Content>
