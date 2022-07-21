<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cancelorder.aspx.cs" Inherits="WebApplication1.cancelorder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
      <div>
            <asp:GridView id="GridView2" runat="server"></asp:GridView>
            <br />
            <br />
             <asp:Label ID="Label1" runat="server" Text="order id: "></asp:Label>
            <asp:TextBox ID="txt_orderid" runat="server" ></asp:TextBox>
             <br />
              <br />
                 <asp:Button runat="server" Text="cancel order" Width="178px" onclick="cancelorder1"/> 
            
            </div>
    </form>
</body>
</html>
