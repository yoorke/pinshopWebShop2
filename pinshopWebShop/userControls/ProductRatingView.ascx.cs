using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebShop2.userControls
{
    public partial class ProductRatingView : System.Web.UI.UserControl
    {
        private double _ratingValue;

        public double RatingValue
        {
            get { return _ratingValue; }
            set { _ratingValue = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                showRating();
        }

        private void showRating()
        {
            for(int i = 1; i <= 5; i++)
            { 
                HtmlGenericControl ratingStar = new HtmlGenericControl("span");
                ratingStar.Attributes["class"] = "fa fa-fw fa-star" +((_ratingValue >= i) ? string.Empty : "-o");
                //ratingStar.Attributes["class"] = ((_ratingValue >= i) ? "fas" : "far") + " fa-fw fa-star";

                ratingDiv.Controls.Add(ratingStar);
            }
        }
    }
}