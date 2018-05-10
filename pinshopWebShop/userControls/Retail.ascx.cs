using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;

namespace WebShop2.UserControls
{
    public partial class Retail : System.Web.UI.UserControl
    {
        private eshopBE.Retail _retail;

        public eshopBE.Retail RetailItem
        {
            get { return _retail; }
            set { _retail = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //showRetail();
        }

        public void ShowRetail()
        {
            if(_retail != null)
            {
                lblName.Text = _retail.Name;
                lblAddress.Text = _retail.Address + ", " + _retail.City.Name;
                lblPhone.Text = _retail.Phone;
                lblMobilePhone.Text = _retail.MobilePhone;
            }

        }


    }
}