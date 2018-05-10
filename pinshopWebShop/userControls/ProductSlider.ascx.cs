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
using System.Collections.Generic;
using eshopBE;

namespace WebShop2.UserControls
{
    public partial class ProductSlider : System.Web.UI.UserControl
    {
        private List<Product> _products;
        private int _numberOfProducts;
        private int _slidesCount;
        private string _name;
        private int _lgCols;

        public List<Product> Products
        {
            get { return _products; }
            set
            {
                _products = value;
                setValues();
            }
        }

        public int NumberOfProducts
        {
            get { return _numberOfProducts; }
            set { _numberOfProducts = value; }
        }

        public string Name
        {
            get { return _name; }
            set
            {
                _name = value;
                setName();
            }
        }

        public int LgCols
        {
            get { return _lgCols; }
            set { _lgCols = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private void setValues()
        {
            
            _slidesCount = 0;
            if (_products != null)
            {
                int numberOfSlides = _products.Count / _numberOfProducts;
                List<List<Product>> slides = new List<List<Product>>();
                int count = 0;
                while (_products.Count > 0)
                {
                    if (count == 0)
                        slides.Add(new List<Product>());
                    slides[slides.Count - 1].Add(_products[0]);
                    _products.RemoveAt(0);
                    if (++count == _numberOfProducts)
                        count = 0;
                }

                rptSlides.DataSource = slides;
                rptSlides.DataBind();
            }
        }

        protected void rptSlides_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (_slidesCount++ == 0)
                {
                    HtmlControl divHeader = (HtmlControl)e.Item.FindControl("divHeader");
                    divHeader.Attributes["class"] = "item active";
                }
                Repeater rptProducts = (Repeater)e.Item.FindControl("rptProducts");
                rptProducts.DataSource = e.Item.DataItem;
                rptProducts.DataBind();
            }
        }

        private void setName()
        {
            lblName.Text = _name;
        }

        protected void rptProducts_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlControl colDiv = (HtmlControl)e.Item.FindControl("colDiv");
                colDiv.Attributes.Add("class", "col-lg-" + _lgCols + " col-md-3 col-sm-3 col-xs-6");

                if(e.Item.ItemIndex != (((List<Product>)((Repeater)e.Item.Parent).DataSource).Count - 1))
                {
                    //colDiv.Attributes.Add("class", colDiv.Attributes["class"] += " right-border");
                    
                }
                colDiv.Attributes.Add("class", colDiv.Attributes["class"] += " product-fp-col");
            }
        }
    }
}