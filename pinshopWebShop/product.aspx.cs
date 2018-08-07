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
using System.Text;
using System.Web.Services;

namespace WebShop2
{
    public partial class product : System.Web.UI.Page
    {
        /*private List<string> images
        {
            get{if(ViewState["images"]!=null)
                return (List<string>)ViewState["images"];
            else
                return null;
            }
            set { ViewState["images"] = value; }
        }*/

        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            if (!Page.IsPostBack)
            {
                //string productName = (Page.Request.QueryString.ToString().Contains("productID")) ? Page.Request.QueryString["productID"] : string.Empty;
                string productName = (Page.RouteData.Values["product"] != null) ? Page.RouteData.Values["product"].ToString() : string.Empty;
                
                if (productName != string.Empty)
                {
                    StringBuilder sb = new StringBuilder();
                    for (int i = productName.Length - 1; i > 0; i--)
                        if (productName[i] == '-')
                            break;
                        else
                            if (char.IsDigit(productName[i]))
                                sb.Insert(0, productName[i]);

                    int productID;
                    int.TryParse(sb.ToString(), out productID);
                    loadProduct(productID);
                }
            }
            else
            {
                //priProductImages.Images = images;
                Page.Title = ViewState["pageTitle"].ToString();
                
            }
            lblProductFacebookLike.InnerHtml = "<div class='fb-like' data-href='" + ConfigurationManager.AppSettings["webShopUrl"] + Page.Request.RawUrl + "' data-width='100' data-layout='button_count' data-action='like' data-show-faces='true' data-share='true'></div>";
            createProductTags();
            loanBox.Visible = bool.Parse(ConfigurationManager.AppSettings["loanBoxVisible"]);
        }

        private void loadProduct(int productID)
        {
            ProductBL productBL = new ProductBL();
            Product product = productBL.GetProduct(productID, string.Empty, true, string.Empty);

            if(product != null) {

                if (!Request.RawUrl.Equals(product.Url))
                    Response.RedirectPermanent(product.Url);
                
                //images = product.Images;
                priProductImages.Images = product.Images;
                priProductImages.ShowImages();

                switch(ConfigurationManager.AppSettings["product_Line1"])
                {
                    case "Name": lblBrand.Text = product.Name; break;
                    case "Brand": lblBrand.Text = product.Brand.Name; break;
                }
                switch(ConfigurationManager.AppSettings["product_Line2"])
                {
                    case "Name": lblName.Text = product.Name;break;
                    case "Description": lblName.Text = product.Description;break;
                }
                lblDescription.Text = product.Description;
                lblPrice.Text = "MP cena: " + string.Format("{0:N2}", product.Price);
                lblWebPrice.Text = (product.Promotion == null) ? string.Format("{0:N2}", product.WebPrice) : string.Format("{0:N2}", product.Promotion.Price);
                lblSaving.Text = "Ušteda: " + string.Format("{0:N2}", product.Price - double.Parse(lblWebPrice.Text));

                if(product.Price == double.Parse(lblWebPrice.Text))
                {
                    priceDiv.Visible = false;
                    savingDiv.Visible = false;
                }

                lblSpecification.Text = !product.Specification.Contains("<table class='table table-striped'><tbody></table>") ? product.Specification : "Nema podataka";
                lblDescription.Text = product.Description != string.Empty ? product.Description : "Nema opisa";
                if (product.Promotion != null)
                {
                    imgPromotion.ImageUrl = "/images/" + product.Promotion.ImageUrl;
                    imgPromotion.Visible = true;
                }
                lblProductID.Value = product.ProductID.ToString();
                Page.Title = (ConfigurationManager.AppSettings["product_Line1"] == "Name" ? product.Name : product.Brand.Name) + " " + (ConfigurationManager.AppSettings["product_Line2"] == "Name" ? product.Name : product.Description);
                ViewState.Add("pageTitle", Page.Title);
                ViewState.Add("productDescription", product.Description);
                if(product.Images != null && product.Images.Count > 0)
                    ViewState.Add("image", product.Images[0]);

                lnkCategory.NavigateUrl = "/proizvodi/" + product.Categories[0].Url;
                lnkCategory.Text = product.Categories[0].Name;

                loadProductSliders(product.Categories[0]);

                divUputstvo.Visible = ConfigurationManager.AppSettings["categoryManual"].Contains(product.Categories[0].Url.ToLower()) ? true : false;

                txtAvailability.Text = product.IsInStock ? "NA STANJU" : "NEMA NA STANJU";

                lblStockIcon.CssClass = "fa fa-fw fa-check-square";

                if (!product.IsInStock)
                { 
                    btnCartAjax.Attributes.Add("disabled", "true");
                    btnCartAjax.Attributes.Add("class", "ws-btn btn-cart btn-not-in-stock");
                    divNis.Style.Add("display", "block");
                    txtDelivery.Text = "-";
                    lblStockIcon.CssClass = "fa fa-fw fa-remove not-in-stock";
                    divNis.Attributes["class"] = "nis-cont not-in-stock";
                }

                btnCartAjax.Attributes.Add("onclick", "AddToCart('" + lblProductID.ClientID + "')");
                
                lblCode.Text = product.Code;

                if(product.Brand.LogoUrl != null && product.Brand.LogoUrl != string.Empty && bool.Parse(ConfigurationManager.AppSettings["showBrandLogoOnProductPage"]))
                {
                    imgBrand.Visible = true;
                    imgBrand.ImageUrl = "/images/brand/" + product.Brand.LogoUrl;
                }

                ViewState.Add("productUrl", product.Url);
            }
            else
            {
                Server.Transfer("~/not-found.aspx");
            }
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            CartBL cartBL = new CartBL();
            cartBL.AddProductToCart(int.Parse(lblProductID.Value), Session["cartID"].ToString(), 1, double.Parse(lblWebPrice.Text.Substring(0, lblWebPrice.Text.IndexOf(" din"))), double.Parse(lblWebPrice.Text.Substring(0, lblWebPrice.Text.IndexOf(" din"))));
            Response.Redirect("/korpa");
        }

        protected void btnCompare_Click(object sender, EventArgs e)
        {

        }

        

        private void createProductTags()
        {
            HtmlMeta tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "fb:admins");
            tag.Attributes.Add("content", "147221185684092");
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:title");
            tag.Attributes.Add("content", ViewState["pageTitle"].ToString() + " " + ViewState["productDescription"].ToString());
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:type");
            tag.Attributes.Add("content", "product");
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:url");
            tag.Attributes.Add("content", ConfigurationManager.AppSettings["webShopUrl"] + Page.Request.RawUrl);
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:image");
            tag.Attributes.Add("content", ConfigurationManager.AppSettings["webShopUrl"] + priProductImages.GetMainImageUrl);
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:image:width");
            tag.Attributes.Add("content", priProductImages.GetMainImageWidth.ToString());
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:image:height");
            tag.Attributes.Add("content", priProductImages.GetMainImageHeight.ToString());
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:site_name");
            tag.Attributes.Add("content", "PinShop | Vaša online prodavnica");
            Header.Controls.Add(tag);

            tag = new HtmlMeta();
            tag.Attributes.Clear();
            tag.Attributes.Add("property", "og:description");
            tag.Attributes.Add("content", ViewState["pageTitle"].ToString() + " " + ViewState["productDescription"].ToString());
            Header.Controls.Add(tag);

            HtmlLink link = new HtmlLink();
            link.Attributes.Add("rel", "canonical");
            link.Attributes.Add("href", ConfigurationManager.AppSettings["webShopUrl"] +  ViewState["productUrl"]);
            Header.Controls.Add(link);
        }

        private void loadProductSliders(Category category)
        {
            sliderCategory.NumberOfProducts = 4;
            sliderCategory.LgCols = 3;
            sliderCategory.Products = new ProductBL().GetProductsForFirstPage(category.CategoryID, -1, 12, "Slučajni");
            sliderCategory.Name = category.Name;
            ((Literal)sliderCategory.FindControl("lblPrev")).Text = @"<a id=""prev"" runat=""server"" href=""#carouselCategory"" data-slide=""prev""><span class='fa fa-fw fa-chevron-circle-left direction-icon'></span></a>";
            ((Literal)sliderCategory.FindControl("lblNext")).Text = @"<a id=""next"" runat=""server"" href=""#carouselCategory"" data-slide=""next"" class=""next_button""><span class='fa fa-fw fa-chevron-circle-right direction-icon'></span></a>";
            ((Literal)sliderCategory.FindControl("lblCarousel")).Text = @"<div id=""carouselCategory"" class=""carousel slide"" data-ride="""" runat=""server"">";
            ((Literal)sliderCategory.FindControl("lblCarouselClose")).Text = "</div>";
        }
    }
}
