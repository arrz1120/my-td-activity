<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WeiXinIndex.aspx.cs" Inherits="TuanDai.WXApiWeb.WeiXinIndex" %>

<%@ Import Namespace="TuanDai.PortalSystem.Model" %>
<%@ Import Namespace="Tool" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-itunes-app" content="app-id=796440356"/>
<link rel="apple-touch-icon-precomposed" sizes="57x57" href="/imgs/images/AppIcon57x57.png"/>
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/imgs/images/AppIcon57x57@2x.png"/>
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/imgs/images/AppIcon72x72.png"/>
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="/imgs/images/AppIcon72x72@2x.png"/>
<title>团贷网微信版</title>
<link rel="shortcut icon" href="/favicon.ico?v=20160711001" />
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css?v=20160412" />
<link rel="stylesheet" type="text/css" href="/css/index3.css?v=20160526001" />
<link rel="stylesheet" type="text/css" href="/css/log-alert.css?v=20160509002" />
</head>
<body class="bg-f7f7f5">
<div class="loading-box" id="cMloading">
	<div class="loading-tips"><img src="/imgs/images/icon/ico_loading.png" alt=""><span>加载中...</span></div>
</div>
<div id="bigDiv">
	<div class="swiper-container" id="swiper-banner">
		<div class="swiper-wrapper">
	        <%
	           var imgIndex = 0;
	           foreach (ProjectAdImageInfo imgeInfo in BannerList) { %>
		    <div class="swiper-slide"><a href="<%=imgeInfo.Link %>"><img src="<%= imgeInfo.ImageUrl %>" <%=imgIndex>1?"style='display:none;'":"" %> /></a></div> 
	        <%} %>
		</div>
		<div class="swiper-pagination" id="nav-mark"></div>
	</div>
	 
	<div class="index-nav bg-fff">
		<div class="clearfix">
			<div class="w33p lf text-center pt20 pb15 click-respond">
				<a href="/pages/news/noticelist.aspx">
					<div class="nav-img nav-img5 webkit-box box-center"><img src="/imgs/images/icon/ico_sound02.png" alt="" /></div>
					<p class="f13px c-212121 mt7">团贷公告</p>
				</a>
			</div>
			<div class="w33p lf text-center pt20 pb15 click-respond">
				<a href="/pages/aboutus/BigData.aspx">
					<div class="nav-img nav-img2 webkit-box box-center"><img src="/imgs/images/icon/ico_s2.png" alt="" /></div>
					<p class="f13px c-212121 mt7">团贷大数据</p>
				</a>
			</div>
			<div class="w33p lf text-center pt20 pb15 click-respond">
				<a href="http://hd.tuandai.com/weixin/tuandaiAppNew/IndexApp.aspx?type=weixinapp">
					<div class="nav-img nav-img3 webkit-box box-center"><img src="/imgs/images/icon/ico_share1.png" alt="" /></div>
					<p class="f13px c-212121 mt7">下载APP</p>
				</a>
			</div>
		</div>
	</div>
	
	<!--团贷大讲堂-->
	<div class="mt15 bigCourse webkit-box box-center bg-fff bb-e6e6e6 click-respond">
		<img src="/imgs/images/pic/bigCourse.png"/>
	</div>
	
	<% if (NewHandProjectList != null)
	   { %>
	    <section id="newHandScrollDiv" class="mr15"> 
	      <ul>
	         <% foreach (TuanDai.PortalSystem.Model.WXProjectListInfo Item in this.NewHandProjectList){%>
	                <li>
	                <div class="bg-fff pos-r webkit-box box-align new_u_i click-respond" onclick="javascript:window.location.href='<%=TuanDai.WXApiWeb.invest_list.GetClickUrl(Item.TypeId, Item.SubTypeId , Item.Id)%>';">
		                <div class="f12px c-808080"><span class="f18px c-ff881f"><%=ToolStatus.DeleteZero(Item.YearRate+Item.NewHandRate) %><span class="f10px c-ff881f">%</span></span>年化</div>
		                <div class="f12px c-808080 i_time"><%=Item.Deadline %><%=Item.DeadType==1?"个月":"天" %></div>
		                <div class="f12px c-808080"><%=ToolStatus.ConvertRepaymentType(Item.RepaymentType)%></div>
		                <a class="<%=Item.Status==2?"newHandYellow":"newHandGray" %>" href="javascript:void(0);"><%=Item.Status==2?"马上投资":"已售罄" %></a>
	                </div>
	              </li>
	         <%} %>
	      </ul> 
	    </section>
	<%} %>
		
	<div class="knowMore pd15 clearfix bg-fff mt10">
		<div class="w50p lf knowMore_l click-respond" onclick="window.location.href='/pages/invest/we/WE_list.aspx'">
			<div class="webkit-box box-center box-vertical bg_more more3">
				<p class="f15px c-ffffff">理财We计划</p>
				<p class="f12px c-ffffff line-h18">投资更轻松</p>
			</div>
		</div>
		<div class="w50p lf knowMore_r click-respond"  onclick="window.location.href='/pages/invest/invest_list.aspx'">
			<div class="webkit-box box-center box-vertical bg_more more4">
				<p class="f15px c-ffffff">优质标的</p>
				<p class="f12px c-ffffff line-h18">投资有保障</p>
			</div>
		</div>
	</div>
 	<div class="mt15 bg-fff invset-guide swiper-invest swiper-invest1">
        <div class="swiper-slide click-respond" onclick="javascript:window.location.href='/pages/invest/WE/<%=FirstWeInfo.IsWeFQB?"WeFqb_detail.aspx":"WE_detail.aspx"%>?id=<%=FirstWeInfo.ProductId %>'">
    		<div class="webkit-box slide-box">
    			<div class="webkit-box box-center box-vertical slide_l br-e6e6e6">
    				<%=GetWePlanYearRate(FirstWeInfo) %>
    				<p class="c-808080 f12px line-h12 pt5">预期年化利率</p>
    			</div>
    			<div class="webkit-box box-vertical box-center slide_r pl15">
    				<div class="w100p pr30">
        				<p class="f13px c-808080">期限: <span class="c-212121 f13px"><%=FirstWeInfo.Deadline %>个月</span></p>
        				<p class="f13px c-808080">剩余金额:  <%=GetWePlanSurplusMoney(FirstWeInfo) %></p>
        				<p class="f13px c-808080 text-overflow"><%=FirstWeInfo.ProductName %></p>
                        <div class="clearfix itemTipsBox">
                            <% if ((FirstWeInfo.TypeWord.ToLower().Contains("p") || FirstWeInfo.TypeWord.ToLower().Contains("r") || FirstWeInfo.TypeWord.ToLower().Contains("q")) && FirstWeInfo.StartDate >= DateTime.Parse(SetModel.Param1Value) && FirstWeInfo.StartDate < DateTime.Parse(SetModel.Param2Value))
                                {
                            %>
                                <div class="itemTips itemTips2">加息<%= SetModel.Param3Value%>%</div>
                            <% } %>
                            <%else if (FirstWeInfo.StartDate >= DateTime.Parse(SetModel1.Param1Value) && FirstWeInfo.StartDate < DateTime.Parse(SetModel1.Param2Value))
                                {
                            %>
                                <div class="itemTips itemTips2">加息<%= SetModel1.Param3Value%>%</div>
                            <% } %>
                          <% if (FirstWeInfo.IsWeFQB){ %>
                               <%-- <div class="itemTips itemTips2">加入返现5‰</div> --%>
		        			    <div class="itemTips itemTips1">可提前退出</div> 
                        <%} %>
                             </div>
    				</div>
    			</div>
			</div>
			<i class="ico-ccc"></i>
		</div>
	</div>
	
	<div class="mt15 bg-fff swiper-invest swiper-invest2 invset-guide">
        <div class="swiper-slide click-respond" onclick="javascript:window.location.href='<%=TuanDai.WXApiWeb.invest_list.GetClickUrl(FirstProjectInfo.TypeId, FirstProjectInfo.SubTypeId , FirstProjectInfo.Id)%>'">
    		<div class="webkit-box slide-box">
    			<div class="webkit-box box-center box-vertical slide_l br-e6e6e6">
    					<%=GetProjectYearRate(FirstProjectInfo) %>
    				<p class="c-808080 f12px line-h12 pt5">预期年化利率</p>
    			</div>
    			<div class="webkit-box box-vertical box-center slide_r pl15">
    				<div class="w100p pr20">
        				<p class="f13px c-808080">期限: <%=GetProjectShowDeadline(FirstProjectInfo) %></p>
        				<p class="f13px c-808080">剩余金额: <%=GetProjectSurplusMoney(FirstProjectInfo) %></p>
        				<p class="f13px c-808080 text-overflow">[<%=GetTypeName(FirstProjectInfo.TypeId,FirstProjectInfo.SubTypeId) %>]<%=TuanDai.WXApiWeb.invest_list.FilterProjectName(FirstProjectInfo.TypeId, FirstProjectInfo.Title)%></p>
        				<div class="itemTipsBox clearfix">
                           <% if (!string.IsNullOrWhiteSpace(FirstProjectInfo.TuandaiRate))
                                 { %>
    			                <div class="itemTips itemTips1">加息<%=FirstProjectInfo.TuandaiRate %>%</div>
                            <%} %>                             
                            <% if (FirstProjectInfo.IsNewHand && FirstProjectInfo.NewHandRate>0)
                                { %>
                            <div class="itemTips itemTips2">
                            	新手+<%=ToolStatus.DeleteZero(FirstProjectInfo.NewHandRate)%>%
                            </div>
                            <%} %>  
        				</div>
    				</div>
    			</div>
    		</div>	
    		<i class="ico-ccc"></i>
    	</div>
	</div>
	
	<a href="http://hd.tuandai.com/weixin/Invitation_3rd/Index.aspx" class="block mt15 click-respond">
		<img src="/imgs/images/pic/invitnew.png"/>
	</a>
	
	<div class="bt-e6e6e6 bb-e6e6e6 mt10">
		<img class="w100p" src="/imgs/images/pic/downloadApp.png"/>
		<a href="javascript:void(0);" class="c-ffffff bg-ffcf1f f15px text-center dl_app">下载APP</a>
	</div>
	
	<div class="bottom-split"></div>
	
	<!--微信底部-->
	<div class="bt-e6e6e6 webkit-box box-center wx-footer">
		<a class="block box-flex1 text-center click-respond" href="javascript:void(0);">
			<p><img src="/imgs/images/icon/ico_f1_act.png"/></p>
			<p class="f10px line-h18 c-ffc000">团贷</p>
		</a>
		<a class="webkit-box box-center box-vertical box-flex1 text-center click-respond" href="/pages/invest/invest_list.aspx">
			<p><img src="/imgs/images/icon/ico_f2.png"/></p>
			<p class="f10px line-h18 c-626262">投资</p>
		</a>
		<a class="webkit-box box-center box-vertical box-flex1 text-center click-respond" href="javascript:void(0);" id="btnGoMember">
			<p><img src="/imgs/images/icon/ico_f3.png"/></p>
			<p class="f10px line-h18 c-626262">我的</p>
		</a>
	</div>
</div>

   <!-----登录注册弹框---->
    <% if(!TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated){ %>
	<!--登录-->
	<div class="bg-fff log-alert hide" id="dvLoginPass">
		<div class="log-close webkit-box box-center">
			<i class="block logSprite close"></i>
		</div>
		<div class="text-center f17px pt15 pb15">登录</div>
		<div class="contentWrap pt20">
			<div class="input-box bb-e6e6e6">
				<i class="block logSprite phone"></i>
				<input type="tel" placeholder="请输入手机号码" id="txtLoginTel" />
			</div>
			<div class="input-box bb-e6e6e6">
				<i class="block logSprite unlock"></i>
				<input type="password" placeholder="请输入登录密码" id="txtLoginPass"  /> 
				<!--<b class="block logSprite eye-close" id="btnSee2"></b>-->
				<div class="btnsee webkit-box box-center" id="btnSee2">
					<b class="block logSprite eye-close"></b>
				</div>
			</div>
			<div class="btn btnYellow mt50 opacity05" id="loginConfirm">确定</div>
			<%--<a href="/Member/safety/ResetPwd.aspx" class="block text-center f13px c-ffcf1f mt8">忘记密码</a>--%>
            <div class="mt8 clearfix">
				<a href="/user/Register.aspx" class="lf f13px c-ffcf1f">注册</a>
				<a href="/Member/safety/ResetPwd.aspx" class="rf f13px c-ffcf1f">忘记密码</a>
			</div>
		</div>
	</div>
	<!--注册-->
	<div class="bg-fff log-alert hide" id="dvRegister">
		<div class="log-close webkit-box box-center">
			<i class="block logSprite close"></i>
		</div>
		<div class="text-center f17px pt15 pb15">注册</div>
		<div class="contentWrap pt20">
			<div class="input-box bb-e6e6e6">
				<i class="block logSprite phone"></i>
				<input type="tel" placeholder="请输入手机号码" id="txtRegTel" />
			</div>
			<div class="input-box bb-e6e6e6" id="setPassword">
				<i class="block logSprite lock"></i>
				<input type="password" placeholder=""   id="txtRegPass" />
				<p id="likePlaceholder">设置密码<span>（6-16个字符，数字+字母）</span></p>
				<!--<b class="block logSprite eye-close" id="btnSee"></b>-->
				<div class="btnsee webkit-box box-center" id="btnSee">
					<b class="block logSprite eye-close"></b>
				</div>
			</div>
			<div class="input-box bb-e6e6e6">
				<i class="block logSprite info"></i>
				<input type="tel" placeholder="验证码"  id="txtRegCode" />
				<div class="timeout bl-e6e6e6 f13px c-ffcf1f text-center" id="getCode">
					获取验证码
				</div>
				<div class="timeWrap bl-e6e6e6 hide" id="timeWrap">
					<div class="time_bg"></div>
					<div class="time">
					    <div class="wrap circle_right">
					        <div class="round rightcircle" id="rightcircle"></div>
					    </div>
					    <div class="wrap circle_left">
					        <div class="round leftcircle" id="leftcircle"></div>
					    </div>
					    <div id="show"></div>
					</div>
				</div>
			</div>
			<div class="clearfix pl10 mt8 invite_t">
				<div class="lf c-ffcf1f f13px" id="invite"><i class="triangle-r"></i>邀请人手机号码</div>
				<div class="rf c-ffcf1f f13px" id="getVoiceCode">语音验证码</div>
			</div>
			<div class="input-box bb-e6e6e6 mt13 hide" id="invite-inp">
				<i class="block logSprite people"></i>
				<input type="tel" placeholder="邀请人手机号码" id="txtFriendTel"  />
			</div>
			<div class="btn btnYellow mt50" id="zhuceConfirm">注册</div>
			<div class="text-center f13px c-ababab mt8">注册即表示您已同意<a class="f13px c-ffcf1f" href="/pages/agreement.aspx">《团贷网服务协议》</a></div>
		</div>
        <div class="bottom_txt f13px c-ababab w100p text-center">已有账号？<a href="/user/Login.aspx" class="f13px c-ffcf1f">马上登录</a></div>
	</div>
	<!--登录注册-->
	<div class="bg-fff log-alert hide" id="dvLogin">
		<div class="log-close webkit-box box-center">
			<i class="block logSprite close"></i>
		</div>
		<div class="tdLogo"></div>
		<div class="contentWrap pt20">
			<div class="input-box bb-e6e6e6">
				<i class="block logSprite phone"></i>
				<input type="tel" placeholder="请输入手机号码" id="tel-inp" />
			</div>
		</div>
        <div class="bottom_txt f13px c-ababab w100p text-center">你也可以选择<a href="/user/Login.aspx" class="f13px c-ffcf1f">用户名登录</a></div>
		<%--<div class="bottom_txt f13px c-ababab w100p text-center">输入手机号码，即可马上<span class="f13px c-212121">登录</span>或<span class="f13px c-212121">注册</span></div>--%>
	</div>	
    <%} %> 
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<% if(!TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated){ %>
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script> 
<script type="text/javascript" src="/scripts/Common.js"></script> 
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=20160504"></script> 
<script type="text/javascript" src="/scripts/home.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>     
<%} %>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    var isUserLogin = "<%=TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated?1:0%>";
	$(function () {
	    $(".bigCourse").click(function () {
	        window.location.href = "/pages/aboutus/ClassRoom.aspx";
	    });

		//banner滑动 
		var swiper_banner = new Swiper('#swiper-banner', {
		    onInit: function () {
		        $('#swiper-banner').find('img').show();
		    },
		    autoplay: 5000,
		    direction: 'horizontal',
		    loop: true,
		    pagination: '#nav-mark'
		});
	    //新手标滚动
		setInterval('AutoScroll("#newHandScrollDiv")', 3000);
		$("#btnGoMember").click(function () {
		    if (isUserLogin == "1") {
		        window.location.href = "/Member/my_account.aspx";
		    } else {
		        moveToTop("#dvLogin");
		       // $("#tel-inp").focus();
		    }
		}); 
	}); 
	function AutoScroll(obj) {
	    $(obj).find("ul:first").animate({
	        marginTop: "-25px"
	    }, 500, function () {
	        $(this).css({ marginTop: "0px" }).find("li:first").appendTo(this);
	    });
	} 
</script> 
</body>
</html>
