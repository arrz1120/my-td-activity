<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameIndex.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.HighSpeedGame.GameIndex" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>脑洞全开 - 测你财“经”有多大？</title>
    <meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
    <meta name="description" content="团贷网是中国互联网金融领军企业，首家注册资本一亿元股份制网贷平台，解决中小微企业资金需求，为投资用户带来高收益。100%本息担保、100%人工审核、足额抵押物担保，确保投资理财用户资金安全。">
    <meta name="viewport" content="width=device-width initial-scale=1.0 user-scalable=no" />
    <meta content="telephone=no" name="format-detection" /> 
    <link rel="stylesheet" href="css/question.css?v=20150713" />
    <script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>  
    <script type="text/javascript"> 
        wx.config({
            debug: false,
            appId: '<%=AppId %>',
            timestamp: <%=TimeStamp%>,
            nonceStr: '<%=NonceStr %>',
            signature: '<%=Signature %>',
            jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'hideMenuItems',
                'showMenuItems' 
                ]
            });
    </script>
</head>
<body>
 <input type="hidden" id="hidenRightAnswerNum" value="0" />
<section class="con">
    <section class="start-con">
        <div class="full-pos bg1"></div>
        <div class="full-pos p11"></div>
        <div class="full-pos p12"></div>
        <div class="full-pos p13"></div>
        <div class="full-pos p14"></div>
        <div class="full-pos p15 animated pulse"></div>
        <div class="full-pos p16 animated zoomInDown "></div>
        <div class="full-pos p17"></div>
        <a id="start" class="start-but" href="javascript:;"></a>
    </section>
    <section class="card-con second-con here">
        <div class="full-pos bg2"></div>
        <div class="full-pos p21"></div>
        <div class="full-pos p22"></div>
        <div class="full-pos p23 animated bounceIn"></div>
        <div class="full-pos p24 animated bounce"></div>
    </section>

    <!--人物篇 Start--> 
    <section class="card-con bg3">  
        <input type="hidden" id="hideExamId1" value="<%=personModel.ExamId %>" />
        <div class="card">
            <div class="avatar-box">
               <img src="<%=personModel.Title %>" alt=""/>
            </div>
            <div class="description">
               <h3>1.请找出关于图中人物的错误信息</h3>
            </div>
            <div class="check-con">
                <button class="button" attrdata="A"><span>A.</span><%=personModel.AnswerA%></button>
                <button class="button" attrdata="B"><span>B.</span><%=personModel.AnswerB%></button>
                <button class="button" attrdata="C"><span>C.</span><%=personModel.AnswerC%></button>
                <button class="button" attrdata="D"><span>D.</span><%=personModel.AnswerD%></button>
            </div>
        </div>
    </section>

     <!--算术篇 Start-->
    <section class="card-con bg4">
        <input type="hidden" id="hideExamId2" value="<%=arithModel.ExamId %>" />
        <div class="card">
            <div class="description">
                <h3 class="dif-title">2.<%=arithModel.Title%></h3>
            </div>
            <div class="check-con">
                <button class="button" attrdata="A"><span>A.</span><%=arithModel.AnswerA%></button>
                <button class="button" attrdata="B"><span>B.</span><%=arithModel.AnswerB%></button>
                <button class="button" attrdata="C"><span>C.</span><%=arithModel.AnswerC%></button>
                <button class="button" attrdata="D"><span>D.</span><%=arithModel.AnswerD%></button>
            </div>
        </div>
    </section>

    <!--看图识标篇 Start-->
    <section class="card-con bg5">
        <input type="hidden" id="hideExamId3" value="<%=logoModel.ExamId %>" />
        <div class="card">
            <div class="description">
                <h3>3.以下哪个logo姿势正确？</h3>
            </div>
            <div class="topic3">
                <div class="topic3-cn clearfix">
                    <button class="button left"  attrdata="A"><img src="<%=logoModel.AnswerA%>" alt=""/></button>
                    <button class="button right" attrdata="B"><img src="<%=logoModel.AnswerB%>" alt=""/></button>
                </div>
                <div class="topic3-cn clearfix">
                    <button class="button left" attrdata="C"><img src="<%=logoModel.AnswerC%>" alt=""/></button>
                    <button class="button right" attrdata="D"><img src="<%=logoModel.AnswerD%>" alt=""/></button>
                </div>
            </div>
        </div>
    </section> 

</section>
 
<!--音乐-->
<div class="music">
    <i class="icon-music open" num="1"></i><i class="music-span"></i>
    <audio id="aud" src="imgs/music.mp3" loop="loop" autoplay="autoplay"></audio>
    <div class="music_text">开启</div>
</div>

<!--弹窗-->
 <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
        <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>  
    </span>
    <span style="float: right;max-width: 60%;padding-right: 20px;">
        <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/> 
    </span>
  </div>
</section>
<!--遮罩层-->
<div class="maskLayer hide"></div>

<script src="js/jquery-2.1.1.min.js"></script>
<script src="js/weixinapi.js?v=2.3" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
<script type="text/javascript">
    var hasFinishNum = 1;
    $(document).ready(function () {
        (function readyStyle() {
            inner_height = window.innerHeight;
            margin_top = Math.floor(((innerHeight - 250) / 2) + 10);
            full_margin_top = margin_top + 'px';
            $('.start-con').css({
                height: inner_height
            });

            $('.description').each(function () {
                $(this).css({
                    marginTop: full_margin_top
                })
            });
            $('.card-con').each(function () {
                $(this).css({
                    height: inner_height
                })
            });
        } ())


        $('#start').click(function () {
            $('.start-con').fadeOut(500);
            $('.second-con').addClass('animate-show');
        });

        $('.second-con').bind('touchstart', function (e) {
            e.preventDefault();
            $(this).fadeOut(500);
            $(this).next('.card-con').addClass('here');
        });
//        $(".p24").click(function () {
//            $(this).fadeOut(500);
//            $(this).next('.card-con').addClass('here');
//        });

        $('.p23').click(function () {
            $(this).parent().fadeOut(500);
            $(this).parent().next('.card-con').addClass('here');
        });


        $('.button').click(function () {
            var examId = $(this).parents(".card-con").children('input:hidden').val();
            var isResult = selectSubject(examId, $(this).attr("attrdata"));
            if (isResult) {
                $(this).addClass('checked');
                $(this).parents('.card-con').fadeOut(200);
                $(this).parents('.card-con').next().addClass('here');
                if (hasFinishNum == 3) {
                    //已经答完所有题目
                    PostSubmit("/Activity/HighSpeedGame/ExamResult.aspx", $("#hidenRightAnswerNum").val());
                    return;
                }
                hasFinishNum++;
            }
        });
    });
    function selectSubject(examId, answer) {
        var isResult = false;
        $.ajax({
            url: "/ajaxCross/HighSpeedGameAjax.ashx",
            type: "post",
            dataType: "json",
            async: false,
            data: {
                Cmd: "AnswerQuestion",
                ExamId: examId,
                Answer: answer
            },
            success: function (data) {
                switch (data.result) {
                    case "1": //回答正确
                        var rightNum = $("#hidenRightAnswerNum").val();
                        if (rightNum == "")
                            rightNum = 0;
                        else
                            rightNum = parseInt($("#hidenRightAnswerNum").val());
                        $("#hidenRightAnswerNum").val(rightNum + 1);
                        isResult = true;
                        break;
                    case "0"://回答错误
                        isResult = true;
                        break;
                    default:
                        ShowMsg(data.msg);
                        break;
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ShowMsg("答题失败，请重试!");
            }
        });
        return isResult;
    }

    function Done() {
        $(".maskLayer").fadeOut();
        $("#tip").animate({
            bottom: "-430px"
        }, 200);
    }
    function PostSubmit(url, data) {
        var postUrl = url; //提交地址  
        var postData = data; //第一个数据  
        var ExportForm = document.createElement("FORM");
        document.body.appendChild(ExportForm);
        ExportForm.method = "POST";
        var newElement = document.createElement("input");
        newElement.setAttribute("name", "jsondata");
        newElement.setAttribute("type", "hidden");
        ExportForm.appendChild(newElement);
        newElement.value = postData;
        ExportForm.action = postUrl;
        ExportForm.submit();
    }; 
    function ShowMsg(msg, isShowOk, okValue, url) {
        $(".maskLayer").fadeIn();
        $("#msg").html(msg);
        if (isShowOk == "1") {
            $("#btnOk").html(okValue);
            $("#btnOk").attr("href", url);
            $("#btnCancel").val("取消");
            $("#btnOk").parent().show();
        } else {
            $("#btnOk").parent().hide();
            $("#btnCancel").val("确定");
        }
        var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
        $("#tip").animate({
            bottom: bottom
        }, 200);
    }
    //音乐播放
    $(".music").click(function () {
        if ($(".icon-music").attr("num") == "1") {
            $(".icon-music").removeClass("open");
            $(".icon-music").attr("num", "2")
            $(".music-span").css("display", "none");
            document.getElementById("aud").pause();
            $(".music_text").html("关闭");
            $(".music_text").addClass("show_hide");
            setTimeout(musicHide, 2000);
        } else {
            $(".icon-music").attr("num", "1");
            $(".icon-music").addClass("open");
            $(".music-span").css("display", "block");
            document.getElementById("aud").play();
            $(".music_text").html("开启");
            $(".music_text").addClass("show_hide");
            setTimeout(musicHide, 2000);
        }
        function musicHide() {
            $(".music_text").removeClass("show_hide");
        }
    }); 
</script>
</body>
</html>