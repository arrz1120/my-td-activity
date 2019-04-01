<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuOperation.aspx.cs"  Inherits="TuanDai.WXApiWeb.MenuOperation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table>
       <h><strong>菜单操作</strong></h>
        <tr>
            <td>
                <asp:Button ID="btnCreateMenu" runat="server" Text="创建菜单" 
                    onclick="btnCreateMenu_Click"  OnClientClick="return confirm('您确定是否创建服务号菜单？');" />
            </td>
            <td width="80">&nbsp;</td>
            <td>
                <asp:Button ID="btngGetToken" runat="server" Text="获取AccessToken"  onclick="btngGetToken_Click"  OnClientClick="return confirm('您确定是否执行此功能？');" />
                <br /> 
                <%=strAccessToken %>
            </td> 
        </tr>
    </table>
    </form>
</body>
</html>
