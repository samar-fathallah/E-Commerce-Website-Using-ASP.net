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
    public partial class cancelorder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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

        protected void cancelorder1(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            String username = (String)Session["String1"];

            SqlCommand cmd = new SqlCommand("cancelOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            int orderID = int.Parse(txt_orderid.Text);





            cmd.Parameters.Add(new SqlParameter("@orderid", orderID));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

        }

    }
}