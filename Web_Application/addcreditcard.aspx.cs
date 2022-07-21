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
    public partial class addcreditcard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Addcreditcard(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];

            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string ccnumber = txt_cardnum.Text;
            string cvv = txt_cvv.Text;
            DateTime expirydate = DateTime.Parse(txt_date.Text);
            cmd.Parameters.Add(new SqlParameter("@creditcardnumber", ccnumber));
            cmd.Parameters.Add(new SqlParameter("@cvv", cvv));
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expirydate));
            conn.Open();
            cmd.ExecuteNonQuery();
            Response.Write("Your redit Card was added sacsafoly");
            conn.Close();

        }
    }
}