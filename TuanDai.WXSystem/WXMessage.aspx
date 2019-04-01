<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="WXMessage.aspx.cs" Inherits="TuanDai.WXApiWeb.WXMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>关注后推送</title>
</head>
<body>
    <br /><br /><br /><br />
   <div style="text-align:center;font-size:18px;">消息已发送成功！<br/> <br/> <br/>  <a onclick="closeMyWin()">关闭页面</a>    </div> 
   
 <script type="text/javascript" src="/scripts/jquery.min.js"></script>
  <script type="text/javascript">
      var IsInWeiXin = "<%=IsInWeiXin %>"; 
      var browser = {
          versions: function () {
              var u = navigator.userAgent, app = navigator.appVersion;
              return { //移动终端浏览器版本信息
                  ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                  android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                  iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                  iPad: u.indexOf('iPad') > -1 //是否iPad
              };
          }()
      }

      function closeMyWin() {
          if (IsInWeiXin == "1") {
              WeixinJSBridge.call("closeWindow");
          } else {
              self.close();
          }
      }
      $(function () {
          if (IsInWeiXin == "1") {
              if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
                  setTimeout(function () { f_close(); }, 300);
              }
              if (browser.versions.android) {
                  setTimeout(function () { f_close(); }, 1500);
              }              
          }
      });     
      function f_close() { 
          if (typeof (WeixinJSBridge) != "undefined") { 
              WeixinJSBridge.call('closeWindow');
          } else {
              if (navigator.userAgent.indexOf("MSIE") > 0) {
                  if (navigator.userAgent.indexOf("MSIE 6.0") > 0) {
                      window.opener = null; window.close();
                  }
                  else {
                      window.open('', '_top'); window.top.close();
                  }
              }
              else if (navigator.userAgent.indexOf("Firefox") > 0) {
                  window.location.href = 'about:blank '; 
              }
              else {
                  window.opener = null;
                  window.open('', '_self', '');
                  window.close();
              }
          }
      }

  </script>
</body>
</html>
