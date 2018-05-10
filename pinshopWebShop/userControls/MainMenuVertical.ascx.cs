using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using eshopBE;
using System.Web.UI.HtmlControls;

namespace WebShop2.UserControls
{
    public partial class MainMenuVertical : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rptMainMenu.DataSource = new CategoryBL().GetNestedCategoriesList();
            rptMainMenu.DataBind();
        }

        protected void rptMainMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (((Category)e.Item.DataItem).SubCategory != null && ((Category)e.Item.DataItem).SubCategory.Count > 0)
                {
                    ((HtmlControl)e.Item.FindControl("li")).Attributes["class"] = "has-children";
                }
            }
        }

        protected void rptSubMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //((CategoryBanner)e.Item.FindControl("categoryBanner1")).CategoryBannerID = (int)((Category)e.Item.DataItem).ParentCategoryID;
                if (((Category)e.Item.DataItem).SubCategory != null && ((Category)e.Item.DataItem).SubCategory.Count > 0)
                {
                    ((HtmlControl)e.Item.FindControl("secondLi")).Attributes["class"] = "has-children";
                    
                }

                string imageUrlSource = ((HiddenField)e.Item.FindControl("lblImageUrlSource")).Value;
                string imageUrl = ((Image)e.Item.FindControl("imgCategory")).ImageUrl;
                int imageUrlPositionX = int.Parse(((HiddenField)e.Item.FindControl("lblImageUrlPositionX")).Value);
                int imageUrlPositionY = int.Parse(((HiddenField)e.Item.FindControl("lblImageUrlPositionY")).Value);

                if(imageUrlSource.Equals("1"))
                {
                    string style = "background:url('" + imageUrl + "') " + imageUrlPositionX.ToString() + "px " + imageUrlPositionY.ToString() + "px";
                    ((HtmlControl)e.Item.FindControl("imgSprite")).Attributes.Add("style", style);
                }
            }
        }
    }
}