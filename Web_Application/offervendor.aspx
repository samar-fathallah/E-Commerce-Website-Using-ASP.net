<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="offervendor.aspx.cs" Inherits="WebApplication1.offervendor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Label ID="Label1" runat="server" Text="offer amount: "></asp:Label>
        <asp:TextBox ID="txt_offeramoun" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="expiry date: "></asp:Label>
        <asp:TextBox ID="txt_expirydate" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Add offer" OnClick="offer" Width="163px"/>
        <br />
        <br />
    </div>
    </form>
</body>
</html>
