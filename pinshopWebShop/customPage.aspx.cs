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
using eshopBE;
using eshopBL;
using System.Collections.Generic;

namespace WebShop2
{
    public partial class customPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            if (!Page.IsPostBack)
            {
                string url=string.Empty;
                //if (Page.Request.QueryString.ToString().Contains("url"))
                //url = Page.Request.QueryString["url"].Remove(0,1);
                if (Page.RouteData.Values["url"] != null)
                    url = Page.RouteData.Values["url"].ToString();
                if (url != string.Empty)
                    loadCustomPage(url);
            }
        }

        private void loadCustomPage(string url)
        {
            CustomPageBL customPageBL = new CustomPageBL();
            CustomPage customPage = customPageBL.GetCustomPage(url);
            Page.Title = customPage.Title;
            ViewState.Add("pageTitle", customPage.Title);
            lblHeading.Text = customPage.Heading;
            divContent.InnerHtml = customPage.Content;
            //lblHeader.Text = customPage.Head;
            lblFooter.Text = customPage.Footer;

            List<Product> products = new List<Product>();
            foreach (CustomPageProduct customPageProduct in customPage.Products)
                products.Add(new ProductBL().GetProduct(customPageProduct.ProductID, string.Empty, false, string.Empty));

            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }
    }
}
