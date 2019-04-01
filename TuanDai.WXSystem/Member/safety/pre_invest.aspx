<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pre_invest.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.pre_invest" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>投资前准备</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/cunguan.css?20161220001" />
</head>
<body class="bg-f2f2f0">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">投资前准备</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

    <div class="tzqBox pb20" id="tzqBox">
        <div class="pt30 pb25 bg-fff">
            <%if (cgtmode.accountStage == 1)
              { %>
            <div class="imgTouZiQian6 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">完善投资前准备信息</p>
            <p class="c-999999 f13px text-center mt10">享受更全面的账户保护</p>
            <%}
              else if (cgtmode.accountStage == 2)
              {
                  if (cgtmode.accountSubStage == 2)
                  {
                      //未提交资料
            %>
            <div class="imgTouZiQian4 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">
                您的证件为港澳台通行证或外籍证件，<br />
                请联系客服，提交相关申请资料
            </p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
                  else if (cgtmode.accountSubStage == 3)
                  {
                      //审核中
            %>
            <div class="imgTouZiQian3 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">
                您的资料已提交<br />
                请耐心等待银行审核...
            </p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
                  else if (cgtmode.accountSubStage == 4)
                  {
                      //审核失败
            %>
            <div class="imgTouZiQian4 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">抱歉！您提交的资料未通过审核...</p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
                  else if (cgtmode.accountSubStage == 5)
                  {
                      //三要素中有一项有误
            %>
            <div class="imgTouZiQian6 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">
                您的身份信息或银行信息有误<br />
                建议重新绑定银行卡
            </p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
                  else
                  {
                      //未激活
            %>
            <div class="imgTouZiQian6 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">您的存管通账号尚未激活，请激活</p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
              }
              else if (cgtmode.accountStage == 3)
              {
                  if (!cgtmode.isBindCard)
                  {
                      //未绑卡
            %>
            <div class="imgTouZiQian7 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">银行卡未绑定</p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
                  else if (!cgtmode.isAllowRechare)
                  {
                      //已开通存管，三要素对，预留手机号不对
            %>
            <div class="imgTouZiQian5 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">您的预留手机号码有误</p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }else if (rInfo == null)
                  {
                      %>
            <div class="imgTouZiQian6 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">
                未完成投资偏好评测<br />
                完成评测后才能进行投资哦
            </p>
            <p class="c-999999 f13px text-center mt10">如有疑问，请联系客服></p>
            <a href="tel:10101218" class="callKeFu">拨打客服电话</a>
            <%
                  }
                  else
                  {
            %>
            <div class="imgTouZiQian2 margin-auto"></div>
            <p class="c-333333 f17px text-center mt20">已开通银行存管账户</p>
            <p class="c-999999 f13px text-center mt10">账户安全保障中...</p>
            <% }
              } %>
        </div>

        <div class="bg-fff mt15 pl15">
            <div class="clearfix pt10 pb10 pr15 bt-e6e6e6">
                <% if (!isRealName)
                   {
                %>
                <div class="lf f15px c-333333">实名认证</div>
                <div class="rf f12px c-fab600" style="margin-right: 15px;" onclick="JAVASCRIPT:window.location.href='/member/cgt/opencgt.aspx';"><i class="ico_warn"></i>立即实名</div>
                <i class="ico-arrow-r"></i>
                <%
                   }
                   else
                   {
                       %>
                <div class="lf f15px c-333333">实名认证</div>
                <div class="rf f12px c-999999"><%=MaskLeftReplace(UserInfo.RealName) %>(<%=BusinessDll.StringHandler.MaskTelNo(UserInfo.IdentityCard) %>)</div>
                <%
                   } %>
                
            </div>
            <% if (!cgtmode.isBindCard)
               { %>
            <a id="bindMyCard" class="block clearfix pt10 pb10 pr30 bt-e6e6e6">
                <div class="lf f15px c-333333">我的银行卡</div>
                <div class="rf f12px c-fab600"><i class="ico_warn"></i>立即绑定</div>
                <i class="ico-arrow-r"></i>
            </a>
            <% }
               else
               {
                   if (cgtmode.accountStage > 2)
                   {
            %>
            <a href="/Member/Bank/bankInfo.aspx" class="block clearfix pt10 pb10 pr30 bt-e6e6e6">
                <div class="lf f15px c-333333">我的银行卡</div>
                <div class="rf f12px c-999999">银行卡、开户行</div>
                <i class="ico-arrow-r"></i>
            </a>
            <a href="javascript:void(0);" class="block clearfix pt10 pb10 pr30 bt-e6e6e6" onclick="ModifyMobile()">
                <div class="lf f15px c-333333">银行预留手机号</div>
                <% if (cgtmode.accountStage == 3 && !cgtmode.isAllowRechare)
                   {
                %>
                <div class="rf f12px c-fab600"><i class="ico_warn"></i>立即修改</div>
                <i class="ico-arrow-r"></i>
                <%
                   }
                   else
                   {
                %>
                <div class="rf f12px c-999999"><%= BusinessDll.StringHandler.MaskTelNo(CgtUser.mobile) %>&nbsp;修改</div>
                <i class="ico-arrow-r"></i>
                <% }
                   }
               }
                %></a>
            <a href="<%=rInfo==null?TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl+"/weixin/20170322question/index.aspx":TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl+"/weixin/20170322question/result.aspx" %>" class="block clearfix pt10 pb10 pr30 bt-e6e6e6">
                <div class="lf f15px c-333333">风险评测</div>
                <div class="rf f12px c-999999"><%=rInfo == null ?"<span class='rf f12px' style='color:red;'>未评测</span>":rInfo.AssessScore<=40?"保守型":rInfo.AssessScore<=60?"稳健型":"积极型" %></div>
                <i class="ico-arrow-r"></i>
            </a>
        </div>
        <div class="tzqBottom w100p c-808080 text-center"><%--<i class="ico_shield"></i>个人资产由银行级别风控体系保障--%></div>
    </div>
    <div id="div_jump" class="jumpPage webkit-box box-center box-vertical h100p hide">
        <div class="jump_loading"></div>
        <p>即将前往存管页面</p>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        //处理底部文字位置
        function setBotPos() {
            var winHeight = $(window).height();
            var conHeight = $("#tzqBox").outerHeight();
            if (winHeight - conHeight <= 15) {
                $(".tzqBottom").css('margin-top', '20px');
            } else {
                $(".tzqBottom").css({
                    'position': 'absolute',
                    'bottom': '15px'
                });
            }
        }

        $(function () {
            setBotPos();
            $("#bindMyCard").click(function () {
                window.location.href = "/Member/cgt/cgtBindCard.aspx";
            });
        });

        //修改银行预留手机号
        function ModifyMobile() {
            $("#div_jump").removeClass("hide");
            $("#tzqBox").addClass("hide");
            $("body").attr("class", "bg-fff");

            $.ajax({
                url: "/ajaxCross/ajax_cgt.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "MODIFY_MOBILE_Req" },
                success: function (json) {
                    var status = parseInt(json.result);
                    if (status == 1) {
                        window.location.href = unescape(json.msg);
                    } else {
                        $("#div_jump").addClass("hide");
                        $("#tzqBox").removeClass("hide");
                        $("body").attr("class", "bg-f2f2f0");
                        $("body").showMessage({ message: json.msg, showCancel: false });
                    }
                },
                error: function () {
                    window.location.href = window.location.href;
                }
            });
        }
    </script>
</body>
</html>
