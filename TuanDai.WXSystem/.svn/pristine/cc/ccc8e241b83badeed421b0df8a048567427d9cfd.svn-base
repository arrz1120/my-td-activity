<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="binding_cardaddress.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.binding_cardaddress" %>
<%@ Import Namespace="Tool" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>绑定银行卡</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /> 
<style type="text/css">
	.pl108{padding-left: 108px;}
	.fb{font-weight: bold;}
	.t15{top: 15px;}
	.l15{left: 15px;}
	.r15{right: 15px;}
	.c-a9a9a9{color: #a9a9a9;}
	.bt-d9d9d9{border-top: 1px solid #d9d9d9;}
	.bb-d9d9d9{border-bottom: 1px solid #d9d9d9;}
	.inp{border: 0;outline: 0;width: 100%;}
	.border-radius-top{border-top-left-radius: 6px;border-top-right-radius: 6px;}
	.ico-phone{display: inline-block;width: 17px;height: 18px;background: url(/imgs/images/ico-phone.png) no-repeat;background-size: 100% 100%;margin-right: 8px;vertical-align: -5px;}
	.bbc-alert{display:-webkit-box;-webkit-box-pack:center;-webkit-box-align:center; display:box;-box-pack:center;box-align:center; }
	.bbc-alert-box{width: 80%;border-radius: 6px;background: #fff;}
	.ico-close{width: 12px;height: 12px;background: url(/imgs/images/ico-close-gray.png) no-repeat;background-size: 100% 100%;top: 15px;right: 15px;}
	.btn52{height: 52px;line-height: 52px;border-radius: 0;border-bottom-left-radius: 6px;border-bottom-right-radius: 6px;}
	.addSelect{border: 0;outline: none;font-family: inherit;width: 100%;}
	.addSelect option{display: block;}
    .addcard_mx { font-size: 16px; color: #ff9600;}
</style>
</head>
<body>  
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/withdrawal/drawmoney.aspx'">返回</div>
        <h1 class="title">绑定银行卡</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>

   <div class="c-212121 f14px pl15 pr15 pt20">为保证提现能快速准确到账，请填写<span class="f14px c-ffcf1f"><%=Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.BankType), bankModel.BankType) %>（<%=bankModel.BankAccountNo.Right(4) %>）</span>的开户行。</div>
	 
    <div class="mt20 bt-d9d9d9 bb-d9d9d9 pt10 pb10 pos-r pl108 bg-fff">
		<span class="c-212121 f14px pos-a l15">所在省份</span>
		<div class="pr40">
			<select class="addSelect f14px c-a9a9a9"  id="sel_city1">
				<option value="">请选择省份</option>
                <% foreach(var item in provincelist){ %>
                <option value="<%=item.ProName %>"><%=item.ProName %></option>
                <%} %>
			</select> 
		</div> 
        <i class="ico-arrow-r pos-a t15 r15"></i>
	</div>
    <div class="mt20 bt-d9d9d9 bb-d9d9d9 pt10 pb10 pos-r pl108 bg-fff">
		<span class="c-212121 f14px pos-a l15">所在城市</span>
		<div class="pr40">
			<select class="addSelect f14px c-a9a9a9"  id="sel_city2">
				<option value="">请选择城市</option> 
               <% foreach (var item in citylist)
                     { %>
                <option value="<%=item.CityName %>"><%=item.CityName %></option>
                <%} %>
			</select> 
		</div>
        <i class="ico-arrow-r pos-a t15 r15"></i>
	</div>

	<div class="mt20 bt-d9d9d9 bb-d9d9d9 pt10 pb10 pos-r pl108 bg-fff">
		<span class="c-212121 f14px pos-a l15">开户银行</span>
		<input class="inp f14px c-212121" type="text" placeholder="请输入支行名称" id="txtOpenBankName" />
	</div>

	
    <div id="trError" style="display:none;" class="addcard_mx"> 
    </div>
    <div class="text-right c-fd6040 f12px mt30 pr15"><a href="javascript:void(0);" id="btnforget" class="c-fd6040">忘记开户行</a></div>
	<div class="ml15 mr15 mt10">
		<div class="btn btnYellow">下一步</div>
	</div>
	
	<!--弹框-->
	<div class="alert bbc-alert" id="alert" style="display: none;">
		<div class="bbc-alert-box pos-r">
			<div class="ico-close pos-a"></div>
			<div class="f14px fb c-212121 text-center pt25 pb25"><i class="ico-phone"></i><%=BankName %>客服:<%=BankHotLine %></div>
			<div class="pl15 pr15 c-ababab f12px">您可以拨打<%=BankName %>客服电话，向客服咨询开户行信息，或者网上银行进行查询。<span class="f12px c-fd6040">请填写准确的开户行信息，开户行信息错误会导致提现失效。</span></div>
		  <a href="tel:<%=BankHotLine %>" class="btn btn52 btnYellow mt25">马上拨打</a>
		</div>
	</div>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20160422"></script>
<script type="text/javascript">
    function clearErr() {
        $("#trError").html("");
        $("#trError").css("display", "none");
    }
    function addErr(err) {
        $("#trError").html(err);
        $("#trError").css("display", "");
    }

    $(function () {
        $("#btnforget").click(function () {
            $("#alert").show();
        });
        $(".ico-close").click(function () {
            $("#alert").hide();
        });

        $("#" + 'sel_city1').change(function () {
            var thisDom = $(this);
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: {Cmd:"getcity",province:thisDom.val()},
                success: function (d) {
                    if (d.result == "1") {
                        $('#sel_city2').html("");
                        for (var i = 0; i < d.list.length; i++) {
                            $('#sel_city2').append("<option value='" + d.list[i].CityName + "'>" + d.list[i].CityName + "</option>");
                        }
                        $('#sel_city2').change();
                    }
                }
            });
        });
        $(".btnYellow").click(function () { 
            if ($("#sel_city1").val() == "") {
                addErr("* 请选择省份");
                return;
            }
            if ($("#sel_city2").val() == "") {
                addErr("* 请选择所在城市");
                return;
            }            
            if ($("#txtOpenBankName").val().length < 1) {
                addErr("* 请输入开户支行名称");
                return false;
            } 
            submitAddCard();
        });
    });
    function submitAddCard() {
        var province = $("#sel_city1 :selected").val();
        var cityName = $("#sel_city2 :selected").val();
        var bankName = $("#txtOpenBankName").val();
        var account = "<%=bankModel.BankAccountNo%>";
        var bankType = "<%=bankModel.BankType%>";
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: {
                Cmd: "addbankaccount", province: province,
                account: account, cityName: cityName,
                bankName: bankName, bankType: bankType
            },
            success: function (json) {
                var d = json.result;
                var msg = json.msg;
                if (parseInt(d) == 1) {
                    window.location.href = "/Member/withdrawal/drawmoney.aspx";
                }
                else if (parseInt(d) == -1) {
                    addErr("添加失败：用户不存在！");
                    return false;
                } else if (parseInt(d) == -2) {
                    addErr("添加失败：" + msg);
                    return false;
                } else if (parseInt(d) == -3) {
                    addErr("添加失败：该银行账号已经绑定另一用户，不能再绑定！");
                    return false;
                }
                else if (parseInt(d) == -4) {
                    addErr("添加失败：每个用户最多添加1张银行卡！");
                    return false;
                }
            }
        });
    }
</script>
</html>