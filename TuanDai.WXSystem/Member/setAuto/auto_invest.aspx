<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="auto_invest.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.setAuto.auto_invest" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>自动投标</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
        <link rel="stylesheet" type="text/css" href="/css/auto-invest.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>

	<body class="bg-f6f7f8">
	    <%=GetNavStr() %>
		<div class="pl15">
			<div class="clearfix">
				<p class="f13px lf ranking">排名：<%if (rankid > 0)
                   { %>
                       <span class="c-fd6040 f13px"><%=rankid%></span>名
                <%}%>
                 <%else
                     { %>未开启
                  <%}%></p>
				<a href="/Member/setAuto/auto_rule.aspx" class="rf j-rule c-fd6040 f13px ranking pr15">规则</a>
			</div>
		</div>
        <%
	        if (this.autoList.Count > 0)
	        {
	            var rowCount = 0;
	            foreach (var model in this.autoList)
	            {
	                rowCount = rowCount + 1;
	                var isWe = false;
	                if (model.StartDeadType == 0 && model.EndDeadType == 0 && model.StartDeadLine == 0 && model.EndDeadLine == 0)
	                    isWe = true;
	    %>
		<div class="auto-item pl15 bb-e6e6e6 bt-e6e6e6 bg-fff">
			<div class="clearfix bb-dashed top-con">
				<p class="lf"><%=rowCount==1?"一":rowCount==2?"二":"三" %>：<%=isWe?"智能投资计划":"投资优质项目" %></p>
				<div class="states mt8 rf mr15">
					<%if (model.Status.ToString() == "0")
                            {%>
                            <input type="checkbox" class="switch" id="time<%=model.Id %>" attrval="<%=model.Id %>" status="<%=model.Status %>" pattern="<%=isWe?"2":"1" %>">
                            <label for="time<%=model.Id %>" id="lab<%=model.Id %>"></label>
                            <%}
                            else
                            {%>
                            <input type="checkbox" class="switch" id="time<%=model.Id %>" attrval="<%=model.Id %>" status="<%=model.Status %>" checked="checked" pattern="<%=isWe?"2":"1" %>">
                            <label for="time<%=model.Id %>"  id="lab<%=model.Id %>"></label>
                        <%}%> 
				</div>
			</div>
			<div class="autoList webkit-box" onclick="javascript:window.location.href='<%=isWe?"autoWeSet.aspx":"autoSet.aspx" %>?type=1&id=<%=model.Id %>';">
			    <% if (!isWe)
                       {
                    %>
				<div>
					<p class="f13px c-ababab">年化利率</p>
					<p class="f15px c-fd6040 pt5"><%= getRateRank(model.StartRate, model.EndRate) %></p>
				</div>
				<div>
					<p class="f13px c-ababab">回购时间</p>
					<p class="f15px pt5"><%= getDeadline(model.StartDeadLine, model.EndDeadLine, model.StartDeadType, model.EndDeadType) %></p>
				</div>
                <%
                       }
                       else
			       {
			           GetWeAutoString(model.ProjectType);
                    %>
                    <div>
					    <p class="f13px c-ababab">年化利率</p>
					    <p class="f15px c-fd6040 pt5"><%=WeMinRate %>%</p>
				    </div>
				    <div>
					    <p class="f13px c-ababab">回购时间</p>
					    <p class="f15px pt5"><%=WeDeadlines %>个月</p>
				    </div>
                    <%
                       } %>
				<div>
					<p class="f13px c-ababab">有效期限</p>
					<p class="f15px pt5"><%= getValid(model.StartDate, model.EndDate)%></p>
				</div>
			</div>
			<i class="pos-a ico-arrow-d-ccc"></i>
		</div>
        <% }
	        } %>
		<div class="mt30 pl15 pr15">
			<a onclick="JAVASCRIPT:if('<%=autoList.Count>=3 %>' == 'True'){$('body').showMessage({message:'自动投标最多设置3条',showCancel:false}) ; return false;};" <%=autoList.Count<3 && (ConfigHelper.getConfigString("IsOpenNewAutoInvest", "0") != "0")?"href='autoWeSet.aspx?type=0'":"href='autoSet.aspx'" %> class="btn btnYellow"><i class="ico-plus mr10"></i>添加</a>
			<p class="f13px c-999999 pt10 text-center">您最多可以保存3条自动投标设置</p>
		</div>
		<div class="bot f13px c-999999 w100p text-center mt8">启用自动投标即表示您同意<a class="f13px" href="/Member/setAuto/setAutoAccredit.aspx">《自动投标授权书》</a></div>
        
        <script type="text/javascript" src="/scripts/jquery.min.js"></script>
		<script type="text/javascript" src="/scripts/fastclick.js"></script>
        <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
        <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
        <script type="text/javascript">
            $(function () {
                $("#btnCancel").click(function () {
                    window.location.href = window.location.href;
                });

                //启用、暂停
                $(".switch").click(function () {
                    var status = $(this).attr("status");
                    var id = $(this).attr("attrval");
                    var pattern = $(this).attr("pattern");
                    var str = "确定要开启吗？";
                    if (status == "1") {
                        status = "0";
                        str = "确定要暂停吗？";
                    }
                    else {
                        status = "1";
                    }

                    $("body").showMessage({
                        message: str, okString: "确定", cancelString: "取消", okbtnEvent: function () {
                            $.ajax({
                                url: "/ajaxCross/ajax_autoLoan.ashx",
                                type: "post",
                                dataType: "json",
                                data: { Cmd: "updateStatus", status: $("#divPopTips").attr("dataStatus"), id: $("#divPopTips").attr("dataId"), pattern: $("#divPopTips").attr("pattern") },
                                success: function (json) {
                                    var d = json.result;
                                    if (parseInt(d) == 1) {
                                        window.location.href = window.location.href;
                                    }
                                    else {
                                        $("body").showMessage({ message: "修改失败" });
                                    }
                                },
                                error: function () {
                                    $("body").showMessage({ message: "网络不给力" });
                                }
                            });
                        },cancelEvent:function() {
                            window.location.href = window.location.href;
                        }
                    });
                    $("#divPopTips").attr("dataStatus", status).attr("dataId", id).attr("pattern", pattern).bind("click",function() {
                        window.location.href = window.location.href;
                    });
                });
            });
        </script>
	</body>
</html>