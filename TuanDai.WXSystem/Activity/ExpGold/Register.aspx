<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Register.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.ExpGold.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	 <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <title></title>
    <meta name="keywords" content="团贷网,你我金融,互联网金融,P2P网贷,P2P理财"/>
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。"/>
    <link rel="stylesheet" type="text/css" href="css/index.css?v=20151208002"/>
    <!--动态计算rem-->
    <script type="text/javascript">
        (function (doc, win) {
            var docEl = doc.documentElement,
                    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                    recalc = function () {
                        var clientWidth = docEl.clientWidth;
                        if (!clientWidth) return;
                        docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
    </script>
</head>
<body> 
      <div id="wraper">
            <img class="bg01" src="images/bg_01.png" alt=""/>
            <div class="gold1 pos-a fadeInUp1">
                <img src="images/gold1.png"/>
            </div>
            <div class="gold2 pos-a fadeInUp2">
                <img src="images/gold2.png"/>
            </div>
            <div class="inpWrap pos-a">
                <div class="inp w70">
                    <input class="telInp h40 bor-r4 pl12 fs16 ffhei" id="telInp"  maxlength="11" type="text" placeholder="输入手机号码即可领取2000元"/>
                </div>
                <div id="codeWrap" style="display: none;">
                    <div class="code w70 mt8 clearfix">
                        <input class="codeInp h40 bor-r4 pl12 w56 fl fs16 ffhei" maxlength="4" type="text" id="txtValidNumber" placeholder="输入图形验证码"/>
                        <img class="h40 bor-r4 btn fr w40 fs16" src="/ValidateCode.ashx?v=20151208001" id="imgVcode" onclick="reloadCode('/ValidateCode.ashx')"/>
                    </div>
                    <div class="telCode w70 mt8 clearfix">
                        <input class="telCodeInp h40 bor-r4 pl12 w56 fl fs16 ffhei" type="text" maxlength="6" id="messCode" placeholder="输入手机验证码"/>
                        <button id="getCode" class="h40 bor-r4 btn fr w40 fs16">
                            获取验证码 
                            <!--请稍等（60s）-->
                        </button>
                    </div>
                </div>
                <div class="investNow w70 bor-r4" id="btnReceive">
                    马上投资
                </div>
                <div class="ins mt20auto">
                    活动说明
                </div> 
            </div>                
        </div>

         <div class="cover" style="display: none;">
            <div class="coverContent rule" style="display: none;">
                <div class="closeCover">
                    
                </div>
                <ul>
                    <li>投资体验金不能提现，仅能用于投资体验专享标之用；</li>
                    <li>完成投标后，利息收益将以红包形式发放至您的团宝箱，同时团贷网将收回体验金本金；</li>
                    <li>利息红包自发放之日起30天内，累计投资满2000元即可使用；</li>
                    <li>本活动最终解释权归团贷网所有。</li>
                </ul>
            </div> 
            <div class="coverContent getCash" style="display: none;">
				<div class="hb">
					<img src="images/hb.png"/>
					<img class="star1 pos-a scaleFadeIn" src="images/star1.png"/>
					<img class="star2 pos-a scaleFadeIn" src="images/star2.png"/>
				</div>
				<p class="tips">恭喜您，已领取2000元投资体验金！</p>
				<div class="confirm" id="confirmTo3">
					确定
				</div>
			</div>
        </div>
         <section class="sec sec02">
        <div class="head">
            <div class="line"></div>
            <h2>大咖的选择·信心满满的</h2>
        </div>
        <p class="c-898989 fs028r ti056r pt4r">团贷网是一家专注于「在线理财服务」的知名互联网金融平台，通过整合小微企业融资需求，旨在为广大投资人提供“收益高、保障齐”的多元化理财产品。</p>
        <div class="pt4r clearfix">
            <div class="fl hezhao">
                <img src="images/hezhao.png">
            </div>
            <div class="fr frTxt">
                <div class="pb2r bb-dcdcdc">
                    <h6>·商界大咖指路</h6>
                    <p>运营以来史玉柱、江南春、王利芬、冯仑等商界大咖倾力指导。</p>
                </div>
                <div class="pt2r">
                    <h6>·顶尖机构投资</h6>
                    <p> 2015年6月，获九鼎投资、巨人投资（史玉柱创立）、九弈投资战略投资， 完成2亿元B轮融资！</p>
                </div>
            </div>
        </div>  

        <div class="pt4r clearfix">
            <div class="fl tjb tjb_l" id="projectDesc1">
                <h5>新手专享</h5>
                <p class="p1"><span>15</span>%年化收益</p>
                <p class="p2">1个月/到期本息</p>
                <p class="p3">起投金额 100元</p>
            </div>
            <div class="fr tjb tjb_r" id="projectDesc2">
                <h5>新手专享</h5>
                <p class="p1"><span>13</span>%年化收益</p>
                <p class="p2">15天/到期本息</p>
                <p class="p3">起投金额 10元</p>
            </div>
        </div>
        <div class="knowMore mt4r btnBreath" id="knowMore">
            了解更多<img src="images/icon.png" id="icon">
        </div>
     </section>

     <section class="sec sec03 pt1r hide">
        <div class="img">
            <img src="images/more1.png">
        </div>
        <div class="img">
            <img src="images/more2.png">
        </div>
        <div class="img">
            <img src="images/more3.png?v=2015122601">
        </div>
     </section>
    
    <section class="sec sec04 mt4r">

        <div class="head">
            <div class="line"></div>
            <h2>团贷网理财·安全杠杠的</h2>
        </div>

        <div class="item clearfix mt4r">
            <img src="images/i1.png" class="fl"/>
            <div class="fl itemCn">
                <p class="p1 c-179bef">第三方机构担保</p>
                <p class="p2">当出现借款逾期时，由担保机构先行垫付。</p>
            </div>
        </div>

        <div class="item clearfix">
            <img src="images/i2.png" class="fl"/>
            <div class="fl itemCn">
                <p class="p1 c-fd7c00">足额抵押物保障</p>
                <p class="p2">借款人或借款企业在借款前，会严格审核其清偿能力。</p>
            </div>
        </div>

        <div class="item clearfix">
            <img src="images/i3.png" class="fl"/>
            <div class="fl itemCn">
                <p class="p1 c-00b091">财付通资金托管</p>
                <p class="p2">投资人的资金直接流向借款人，平台不归集资金。</p>
            </div>
        </div>

        <div class="item clearfix">
            <img src="images/i4.png" class="fl"/>
            <div class="fl itemCn">
                <p class="p1 c-f84330">阳光保险全程承保</p>
                <p class="p2">与阳光保险签订协议，全程承保投资人的财产损失。</p>
            </div>
        </div>
        <p class="userCount">已有<span><%=UserCount.ToString("N0")%></span>位用户选择我们</p>
        <div class="knowMore mt2r btnBreath" id="toTop1">
            马上加入
        </div>    
     </section>
     <div class="bottomFixed hide" id="toTop2">
        <p class="p1">注册领取<span>2000元</span>体验红包</p>
        <p class="p2"><span>388元</span>现金红包</p>
     </div> 


		<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="/scripts/base.js?v=20151209001" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			var tdFrom = "<%=tdFrom %>";
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
			function link() {
				$("#confirmTo3").click(function () {
				    location.href = "Investment.aspx";
				})
			}
			function onInp() {
				var oInp = document.getElementById('telInp');
				oInp.oninput = function () {
					var val = oInp.value;
					if (val.length == 11) {
						$(".ins").removeClass('mt20auto').addClass('mt8auto');
						$("#codeWrap").slideDown();
					}
				}
			}

			$(function () {
			    goldAnimate();
			    openEvent(".ins", ".rule");
				closeEvent(".closeCover", ".rule"); 
				$('#messCode').blur(function () { BlurCode(false); });
				$("#telInp").blur(function () { BlurTelNo(false); });
				$("#btnReceive").click(function () {
					RegSubmit($("#btnReceive"));
				});
				link();
				onInp();
				$("#getCode").bind("click", function () { sendMobileValidSMSCode(); });
				$(window).scroll(function () {
				    var st = $(window).scrollTop();
				    var secH = $('#wraper').height();
				    if (st > secH) {
				        $('.bottomFixed').removeClass('hide');
				    }
				    else {
				        $('.bottomFixed').addClass('hide');
				    }
				});
				$('#knowMore').on('touchstart', function () {
				    var sec03 = $('.sec03');
				    var icon = $('#icon');
				    if (sec03.hasClass('hide')) {
				        sec03.removeClass('hide');
				        icon.removeClass('ico-ani2').addClass('ico-ani1');
				    }
				    else {
				        sec03.addClass('hide');
				        icon.removeClass('ico-ani1').addClass('ico-ani2');
				    }
				});
				$('#toTop1,#toTop2').click(function () {
				    $('html body').animate({ scrollTop: 0, }, 600);
				});
				$('#projectDesc1').click(function () {
				    $('html body').animate({ scrollTop: 0, }, 600);
				});
				$('#projectDesc2').click(function () {
				    $('html body').animate({ scrollTop: 0, }, 600);
				});
			})


			function reloadCode(urlString) {
				$("#imgVcode").attr("src", urlString + "?id=" + Math.random());
			}

			var timer = null;
			var leftsecond = 60; //倒计时
			var mbTest = /^(13|14|15|17|18)[0-9]{9}$/;

			//获取手机验证码
			function sendMobileValidSMSCode() {
			    var mobile = $("#telInp").val();
			    var ValidNumber = $("#txtValidNumber").val();

				if (mobile == "") {
					alert("手机号码不能为空");
					return;
				}
				if (ValidNumber == ""){
				    alert("验证码不能为空");
				    return;
				}
				if (!ValidateImgCode()) {
					return;
				}		        
				var validCode = $("#txtValidNumber").val();
				$("#getCode").unbind();
				if (mbTest.test(mobile)) {
					$("#getCode").val("短信发送中...");
					$.ajax({
						url: "/ajaxCross/Login.ashx",
						type: "post",
						dataType: "json",
						data: { cmd: "GetPhoneRegCode", mobilenumber: mobile, ValidCode: validCode },
						success: function (json) {
							var result = json.result;
							leftsecond = 60;
							if (parseInt(result) == -100) { window.location.href = "/View/NoticeMessage.aspx?status=2"; }
							$("#getCode").addClass('countdown').html('请稍等（60s）');
							if (result == "1") {
								clearInterval(timer);
								timer = setInterval(setLeftTime, 1000, "1");
								$("#telInp").attr("readonly", true);
							}
							else if (result == "0") {
								if (json.msg != "") {
									alert(json.msg);
								}
								clearInterval(timer);		                        
								timer = setInterval(setLeftTime, 1000, "1");
								$("#telInp").attr("readonly", true);
							}
							else {		                        
								alert(json.msg)
								clearInterval(timer);
								timer = setInterval(setLeftTime, 1000, "1");
								$("#telInp").attr("readonly", true);
							}
						},
						error: function () {
							$("#getCode").bind("click", function () { sendMobileValidSMSCode(); });
							$("#getCode").val("获取手机验证码");
						}
					});
				}
				else {
					$("#getCode").bind("click", function () { sendMobileValidSMSCode(); });
				}
			}

			function setLeftTime() {
				var second = Math.floor(leftsecond);	        	        
				$("#getCode").html('请稍等（' + second + 's）');
				leftsecond--;
				if (leftsecond < 1) {
					clearInterval(timer);
					try {
						$("#getCode").bind("click", function () { sendMobileValidSMSCode(); });
						$("#getCode").removeClass('countdown').html('获取验证码');
						$("#telInp").removeAttr("readonly");
					} catch (E) { }
					return;
				}
			}
			/*图形验证码验证*/
			function ValidateImgCode() {
				var code = $("#txtValidNumber").val();
				if (code == "") {
					$("#dvValidNumber").html("图形验证码不能为空");
					return false;
				}
				else {
					$("#dvValidNumber").html("&nbsp;");
					return true;
				}
			}

			//用户注册
			function RegSubmit(ctrl) { 
				if (BlurTelNo(true) && ValidateImgCode() && BlurCode(true)) {
					$(ctrl).unbind("click");
					$.ajax({
						async: true,
						url: "/Activity/ExpGold/ajax.ashx",
						dataType: "json",
						type: "post",
						data: {
							cmd: "RegisterUser", mobilenumber: $("#telInp").val(), verificationCode: $("#messCode").val(), from: tdFrom
						},
						success: function (json) {
						    //AsyncReg(json);
						    if (json.result == "1") {
						        showCover(".getCash");
						    }
						    else {
						        alert(json.msg);						        
						    }
						},
						error: function () {
							$(ctrl).click(function () { RegSubmit(ctrl); });
						}
					});
				}
			}
			//检验 验证码
			function BlurCode(isSubmit) {
			    var txt = "#messCode"; 
			    var str = $("#messCode").val();
			    var pat = new RegExp("^[0-9]{6}$", "i");

			    if ($.trim(str) != "") {
			        if (!pat.test(str)) {//格式不正确 
			            alert("验证码错误,请重新输入");
			            return false;
			        }
			        else {
			            //$(td).html("&nbsp;");
			            return true;
			        }
			    }
			    else {
			        if (isSubmit == true) { 
			            alert("请输入验证码");
			        }
			        else {
			            //$(td).html("&nbsp;");
			        }
			        return false;
			    }
			}


			function BlurTelNo(isSubmit) {
			    var result = false;
			    var txt = "#telInp";
			    //var td = "#dvPhoneError";
			    var patTel = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
			    var str = $(txt).val();
			    if ($.trim(str) != "") {
			        if (patTel.test(str)) {
			            $.ajax({
			                async: false,
			                url: "/ajaxCross/Login.ashx",
			                dataType: "json",
			                type: "post",
			                data: {
			                    cmd: "CheckPhone", mobilenumber: $("#telInp").val()
			                },
			                success: function (json) {
			                    if (json.result == "False") {
			                        //$(td).html("&nbsp;");
			                        result = true;
			                    } else {
			                        //$(td).html("该手机号码已注册，本活动页仅限邀请新注册用户");
			                        alert("该手机号码已注册，本活动页仅限邀请新注册用户");
			                        result = false;
			                    }
			                },
			                error: function () {
			                    //$(td).html("手机号码检测失败");
			                    alert("手机号码检测失败");
			                    result = false;
			                }
			            });

			        }
			        else {
			            //$(td).html("输入手机号码格式不正确");
			            alert("输入手机号码格式不正确");
			            result = false;
			        }
			        return result;
			    }
			    else {
			        if (isSubmit == true) {
			            //$(td).html("手机号码不能为空");
			            alert("手机号码不能为空");
			        }
			        else {
			            //$(td).html("&nbsp;");
			        }
			        return false;
			    }
			}
		</script>
	</body>
</html>
