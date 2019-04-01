<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_userInfo.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.my_userInfo" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>个人资料</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=<%=GlobalUtils.Version %>" />
    <!--账户中心-->
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>

<body>
    <%= this.GetNavStr()%>
    <div style="display: none;"><%= this.GetNavIcon()%></div>
    <div class="MyInfoBox">
        <div class="bg-fff">
            <section class="hbody">
                <div class="headPic pos-r">
                    <img class="defaultHead" src="<%= headImage %>">
                    <div class="upload-box pos-a">
                        <div class="uploader pos-r">
                            <input type="file" name="fuImage" id="fuImage" accept="image/*" />
	                        <img src="/imgs/images/ico-camera.png" class="ico-camera pos-a"/>
                        </div>
                    </div>
                </div>
                <div class="infoBox">
                    <p>
                        <img class="icon_v<%=this.UserVipModel.Level %>" src="/imgs/images/V<%=this.UserVipModel.Level %>.png" />
                        <span><%=this.UserVipModel.LevelName %></span>
                    </p>
                    <%--<a href="javascript:checkCgtCommGoUrl('/Member/upgradeaccount.aspx')" class="f12px c-fff up-member mt5"><%=userModel.Level==2?"超级会员续期":"升级超级会员" %></a>--%>
                    <a href="/pages/downOpenApp.aspx" class="f12px c-fff up-member mt5"><%=userModel.Level==2?"超级会员续期":"升级超级会员" %></a>
                </div>

            </section>

            <section class="pl15 bb-e6e6e6 bg-fff mt20">
                <div class="infoMain bb-e6e6e6">
                    <div class="leftBox">昵称</div>
                    <div class="rightBox pr30">
                        <div class="contBox">
                            <input type="text" name="" class="ipt" id="txtNickName" placeholder="请输入昵称" disabled="disabled">
                        </div>
                    </div>
                </div>
                <div class="infoMain bb-e6e6e6">
                    <div class="leftBox">注册手机号</div>
                    <div class="rightBox pr15">
                        <div class="contBox">
                            <% if (userModel.IsValidateMobile)
                               {%>
                            <div class="contBox c-d1d1d1" onclick="GoToUrl('/Member/safety/mobile_change.aspx')"><%=BusinessDll.StringHandler.MaskTelNo(userModel.TelNo) %><img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                            <%}
                               else
                               { %>
                            <div class="contBox c-d1d1d1" onclick="GoToUrl('/Member/safety/bindmobile.aspx')">未绑定<img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                            <%} %>
                        </div>
                    </div>
                </div>
                <div class="infoMain">
                    <div class="leftBox">详细资料</div>
                    <div class="rightBox pr15">
                        <div class="contBox c-fa7d00" onclick="GoToUrl('/Member/my_userdetailinfo.aspx')"><%=IsCompleteDetailInfo?"修改":"未完善" %><img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                    </div>
                </div>
            </section>

        </div>

        <div class="bg-fff mt10">
            <section class="pl15 bb-e6e6e6 bg-fff">
                <div class="infoMain bb-e6e6e6">
                    <div class="leftBox">投资前准备</div>
                    <div class="rightBox pr15">
                        <% if (CgtUser != null && CgtUser.accountStage == 3 && CgtUser.isBindCard && CgtUser.isAllowRechare && userModel != null && !string.IsNullOrEmpty(userModel.OpenBankName) && rInfo != null)
                       { %>
                    <%--<div class="contBox c-d1d1d1" onclick="javascript:checkCgtCommGoUrl('/Member/safety/pre_invest.aspx');">存管账户、银行卡等<img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>--%>
                    <div class="contBox c-d1d1d1" onclick="window.location.href='/pages/downopenapp.aspx';">存管账户、银行卡等<img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                    <% }
                       else
                       { %>
                     <%--<div class="contBox c-fa7d00"  onclick="javascript:checkCgtCommGoUrl('/Member/safety/pre_invest.aspx');">未完善，存管账户、银行卡等<img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                    <% } %>--%>
                        <div class="contBox c-fa7d00"  onclick="window.location.href='/pages/downopenapp.aspx';">未完善，存管账户、银行卡等<img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                    <% } %>
                    </div>
                </div>
                <div class="infoMain bb-e6e6e6">
                    <div class="leftBox">登录密码</div>
                    <div class="rightBox pr15">
                        <div class="contBox c-d1d1d1" onclick="GoToUrl('/Member/safety/reset_LoginPassword.aspx')">修改<img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                    </div>
                </div>
                <%if (CgtUser != null && (CgtUser.accountStage == 3 || CgtUser.accountStage == 6 || CgtUser.accountStage ==7))
              {%>
                <div class="infoMain">
                    <div class="leftBox">交易密码</div>
                    <div class="rightBox pr15">
                        <%--<div class="contBox c-d1d1d1" onclick="GoToUrl('/Member/safety/trade_password.aspx')"><%=IsTenderNeedPayPassword == false ?"未开启":"已开启" %><img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>--%>
                        <div class="contBox c-d1d1d1" onclick="window.location.href='/pages/downopenapp.aspx';"><%=IsTenderNeedPayPassword == false ?"未开启":"已开启" %><img src="/imgs/images/icon/ico-arrow-r-d1d1d1.png" /></div>
                    </div>
                </div>
                <%} %>
            </section>
        </div>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/ajaxfileupload.js"></script>
    <script src="/scripts/upload.js" type="text/javascript"></script>
    <script src="/scripts/mobileBUGFix.mini.js" type="text/javascript"></script>
    <script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $(function () {
            $("#txtNickName").val("<%= userModel.NickName %>");

            //保存上传图像. 
            $('#fuImage').localResizeIMG({
                width: 250,
                quality: 1,
                success: function (result) {
                    $("body").showLoading("正在上传...");
                    $.ajax({
                        url: '/ajaxCross/ajax_files.ashx?Cmd=BindUserHead',
                        type: 'POST',
                        data: { base64: result.clearBase64 },
                        dataType: 'json',
                        error: function () {
                            $("body").hideLoading();
                            $("body").showMessage({ message: "您好，上传失败，请重试！", showCancel: false });
                        },
                        success: function (result) {
                            $("body").hideLoading();
                            if (result.status == "1") {
                                $("#fuImage").val("");
                                $("img[id$='headimg']").attr("src", result.fileName + "?v=" + (new Date()).getTime());
                                $("body").showMessage({ message: "图片上传成功！", showCancel: false,okbtnEvent:function() {
                                    window.location.href = window.location.href;
                                } });
                                setTimeout(Done, 2000);
                            } else {
                                $("body").showMessage({ message: "您好，上传失败，请重试！", showCancel: false });
                            }
                        }
                    });
                }
            });
        });

        
        function GoToUrl(url) {
            window.location.href = url;
        }
        //弹出层事件
        function Done() {
            $(".maskLayer").fadeOut();
            $("#tip").animate({
                bottom: "-430px"
            }, 200);
        }
    </script>
</body>

</html>
