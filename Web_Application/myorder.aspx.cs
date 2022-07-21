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
    public partial class myorder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);


                String username = (String)Session["String1"];
                SqlCommand cmd = new SqlCommand("showOrders", conn);
                cmd.Parameters.Add(new SqlParameter("@customername", username));

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
        }
            protected void pay(object sender, EventArgs e)
            {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String username = (String)Session["String1"];

                SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                int orderID = int.Parse(txt_orderid.Text);
                decimal cash = decimal.Parse(txt_cash.Text);
                decimal credit = decimal.Parse(txt_credit.Text);




                cmd.Parameters.Add(new SqlParameter("@orderID", orderID));
                cmd.Parameters.Add(new SqlParameter("@cash", cash));
                cmd.Parameters.Add(new SqlParameter("@credit", credit));
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            Response.Write("paid sacsafoly");
            }

            protected void addcredit(object sender, EventArgs e)
            {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            String username = (String)Session["String1"];

                SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                int orderID = int.Parse(txt_ordid.Text);

                String credit = txt_crednum.Text;




                cmd.Parameters.Add(new SqlParameter("@orderid", orderID));

                cmd.Parameters.Add(new SqlParameter("@creditcard", credit));

                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException exc) when (exc.Number == 547)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "this credit card does not exsit" + "');", true);

                }
                conn.Close();
            Response.Write("added sacsafoly");
        }
        }
}