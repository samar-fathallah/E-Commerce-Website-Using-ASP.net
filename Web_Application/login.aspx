<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div>
        <asp:Label ID="Label14" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox ID="txt_usernamephone" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label13" runat="server" Text="Mobile Number:"></asp:Label>
        <asp:TextBox ID="txt_number" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" Text="Add Mobile Number" Onclick="addmobile" Width="163px"/>
        <br />
        <br />
        </div>

        <div>
        <asp:Label ID="lbl_username" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox ID="txt_username" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_password" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="btn_login" runat="server" Text="Login" Onclick="Login" Width="90px"/>
        </div>

        <br />
        <br />
        <div>
        <asp:Label ID="Label3" runat="server" Text="Customer Register"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox ID="txt_cusername" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_cpassword" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label7" runat="server" Text="First Name: "></asp:Label>
        <asp:TextBox ID="txt_clastname" runat="server" ></asp:TextBox>
        <br />
        <br />  
        <asp:Label ID="Label8" runat="server" Text="Last Name: "></asp:Label>
        <asp:TextBox ID="txt_cfirstname" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Text="Email: "></asp:Label>
        <asp:TextBox ID="txt_email" runat="server" TextMode="Email"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="register" Onclick="Customer_register" Width="90px"/>
        </div>

         <div>
        <asp:Label ID="Label4" runat="server" Text="Vendor Register"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Username: "></asp:Label>
    
        <asp:TextBox ID="txt_vusername" runat="server"></asp:TextBox>
     <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_vpassword" runat="server" TextMode="Password"></asp:TextBox>
    
        <br />
        <br />
              <asp:Label ID="Label10" runat="server" Text="First Name: "></asp:Label>
        <asp:TextBox ID="txt_vfirstname" runat="server" Width="152px" ></asp:TextBox>
        <br />
        <br />  
        <asp:Label ID="Label11" runat="server" Text="Last Name: "></asp:Label>
        <asp:TextBox ID="txt_vlastname" runat="server" ></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label12" runat="server" Text="Email: "></asp:Label>
        <asp:TextBox ID="txt_vemail" runat="server" TextMode="Email"></asp:TextBox>
       <br />
        <br />  
        <asp:Label ID="Label15" runat="server" Text="Company Name: "></asp:Label>
        <asp:TextBox ID="txt_companyname" runat="server" ></asp:TextBox>
        <br />
        <br />  
        <asp:Label ID="Label16" runat="server" Text="Bank Account Number: "></asp:Label> <a href="myorder.aspx"></a>
        <asp:TextBox ID="txt_bnum" runat="server" ></asp:TextBox>
        <br />
        <br /> 
        <asp:Button ID="Button2" runat="server" Text="register" Onclick="vendor_register" Width="90px" Font-Bold="True" />
        </div>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
