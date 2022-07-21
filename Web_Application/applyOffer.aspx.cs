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
    public partial class applyOffer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void applyoffer(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];
            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("checkOfferonProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;




            //To read the input from the user
            int serial = int.Parse(txt_serial.Text);
            int offerid = int.Parse(txt_offerid.Text);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@serial", serial));

            SqlParameter success = cmd.Parameters.Add("@activeoffer", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if ((success.Value).ToString().Equals("1"))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "There is already an offer on it" + "');", true);
            }
            else
            {
                SqlCommand cmd1 = new SqlCommand("applyOffer", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@vendorname", username));
                cmd1.Parameters.Add(new SqlParameter("@serial", serial));
                cmd1.Parameters.Add(new SqlParameter("@offerid", offerid));
                conn.Open();
                try
                {
                    cmd1.ExecuteNonQuery();
                    Response.Write("added sacsafoly");
                }
                catch (SqlException exc) when (exc.Number == 547)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "offer_id/product does not exist" + "');", true);

                }
              
                conn.Close();
            }
        }
    }
}