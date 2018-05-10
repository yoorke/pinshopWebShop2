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
    public partial class ProductCompare : System.Web.UI.UserControl
    {
        private Product _product;
        
        public Product Product
        { 
            get { return _product; }
            set
            {
                _product = value;
                setValues();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void setValues()
        {
            //imgProduct.ImageUrl = _product.Images[0] != "/images/no-image.jpg" ? _product.Images[0].Substring(0, _product.Images[0].IndexOf(".")) + "-home.jpg" : _product.Images[0];
            imgProduct.ImageUrl = new ProductBL().CreateImageDirectory(int.Parse(_product.Images[0].ImageUrl.Substring(0, _product.Images[0].ImageUrl.LastIndexOf('.')))) + _product.Images[0].ImageUrl.Substring(0, _product.Images[0].ImageUrl.LastIndexOf('.')) + "-" + ConfigurationManager.AppSettings["listName"] + _product.Images[0].ImageUrl.Substring(_product.Images[0].ImageUrl.LastIndexOf('.'));
            lblBrand.Text = ConfigurationManager.AppSettings["product_Line1"] == "Name" ? _product.Name : _product.Brand.Name;
            lblProductName.Text = ConfigurationManager.AppSettings["product_Line2"] == "Description" ? _product.Description : _product.Name;
            lblWebPrice.Text = string.Format("{0:N2}", _product.WebPrice);
            lblSpecification.Text = _product.Specification;
            lblProductID.Value = _product.ProductID.ToString();
        }
    }
}