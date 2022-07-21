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
    public partial class mycart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];
            SqlCommand cmd = new SqlCommand("viewMyCart", conn);
            cmd.Parameters.Add(new SqlParameter("@customer", username));

            cmd.CommandType = CommandType.StoredProcedure;
            try
            {

                conn.Open();
                DataSet ds = new DataSet();

                SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

                objAdp.Fill(ds);

                GridView2.DataSource = ds;
                GridView2.DataBind();

            }
            catch (Exception ex)
            {
                Response.Write(ex.Message.ToString());
            }
            finally
            {
                conn.Close();
            }
        }

        protected void Addtocart(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];

            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int cartnumber = int.Parse(txt_cartnumber.Text);
            cmd.Parameters.Add(new SqlParameter("@serial", cartnumber));
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            conn.Open();

            try
            {
                cmd.ExecuteNonQuery();
                Response.Write("Added sacsafoly ");

            }
            catch (SqlException exc) when (exc.Number == 547)
            {
                Response.Write("Enter a valid product id ");

            }
            conn.Close();
        }


        protected void Removefromcart(object sender, EventArgs e)
        {

            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];

            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int cartnumber = int.Parse(txt_cartnumber.Text);
            cmd.Parameters.Add(new SqlParameter("@serial", cartnumber));
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Write("REMOVE SACSAFOLY");
        }
        protected void makeorder(object sender, EventArgs e)
        {

            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            String username = (String)Session["String1"];

            SqlCommand cmd = new SqlCommand("makeOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", username));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("myorder.aspx", true);
        }
    }
}
