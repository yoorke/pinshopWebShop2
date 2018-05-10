﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;

namespace WebShop2
{
    public partial class promotion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            if (!Page.IsPostBack)
            {
                if(Page.Request.QueryString.ToString().Contains("akcija"))
                {
                    string url = Page.Request.QueryString["akcija"].ToString();
                    loadPromotion(url);
                }
            }
        }

        private void loadPromotion(string url)
        {
            Promotion promotion = new PromotionBL().GetPromotion(url);
            rptProducts.DataSource = new ProductBL().GetProductsForPromotion(promotion.PromotionID);
            rptProducts.DataBind();
            lblPromotionName.Text = promotion.Name;
        }
    }
}