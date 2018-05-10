﻿using System;
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
    public partial class Cart : System.Web.UI.UserControl
    {
        public event EventHandler QuantityChanged;
        //private DataTable _cart;
        //private Coupon _coupon;

        /*public DataTable CartItems
        {
            get { return _cart; }
            set
            {
                _cart = value;
                setValues();
            }
        }*/

        /*public Coupon CartCoupon
        {
            set
            {
                _coupon = value;
            }
        }*/

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
                LoadCart();
            //btnDeleteCoupon.Visible = couponExists();
        }

        private void setValues()
        {
            
            
            
            
            //calculateTotal();
        }

        public void LoadCart()
        {
            CartBL cartBL = new CartBL();
            dgvCart.DataSource = cartBL.GetProducts(Session["cartID"].ToString());
            dgvCart.DataBind();
            ViewState.Add("discount", cartBL.GetCartDiscount(Session["cartID"].ToString()));
            calculateCart();
            if (dgvCart.Rows.Count == 0)
            {
                lblStatus.Text = "Nemate proizvoda u korpi";
                lblStatus.Visible = true;
            }
        }

        private bool couponExists()
        {
            if (ViewState["discount"] != null)
                if (int.Parse(ViewState["discount"].ToString()) > 0)
                    return true;
            return false;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            /*Checkout checkout = (Checkout)this.Parent.FindControl("Checkout1");
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                checkout.FindControl("divAccount").Visible = true;
            else
                checkout.FindControl("divLogin").Visible = true;*/

            if (dgvCart.Rows.Count > 0)
                Response.Redirect("/porucivanje");
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("/");
        }

        protected void dgvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ((Label)e.Row.FindControl("lblRowIndex")).Text = (e.Row.RowIndex + 1).ToString();

                if (((TextBox)((Panel)e.Row.FindControl("pnlQuantity")).FindControl("txtQuantity")).Text == "1")
                    ((LinkButton)e.Row.FindControl("btnRemoveQuantity")).Enabled = false;
                else ((LinkButton)e.Row.FindControl("btnRemoveQuantity")).Enabled = true;

                if (int.Parse(((Label)e.Row.FindControl("lblCouponID")).Text) > 1)
                { 
                    //((HtmlControl)e.Row.FindControl("divCoupon")).Style.Add("display", "block");
                    ((Label)e.Row.FindControl("lblUserPrice")).Attributes["class"] = "couponPrice";
                    ((Label)e.Row.FindControl("lblSum")).Attributes["class"] = "couponPrice";
                    ((Label)e.Row.FindControl("lblUserPrice")).ToolTip = "Cena na osnovu kupona";
                    ((Label)e.Row.FindControl("lblSum")).ToolTip = "Cena na osnovu kupona";
                }
                string imgUrl = ((Image)e.Row.FindControl("imgProduct")).ImageUrl;
                string filename = imgUrl.Substring(0, imgUrl.LastIndexOf('.'));
                string extension = imgUrl.Substring(imgUrl.LastIndexOf('.'));
                ((Image)e.Row.FindControl("imgProduct")).ImageUrl = new ProductBL().CreateImageDirectory(int.Parse(filename)) + filename + "-" + ConfigurationManager.AppSettings["listName"] + extension;
            }
        }

        protected void btnUpdateQuantity_Click(object sender, EventArgs e)
        {

        }

        protected void dgvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "UpdateQuantity":
                    {
                        GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                        int productID = int.Parse(((Label)row.Cells[0].FindControl("lblProductID")).Text);
                        double productPrice = double.Parse(((Label)row.Cells[0].FindControl("lblProductPrice")).Text);
                        double userPrice = double.Parse(((Label)row.Cells[0].FindControl("lblUserPrice")).Text);
                        int quantity;
                        if (!int.TryParse(((TextBox)row.Cells[0].FindControl("txtQuantity")).Text, out quantity))
                        {
                            Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('wrong')</SCRIPT>");
                            break;
                        }
                        else
                        {
                            CartBL cartBL = new CartBL();
                            cartBL.UpdateCartProduct(Session["cartID"].ToString(), productID, quantity, productPrice, userPrice, int.Parse(((Label)row.Cells[0].FindControl("lblCouponID")).Text));
                            calculateItem(row.RowIndex, userPrice * quantity);
                            calculateTotal();
                        }
                        break;
                    }
                case "AddQuantity":
                    {
                        GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                        int productID = int.Parse(((Label)row.Cells[0].FindControl("lblProductID")).Text);
                        double productPrice = double.Parse(((Label)row.Cells[0].FindControl("lblProductPrice")).Text);
                        double userPrice = double.Parse(((Label)row.Cells[0].FindControl("lblUserPrice")).Text);
                        int quantity = int.Parse(((TextBox)row.Cells[0].FindControl("txtQuantity")).Text) + 1;
                        (((TextBox)row.Cells[0].FindControl("txtQuantity")).Text) = quantity.ToString();

                        if (quantity > 1)
                            ((LinkButton)row.Cells[0].FindControl("btnRemoveQuantity")).Enabled = true;

                        new CartBL().UpdateCartProduct(Session["cartID"].ToString(), productID, quantity, productPrice, userPrice, int.Parse(((Label)row.Cells[0].FindControl("lblCouponID")).Text));
                        calculateItem(row.RowIndex, userPrice * quantity);
                        calculateTotal();

                        if(QuantityChanged != null)
                            QuantityChanged(this, null);
                    }
                    break;

                case "RemoveQuantity":
                    {
                        GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                        int productID = int.Parse(((Label)row.Cells[0].FindControl("lblProductID")).Text);
                        double productPrice = double.Parse(((Label)row.Cells[0].FindControl("lblProductPrice")).Text);
                        double userPrice = double.Parse(((Label)row.Cells[0].FindControl("lblUserPrice")).Text);
                        int quantity = int.Parse(((TextBox)row.Cells[0].FindControl("txtQuantity")).Text) - 1;
                        (((TextBox)row.Cells[0].FindControl("txtQuantity")).Text) = quantity.ToString();

                        if (quantity == 1)
                            ((LinkButton)row.Cells[0].FindControl("btnRemoveQuantity")).Enabled = false;

                        new CartBL().UpdateCartProduct(Session["cartID"].ToString(), productID, quantity, productPrice, userPrice, int.Parse(((Label)row.Cells[0].FindControl("lblCouponID")).Text));
                        calculateItem(row.RowIndex, userPrice * quantity);
                        calculateTotal();

                        if(QuantityChanged != null)
                            QuantityChanged(this, null);
                    }
                    break;
            }
        }

        

        private void calculateItem(int rowIndex, double total)
        {
            ((Label)dgvCart.Rows[rowIndex].FindControl("lblSum")).Text = string.Format("{0:N2}", total);
        }

        private void calculateTotal()
        {
            double total = 0;
            foreach (GridViewRow row in dgvCart.Rows)
            {
                total += double.Parse(((Label)row.FindControl("lblSum")).Text);
            }
            lblTotal.Text = string.Format("{0:N2}", total);
            lblOsnovica.Text = string.Format("{0:N2}", total / 1.2);
            lblTax.Text = string.Format("{0:N2}", total - double.Parse(lblOsnovica.Text));
        }

        protected void btnAddCoupon_Click(object sender, EventArgs e)
        {
            CouponBL couponBL = new CouponBL();
            //Coupon coupon = couponBL.GetCoupon(txtCoupon.Text);

            //if (coupon != null)
            {
                //ViewState["discount"] = coupon.Discount;
                //CartBL cartBL = new CartBL();
                //cartBL.SaveCartCoupon(Session["cartID"].ToString(), coupon.CouponID);
                //calculateCart();
                //btnDeleteCoupon.Visible = true;
            }
        }

        private void calculateCart()
        {
            double price;
            double discount = (ViewState["discount"] != null) ? double.Parse(ViewState["discount"].ToString()) : 0;
            CartBL cartBL = new CartBL();

            foreach (GridViewRow row in dgvCart.Rows)
            {
                //if (double.Parse(((Label)row.FindControl("lblProductPrice")).Text) == double.Parse(((Label)row.FindControl("lblUserPrice")).Text))
                //{
                    //price = double.Parse(((Label)row.FindControl("lblProductPrice")).Text);
                    //double discountPrice = price * (1 - ((double)discount) / 100);
                    double quantity = double.Parse(((TextBox)row.FindControl("txtQuantity")).Text);
                    //int productID = int.Parse(((Label)row.FindControl("lblProductID")).Text);
                    //((Label)row.FindControl("lblUserPrice")).Text = string.Format("{0:N2}", discountPrice);
                    ((Label)row.FindControl("lblSum")).Text = string.Format("{0:N2}", double.Parse(((Label)row.FindControl("lblUserPrice")).Text) * quantity);
                    //cartBL.UpdateCartProduct(Session["cartID"].ToString(), productID, quantity, price, discountPrice);
                //}
                
            }
            calculateTotal();
        }

        protected void dgvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (dgvCart.Rows.Count > 0)
            {
                CartBL cartBL = new CartBL();
                int status = cartBL.DeleteProductFromCart(int.Parse(dgvCart.DataKeys[e.RowIndex].Values[0].ToString()), Session["cartID"].ToString());
                //setValues();
                //Response.Redirect("/cart.aspx");
                LoadCart();
                //((CartFirstPage)Page.Master.FindControl("CartFirstPage1")).ProductsCount = dgvCart.Rows.Count;
                if (QuantityChanged != null)
                    QuantityChanged(this, null);
            }
        }

        protected void btnDeleteCoupon_Click(object sender, EventArgs e)
        {
            ViewState["discount"] = 0;
            calculateCart();
            CartBL cartBL = new CartBL();
            cartBL.SaveCartCoupon(Session["cartID"].ToString(), -1);
            //btnDeleteCoupon.Visible = false;
        }

        private void setStatus(string message, System.Drawing.Color color, bool visible)
        {
            //CustomStatus1.Text = message;
            //CustomStatus1.ForeColor = color;
            //CustomStatus1.Visible = visible;
        }
    }
}