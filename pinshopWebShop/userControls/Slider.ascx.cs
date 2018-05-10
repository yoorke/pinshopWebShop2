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
using eshopBL;
using eshopBE;

namespace WebShop2.UserControls
{
    public partial class Slider : System.Web.UI.UserControl
    {
        private int _sliderID;

        public int SliderID
        {
            get { return _sliderID; }
            set { _sliderID = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                loadSlider();
        }

        public void loadSlider()
        {
            rptSlider.DataSource = new SliderBL().GetSliderItems(_sliderID);
            rptSlider.DataBind();
        }
    }
}