<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editVendor.aspx.cs" Inherits="WebApplication1.editVendor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
           <div>
            
        <asp:Label ID="Label1" runat="server" Text="product name: "></asp:Label>
        <asp:TextBox ID="txt_productname" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="serialnumber: "></asp:Label>
        <asp:TextBox ID="txt_serialnumber" runat="server" ></asp:TextBox>
        <br />
        <br />        
        <asp:Label ID="Label2" runat="server" Text="category: "></asp:Label>
        <asp:TextBox ID="txt_category" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="product description: "></asp:Label>
        <asp:TextBox ID="txt_productdescription" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="price: "></asp:Label>
        <asp:TextBox ID="txt_price" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="color: "></asp:Label>
        <asp:TextBox ID="txt_color" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="edit product" OnClick="Edit" Width="163px"/>
        <br />
        <br />
        
        </div>
    </form>
</body>
</html>
