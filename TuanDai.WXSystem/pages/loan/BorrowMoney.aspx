<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BorrowMoney.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.loan.BorrowMoney" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>我要借款</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/loan.css?v=20160311" />
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='<%= TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?"/WeiXinIndex.aspx":"/Index.aspx" %>'">返回</div>
            <h1 class="title">我要借款</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <section class="loanMain pb10">
	  	<div class="imgBox"><img src="/imgs/images/borrowMoney_banner1.png" alt=""></div> 
	  	
	  	<div class="mt10 bt-e6e6e6 bb-e6e6e6 click-respond">
	        <div class="clearfix nav" id="btnzhph">
		      <div class="lf">
		          <p class="f17px c-212121 p-borrow"><img class="ico-borrow" src="/imgs/images/icon/ico-zhph.png"/>快速信用借款<span class="c-ababab f13px">（正合普惠金融）</span></p>
		      </div>
		      <div class="rf"><i class="ico-arrow-r-d1d1d1"></i></div>
		 	</div> 
		</div>  	
	 	
	 	<div class="mt10 bt-e6e6e6 bb-e6e6e6">
	        <div class="clearfix nav">
		      <div class="lf">
		          <p class="f17px c-212121 p-borrow"><img class="ico-borrow" src="/imgs/images/ico-borrow.png" alt=""/>资产标借款</p>
		      </div>
		      <div class="rf btn-apply" id="apply">立即申请</div>
		 	</div>
	 	</div>
	 	<p class="pl15 pr15 pt10 c-999 f13px text-justify bg-fff">温馨提示：管理费按用户的会员等级实行阶梯折扣优惠，等级越高折扣越低；管理费一次性收取，提前还款不退。</p>
		<div class="pl15 pr15 pt10 bg-fff pb15">
			<div class="bm-table">
				<table>
					<tbody>
						<tr>
							<th class="bb-e6e6e6 br-e6e6e6-before">会员等级</th>
							<th class="bb-e6e6e6">管理费折扣</th>
						</tr>
						<tr class="bg-fff">
							<td class="bb-e6e6e6 br-e6e6e6-before">
								<img src="/imgs/images/V1.png"/>
								<img src="/imgs/images/V2.png"/>
								<img src="/imgs/images/V3.png"/>
							</td>
							<td class="bb-e6e6e6">---</td>
						</tr>
						<tr>
							<td class="bb-e6e6e6 br-e6e6e6-before"><img src="/imgs/images/V4.png"/></td>
							<td class="bb-e6e6e6">7折</td>
						</tr>
						<tr class="bg-fff">
							<td class="bb-e6e6e6 br-e6e6e6-before"><img src="/imgs/images/V5.png"/></td>
							<td class="bb-e6e6e6">6.5折</td>
						</tr>
						<tr>
							<td class="bb-e6e6e6 br-e6e6e6-before"><img src="/imgs/images/V6.png"/></td>
							<td class="bb-e6e6e6">5.5折</td>
						</tr>
						<tr class="bg-fff">
							<td class="bb-e6e6e6 br-e6e6e6-before"><img src="/imgs/images/V7.png"/></td>
							<td class="bb-e6e6e6">4.5折</td>
						</tr>
						<tr>
							<td class="br-e6e6e6-before"><img src="/imgs/images/V8.png"/></td>
							<td>3.5折</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
    </section>
    <div class="maskLayer hide"></div>

    
 
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=20160505001"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20160326001"></script>
    
    <script type="text/javascript">
        $(function () {
            $("#btnzhph").click(function () {
                window.location.href = "ZhphLoanType.aspx";
            });
            $("#apply").click(function () {
                $("body").showLoading("检测中...");
                $.ajax({
                    url: "/ajaxCross/ajax_loan.ashx?Cmd=Check",
                    type: "get",
                    dataType: "json",
                    success: function (json) {
                        $("body").hideLoading();
                        if (json.Success) {
                            window.location.href = "Apply.aspx";
                        } else {
                            $("body").showMessage({
                                message: json.Message, showCancel: json.Url != "", okbtnEvent: function () {
                                    window.location.href = json.Url;
                                }
                            }); 
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $("body").hideLoading();
                    }
                });
            }); 
        }); 
       
    </script>
</body>
</html>
