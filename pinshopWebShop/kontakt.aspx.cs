using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopUtilities;

namespace WebShop2
{
    public partial class kontakt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            txtEmail.Focus();
            txtCaptchaCode.Text = string.Empty;
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                if(botDetect1.Validate(txtCaptchaCode.Text))
                { 
                    System.Web.Hosting.HostingEnvironment.QueueBackgroundWorkItem(bw =>
                    {
                        Common.SendMessage(txtEmail.Text, "Poruka sa sajta pinshop.rs - " + txtSubject.Text, "Poruka od: " + txtEmail.Text + "<br/><br/>" + txtMessage.Text);
                        //lblStatus.Text = "Vaša poruka je uspešno poslata.";
                        //lblStatus.Visible = true;
                        //lblStatus.CssClass = "alert alert-success text-center";
                    });
                    lblStatus.Text = "Vaša poruka je uspešno poslata";
                    lblStatus.Visible = true;
                    lblStatus.CssClass = "alert alert-success text-center";
                }
                else
                {
                    lblStatus.Text = "Kod sa slike nije dobar. Pokušajte ponovo.";
                    lblStatus.Visible = true;
                    lblStatus.CssClass = "alert alert-danger text-center";
                }
            }
            catch
            {
                lblStatus.Text = "Greška prilikom slanja";
                lblStatus.Visible = true;
                lblStatus.CssClass = "alert alert-danger text-center";
            }
        }
    }
}