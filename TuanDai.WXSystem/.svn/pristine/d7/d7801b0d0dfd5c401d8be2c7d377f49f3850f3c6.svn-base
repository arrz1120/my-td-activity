<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="memberCenter_bak.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.MemberCenter.memberCenter_bak" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>会员中心</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
<link rel="stylesheet" type="text/css" href="/css/memberCenter.css?v=2015112301" /><!--会员中心-->
</head>
<body>	 
 <%= this.GetNavStr()%>
<header class="headerMain">
	<div class="header"> 
		<div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div> 
		<h1 class="title">会员中心</h1>
	</div>
	<%= this.GetNavIcon()%>
	<div class="none"></div>
</header>
	<div class="memberCenter">
		<header> 
            <div class="headPic"><img src="<%=!string.IsNullOrEmpty(model.HeadImage)?model.HeadImage:"/imgs/images/default.jpg" %>"  width="80px" height="80px"></div>
			<div class="memberinfoBox">
				<div class="row1">
					<span class="lable">我的等级:</span> 
					<div class="con">
						<div class="myLevel">
							<img src="/imgs/images/V<%=this.model.Level %>.png"/><%=this.model.LevelName %>
						</div>
						<div class="privileges">
							<%--=userModel.Level==2?"超级会员":"普通会员" --%>
                            <% if (model.Level == 1 || model.Level == 2)
                               {
                                   %>
                            <img src="/imgs/member/icon-tongzuan.png"/>铜冠会员
                            <%
                               } 
                               if (model.Level == 3 || model.Level == 4)
                               {
                                   %>
                            <img src="/imgs/member/icon-yinzuan.png"/>银冠会员
                            <%
                               } 
                               if (model.Level == 5 || model.Level == 6)
                               {
                                   %>
                            <img src="/imgs/member/icon-jinzuan.png"/>金冠会员
                            <%
                               } 
                               if (model.Level == 7 || model.Level == 8)
                               {
                                   %>
                            <img src="/imgs/member/icon-huangzuan.png"/>皇冠会员
                            <%
                               } %>
                            

						</div>
					</div>
				</div>
				<div class="row1">
					<span class="lable">成长值:</span> 
					 <%if(this.model.Level!=8){ %>
					<div class="bar">
						<div class="percent" style="width: <%=this.percent %>%"></div>
						<p><%=this.model.Growth %>/<%=this.model.CurLevelMaxGrowth %></p>
					</div>
					<%}
					  else
					  { %>
                    <div class="bar">
					    <div class="percent" style="width: 100%"></div>
						<p><%=this.model.Growth %></p>
                    </div>
					<%} %>
				</div>
			</div>
		</header>
		<%if (!string.IsNullOrEmpty(strAction))
		  { 
			   %>
		<div class="ad">
			<img src="/imgs/member/icon_gift.png"/><p><%="您已获得一个"+strAction %></p>
			<a id="clickToGet" class="clickToGet" href="javascript:void(0)">点击领取</a>
		</div>
		<%} %>
		<section>
			<div class="secWrap">
				<div class="secTit secTit01">
					<img class="ico_arrow_r2" src="/imgs/images/ico_arrow_r2.png"/>
					<div class="link link01">
						<a href="/Member/MemberCenter/myPrivileges.aspx">查看更多</a>
					</div>
				</div>
				<div class="secCon">
					<div class="swiper-container1" id="in_industry">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges1<%=dicPriv[1]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[1]!=""?"class='c-b2b2b2'":""%> >升级投资礼包</p>
								</div>
							</div>
                            <div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges6<%=dicPriv[6]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[6]!=""?"class='c-b2b2b2'":""%>>专享服务</p>
								</div>
							</div>
                            <div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges5<%=dicPriv[5]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[5]!=""?"class='c-b2b2b2'":""%>>快速提现</p>
								</div>
							</div>
                            <div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges8<%=dicPriv[8]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[8]!=""?"class='c-b2b2b2'":""%>>生日特权</p>
								</div>
							</div>
							<div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges2<%=dicPriv[2]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[2]!=""?"class='c-b2b2b2'":""%>>专属客服</p>
								</div>
							</div> 
							<div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges4<%=dicPriv[4]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[4]!=""?"class='c-b2b2b2'":""%>>贵宾俱乐部</p>
								</div>
							</div> 
							<div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges7<%=dicPriv[7]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[7]!=""?"class='c-b2b2b2'":""%>>周年纪念品</p>
								</div>
							</div>
							<div class="swiper-slide">
								<div class="pics">
									<img src="/imgs/member/Privileges3<%=dicPriv[3]%>.png"  alt="" class="img tc"/>
								</div>
								<div class="words">
									<p <%=dicPriv[3]!=""?"class='c-b2b2b2'":""%>>年会邀请函</p>
								</div>
							</div> 
						</div>
					</div>

				</div>
			</div>
		</section>	
		<section>
			<div class="secWrap">
				<div class="secTit secTit02">
					<img class="ico_arrow_r2" src="/imgs/images/ico_arrow_r2.png"/>
					<div class="link link01">
						<a href="growUpDetail.aspx">查看成长值明细</a>
					</div>
				</div>
				<div class="gongshiWrap">
					<div class="gongshi">
						<img src="/imgs/member/gongshi.png"/>
					</div>
				</div>
				<div class="mission clearfix">
					<a href="missionDetail.aspx#xinshou">
						<div class="missionL">
							<img src="/imgs/member/icon_newUser.png"/> 
								<div class="misTxt">
									<font>新手任务</font>
									<p>实名认证，绑定银行卡等</p>
								</div> 
						</div>
					</a>
					<a href="missionDetail.aspx#richang">
						<div class="missionR">
							<img src="/imgs/member/icon_daily.png"/>
							<div class="misTxt misTxtR">
								<font>日常任务</font>
								<p>每日签到，邀请好友等</p>
							</div>
						</div>
					</a>
				</div>
			</div>
		</section>
		<section>
			<div class="secWrap">
				<div class="secTit secTit03"></div>
				<div class="activity">
					<div class="activityCon">
                        <%if(listAct!=null && listAct.Count>0)
                          { 
                              %>
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<%--<div class="swiper-slide"><img src="/imgs/member/activity1.png"/></div>
								<div class="swiper-slide"><img src="/imgs/member/activity1.png"/></div>
								<div class="swiper-slide"><img src="/imgs/member/activity1.png"/></div>--%>
								<%foreach(var item in this.listAct)
								  {
								%>
								<div id="ActInfo<%=item.Index %>" StatusDesc="<%=item.StatusDesc %>" Url="<%=item.Url %>" 
                                     Status="<%=item.Status %>" SubType="<%=item.SubType%>" ActivityId="<%=item.ActivityId%>" 
                                     LimitLevel="<%=item.LimitLevel%>" class="swiper-slide">
                                    <img src="<%=item.ImgPath %>" /> 
								</div>
								<%} %>
							</div>
							<!-- 如果需要分页器 -->
							<!--<div class="swiper-pagination"></div>-->
						</div>
                        
						<div class="btnGet <%=listAct[0].Status==1?"btn_getNow":"btn_getNowGray" %>">
							<%=listAct.First().StatusDesc %>
						</div>
                        <%}else{ %>
                        <div style="text-align:center;padding-top:30px;font-size:13px;">暂时没有活动~~~</div>
                        <%} %>
					</div>
					<div class="mark"></div>
				</div>
			</div>
		</section>

		<div id="window" class="window" style="display: none;">
			<div class="content">
				<div class="inner">
					<div class="h6">恭喜您获得</div>
					<div class="award">
						<%=strAction %>
					</div>
				</div>
				<div class="awardList clearfix">
					<div class="listItem list1">
						<img src="/imgs/member/icon1.png"/>
						<div class="num"> 
                            <% if(redType=="1"){ %>
                            ￥10
                            <%} else if(redType=="2"){ %>
                            ￥10 x 2
                            <%}else{ %>
                             ￥10 x 3
                            <%} %>
						</div>
						<div class="ins">
							红包
						</div>
					</div>
					<div class="listItem list2">
						<img src="/imgs/member/icon2.png"/>
						<div class="num">
                           ￥18
						</div>
						<div class="ins">
							投资红包
						</div>
					</div>
					<div class="listItem list3">
						<img src="/imgs/member/icon3.png"/>
						<div class="num">
						   <% if(redType=="1"){ %>
                            2个月
                            <%} else if(redType=="2"){ %>
                            4个月
                            <%}else{ %>
                            6个月
                            <%} %>
						</div>
						<div class="ins">
							超级会员
						</div>
					</div>
				</div>
				<div id="confirm" class="confirm">
					确定
				</div>
			</div>
		</div>
	</div>
	
	<!--end-->

	<script type="text/javascript" src="/scripts/jquery.min.js"></script>
	<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
	<script type="text/javascript" src="/scripts/base.js?v=20150828"></script>
	<script type="text/javascript">
	    var doLink = true;
	    var curLevel = "<%=model.Level%>";
	    $(document).ready(function () {
	        var mySwiper = new Swiper('.swiper-container', {
	            direction: 'horizontal',
	            loop: false,
	            // 如果需要分页器
	            pagination: '.mark',
	            onSlideChangeEnd: function (mySwiper) {
	                var status = parseInt($("#ActInfo" + mySwiper.activeIndex).attr("Status"));
	                var SubType = parseInt($("#ActInfo" + mySwiper.activeIndex).attr("SubType"));
	                $(".btnGet").html($("#ActInfo" + mySwiper.activeIndex).attr("StatusDesc"));
	                $(".btnGet").removeClass("btn_getNow").removeClass("btn_getNowGray");
	                if (status == 1) {
	                    $(".btnGet").addClass("btn_getNow");
	                } else {
	                    $(".btnGet").addClass("btn_getNowGray");
	                } 
	                $(".btnGet").click(function () {
	                    $(".btnGet").unbind("click");
	                    if (SubType == "2") { 
	                        if ($("#ActInfo" + mySwiper.activeIndex).attr("Url") != "") { 
	                            window.location.href = $("#ActInfo" + mySwiper.activeIndex).attr("Url");
	                        }
	                    } else {
	                        if (status == 1) {
	                            var activityId = $("#ActInfo" + mySwiper.activeIndex).attr("ActivityId");
	                            var limitLevel = $("#ActInfo" + mySwiper.activeIndex).attr("LimitLevel");
	                            ReceiveGift(activityId, limitLevel, curLevel, $(".btnGet"));
	                        }
	                    }
	                });
	            }
	        });
	        var swiper = new Swiper('#in_industry', {
	            slidesPerView: 'auto',
	            spaceBetween: 10
	        });
	        $(".btnGet").click(function () {
	            var status = parseInt($("#ActInfo" + mySwiper.activeIndex).attr("Status"));
	            var SubType = parseInt($("#ActInfo" + mySwiper.activeIndex).attr("SubType")); 
	            if (SubType == "2") {
	                if ($("#ActInfo" + mySwiper.activeIndex).attr("Url") != "")
	                    window.location.href = $("#ActInfo" + mySwiper.activeIndex).attr("Url");
	            } else {
	                if (status == 1) {
	                    var activityId = $("#ActInfo" + mySwiper.activeIndex).attr("ActivityId");
	                    var limitLevel = $("#ActInfo" + mySwiper.activeIndex).attr("LimitLevel");
	                    ReceiveGift(activityId, limitLevel, curLevel, $(".btnGet"));
	                }
	            } 
	        });
	        $("#clickToGet").click(function () {
	            ReceiveRedPacket("<%=redType%>");
	        });
	        $("#confirm").click(function () {
	            $('#window').hide();
	            window.location.href = "/Member/UserPrize/Index.aspx";
	        }); 
	    });

	    function ReceiveRedPacket(redType) { 
			$.ajax({
				url: "/AjaxCross/ajax_Acticity.ashx",
				type: "post",
				dataType: "json",
				async: false,
				data: {
					Cmd: "ReceivePrize", rType: redType
				}, success: function (data) {
					if (data.Result == "1") {
						$("#window").show();
					}
					else if (data.Result == "2") {
						alert("对不起，您还未登录!");
					}
					else {					    
						alert(data.msg);
					}
				}, error: function () {
					alert("领取失败，请稍后重试!");
				}
			});
	    }

	    function ReceiveGift(activityId, limitLevel, level, obj) {
	        if (limitLevel.indexOf(level) == -1) {
	            alert("对不起，您还未达到领取等级!");
	            return;
	        }
	        $.ajax({
	            url: "/ajaxCross/ajax_Acticity.ashx",
	            type: "post",
	            dataType: "json",
	            async: false,
	            data: {
	                Cmd: "ReceiveGift", ActivityId: activityId
	            }, success: function (data) {
	                if (data.Result == "1") {
	                    alert("您已成功领取门票!"); 
	                    $(obj).html("已经领取");
	                    $(obj).removeClass("btn_getNow").addClass("btn_getNowGray");
	                    $(obj).unbind("click");
	                } else if (data.Result == "2") {
	                    alert("对不起，您还未登录!");
	                    window.location = + "/user/login.aspx?ReturnUrl=" +location.href; 
	                } else {
	                    switch (data.Result) {
	                        case "-1":
	                            alert("领取失败，活动未开始!"); 
	                            break;
	                        case "-2":
	                            alert("领取失败，活动已结束!"); 
	                            break;
	                        case "-3":
	                            alert("领取失败，活动已截止!"); 
	                            break;
	                        case "-4":
	                            alert("领取失败，对不起，已经被领完啦!"); 
	                            $(obj).html("已经领完");
	                            $(obj).removeClass("btn_getNow").addClass("btn_getNowGray");
	                            $(obj).unbind("click");
	                            break;
	                        case "-5":
	                            alert("对不起，您还未达到领取等级!"); 
	                            break;
	                        case "-6":
	                            alert("您已经领取!");	                            
	                            $(obj).html("已经领取");
	                            $(obj).removeClass("btn_getNow").addClass("btn_getNowGray");
	                            $(obj).unbind("click");
	                            break;
	                        default:
	                            alert(data.msg); 
	                            break;
	                    }
	                }
	            }, error: function () {
	                alert("领取失败，请稍后重试!"); 
	            }
	        });
	    }
	</script>
</body>
</html>
