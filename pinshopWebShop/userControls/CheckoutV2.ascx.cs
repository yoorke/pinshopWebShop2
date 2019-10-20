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
using eshopBE;
using eshopBL;
using eshopUtilities;
using System.Collections.Generic;

namespace WebShop2.UserControls
{
    public partial class CheckoutV2 : System.Web.UI.UserControl
    {
        public event EventHandler CouponApplied;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (!Page.IsPostBack)
                {
                    loadUser();
                    loadIntoForm();
                }


                if (HttpContext.Current.User.Identity.IsAuthenticated)
                    pnlLogin.Visible = false;
                else
                    pnlLogin.Visible = true;
            }
            if (!Page.IsPostBack)
                loadIntoForm();
            LoadCart();
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            try
            {
                int userID=1;
                if (chkCreateAccount.Checked && !(new UserBL().UserExists(txtEmail.Text)))
                {
                    User user = createUser();
                    userID = user.UserID;
                    if (userID > 0) { 
                        FormsAuthentication.SetAuthCookie(txtEmail.Text, true);
                        //System.Web.Hosting.HostingEnvironment.QueueBackgroundWorkItem(bw =>
                        //{
                            //Common.SendUserCreatedConfirmationMail(txtEmail.Text, user.Password);
                        //});
                    }
                }
                else if (Membership.GetUser() != null)
                    userID = int.Parse(Membership.GetUser().ProviderUserKey.ToString());
                else userID = 42;
                Order order = createOrder(userID);
                Session.Add("orderTotal", lblTotal.Text);

                try
                {
                    System.Web.Hosting.HostingEnvironment.QueueBackgroundWorkItem(bw =>
                    {
                        Settings settings = new SettingsBL().GetSettings();
                        Common.SendOrderConfirmationMail(txtEmail.Text, txtFirstname.Text + " " + txtLastname.Text, order, settings);
                        Common.SendNewOrderNotification(order.OrderID.ToString(), order, settings);
                    });
                }
                catch
                {

                }
                new CartBL().ClearItems(Session["cartID"].ToString());
                new CartBL().RemoveCoupon(Session["cartID"].ToString());
                //Server.Transfer("/orderSuccessful.aspx");
                Page.Response.Redirect("/porudzbina-uspesna");
            }
            catch (BLException ex)
            {
                setStatus(ex.Message, System.Drawing.Color.Red, true, "danger");
                //Page.MaintainScrollPositionOnPostBack = false;
                //Page.SetFocus(csStatus);
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "hash", "alert('12312312')", true);
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "setFocus", "location.hash = " + csStatus.GetClientID, true);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "setFocus", "scrollToErrorDiv()", true);
                //Page.RegisterClientScriptBlock("hash", "location.hash = " + csStatus.GetClientID);
            }
        }

        private List<OrderItem> getItems()
        {
            CartBL cartBL = new CartBL();
            DataTable cartItems = cartBL.GetProducts(Session["cartID"].ToString());

            List<OrderItem> items = new List<OrderItem>();
            for (int i = 0; i < cartItems.Rows.Count; i++)
            {
                items.Add(new OrderItem(-1, -1,  new ProductBL().GetProduct(int.Parse(cartItems.Rows[i]["productID"].ToString()), string.Empty, false, string.Empty), double.Parse(cartItems.Rows[i]["productPrice"].ToString()), double.Parse(cartItems.Rows[i]["userPrice"].ToString()), double.Parse(cartItems.Rows[i]["quantity"].ToString())));
            }
            return items;
        }

        private Order createOrder(int userID)
        {
            Order order = new Order();
            order.Date = DateTime.Now.ToUniversalTime();
            order.Firstname = txtFirstname.Text;
            order.Lastname = txtLastname.Text;
            order.Address = txtAddress.Text;
            order.City = txtCity.Text;
            order.Phone = txtPhone.Text;
            order.Email = txtEmail.Text;
            order.Items = getItems();
            order.User = new User(userID, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, null, string.Empty, string.Empty, DateTime.Now, string.Empty, 0, 1);
            order.Name = (rdbUserType.SelectedValue == "2") ? txtCompanyName.Text : string.Empty;
            order.Pib = (rdbUserType.SelectedValue == "2") ? txtPib.Text : string.Empty;
            //order.Payment = (order.Name != string.Empty) ? new Payment(int.Parse(rdbPaymentCompany.SelectedValue), rdbPaymentCompany.SelectedItem.Text) : new Payment(int.Parse(rdbPayment.SelectedValue.ToString()), rdbPayment.SelectedItem.Text);
            order.Payment = new Payment(int.Parse(rdbPayment.SelectedValue), rdbPayment.SelectedItem.Text);
            order.Delivery = new Delivery(int.Parse(rdbDelivery.SelectedValue.ToString()), rdbDelivery.SelectedItem.Text);
            CartBL cartBL = new CartBL();
            order.Coupon = new Coupon(cartBL.GetCartCoupon(Session["cartID"].ToString()), string.Empty, 0, string.Empty, DateTime.Now, DateTime.Now, null, null);
            order.OrderStatus = new OrderStatus(1, string.Empty);
            order.Zip = txtZip.Text;
            order.Comment = txtRemark.Text;
            order.CartID = Session["cartID"].ToString();


            OrderBL orderBL = new OrderBL();
            orderBL.SaveOrder(order);
            return order;
        }

        private User createUser()
        {
            return UserBL.SaveUser(txtFirstname.Text, txtLastname.Text, txtEmail.Text, string.Empty, txtEmail.Text, txtAddress.Text, txtCity.Text, txtPhone.Text, "kupac", txtZip.Text);
        }

        private void loadUser()
        {
            User user = UserBL.GetUser(-1, HttpContext.Current.User.Identity.Name);

            txtFirstname.Text = user.FirstName;
            txtLastname.Text = user.LastName;
            txtEmail.Text = user.Email;
            txtAddress.Text = user.Address;
            txtCity.Text = user.City;
            txtPhone.Text = user.Phone;
            txtZip.Text = user.Zip;

            chkCreateAccount.Checked = false;
            chkCreateAccount.Enabled = false;
        }

        private void setStatus(string text, System.Drawing.Color color, bool visible, string classes)
        {
            csStatus.Text = text;
            csStatus.ForeColor = color;
            csStatus.Visible = visible;
            csStatus.Class = classes;
            csStatus.Show();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(Page.ResolveUrl("~/korpa"));
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(txtUsername.Text, txtPassword.Text))
            {
                FormsAuthentication.SetAuthCookie(txtUsername.Text, true);
                Response.Redirect("/checkout.aspx");
            }
            else
                setStatus("Prijava nije uspešna", System.Drawing.Color.Red, true, "alert-danger");
        }

        public void LoadCart()
        {
            DataTable cart = new CartBL().GetProducts(Session["cartID"].ToString());

            double cartTotal = 0;
            double taxBase = 0;
            double tax = 0;
            double discount = 0;
            double delivery = 0;
            double total = 0;
            double saving = 0;
            int couponID = 1;

            for(int i=0;i<cart.Rows.Count;i++)
            {
                cartTotal += double.Parse(cart.Rows[i]["productPrice"].ToString()) * double.Parse(cart.Rows[i]["quantity"].ToString());
                discount += double.Parse(cart.Rows[i]["userPrice"].ToString()) * double.Parse(cart.Rows[i]["quantity"].ToString());
                if (int.Parse(cart.Rows[i]["couponID"].ToString()) > 1)
                { 
                    couponID = int.Parse(cart.Rows[i]["couponID"].ToString());
                    
                }
            }

            if (couponID > 1)
                lblRemoveCoupon.Visible = true;
            else lblRemoveCoupon.Visible = false;

            lblProductCount.Text = cart.Rows.Count.ToString();
            taxBase = discount / 1.2;
            tax = discount - taxBase;

            //delivery = rdbDelivery.SelectedValue != "2" ? 
            //((cartTotal > double.Parse(ConfigurationManager.AppSettings["freeDeliveryTotalValue"])) ? 
            //0 : double.Parse(ConfigurationManager.AppSettings["deliveryCost"])) : 0;

            //delivery = rdbDelivery.SelectedValue != "2" ?
            //((cartTotal > new SettingsHandler().GetSettings().FreeDeliveryTotalValue) ?
            //0 : new SettingsHandler().GetSettings().DeliveryCost) : 0;

            Settings settings = new SettingsBL().GetSettings();
            delivery = rdbDelivery.SelectedValue != "2" ?
                ((cartTotal > settings.FreeDeliveryTotalValue) ?
                    0 : settings.DeliveryCost) : 0;

            total = discount + delivery;
            saving = cartTotal - discount;

            Coupon coupon = new CouponBL().GetCoupon(couponID);
            if (coupon != null)
                lblCoupon.Text = coupon.Code;
            else lblCoupon.Text = string.Empty;

            lblCartValue.Text = string.Format("{0:N2}", cartTotal);
            lblDeliveryPrice.Text = string.Format("{0:N2}", delivery);
            lblTotal.Text = string.Format("{0:N2}", total);
            lblDiscount.Text = string.Format("{0:N2}", saving);
        }

        protected void rdbDelivery_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCart();
            if (rdbDelivery.SelectedValue == "2")
            {
                showDeliveryInfo.Attributes.Add("style", "display:none");
                showShop.Attributes.Add("style", "display:block");
            }
            else
            {
                showDeliveryInfo.Attributes.Add("style", "display:block");
                showShop.Attributes.Add("style", "display:none");
            }

            loadPaymentItems(int.Parse(rdbUserType.SelectedValue), int.Parse(rdbDelivery.SelectedValue));
        }

        protected void btnCoupon_Click(object sender, EventArgs e)
        {
            if(txtCoupon.Text != null)
            {
                Coupon coupon = new CouponBL().GetCoupon(txtCoupon.Text);
                if(coupon != null)
                {
                    new CartBL().SaveCartCoupon(Session["cartID"].ToString(), coupon.CouponID);
                    new CartBL().ApplyCoupon(Session["cartID"].ToString());
                    LoadCart();
                    if (CouponApplied != null)
                        CouponApplied(this, null);
                    //Response.Redirect("/porucivanje");
                    lblRemoveCoupon.Visible = true;
                    
                }
            }
        }

        protected void lblRemoveCoupon_Click(object sender, EventArgs e)
        {
            new CartBL().RemoveCoupon(Session["cartID"].ToString());
            LoadCart();
            if (CouponApplied != null)
                CouponApplied(this, null);
        }

        private void loadIntoForm()
        {
            loadPaymentItems(1, 1);
        }

        private void loadPaymentItems(int userType, int deliveryType)
        {
            rdbPayment.Items.Clear();

            if(userType == 1) //private
            {
                if(deliveryType == 1) //dostava
                { 
                    rdbPayment.Items.Add(new ListItem("Gotovina pri preuzimanju", "1", true));
                    rdbPayment.Items.Add(new ListItem("Uplatnica", "3"));
                }
                else if(deliveryType == 2) //licno
                {
                    rdbPayment.Items.Add(new ListItem("Gotovina", "1", true));
                    rdbPayment.Items.Add(new ListItem("Ček", "2", true));
                    rdbPayment.Items.Add(new ListItem("Kartica", "5", true));
                    rdbPayment.Items.Add(new ListItem("Uplatnica", "3", true));
                }
            }
            else if(userType == 2) //company
            {
                if(deliveryType == 1)
                {
                    rdbPayment.Items.Add(new ListItem("Gotovina pri preuzimanju", "1", true));
                    rdbPayment.Items.Add(new ListItem("Virmansko plaćanje po predračunu", "4", true));
                }
                else if(deliveryType == 2)
                {
                    rdbPayment.Items.Add(new ListItem("Gotovina", "1", true));
                    rdbPayment.Items.Add(new ListItem("Kartica", "5", true));
                    rdbPayment.Items.Add(new ListItem("Virmansko plaćanje po predračunu", "4", true));
                }
            }
            rdbPayment.Items[0].Selected = true;
        }

        protected void rdbUserType_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadPaymentItems(int.Parse(rdbUserType.SelectedValue), int.Parse(rdbDelivery.SelectedValue));
            if (rdbUserType.SelectedValue == "1")
            { 
                divCompany.Style.Add("display", "none");
                txtCompanyName.Text = "fizičko lice";
                txtPib.Text = "000000000";
            }
            else
            { 
                divCompany.Style.Add("display", "block");
                txtCompanyName.Text = string.Empty;
                txtPib.Text = string.Empty;
            }
        }
    }
}