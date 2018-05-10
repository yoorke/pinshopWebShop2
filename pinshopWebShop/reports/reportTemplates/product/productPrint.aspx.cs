using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;
using System.IO;
using System.Text.RegularExpressions;
using NReco.PdfGenerator;
using System.Configuration;

namespace WebShop2.reports.reportTemplates.product
{
    public partial class productPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                int productID = -1;
                if(int.TryParse(Page.RouteData.Values["productID"].ToString(), out productID))
                    printProduct(productID);
            }
        }

        private void printProduct(int productID)
        {
            string content = generateContent(loadProduct(productID), loadTemplate("content"));
            //kreira html

            var pdfCreator = new HtmlToPdfConverter();
            pdfCreator.Margins.Top = 24;
            pdfCreator.Margins.Bottom = 15;
            pdfCreator.Margins.Left = 10;
            pdfCreator.Margins.Right = 10;
            pdfCreator.Size = NReco.PdfGenerator.PageSize.A4;

            pdfCreator.PageHeaderHtml = getHeader();
            pdfCreator.PageFooterHtml = getFooter();

            var pdfBytes = pdfCreator.GeneratePdf(content);

            using (FileStream fs = new FileStream(Server.MapPath("~/pdf/product.pdf"), FileMode.Create, FileAccess.Write))
            {
                fs.Write(pdfBytes, 0, pdfBytes.Length);
                fs.Close();
            }

            Response.Redirect(ResolveUrl("~/pdf/product.pdf"));
        }

        private Product loadProduct(int productID)
        {
            return new ProductBL().GetProduct(productID, string.Empty, false, string.Empty);
        }

        private string loadTemplate(string type)
        {
            string template = string.Empty;
            switch(type)
            {
                case "content":
                    {
                        template = "product/productReportTemplate.html";break;   
                    }
                case "header":
                    {
                        template = "reportHeaderTemplate.html";break;
                    }
                case "footer":
                    {
                        template = "reportFooterTemplate.html";break;
                    }                    
            }
            using (TextReader tr = new StreamReader(Server.MapPath("~/reports/reportTemplates/" + template)))
            {
                return tr.ReadToEnd();
            }
        }

        private string generateContent(Product product, string template)
        {
            Regex regex;
            Dictionary<string, string> replaceTags = getReplaceTags(product);
            foreach(KeyValuePair<string, string> item in replaceTags)
            {
                regex = new Regex("\\[" + item.Key + "\\]");
                template = regex.Replace(template, item.Value);
            }

            return template;
        }

        private Dictionary<string, string> getReplaceTags(Product product)
        {
            Dictionary<string, string> replaceTags = new Dictionary<string, string>();
            replaceTags.Add("TITLE", product.Brand.Name + " " + product.Name);
            replaceTags.Add("PRINT-DATE", DateTime.Now.ToString("dd.MM.yyyy"));
            replaceTags.Add("PRODUCT-NAME-LINE-1", product.Brand.Name);
            replaceTags.Add("PRODUCT-NAME-LINE-2", product.Name);
            replaceTags.Add("AVAILABILITY", product.IsInStock ? "NA STANJU" : "NEMA NA STANJU");
            replaceTags.Add("PRODUCT-CODE", product.Code);
            replaceTags.Add("PRODUCT-PRICE", string.Format("{0:N2}", product.Price));
            replaceTags.Add("PRODUCT-WEB-PRICE", string.Format("{0:N2}", getWebPrice(product)));
            replaceTags.Add("SAVING", string.Format("{0:N2}", product.Price - getWebPrice(product)));
            replaceTags.Add("DESCRIPTION", product.Description);
            replaceTags.Add("SPECIFICATION", product.Specification);
            replaceTags.Add("CSS-PATH", Server.MapPath("~/reports/reportTemplates/report-style.css"));
            replaceTags.Add("IMAGE-SRC", getImageUrl(product));

            return replaceTags;
        }

        private double getWebPrice(Product product)
        {
            if (product.Promotion != null)
                return product.Promotion.Price;

            return product.WebPrice;
        }

        private string getImageUrl(Product product)
        {
            string filename = product.Images[0].ImageUrl.Substring(0, product.Images[0].ImageUrl.LastIndexOf('.'));
            string extension = product.Images[0].ImageUrl.Substring(product.Images[0].ImageUrl.LastIndexOf('.'));
            string mainName = ConfigurationManager.AppSettings["mainName"];

            return Server.MapPath("~/" + new ProductBL().CreateImageDirectory(int.Parse(filename)) + filename + "-" + mainName + extension);
        }

        private string getHeader()
        {
            return replaceTags(getHeaderTags(), loadTemplate("header"));
        }

        private string replaceTags(Dictionary<string, string> tags, string template)
        {
            Regex regex;
            foreach(KeyValuePair<string, string> item in tags)
            {
                regex = new Regex("\\[" + item.Key + "\\]");
                template = regex.Replace(template, item.Value);
            }

            return template;
        }

        private Dictionary<string, string> getHeaderTags()
        {
            Dictionary<string, string> tags = new Dictionary<string, string>();
            tags.Add("COMPANY-NAME", ConfigurationManager.AppSettings["companyName"]);
            tags.Add("COMPANY-LOGO", ConfigurationManager.AppSettings["logoUrl"]);
            tags.Add("PRINT-DATE", DateTime.Now.ToString("dd.MM.yyyy"));
            tags.Add("CSS-PATH", Server.MapPath("~/reports/reportTemplates/report-style.css"));
            tags.Add("COMPANY-URL", ConfigurationManager.AppSettings["webShopUrl"]);

            return tags;
        }

        private Dictionary<string, string> getFooterTags()
        {
            Dictionary<string, string> tags = new Dictionary<string, string>();
            tags.Add("COMPANY-NAME", ConfigurationManager.AppSettings["companyName"]);
            tags.Add("COMPANY-URL", ConfigurationManager.AppSettings["webShopUrl"]);
            tags.Add("CSS-PATH", Server.MapPath("~/reports/reportTemplates/report-style.css"));

            return tags;
        }

        private string getFooter()
        {
            return replaceTags(getFooterTags(), loadTemplate("footer"));
        }
    }
}