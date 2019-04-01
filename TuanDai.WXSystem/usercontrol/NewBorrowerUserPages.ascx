﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewBorrowerUserPages.ascx.cs" Inherits="TuanDai.WXApiWeb.usercontrol.NewBorrowerUserPages" %>
 <% if(borrowerUserInfo.UserTypeId==2){ %>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">借款方：<%=BusinessDll.StringHandler.MaskStartPre(borrowerUserInfo.RealName,1)%></div> 
   <% if( borrowerUserInfo.IsShowExt=="1"){ %>
    <div class="h43 c-808080 f14px pl15">注册资本：<%=borrowerUserInfo.RegAmount %></div>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">注册地址：<%=borrowerUserInfo.RegAddress %></div>
    <div class="h43 c-808080 f14px pl15">成立时间：<%=borrowerUserInfo.RegDate %></div>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">法定代表人：<%=borrowerUserInfo.LegalName %></div>
    <%}else{ %>
    <div class="h43 c-808080 f14px pl15">手机号：<%=BusinessDll.StringHandler.MaskTelNo(borrowerUserInfo.TelNo)%></div>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">注册时间：<%=borrowerUserInfo.AddDateStr%></div>     
     <%if (!string.IsNullOrEmpty(borrowerUserInfo.BankCity))
       { %>
        <div class="h43 c-808080 f14px pl15">所在地：<%=BusinessDll.StringHandler.MaskStartPre(Tool.WebFormHandler.CutString(borrowerUserInfo.BankCity,6),3) %></div> 
     <%} %>
    <%} %>
<%}else{ %>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">借款方：<%=BusinessDll.StringHandler.MaskStartPre(borrowerUserInfo.RealName,1)%></div> 
    <div class="clearfix">
   	   <div class="h43 c-808080 f14px pl15 w50p lf">年龄：<%=borrowerUserInfo.Age%></div>
       <div class="h43 c-808080 f14px pl15 w50p lf">性别：<%=borrowerUserInfo.Sex %></div>
    </div>  
    <div class="h43 c-808080 f14px pl15">注册时间：<%=borrowerUserInfo.AddDateStr%></div>     
    <%if(!string.IsNullOrEmpty(borrowerUserInfo.Marriage)){ %>
    <div class="h43 c-808080 f14px pl15">婚姻状况：<%=borrowerUserInfo.Marriage %></div>
    <%} if(!string.IsNullOrEmpty(borrowerUserInfo.BankCity)){ %>
        <div class="h43 c-808080 f14px pl15">居住城市：<%=BusinessDll.StringHandler.MaskStartPre(Tool.WebFormHandler.CutString(borrowerUserInfo.BankCity,6),3)%></div>
    <%} 
     if (!string.IsNullOrEmpty(borrowerUserInfo.Industry)){ %>     
    <div class="h43 c-808080 f14px pl15">所属行业：<%=borrowerUserInfo.Industry%></div>
    <%}
      if(!string.IsNullOrEmpty(borrowerUserInfo.IsHasHouse)){  %>
    <div class="h43 c-808080 f14px pl15">住房情况：<%=borrowerUserInfo.IsHasHouse%></div>   
    <%} %>   
    <div class="h43 c-808080 f14px pl15 bg-fafafa">手机号码：<%=BusinessDll.StringHandler.MaskTelNo(borrowerUserInfo.TelNo)%></div>
    <% if( borrowerUserInfo.IsShowExt=="1"){ %>
    <div class="h43 c-808080 f14px pl15">月均收入：<%=borrowerUserInfo.Salary%></div>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">学历：<%=borrowerUserInfo.Graduation%></div>
    <div class="h43 c-808080 f14px pl15">当前负债：<%=borrowerUserInfo.CurrentDebts%></div>
    <div class="h43 c-808080 f14px pl15 bg-fafafa">在其他网络借贷平台借款情况：<%=borrowerUserInfo.OtherBorrow%></div>
    <div class="h43 c-808080 f14px pl15">近6个月征信报告中的逾期情况：<%=borrowerUserInfo.CreditOverDue%></div> 
    <%} %>   
<%} %>