using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBL;
using System.Web.Security;

namespace WebShop2
{
    public partial class webShop : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                ((Label)loginView.FindControl("lblUsername")).Text = Membership.GetUser().UserName;
            if (!Page.IsPostBack)
            {
                Page.Header.DataBind();
            }
            loadFooter();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        private void loadFooter()
        {
            CustomPageBL customPageBL = new CustomPageBL();

            rptFt1.DataSource = customPageBL.GetCustomPagesForCustomPageCategory(1);
            rptFt1.DataBind();

            rptFt2.DataSource = customPageBL.GetCustomPagesForCustomPageCategory(2);
            rptFt2.DataBind();

            rptFt3.DataSource = customPageBL.GetCustomPagesForCustomPageCategory(3);
            rptFt3.DataBind();

            rptCategoriesFooter.DataSource = new CategoryBL().GetCategoriesForFooter();
            rptCategoriesFooter.DataBind();
        }
    }
}