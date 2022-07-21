using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Viewproducts(object sender, EventArgs e)
        {
            Response.Redirect("viewproducts.aspx", true);
        }

        protected void WISHLIST(object sender, EventArgs e)
        {
            Response.Redirect("wishlist.aspx", true);
        }

        protected void Addcreditcard(object sender, EventArgs e)
        {
            Response.Redirect("addcreditcard.aspx", true);
        }

        protected void Mycart(object sender, EventArgs e)
        {
            Response.Redirect("mycart.aspx", true);
        }
        protected void cancelorder(object sender, EventArgs e)
        {
            Response.Redirect("cancelorder.aspx", true);
        }
    }
}
