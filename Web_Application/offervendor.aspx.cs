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
    public partial class offervendor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void offer(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];
            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int offeramount = int.Parse(txt_offeramoun.Text);
            DateTime expirydate = DateTime.Parse(txt_expirydate.Text);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offeramount", offeramount));
            cmd.Parameters.Add(new SqlParameter("@expiry_date", expirydate));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Write("added sacsafoly");


        }
    }
}
