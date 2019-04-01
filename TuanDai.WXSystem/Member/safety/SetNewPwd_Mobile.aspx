<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetNewPwd_Mobile.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.SetNewPwd_Mobile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>忘记密码</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/pay.css?v=2016032801" />
</head>
<body class="bg-f6f7f8">
  <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header bb-e6e6e6">
        <div class="back" onclick="javascript:window.location.href='/Member/safety/ResetPwd.aspx';">返回</div>
        <h1 class="title">忘记密码</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
    </header>
    
     <div class="ZH_password_c_c" id="temp1">
				<div class="mt15">
			    <div class="inpBox34 bt-e6e6e6 bb-e6e6e6">
			       <span class="f17px c-212121">新密码</span>
			        <input type="password" id="txtpwd" maxlength="16" placeholder="字母+数字6-16位" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
			    </div>
				</div>
				 <span class="verification-3 c-fd6040 ml15" style="display:none;" id="txtpwdTip">字母+数字6-16位</span>
				 <div class="mt15">
			    <div class="inpBox34 bt-e6e6e6 bb-e6e6e6">
			       <span class="f17px c-212121">确认密码</span>
			        <input type="password" id="txtpwd2" maxlength="16" placeholder="再次输入新密码" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false">
			    </div>
				</div>
				<span class="verification-3 c-fd6040 ml15" style="display:none;" id="txtpwd2Tip">字母+数字6-16位</span>
		    <div class="pl15 pr15 mt25">
					<a href="javascript:void(0)" class="btn btnYellow" id="btnSubmit">提交更新</a>
				</div>
		</div>
		
    
    <div class="ZH_password_c_c" id="temp2" style="display:none;">
        <div class="ZH_password_cor">
	        <div class="ZH_password_cor_b1">
	            <i><img src="/imgs/ico_zhengque.jpg" width="53" height="55" /></i>
	            <span><strong>恭喜，您的新密码已修改成功！</strong><br />
	        祝您在团贷网投资愉快！请<em><a href="/user/login.aspx">重新登录</a></em>您的账户</span>
	        </div>
    		</div>
    </div>

     <!--弹窗-->
     <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
      <div class="hbody clearfix" style="margin-bottom: 9px;">
        <i class="ico-exclamation40 lf mr10"></i>
        <span id="msg" style="  font-size: 14px;line-height: 24px;"></span>
      </div>
      <div class="completeBox clearfix">
        <span style="float: right;max-width: 40%;">
             <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>
        </span>
        <span style="float: right;max-width: 60%;padding-right: 10px;">
             <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/>
        </span>
      </div>
    </section>
    <!--遮罩层-->
     <div class="maskLayer hide"></div>
</body>
<script type="text/javascript">
    var backurl = "<%= GoBackUrl%>";
</script>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/setnewpwd_mobile.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
</html>
