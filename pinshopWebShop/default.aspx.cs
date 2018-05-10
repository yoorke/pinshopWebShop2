using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using WebShop2.UserControls;

namespace WebShop2
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                loadPromotions();
                loadCategories();
            }
            insertFacebookTags();
        }

        private void loadPromotions()
        {
            rptPromotions.DataSource = new PromotionBL().GetPromotions(false, true, false);
            rptPromotions.DataBind();
        }

        private void loadCategories()
        {
            rptCategories.DataSource = new CategoryBL().GetCategoriesForFirstPage();
            rptCategories.DataBind();
        }

        protected void rptPromotions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ProductSlider slider = (ProductSlider)e.Item.FindControl("psPromotion");
                slider.NumberOfProducts = 4;
                slider.LgCols = 3;
                slider.Products = new ProductBL().GetProductsForPromotion(int.Parse(((HiddenField)e.Item.FindControl("lblPromotionID")).Value));
                ((Literal)slider.FindControl("lblPrev")).Text = @"<a id=""prev" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @""" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @" data-slide=""prev""><span class='fa fa-fw fa-chevron-circle-left direction-icon'></span></a>";
                ((Literal)slider.FindControl("lblNext")).Text = @"<a id=""next" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @""" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @" data-slide=""next""><span class='fa fa-fw fa-chevron-circle-right direction-icon'></span></a>";
                ((Literal)slider.FindControl("lblCarousel")).Text = @"<div id=" + "carousel" + ((HiddenField)e.Item.FindControl("lblPromotionID")).Value + @" class=""carousel slide"" data-ride="""">";
                ((Literal)slider.FindControl("lblCarouselClose")).Text = "</div>";
            }
        }

        protected void rptCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ProductSlider slider = (ProductSlider)e.Item.FindControl("psCategory");
                slider.NumberOfProducts = 4;
                slider.LgCols = 3;
                slider.Products = new ProductBL().GetProductsForFirstPage(int.Parse(((HiddenField)e.Item.FindControl("lblCategoryID")).Value), -1, int.Parse(((HiddenField)e.Item.FindControl("lblNumberOfProducts")).Value), ((HiddenField)e.Item.FindControl("lblFirstPageOrderBy")).Value);
                ((Literal)slider.FindControl("lblPrev")).Text = @"<a id=""prev" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @""" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @" data-slide=""prev""><span class='fa fa-fw fa-chevron-circle-left direction-icon'></span></a>";
                ((Literal)slider.FindControl("lblNext")).Text = @"<a id=""next" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @""" href=" + "#carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @" data-slide=""next""><span class='fa fa-fw fa-chevron-circle-right direction-icon'></span></a>";
                ((Literal)slider.FindControl("lblCarousel")).Text = @"<div id=" + "carousel" + ((HiddenField)e.Item.FindControl("lblCategoryID")).Value + @" class=""carousel slide"" data-ride="""">";
                ((Literal)slider.FindControl("lblCarouselClose")).Text = "</div>";
            }
        }

        private void insertFacebookTags()
        {

        }
    }
}