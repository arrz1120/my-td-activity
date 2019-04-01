﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invest_list.aspx.cs" Inherits="TuanDai.WXApiWeb.invest_list" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<%@ Import Namespace="TuanDai.PortalSystem.Model" %>
<%@ Import Namespace="Tool" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="keywords" content="小型投资项目,短期投资,P2P投资理财" />
    <meta name="description" content="团贷网拥有大量投资理财产品,为你提供优质的小型投资项目、个人短期投资理财产品,安全可靠的P2P投资理财平台选团贷网更放心" />
    <title>小型投资项目,短期投资,P2P投资平台就上【团贷网】</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/range.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/list.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/baikedaohang.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>

<body class="bg-f1f3f5">
    <div class="loading-box" id="cMloading">
        <div class="loading-tips">
            <img src="/imgs/images/icon/ico_loading.png" alt=""><span>加载中...</span>
        </div>
    </div>
    <div id="bigDiv">
	    <div class="pageContainer">
	    	<div class="list_top">
                 <%if (!(IsInApp || TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser)){ %>
				<header class="headerMain2">
		            <div class="header">
		                <a href="<%=GlobalUtils.WebURL %>" class="logo"></a>
		                <div class="top_right clearfix">
							<a href="javascript:void(0);" class="top_a2 rf webkit-box box-center box-vertical">
								<span></span>
								<span></span>
								<span></span>
							</a>
			            </div>
		            </div>
		        </header>               	        
                 <%} %>
				<div class="list_select clearfix bg-fff bt-e6e6e6">
                    <a href="/pages/invest/we/we_list.aspx" class="block w50p lf f17px text-center ">智能投资</a>
					<a href="javascript:void(0);" class="block w50p lf f17px text-center c-fab600">优质项目</a>
				</div> 
			</div> 

	        <div class="webkit-box w100p bg-fff bt-e6e6e6 bb-e6e6e6 list_sort">
	            <div class="w25p f15px text-center cur" onclick="OrderByFun('queryByDefault',0)" id="dvDefault">默认</div>
	            <div class="w25p f15px text-center" onclick="OrderByFun('queryByRate',2)" id="dvRate">
	                利率
					
	                <span class="inline-block">
	                    <p><i class="triangle triangle-up-gray" id="RateOrderBy"  orderby=""></i></p>
	                    <p><i class="triangle triangle-down-gray" id="dRateOrderBy"></i></p>
	                </span>
	            </div>
	            <div class="w25p f15px text-center" onclick="OrderByFun('queryByDeadline',1)" id="dvDeadline">
	                期限
					
	                <span class="inline-block">
	                    <p><i class="triangle triangle-up-gray" id="DeadlineOrderBy" orderby=""></i></p>
	                    <p><i class="triangle triangle-down-gray" id="dDeadlineOrderBy"></i></p>
	                </span>
	            </div>
	            <div class="w25p f15px text-center" id="dvfilter"  onclick="OrderByFun('filter',0)">筛选<i class="ico-con ico-down-gray" id="sort-ico"></i></div>
	        </div>
	        <div id="wrapper" class="bt-e6e6e6" style="background: none;top:<%=IsInApp || TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?70:118%>px;margin-bottom: 49px;">
	            <div id="scroller">
	                <div id="pullDown" style="background: #f1f3f5;">
	                    <div class="centerBox-wp">
	                        <div class="pullDownTips">
	                            <span class="pullDownIcon"></span>
	                            <span class="pullDownLabel"></span>
	                        </div>
	                    </div>
	                </div>
	                <div class="pt10 bg-f1f3f5"></div>
	                <div class="" id="thelist">
	                    <% if (RecordCount > 0)
	                       {
	                           foreach (var project in this.projectList)
	                           {
	                    %>
	                    <div class="list-item bb-e6e6e6">
	                        <a href="<%=GetClickUrl(project.TypeId, project.SubTypeId , project.Id)%>">
	                        <%--<% if (!new int[] {15, 24, 25, 26, 27,28}.Contains(project.TypeId))
	                           {
	                               %>
	                        <div class="item_r1">即投即计息</div>    
	                        <%
	                           } %>--%>
	                        <div class="item_r2 text-overflow">[<%=GetTypeName(project.TypeId,project.SubTypeId) %>]</div>
	                        <div class="item_r3">
	                            <div class="list-box-left">
	                                <p class="f12px c-ababab">预期年化利率</p>
	                                <p class="rate"><%=GetProjectYearRate(project) %></p>
	                            </div>
	                            <div class="list-box-center text-center">
	                                <p class="f12px c-ababab"><%=TuanDai.WXApiWeb.CommUtils.GetRepaymentTypeString(project.RepaymentType) %></p>
	                                <p class="f15px c-212121 mt15"><%=GetProjectShowDeadline(project) %></p>
	                            </div>
	                            <div class="list-box-right">
	                                <p class="f12px c-ababab">剩余<%=GetProjectSurplusMoney(project) %></p>
	                                <p class="f14px c-212121">
	                                    <a href="javascript:checkCgtSubGoUrl('<%=GetClickUrl(project.TypeId, project.SubTypeId , project.Id)%>');" class="toBuy">抢购</a>
	                                </p>
	                            </div>
	                        </div>
	                        <div class="item_r4 mt8">
	                            <span class="span1"><i class="ico_Shield2"></i>安全保障计划</span>
	                        </div>
	                        </a>
	                    </div>
	                    <%
	                           }
	                       }
	                       else
	                       {
	                    %>
	                    <div class="debt-empty mt50"><div class="img-debt-empty text-center"><img style="width: 60%;" src="/imgs/images/debt-empty.png"/></div><div class="text-center f14px c-212121 mt20">全部标都被抢完了！</div></div>
	                    <%
	                       } %> 
	                </div>
		            <div id="pullUp">
		                <span class="pullUpIcon"></span><span class="pullUpLabel"></span>
		            </div>
	            </div>
	        </div>
	    </div>
	    <!--筛选-->
	    <div class="alert pos-a hide" id="alert" style="padding-top:<%=IsInApp||TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?120:164%>px;">
	        <div class="bg-f7f7f5 pt25" id="sort-move">
	            <div class="pl15 pr15">
	                <p class="f15px c-212121"><span class="f15px c-ababab">年化利率：</span><span class="f23px c-212121" id="count1">5</span>%~<span class="f23px c-212121" id="count2">20</span>%</p>
	                <div class="range-slider">
	                    <span class="c-ababab f12px span_from pos-a">5%</span>
	                    <input type="text" class="js-range-slider1" value="" tabindex="-1" / style="border: none;">
	                    <span class="c-ababab f12px span_to pos-a">20%</span>
	                </div>
	                <p class="f15px c-212121 mt40">
	                    <span class="f15px c-ababab">回款期限：</span>
	                    <span class="f23px c-212121" id="count3">7<small class="f15px c-212121">天</small></span> ~
						
	                    <span class="f23px c-212121" id="count4">18<small class="f15px c-212121">个月</small></span>
	                    <i class="ico-edit" id="time-edit"></i>
	                </p>
	                <div class="range-slider">
	                    <span class="c-ababab f12px span_from pos-a">7天</span>
	                    <input type="text" class="js-range-slider2" value="" tabindex="-1" / style="border: none;">
	                    <span class="c-ababab f12px span_to pos-a">18个月</span>
	                </div>
	            </div>
	            <div class="webkit-box bt-e6e6e6 mt30">
	                <div class="box-flex1 text-center f17px c-808080 pt13 pb13 br-e6e6e6" id="reset">重置</div>
	                <div class="box-flex1 text-center f17px c-fab600 pt13 pb13" id="confirm">确定</div>
	            </div>
	        </div>
	    </div>
	    <!--底部-->
	    <div class="bt-e6e6e6 webkit-box box-center wx-footer">
	        <%--<a class="block box-flex1 text-center" href="/Index.aspx">
	            <p>
	                <img src="/imgs/images/icon/ico_f1.png" /></p>
	            <p class="f10px line-h18 c-626262">团贷</p>
	        </a>--%>
	        <a class="webkit-box box-center box-vertical box-flex1 text-center">
	            <p>
	                <img src="/imgs/images/icon/ico_f2_act.png" /></p>
	            <p class="f10px line-h18 c-ffc000">投资</p>
	        </a>
	        <a class="webkit-box box-center box-vertical box-flex1 text-center" href="/Member/my_account.aspx">
	            <p>
	                <img src="/imgs/images/icon/ico_f3.png" /></p>
	            <p class="f10px line-h18 c-626262">我</p>
	        </a>
	    </div> 
    </div>
    
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/ion.rangeSlider.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/InvestList.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/seo.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>

    <script type="text/javascript">
        var queryType = "queryByDefault";
        var orderByDesc = 1;
        var projectType = "0";
        var pageType="<%=pageType%>";
        var GylPlusRate="<%=GylPlusRate%>";//加息利率
        var Day15PlusRate="<%=Day15PlusRate%>";//加息利率
        pageIndex = 1; 
        pageCount=<%=pageCount %>;
    </script>
</body>
</html>
