<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myorder.aspx.cs" Inherits="WebApplication1.myorder" %>

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
             <asp:Label ID="Label1" runat="server" Text="cash amount: "></asp:Label>
            <asp:TextBox ID="txt_cash" runat="server" ></asp:TextBox>
             <br />
              <br />
             <asp:Label ID="Label2" runat="server" Text="credit card: "></asp:Label>
            <asp:TextBox ID="txt_credit" runat="server" ></asp:TextBox>
             <br />
              <br />
              <asp:Label ID="Label3" runat="server" Text="order id: "></asp:Label>
            <asp:TextBox ID="txt_orderid" runat="server" ></asp:TextBox>
             <br />
              <br />
            <asp:Button runat="server" Text="pay" Width="178px" onclick="pay"/>    
                <br />
              <br />
              <asp:Label ID="Label4" runat="server" Text="credit card number: "></asp:Label>
            <asp:TextBox ID="txt_crednum" runat="server" ></asp:TextBox>
                  <br />
              <br />
                <asp:Label ID="Label5" runat="server" Text="order id: "></asp:Label>
            <asp:TextBox ID="txt_ordid" runat="server" ></asp:TextBox>
                  <br />
              <br />
                <asp:Button runat="server" Text="add credit card" Width="178px" onclick="addcredit"/> 
            
            </div>
    </form>
</body>
</html>
