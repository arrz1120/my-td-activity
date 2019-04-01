<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="survey.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.XinXingFansMeetAndGreet.survey" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>问卷调查</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
<link rel="stylesheet" type="text/css" href="/css/survey.css" /><!--问卷调查-->
</head>
<body> 
   <%= this.GetNavStr()%>
	<header class="headerMain">
		<div class="header">
			<div class="back" onclick="javascript:window.location.href='Index.aspx'">返回</div>
			<h1 class="title">问卷调查</h1>
		</div>
		<%= this.GetNavIcon()%>
		<div class="none"></div>
	</header>

	<div class="survey">
		<header>
			问卷调查（可多选）：
		</header>
		<div class="exam">
			<div class="item" data-type="multiple">
				<div class="itemTit">
					1.您从什么时候开始认识团贷网？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 2012年</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 2013年</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 2014年</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>D. 2015年</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					2.您从什么渠道结识团贷网？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 网络</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 朋友介绍</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 广告</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>D. 其他</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					3.您选择团贷网投资的理由？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 平台安全可靠</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 平台投资利率高</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 欣赏老板唐军</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>D. 发展前景好</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					4.您经常在团贷网上充当什么角色？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 投资人</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 借款人</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 既是投资人也是借款人</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					5.您的首次投资金额是多少？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 标的最低起投标准</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 1000 ~ 5000</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 5000 ~ 10000</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 10000以上</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
    			<div class="itemTit">
    				<span>6.</span>
    				您觉得团粉活动在什么时间开展方便您的安排？
    			</div>
    			<div class="itemCon">
    				<ul class="clearfix">
    					<li>
    						<div class="checkBox"></div>
    						<p>A. 周一到周四</p>
    					</li>
    					<li>
    						<div class="checkBox"></div>
    						<p>B. 周五</p>
    					</li>
    					<li>
    						<div class="checkBox"></div>
    						<p>C. 周六</p>
    					</li>
    					<li>
    						<div class="checkBox"></div>
    						<p>C. 周日</p>
    					</li>
    				</ul>
    			</div>
    		</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					7.您觉得团粉活动在以下哪方面最重要？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 互动性强</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 趣味性强</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 最好能与唐军面对面</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 内容性强</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					8.您觉得团粉日活动以什么样的形式进行比较好？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 沙龙</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 讲座论坛</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 户外活动</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 其他</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					9.如果您来参加活动的话最期待活动有哪方面的内容？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
    					<li>
    						<div class="checkBox"></div>
    						<p>A. 游戏环节抢好礼</p>
    					</li>
    					<li>
    						<div class="checkBox"></div>
    						<p>B. 深入解析团贷网</p>
    					</li>
    					<li>
    						<div class="checkBox"></div>
    						<p>C. 团粉之间的交流</p>
    					</li>
    					<li>
    						<div class="checkBox"></div>
    						<p>C. 沟通答疑环节</p>
    					</li>
    				</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					10.您希望活动的时间控制在多长时间以内？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 1-2 个小时</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 2-3个小时</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 3个小时以上</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="multiple">
				<div class="itemTit">
					11.您更习惯团粉日报名通过以下哪些渠道？
				</div>
				<div class="itemCon">
					<ul class="clearfix">
						<li>
							<div class="checkBox"></div>
							<p>A. 官网报名</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>B. 微信报名</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 400电话报名</p>
						</li>
						<li>
							<div class="checkBox"></div>
							<p>C. 论坛上报名</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="item" data-type="simple">
				<div class="itemTit bbnone">
					12.您觉得团粉日在哪些方面还有改进的空间？请提出宝贵的意见。
				</div>
				<div class="itemCon">
					<div class="textArea">
						<textarea></textarea>
					</div>
				</div>
			</div>
			<div class="submit">
				<div class="submit_btn">
					马上提交
				</div>
			</div>
		</div>
	</div>
	<div class="window" style="display: none;">
		<!-- 获得一次抽奖机会弹窗 -->
		<div class="window_con getChance" style="display: none;">
			<div class="close" id="getChance_close"></div>
			<h3>您已获得<span>1</span>次抽奖机会</h3>
			<p>感谢您参与问卷调查!</p>
			<div class="window_btn" id="mscj">
				马上抽奖
			</div>
		</div>
		<!-- 已参与弹窗 -->
		<div class="window_con noChance" style="display: none;">
			<div class="close" id="noChance_close"></div>
			<h3>您已参与过此调查问卷了。</h3>
			<div class="window_btn" id="return">
				返回
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js"></script>
	<script type="text/javascript">
		$(function () {
			$(".checkBox").on('touchstart', function () {
				var _this = $(this);
				if (_this.hasClass('active')) {
					_this.removeClass('active');
				} else {
					_this.addClass('active');
				}
			});
			$(".submit_btn").click(function () {
			    var postString = "";
			    var splitter = "|";
			    var isRight = true;
			    $(".item").each(function () {
			        var type = $(this).data("type");
			        var question = $(this).text();
			        switch (type) {
			            case "multiple":  //多选.
			                var answer = "";
			                var question = "";
			                var options = $(this).find(".active");
			                splitter = "|";
			                if (options.length > 0) {
			                    question = $(this).find(".itemTit").html();
			                }
			                else {
			                    String: aa = $(this).find(".itemTit").html();
			                    alert(aa.substring(0, aa.indexOf(".")) + "题还没有勾选");
			                    isRight = false;
			                    return false;
			                }
			                $(this).find(".active").each(function (index, element) {
			                    if (index == options.length - 1) splitter = '';
			                    answer += $.trim($(this).next("p").html()) + splitter;
			                })
			                postString += "&" + question + "=" + answer;
			                break;
			            case "simple":
			                var opinion = $(this).find("textarea:first").val();
			                if (opinion == "") {
			                    var aa = $(this).find(".itemTit").html();
			                    alert(aa.substring(0, aa.indexOf("."))+ "题不能为空");
			                    isRight = false;
			                    return false;
			                }
			                postString += "&" + $(this).find(".itemTit").html() + "=" + opinion;
			                break;
			        }
			    });
			    if (isRight == false)
			        return;

			    var sessionId =getCookie('sessionId');
				$.ajax({
				    url: "/AjaxCross/ajax_Acticity.ashx",
				    type: "post",
				    dataType: "json",
				    async: false,
				    data: {
				        Cmd: "SaveSurvey", survey: postString, sessionid: sessionId
				    }, success: function (data) {
				        if (data.Result == "1") {
		                    $(".window").show();
			                $(".getChance").show();
				        }
				        else if (data.Result == "2") {
				            $(".window").show();
				            $(".noChance").show();
				        }
                        else{
				            alert(data.msg);
				        }
				    }, error: function () {
				        alert("提交失败，请稍后重试!");
				    }
				}); 
			});
			$("#mscj").click(function () {
				$(".getChance").hide();
				window.location.href = "index.aspx";
			});
			$("#return").click(function () {
				$(".window").hide();
				$(".noChance").hide();
			});
			$("#getChance_close").click(function () {
				$(".window").hide();
				$(".getChance").hide();
			});
			$("#noChance_close").click(function () {
				$(".window").hide();
				$(".noChance").hide();
			});
		})

	</script>

</body>
</html>
