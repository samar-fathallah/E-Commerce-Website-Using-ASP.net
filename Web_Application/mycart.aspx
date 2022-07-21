<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mycart.aspx.cs" Inherits="WebApplication1.mycart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView id="GridView2" runat="server"></asp:GridView>
        </div>
        <div>
             
              <br />
              <br />
              <asp:Label ID="Label13" runat="server" Text="Product Number:"></asp:Label>
            <asp:TextBox ID="txt_cartnumber" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="ADD" Width="178px" OnClick="Addtocart" />

              <br />
             <asp:Button ID="Button2" runat="server" Text="REMOVE" Width="178px" style="margin-top: 9px" OnClick="Removefromcart"  />
              <br />
              <br />
             <asp:Button ID="Button3" runat="server" Text="make order" Width="178px" style="margin-top: 9px" OnClick="makeorder"  />
        </div>
    </form>
</body>
</html>
