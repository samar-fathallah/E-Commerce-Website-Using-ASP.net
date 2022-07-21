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
    public partial class editVendor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Edit(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];
            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.Parameters.Add(new SqlParameter("@vendorname", username));
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string productname = txt_productname.Text;
            int serialnumber = int.Parse(txt_serialnumber.Text);
            string category = txt_category.Text;
            string product_description = txt_productdescription.Text;
            decimal price = decimal.Parse(txt_price.Text);
            string color = txt_color.Text;

            //pass parameters to the stored procedure
          
            cmd.Parameters.Add(new SqlParameter("@product_name", productname));
            cmd.Parameters.Add(new SqlParameter("@serialnumber", serialnumber));
            cmd.Parameters.Add(new SqlParameter("@category", category));
            cmd.Parameters.Add(new SqlParameter("@product_description", product_description));
            cmd.Parameters.Add(new SqlParameter("@price", price));
            cmd.Parameters.Add(new SqlParameter("@color", color));

            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                Response.Write("YOUR PRODUCT HAVE BEEN EDITED");
            }
            catch (SqlException exc) when (exc.Number == 547)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "product does not exist" + "');", true);

            }

            conn.Close();

        }
    }
}