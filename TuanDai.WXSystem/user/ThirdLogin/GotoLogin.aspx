<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GotoLogin.aspx.cs" Inherits="TuanDai.WXApiWeb.user.ThirdLogin.GotoLogin" %>

<!DOCTYPE html>

<html lang="en">
<head>
  <title>自动登录中</title>
  <style type="text/css">
    .dataTables_processing {
      position: absolute;
      top: 40%;
      left: 30%;
      margin-left: -55px;
      margin-top: -25px;
      width: 50%;
      height: 80px;
      text-align: center;
      text-indent: 2em;
      color: #333;
      background: url(/imgs/loading01.gif) 20px 30px no-repeat #fff;
      z-index: 9999;
      box-shadow: 0 0 10px #ccc;
      line-height: 80px;
      border-radius: 5px;
      font-size:1.7rem;
    }
  </style>
</head>
<body>
   <div id="report_detail_processing" class="dataTables_processing">自动登录中...</div>
</body>
</html>
