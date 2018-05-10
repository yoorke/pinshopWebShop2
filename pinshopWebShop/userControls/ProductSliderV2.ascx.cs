using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopBE;

namespace WebShop2.UserControls
{
    public partial class ProductSliderV2 : System.Web.UI.UserControl
    {
        private List<Product> _products;

        public List<Product> Products
        {
            set { _products = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
                //LoadSlider();
        }

        public void LoadSlider()
        {
            rptProductSlider.DataSource = _products;
            rptProductSlider.DataBind();
        }
    }
}