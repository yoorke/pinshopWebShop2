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
using eshopBL;
using eshopBE;

namespace WebShop2
{
    public partial class wishList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            if (User.Identity.IsAuthenticated)
            {
                if (!Page.IsPostBack)
                {
                    LoadProducts();
                }
            }
            else
                Response.Redirect("~/prijava?returnUrl=/lista-zelja");
        }

        private void LoadProducts()
        {
            rptProducts.DataSource = new WishListBL().GetWishListProducts(int.Parse(Membership.GetUser().ProviderUserKey.ToString()));
            rptProducts.DataBind();
        }
    }
}
