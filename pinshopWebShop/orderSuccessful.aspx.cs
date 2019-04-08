using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

namespace WebShop2
{
    public partial class orderSuccessful : System.Web.UI.Page
    {
        public double OrderValue = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            //Page.ClientScript.RegisterClientScriptBlock(GetType(), "dataLayer", "alert('23131')", false);
            double.TryParse(Session["orderTotal"] != null ? Session["orderTotal"].ToString() : "0", out this.OrderValue);
        }
    }
}
