<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addcreditcard.aspx.cs" Inherits="WebApplication1.addcreditcard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div>
             <asp:Label ID="Label13" runat="server" Text="Credit Card Number:"></asp:Label>
            <asp:TextBox ID="txt_cardnum" runat="server"></asp:TextBox>
            <br />
              <br />
            <asp:Label ID="Label1" runat="server" Text="Expiry Date:"></asp:Label>
            <asp:TextBox ID="txt_date" runat="server" ></asp:TextBox>
             <br />
              <br />
             <asp:Label ID="Label2" runat="server" Text="CVV"></asp:Label>
            <asp:TextBox ID="txt_cvv" runat="server" ></asp:TextBox>
            <asp:Button runat="server" Text="ADD" Width="178px" onclick="Addcreditcard"/>
              <br />
              <br />
        </div>
    </form>
</body>
</html>
