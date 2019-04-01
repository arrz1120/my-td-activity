<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Investment.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.ExpGold.Investment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no"/>
		<meta name="apple-mobile-web-app-capable" content="yes"/>
		<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
		<meta name="format-detection" content="telephone=no"/>
		<link rel="stylesheet" type="text/css" href="css/style.css?v=2015121201"/>
	<title></title>
</head>
<body class="bg-df7c08">
		<div id="wraper">
			<img class="bg01" src="images/bg03.png" alt=""/>
			<div class="tit01 pos-a">
				投资体验金专享标
			</div>
			<div class="txt detail pos-a">
				借款金额<span>200</span>万&nbsp;&nbsp;&nbsp;利率 <span style="margin-left: -3px;">15</span>%&nbsp;&nbsp;&nbsp;期限<span>6</span>天
			</div>
			<div class="investNow w70 bor-r4 pos-a btn_big" id="btnInvest">
				马上投资
			</div>
			<div class="peopleCount pos-a txt">
				已有<font><span><%=count %></span>人</font>使用投资体验金
			</div>
			<div class="list_tit pos-a">
				<font>用户昵称</font><span>使用时间</span>
			</div>
			<div class="list pos-a">
				<div class="bd">
					<ul>
						  <%if (this.list != null && this.list.Count > 0)
						  {
							  string strName="";
							  foreach (var item in this.list)
							  {
								  strName=BusinessDll.StringHandler.MaskStarPre1(item.UserName);
							%>
							<li><font><%=strName.Length>12?strName.Substring(0,12):strName%></font><span><%=item.AddDate.ToString("yyyy-MM-dd")%></span></li>
						<%}
							}%>
						</ul>
				</div>
			</div>
			
			<div class="wp_bottom pos-a">
				要理财，上团贷网，最高年化收益18%!
			</div>	
		</div>	
		<!-- cover -->
		<div class="cover" style="display: none;">
			<div class="coverContent realName" style="display: none;">
				<div class="closeCover realName_close">
					
				</div>
				<div class="realName_top">
					为保障您的权益，投标前请先完成实名认证。
				</div>
				<div class="realName_tips">
					
				</div>
				<div class="name realName_inp h40">
					<span>您的姓名</span>
					<input id="txtRealName" type="text" class="nameInp h36 bor-r4" />
				</div>
				<div class="id realName_inp h40">
					<span>身份证号</span>
					<input id="txtIdCard" type="text" class="idInp h36 bor-r4" />
				</div>
				<div class="confirm realName_confirm" style="margin-top: 20px;" id="btnComfirm">
					确定
				</div>
			</div>
			<div class="coverContent success" style="display: none;">
				<div class="closeCover success_close">
					
				</div>
				<div class="success_img">
					<img src="images/success.png"/>
				</div>
				<div class="success_tips">
					恭喜您，认证成功！
				</div>
				<p class="success_guide">马上投资体验金专享标，赚取利息收益。</p>
				<div class="confirm success_confirm">
					确定
				</div>
			</div>
			
		</div>
		<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/jquery.SuperSlide.2.1.1.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/valid.js?v=20151032001"></script>
		<script type="text/javascript">
		    var IsValidRealName = "<%=IsValidRealName%>";
			function openEvent(openEle, container) {
				$(openEle).click(function () {
					showCover(container);
				})
			}
			function closeEvent(closeEle, container) {
				$(closeEle).click(function () {
					closeCover(container);
				})
			}
			function showCover(container) {
				$(container).show();
				$(".cover").show().addClass('scaleIn');
			}
			function closeCover(container) {
				$(".cover").addClass('scaleOut');
				setTimeout(function () {
					$(".cover").removeClass('scaleIn').removeClass('scaleOut').hide();
					$(container).hide();
				}, 400);
			}
			function goldAnimate() {
				$(".gold1").addClass('fadeInUp1');
				setTimeout(function () {
					$(".gold2").addClass('fadeInUp2');
				}, 30);
			}
			function slide() {
				jQuery(".list").slide({ mainCell: ".bd ul", autoPage: true, effect: "top", autoPlay: true, vis: 5 });
			}
			$(function () {
				goldAnimate();
				//openEvent(".investNow", ".realName");
				closeEvent(".realName_close", ".realName");
				closeEvent(".success_confirm", ".success");
				openEvent(".success_close")
				$(".success_close").click(function () {
				    window.location = location.href;
				})
				slide();
				//$(".realName_confirm").click(function () {
				//	$(".realName").hide();
				//	$(".success").show();
			    //});
				$("#btnInvest").click(function () {				    
				    if (IsValidRealName == "False") {
				        showCover(".realName");
				    }
				    else {
				        $.ajax({
				            url: "/Activity/ExpGold/ajax.ashx",
				            type: "post",
				            dataType: "json",
				            async: true,
				            data: {
				                Cmd: "ExpGoldInvest"
				            }, success: function (data) {
				                if (data != null) {
				                    $("#Experience").hide();
				                    switch (data.result) {
				                        case "-1":
				                            alert("您还未登录，登录之后再来投资！");
				                            break;
				                        case "-101":
				                        case "-100":
				                        case "0":
				                            alert("投资失败");
				                            break;
				                        case "1":				                            
				                            location.href = "ReceiveGold.aspx";
				                            break;
				                        case "2":
				                            alert("您没有体验金红包，不能投资了！");

				                            break;
				                        case "3":
				                            alert("您还没有领取体验金红包，不能投资！");

				                            break;
				                        case "4":
				                            alert("很遗憾，您的2000元体验金已过期！不过还有更多新手红包等您来拿。！");

				                            break;
				                        case "5":
				                            alert("您的体验金红包已使用！");

				                            break;
				                        case "6":
				                            alert("您需要完成手机、实名认证才能投资体验金专享标");
				                            break;
				                    }
				                } else {
				                    alert("投资失败");
				                }
				            }, error: function () {
				                alert("投资失败");
				            }
				        });				        
				    }
				})
				$("#btnComfirm").click(function () {
				    RealNameValid();				    	    
				})
			})
		</script>
	</body>
</html>
