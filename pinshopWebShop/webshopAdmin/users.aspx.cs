﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using eshopBL;

namespace webshopAdmin
{
    public partial class users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated && User.IsInRole("administrator"))
            {
                if (!Page.IsPostBack)
                {
                    loadUsers();
                }
            }
            else
                Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/login.aspx?returnUrl=" + Page.Request.RawUrl);
        }

        private void loadUsers()
        {
            dgvUsers.DataSource = UserBL.GetUsers();
            dgvUsers.DataBind();
        }
        
        protected void dgvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            UserBL.DeleteUser(int.Parse(dgvUsers.DataKeys[e.RowIndex].Values[0].ToString()));
            loadUsers();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/createUser.aspx");
        }

        protected void dgvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((Label)e.Row.FindControl("lblUsername")).Text.StartsWith("admin"))
                    ((ImageButton)e.Row.Cells[5].Controls[0]).Visible = false;
            }
        }
    }
}
