<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="applyOffer.aspx.cs" Inherits="WebApplication1.applyOffer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
      <div>
        <asp:Label ID="Label1" runat="server" Text="offer id: "></asp:Label>
        <asp:TextBox ID="txt_offerid" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="serial: "></asp:Label>
        <asp:TextBox ID="txt_serial" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="apply offer" OnClick="applyoffer" Width="163px"/>
        <br />
        <br />
    </div>
    </form>
</body>
</html>
