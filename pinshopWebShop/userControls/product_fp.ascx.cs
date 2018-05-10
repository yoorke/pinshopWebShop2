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

namespace WebShop2.UserControls
{
    public partial class product_fp : System.Web.UI.UserControl
    {
        private Product _product;
        private string _name;
        private bool _wishList;

        public Product ProductItem
        {
            get { return _product; }
            set
            {
                if (_product != value)
                {
                    _product = value;
                    setValues();
                }
            }
        }

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public bool WishList
        {
            get { return _wishList; }
            set { _wishList = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void setValues()
        {
            //imgPhoto.ImageUrl = _product.Images[0] != "/images/no-image.jpg" ? _product.Images[0].Substring(0, _product.Images[0].IndexOf(".jpg")) + "-list.jpg" : _product.Images[0];
            string filename = _product.Images[0].ImageUrl.Substring(0, _product.Images[0].ImageUrl.LastIndexOf('.'));
            string extension = _product.Images[0].ImageUrl.Substring(_product.Images[0].ImageUrl.LastIndexOf('.'));
            imgPhoto.ImageUrl = new ProductBL().CreateImageDirectory(int.Parse(_product.Images[0].ImageUrl.Substring(0, _product.Images[0].ImageUrl.LastIndexOf('.')))) + filename + "-" + ConfigurationManager.AppSettings["listName"] + extension;
            switch(ConfigurationManager.AppSettings["productFP_Line1"])
            {
                case "Brand": lblBrand.Text = _product.Brand.Name;break;
                case "Name": lblBrand.Text = _product.Name;break;
            }
            switch(ConfigurationManager.AppSettings["productFP_Line2"])
            {
                case "Name": lblName.Text = _product.Name; break;
                case "Description": lblName.Text = _product.Description;break;
            }
            if (bool.Parse(ConfigurationManager.AppSettings["showProductCode"]))
                lblCode.Text = "š: " +_product.Code;

            string url = _product.Url;  //"/product.aspx?productUrl=" + _product.ProductID;
            lnkName.NavigateUrl = url;
            lnkPhoto.NavigateUrl = url;
            lblDetails.NavigateUrl = url;
            //lblBrand.NavigateUrl = url;

            //Price
            lblPrice.Text = string.Format("{0:N2}", _product.Price);
            lblWebPrice.Text = (_product.Promotion == null) ? string.Format("{0:N2}", _product.WebPrice) : string.Format("{0:N2}", _product.Promotion.Price);
            lblSaving.Text = "Ušteda: " + string.Format("{0:N2}", _product.Price - double.Parse(lblWebPrice.Text)) + " din";
            if(_product.Price != _product.WebPrice)
            {
                lblPrice.Visible = true;
                lblSaving.Visible = true;
            }


            //lblDescription.Text = _product.Description;
            //lnkInfo.NavigateUrl = "/product.aspx?productUrl=" + _product.ProductID;
            if (_product.Promotion != null)
            {
                imgPromotion.ImageUrl = "/images/" + _product.Promotion.ImageUrl;
                imgPromotion.Visible = (_product.Promotion.ImageUrl != string.Empty) ? true : false;

                lblPrice.Visible = true;
                lblSaving.Visible = true;
                lblWebPrice.Attributes["class"] = "web_price color-red";
                imgPromotion.Visible = false;
            }
            else
                lblWebPrice.Attributes["class"] = "web_price color-blue";

            
            lblProductID.Value = _product.ProductID.ToString();
            if (_wishList)
                btnDeleteFromWishList.Visible = true;

            if (HttpContext.Current.User.Identity.IsAuthenticated && Roles.IsUserInRole(HttpContext.Current.User.Identity.Name, "Administrator"))
            {
                lnkEditProduct.Visible = true;
                lnkEditProduct.NavigateUrl = "/administrator/product.aspx?id=" + _product.ProductID;
            }
            lblName.ToolTip = _product.Name;

            if (!_product.IsInStock)
            { 
                btnCartAjax.Attributes.Add("disabled", "true");
                btnCartAjax.Attributes.Add("class", "ws-btn btn-cart not-in-stock");
                divNis.Style.Add("display", "block");
            }

            btnCartAjax.Attributes.Add("onclick", "AddToCart('" + lblProductID.ClientID + "')");
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            CartBL cartBL = new CartBL();
            cartBL.AddProductToCart(lblProductID.Value.Contains(',') ? int.Parse(lblProductID.Value.Substring(0, lblProductID.Value.IndexOf(','))) : int.Parse(lblProductID.Value), Session["cartID"].ToString(), 1, double.Parse(lblWebPrice.Text), double.Parse(lblWebPrice.Text));
            //Response.Redirect("/korpa");
        }

        protected void btnDeleteFromWishList_Click(object sender, EventArgs e)
        {
            new WishListBL().DeleteFromWishList(int.Parse(Membership.GetUser().ProviderUserKey.ToString()), int.Parse(lblProductID.Value.ToString()));
            Response.Redirect("~/wishList.aspx");
        }
    }
}