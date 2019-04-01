﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_userdetailinfo.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.my_userdetailinfo" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>详细资料</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--账户中心-->
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />

</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div>
            <h1 class="title">详细资料</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="MyInfoBox clearfix">
        <section class="pl15 bg-fff bb-e6e6e6 bt-e6e6e6 bg-fff">
          <div class="infoMain  bb-e6e6e6">
             <div class="leftBox">最高学历</div>
             <div class="rightBox pr15">
                <select id="Graduation" class="select">
                     <option value="">请选择</option>
                     <option value="高中或以下">高中或以下</option>
                     <option value="大专">大专</option>
                     <option value="本科">本科</option>
                     <option value="研究生或以上">研究生或以上</option> 
                </select>
             </div>
          </div>
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">毕业院校</div>
              <div class="rightBox pr30">
                    <div class="contBox">
                        <input type="text" id="University" class="ipt" placeholder="请输入您所毕业院校信息">
                    </div>
                </div>
          </div>
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">婚姻状况</div>
             <div class="rightBox pr15">
                <select id="Marriage" class="select">
                     <option value="">请选择</option>
                     <option value="未婚">未婚</option>
                     <option value="已婚">已婚</option>
                     <option value="离异">离异</option>
                     <option value="丧偶">丧偶</option>
                </select>
             </div>
          </div>
          <div class="infoMain">
             <div class="leftBox">居住地址</div>
              <div class="rightBox pr30">
                    <div class="contBox">
                        <input type="text" id="Address" class="ipt" onkeyup="value=value.replace(/[^\a-\z\A-\Z0-9\-\_\u4E00-\u9FA5]/g,'')" onpaste="value=value.replace(/[^\a-\z\A-\Z0-9\-\_\u4E00-\u9FA5]/g,'')" oncontextmenu = "value=value.replace(/[^\a-\z\A-\Z0-9\-\_\u4E00-\u9FA5]/g,'')"  placeholder="请输入现居住地址">
                    </div>
                </div>
          </div>
        </section>
        <div class="fixLine"></div>

        <section class="pl15  bg-fff bb-e6e6e6 bt-e6e6e6">
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">公司行业</div>
             <div class="rightBox pr15">
                <select id="OfficeDomain" class="select">
                     <option value="">请选择</option>
                     <option value="制造业">制造业</option>
                     <option value="IT">IT</option>
                     <option value="政府机关">政府机关</option>
                     <option value="媒体/广告">媒体/广告</option>
                     <option value="零售/批发">零售/批发</option>
                     <option value="教育/培训">教育/培训</option>
                     <option value="公共事业">公共事业</option>
                     <option value="交通运输业">交通运输业</option>
                     <option value="房地产业">房地产业</option>
                     <option value="能源业">能源业</option>
                     <option value="金融/法律">金融/法律</option>
                     <option value="餐饮/旅游业">餐饮/旅游业</option>
                     <option value="医疗/卫生/保健">医疗/卫生/保健</option>
                     <option value="建筑工程">建筑工程</option>
                     <option value="农业">农业</option>
                     <option value="娱乐服务业">娱乐服务业</option>
                     <option value="体育/艺术">体育/艺术</option>
                     <option value="公益组织">公益组织</option>
                     <option value="其他">其他</option>
                </select>
             </div>
          </div>
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">公司规模</div>
             <div class="rightBox pr15">
                <select id="OfficeScale" class="select">
                     <option value="">请选择</option>
                     <option value="10人以下">10人以下</option>
                     <option value="10-100人">10-100人</option>
                     <option value="100-500人">100-500人</option>
                     <option value="500人以上">500人以上</option>
                </select>
             </div>
          </div>
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">职位</div>
              <div class="rightBox pr30">
                    <div class="contBox">
                        <input type="text" id="Position" class="ipt" onkeyup="value=value.replace(/[^\a-\z\A-\Z0-9\-\_\u4E00-\u9FA5]/g,'')" onpaste="value=value.replace(/[^\a-\z\A-\Z0-9\-\_\u4E00-\u9FA5]/g,'')" oncontextmenu = "value=value.replace(/[^\a-\z\A-\Z0-9\-\_\u4E00-\u9FA5]/g,'')" placeholder="请输入您的职位信息">
                    </div>
                </div>
          </div>
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">月收入</div>
             <div class="rightBox pr15">
                <select id="Salary" class="select">
                     <option value="">请选择</option>
                     <option value="1000元以下">1000元以下</option>
                     <option value="1001-2000元">1001-2000元</option>
                     <option value="2000-5000元">2000-5000元</option>
                     <option value="5000-10000元">5000-10000元</option>
                     <option value="10000-20000元">10000-20000元</option>
                     <option value="20000-50000元">20000-50000元</option>
                     <option value="50000元以上">50000元以上</option>
                </select>
             </div>
          </div>
            </section>
        <div class="fixLine"></div>
        <section class="pl15  bg-fff bb-e6e6e6 bt-e6e6e6">
            
          <div class="infoMain bb-e6e6e6">
             <div class="leftBox">是否购房</div>
             <div class="rightBox pr15">
                <select id="IsHaveHouse" class="select">
                    <option value="">请选择</option>
                    <option value="False">否</option>
                    <option value="True">是</option>
                </select>
             </div>
          </div>
          <div class="infoMain">
             <div class="leftBox">是否购车</div>
             <div class="rightBox pr15">
                <select id="IsHaveCar" class="select">
                    <option value="">请选择</option>
                    <option value="False">否</option>
                    <option value="True">是</option>
                </select>
             </div>
          </div>
        </section>
        <div class="fixLine"></div>
        <section class="pl15 bb-e6e6e6 bg-fff">
	             <div class="infoMain bb-e6e6e6">
	                <div class="leftBox">紧急联系人</div>
	                <div class="rightBox pr30">
	                    <div class="contBox">
	                        <input type="text" name="EmergencyContactName" id="EmergencyContactName" class="ipt" maxlength="10"  placeholder="紧急联系人名字" />
	                    </div>
	                </div>
	            </div>
	            <div class="infoMain bb-e6e6e6">
	                <div class="leftBox">联系人电话</div>
	                <div class="rightBox pr30">
	                    <div class="contBox">
	                        <input type="text" name="EmergencyContactPhone" id="EmergencyContactPhone" class="ipt" maxlength="11"  placeholder="联系人手机号码" />
	                    </div>
	                </div>
	            </div> 
	           <div class="infoMain bb-e6e6e6"> 
	             <div class="leftBox">联系人关系</div>
	             <div class="rightBox pr15">
	                <select id="EmergencyContactRelationShip" class="select">
	                    <option value="">请选择</option>
	                    <option value="1">配偶</option>
	                    <option value="2">父母</option>
	                    <option value="3">兄弟姐妹</option>
	                    <option value="4">子女</option>
	                    <option value="5">朋友</option>
	                    <option value="6">其他</option>
	                </select>
	             </div> 
	          </div> 
	        </section>
    </div>

    <div class="pl15 pr15 mt20 pb20">
        <a href="javascript:void(0);" class="btn yellowBox f17px" id="btnSave">保存</a>
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



    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/ajaxfileupload.js"></script>
    <script src="/scripts/mobileBUGFix.mini.js" type="text/javascript"></script>
    <script src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $(function () {
            limitInt($("#EmergencyContactPhone"));
            $("#Graduation").val("<%=ExtModel.Graduation %>");
            $("#University").val("<%=ExtModel.University %>");
            $("#Marriage").val("<%=ExtModel.Marriage %>");
            $("#Address").val("<%=ExtModel.Address %>");
            $("#OfficeDomain").val("<%=ExtModel.OfficeDomain %>");
            $("#OfficeScale").val("<%=ExtModel.OfficeScale %>");
            $("#Position").val("<%=ExtModel.Position %>");
            $("#Salary").val("<%=ExtModel.Salary %>");
            $("#IsHaveHouse").val("<%=ExtModel.IsHaveHouse %>");
            $("#IsHaveCar").val("<%=ExtModel.IsHaveCar %>");
            $("#EmergencyContactName").val("<%=ExtModel.ContactName%>");
            $("#EmergencyContactPhone").val("<%=ExtModel.ContactTelNo%>");
            $("#EmergencyContactRelationShip").val("<%= ExtModel.ContactRelationShip%>");

            $("#btnSave").click(function () {
                var Graduation = $("#Graduation").val();
                var University = $("#University").val();
                var Marriage = $("#Marriage").val();
                var Address = $("#Address").val();
                var OfficeDomain = $("#OfficeDomain").val();
                var OfficeScale = $("#OfficeScale").val();
                var Position = $("#Position").val();
                var Salary = $("#Salary").val();
                var IsHaveHouse = $("#IsHaveHouse").val();
                var IsHaveCar = $("#IsHaveCar").val();
                var contactName = $("#EmergencyContactName").val();
                var contactTelNo = $("#EmergencyContactPhone").val();
                var relationShip = $("#EmergencyContactRelationShip").val();

                if (checkFrom()) {
                    var paramObj = {
                        Cmd: "WXUpdateUserBasicInfo",
                        Graduation: Graduation,
                        University: University,
                        Marriage: Marriage,
                        Address: Address,
                        OfficeDomain: OfficeDomain,
                        OfficeScale: OfficeScale,
                        Position: Position,
                        Salary: Salary,
                        IsHaveHouse: IsHaveHouse,
                        IsHaveCar: IsHaveCar,
                        ContactName: contactName,
                        ContactTelNo: contactTelNo,
                        ContactRelationShip: relationShip
                    };
                    $("body").showLoading("提交中...");
                    $.ajax({
                        async: false,
                        url: "/ajaxCross/ajax_userbasicInfo.ashx",
                        type: "post",
                        dataType: "json",
                        data: paramObj,
                        success: function (json) {
                            $("body").hideLoading();
                            var d = json.result;
                            var msg = json.msg;
                            if (parseInt(d) == 1) {
                                $("body").showMessage({
                                    message: "资料保存成功", showCancel: false, okbtnEvent: function () {
                                        window.location.href = "/Member/my_userinfo.aspx";
                                    }
                                });
                            } else {
                                $("body").showMessage({ message: msg, showCancel: false });
                                return false;
                            }
                        },
                        error: function () {
                            $("body").hideLoading();
                        }
                    });
                }
            });
        });

        function checkFrom() {
            if ($.trim($("#EmergencyContactName").val()) == "") {
                alert("请录入紧急联系人！");
                return false;
            }
            if ($.trim($("#EmergencyContactPhone").val()) == "") {
                alert("请录入紧急联系人手机号！");
                return false;
            }
            var contactPhone = $.trim($("#EmergencyContactPhone").val());
            if (contactPhone.length != 11) {
                alert("联系人电话只能输入11位手机号码!");
                return false;
            }
            var phoneRegex = /^(?:13\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
            if (!phoneRegex.test(contactPhone)) {
                alert("联系人电话格式不正确!");
                return false;
            }
            if ($("#EmergencyContactRelationShip").val() == "") {
                alert("请录入与紧急联系人关系！");
                return false;
            }
            if ($("#Graduation").val() == "") {
                alert("请选择最高学历！");
                return false;
            }
            if ($("#University").val() == "") {
                alert("请输入毕业学校！");
                $("#University").focus();
                return false;
            }
            else {
                var university = $("#University").val();
                if (!university.match(/^[\u4E00-\u9FA5a-zA-Z0-9_-]{0,}$/)) {
                    alert("毕业学校只能输入中文、英文、数字");
                    return false;
                }
            }
            if ($("#Marriage").val() == "") {
                alert("请选择婚姻状况！");
                return false;
            }
            if ($("#Address").val() == "") {
                alert("请输入居住地址！");
                $("#Address").focus();
                return false;
            }
            else {
                var address = $("#Address").val();
                if (!address.match(/^[\u4E00-\u9FA5a-zA-Z0-9_-]{0,}$/)) {
                    alert("居住地址只能输入中文、英文、数字");
                    return false;
                }
            }
            if ($("#OfficeDomain").val() == "") {
                alert("请选择公司行业！");
                return false;
            }
            if ($("#OfficeScale").val() == "") {
                alert("请选择公司规模！");
                return false;
            }
            if ($("#Position").val() == "") {
                alert("请输入您的职位信息！");
                $("#Position").focus();
                return false;
            }
            else {
                var position = $("#Position").val();
                if (!position.match(/^[\u4E00-\u9FA5a-zA-Z0-9_-]{0,}$/)) {
                    alert("职位信息只能输入中文、英文、数字");
                    return false;
                }
            }
            if ($("#Salary").val() == "") {
                alert("请选择月收入！");
                return false;
            }
            if ($("#IsHaveHouse").val() == "") {
                alert("请选择是否购房！");
                return false;
            }
            if ($("#IsHaveCar").val() == "") {
                alert("请选择是否购车！");
                return false;
            }
            return true;
        }
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

        window.onload = function () {
            //不要删除此处，当有跳转链接有锚点时，删除此处锚点会失效
        }
    </script>

</body>
</html>
