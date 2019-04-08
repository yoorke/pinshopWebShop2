using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using eshopBE;
using eshopBL;
using System.Collections.Generic;

namespace WebShop2
{
    public partial class compare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //string[] productList;
                //if (Page.Request.QueryString.ToString().Contains("productList"))
                //{
                //if (Page.Request.QueryString["productList"] != null)
                //{
                //productList = Page.Request.QueryString["productList"].Split('-');
                //showProducts(productList);
                //}
                //}
                //List<int> productList = (List<int>)HttpContext.Current.Session["compare"];
                showProducts();
            }
            Master.FindControl("mainMenuVertical").Visible = true;
        }

        private void showProducts()
        {
            List<int> productsID = (List<int>)Session["compare"];
            List<Product> products = new List<Product>();
            if (productsID != null && productsID.Count > 0)
            {
                for (int i = 0; i < productsID.Count; i++)
                {
                    Product newProduct = new ProductBL().GetProduct(productsID[i], string.Empty, false, string.Empty);
                    foreach (Product product in products)                        
                    {
                        foreach (eshopBE.AttributeValue newAttribute in newProduct.Attributes)
                        {
                            bool exists = false;
                            foreach(AttributeValue attribute in product.Attributes)
                            {
                                if (attribute.AttributeID == newAttribute.AttributeID)
                                {
                                    exists = true;
                                    break;
                                }
                            }
                            if (!exists)
                            {
                                AttributeValue value = new AttributeValue();
                                value.AttributeID = newAttribute.AttributeID;
                                value.AttributeValueID = -1;
                                value.Value = string.Empty;
                                product.Attributes.Add(value);
                            }
                        }
                    }


                    products.Add(newProduct);
                }

                rptProducts.DataSource = products;
                rptProducts.DataBind();
            }
            else
            {
                setStatus("Nema proizvoda u listi za poređenje", "warning");
            }
        }

        private void setStatus(string text, string classes)
        {
            lblStatus.Text = text;
            lblStatus.CssClass = "alert alert-" + classes + " status";
            lblStatus.Visible = true;
        }
    }
}
