<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customer.aspx.cs" Inherits="WebApplication1.customer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" Text="VIEW MY PRODUCTS" Width="178px" OnClick="Viewproducts"/>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="MY WISHLIST" Width="178px" OnClick="WISHLIST" />
        <br />
        <br />
          <asp:Button ID="Button2" runat="server" Text="ADD CREDIT CARD" Width="178px" OnClick="Addcreditcard"  />
         <br />
        <br />
          <asp:Button ID="Button4" runat="server" Text="MY CART" Width="178px" OnClick="Mycart"  />
          <br />
        <br />
         <asp:Button ID="Button5" runat="server" Text="CANCEL ORDER" Width="178px" OnClick="cancelorder"  />
    </form>
</body>
</html>
