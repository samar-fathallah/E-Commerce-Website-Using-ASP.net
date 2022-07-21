using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void addmobile(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_usernamephone.Text;
            string number = txt_number.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", number));



            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
       
        protected void Customer_register(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_cusername.Text;
            string firstname = txt_cfirstname.Text;
            string lastname = txt_clastname.Text;
            string password = txt_cpassword.Text;
            string email = txt_email.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
            cmd.Parameters.Add(new SqlParameter("@last_name", lastname));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            if (username.Equals("") || firstname.Equals("") || lastname.Equals("") || password.Equals("") || email.Equals(""))
            {
                Response.Write("PLEASE DONT LEAVE ANY FIELDS EMPTY");
            }
            else
            {
                //Executing the SQLCommand
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("Added sacsafoly ");
                    Response.Redirect("customer.aspx", true);

                }
                catch (SqlException exc) when (exc.Number == 2627)
                {
                    Response.Write("username already used ,please choose another one ");

                }
                catch (SqlException exc) when (exc.Number == 201)
                {
                    Response.Write("please don't leave any field empty");
                }
                conn.Close();
            }
           

        }
        protected void vendor_register(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("vendorRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_vusername.Text;
            string firstname = txt_vfirstname.Text;
            string lastname = txt_vlastname.Text;
            string password = txt_vpassword.Text;
            string email = txt_vemail.Text;
            string companyname = txt_companyname.Text;
            string banknum = txt_bnum.Text;
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
            cmd.Parameters.Add(new SqlParameter("@last_name", lastname));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@company_name", companyname));
            cmd.Parameters.Add(new SqlParameter("@bank_acc_no", banknum));
            if (username.Equals("") || firstname.Equals("") || lastname.Equals("") || password.Equals("") || email.Equals("") ||
                companyname.Equals("") || banknum.Equals(""))
            {
                Response.Write("PLEASE DONT LEAVE ANY FIELDS EMPTY");
            }
            else
            {

                //Executing the SQLCommand
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("Added sacsafoly ");
                    Response.Redirect("vendor.aspx", true);
                }
                catch (SqlException exc) when (exc.Number == 2627)
                {
                    Response.Write("username already used ,please choose another one");

                }
                catch (SqlException exc) when (exc.Number == 201)
                {
                    Response.Write("please don't leave any field empty");
                }

                conn.Close();
            }
        }

        protected void Login(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogiN", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = txt_username.Text;
            string password = txt_password.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            //Save the output from the procedure
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;


            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            if ((success.Value).ToString().Equals("1"))
            {
                //To send response data to the client side (HTML)
                Response.Write("Passed");
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + type + "');", true);


                /*ASP.NET session state enables you to store and retrieve values for a user
                as the user navigates ASP.NET pages in a Web application.
                This is how we store a value in the session*/
                Session["string1"] = username;

                //To navigate to another webpage
                if (type.Value.ToString().Equals("0"))
                    Response.Redirect("customer.aspx", true);
                if (type.Value.ToString().Equals("1"))
                    Response.Redirect("vendor.aspx", true);
                //if (type.Value.ToString().Equals("2"))
                //   Response.Redirect("Admins.aspx", true);
                //if (type.Value.ToString().Equals("3"))
                //  Response.Redirect("Delivery.aspx", true);

            }
            else
            {
                Response.Write("Failed");
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "fail" + "');", true);
            }
        }
    }
    }