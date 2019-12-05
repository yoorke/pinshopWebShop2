using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop2
{
    public partial class error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();

            TextReader tr = new StreamReader(Server.MapPath("~/error.html"));
            Response.Write(tr.ReadToEnd());
            Response.StatusCode = 500;
            Response.Status = "500 Internal Server Error";
            Response.End();
        }
    }
}