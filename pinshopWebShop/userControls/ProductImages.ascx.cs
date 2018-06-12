using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopBE;
using System.Configuration;
using System.IO;
using System.Drawing;

namespace WebShop2.UserControls
{
    public partial class ProductImages : System.Web.UI.UserControl
    {
        private List<ProductImage> _images;

        public List<ProductImage> Images {
            get { return _images; }
            set { _images = value; }
        }

        public string GetMainImageUrl
        {
            get { return lnkMainImage.NavigateUrl; }
        }

        public int GetMainImageWidth
        {
            get
            {
                try
                {
                    string imagePath = getDirectory(getFilename(_images[0].ImageUrl)) + getFilename(_images[0].ImageUrl) + getExtension(_images[0].ImageUrl);
                    Bitmap image = new Bitmap(Server.MapPath("~/" + (File.Exists(Server.MapPath(imagePath)) ? imagePath : "/images/no-image.jpg")));
                    return image.Width;
                }
                catch
                {
                    return 0;
                }
            }
        }

        public int GetMainImageHeight
        {
            get
            {
                try
                {
                    string imagePath = getDirectory(getFilename(_images[0].ImageUrl)) + getFilename(_images[0].ImageUrl) + getExtension(_images[0].ImageUrl);
                Bitmap image = new Bitmap(Server.MapPath("~/" + (File.Exists(Server.MapPath(imagePath)) ? imagePath : "/images/no-image.jpg")));
                return image.Height;
                }
                catch
                {
                    return 0;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rptThumbImages_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HyperLink imageLink = ((HyperLink)e.Item.FindControl("lnkThumbImage"));
                imageLink.NavigateUrl = getDirectory(getFilename(imageLink.NavigateUrl)) + getFilename(imageLink.NavigateUrl) + getExtension(imageLink.NavigateUrl);
                imageLink.Attributes["data-lightbox"] = "main-image";
            }
        }

        public void ShowImages()
        {
            if (_images != null)
            {
                string imagePath = getDirectory(getFilename(_images[0].ImageUrl)) + getFilename(_images[0].ImageUrl) + "-" + ConfigurationManager.AppSettings["mainName"] + getExtension(_images[0].ImageUrl);
                imgMain.ImageUrl = File.Exists(Server.MapPath(imagePath)) ? imagePath : "/images/no-image.jpg";
                lnkMainImage.NavigateUrl = File.Exists(Server.MapPath(getDirectory(getFilename(_images[0].ImageUrl)) + getFilename(_images[0].ImageUrl) + getExtension(_images[0].ImageUrl))) ? getDirectory(getFilename(_images[0].ImageUrl)) + getFilename(_images[0].ImageUrl) + getExtension(_images[0].ImageUrl) : "/images/no-image.jpg";
                pnlThumbs.Controls.Clear();
                if (_images.Count > 1)
                {
                    for (int i = 0; i < _images.Count; i++)
                    {
                        ImageButton image = new ImageButton();
                        image.ID = "imgThumb" + i.ToString();
                        string thumbImagePath = getDirectory(getFilename(_images[i].ImageUrl)) + getFilename(_images[i].ImageUrl) + "-" + ConfigurationManager.AppSettings["thumbName"] + getExtension(_images[i].ImageUrl);
                        image.ImageUrl = File.Exists(Server.MapPath(thumbImagePath)) ? thumbImagePath : "/images/no-image.jpg";
                        image.CssClass = "thumb img-responsive";
                        image.OnClientClick = "ChangeImage(this.src);return false;";

                        pnlThumbs.Controls.Add(new LiteralControl("<div class='col-md-3'>"));
                        pnlThumbs.Controls.Add(image);
                        pnlThumbs.Controls.Add(new LiteralControl("</div>"));
                    }
                }
                setImagesForLightBox();
            }
            else
                imgMain.ImageUrl = Server.MapPath("~/images/no-image.jpg");
        }

        private string getFilename(string imageUrl)
        {
            return imageUrl.Substring(0, imageUrl.LastIndexOf('.'));
        }

        private string getExtension(string imageUrl)
        {
            return imageUrl.Substring(imageUrl.LastIndexOf('.'));
        }

        private string getDirectory(string filename)
        {
            return new ProductBL().CreateImageDirectory(int.Parse(filename));
        }

        private void setImagesForLightBox()
        {
            List<ProductImage> tempImages = new List<ProductImage>(_images);
            tempImages.RemoveAt(0);
            rptThumbImages.DataSource = tempImages;
            rptThumbImages.DataBind();
        }
    }
}