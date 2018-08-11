using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eshopBE;
using eshopBL;
using System.Collections.Generic;
using System.Configuration;
using eshopUtilities;
using System.IO;

namespace WebShop2
{
    public partial class products : System.Web.UI.Page
    {
        private int currentPage;
        //{
        //get
        //{
        //if (ViewState["currentPage"] != null)
        //return int.Parse(ViewState["currentPage"].ToString());
        //else return 0;
        //}
        //set { ViewState["currentPage"] = value; }
        //}

        private int pageSize;
        //{
        //get
        //{
        //if (ViewState["pageSize"] == null)
        //return 16;
        //else
        //return int.Parse(ViewState["pageSize"].ToString());
        //}
        //set { ViewState["pageSize"] = value; }
        //}

        private string sort;
        //{
        //get
        //{
        //if (ViewState["sort"] != null)
        //return ViewState["sort"].ToString();
        //else
        //return "priceAsc";
        //}
        //set { ViewState["sort"] = value; }
        //}

        string categoryUrl = string.Empty;
        int totalPages;

        protected void Page_Load(object sender, EventArgs e)
        {
            Master.FindControl("mainMenuVertical").Visible = true;
            if (!Page.IsPostBack)
            {
                Category category = null;
                categoryUrl = string.Empty;
                string brands = string.Empty;
                string priceFrom = string.Empty;
                string priceTo = string.Empty;
                string attributes = string.Empty;
                string pageSize = string.Empty;
                string pageIndex = string.Empty;
                string sort = string.Empty;

                if (Page.Request.QueryString.ToString().Contains("category"))
                    categoryUrl = Page.Request.QueryString["category"];
                if (Page.Request.QueryString.ToString().Contains("brands"))
                    brands = Page.Request.QueryString["brands"];
                if (Page.Request.QueryString.ToString().Contains("priceFrom"))
                    priceFrom = Page.Request.QueryString["priceFrom"];
                if (Page.Request.QueryString.ToString().Contains("priceTo"))
                    priceTo = Page.Request.QueryString["priceTo"];
                if (Page.Request.QueryString.ToString().Contains("attributes"))
                    attributes = Page.Request.QueryString["attributes"];
                if (Page.Request.QueryString.ToString().Contains("pageSize"))
                    pageSize = Page.Request.QueryString["pageSize"];
                if (Page.Request.QueryString.ToString().Contains("pageIndex"))
                    pageIndex = Page.Request.QueryString["pageIndex"];
                if (Page.Request.QueryString.ToString().Contains("sort"))
                    sort = Page.Request.QueryString["sort"];

                if (Page.RouteData.Values["category"] != null)
                    categoryUrl = Page.RouteData.Values["category"].ToString();

                if (categoryUrl.EndsWith("/"))
                    categoryUrl = categoryUrl.Substring(0, categoryUrl.Length - 1);
                if ((category = new CategoryBL().GetCategoryByUrl(categoryUrl)) == null) {
                    //ErrorLog.LogError(new Exception("Category url:" + categoryUrl), Request.RawUrl, Request.UserHostAddress, Request.Url.ToString());
                    redirect(Request.RawUrl);
                    ErrorLog.LogError(new Exception("Category url:" + categoryUrl), Request.RawUrl, Request.UserHostAddress, Request.Url.ToString());
                    Server.Transfer("/not-found.aspx");
                }

                string[] brandIDs = brands != string.Empty ? brands.Split(',') : new string[] {};
                string[] attributeIDs = attributes != string.Empty ? attributes.Split(',') : new string[] { };

                if (pageSize != string.Empty)
                {
                    this.pageSize = int.Parse(pageSize);
                    cmbPageSize.SelectedValue = this.pageSize.ToString();
                }
                else
                    this.pageSize = 16;

                if (pageIndex != string.Empty)
                {
                    this.currentPage = int.Parse(pageIndex);
                }
                else
                    this.currentPage = 0;

                pgrPager.currentPage = this.currentPage;

                if (sort != string.Empty)
                    this.sort = sort;
                else
                    sort = "priceAsc";

                this.sort = sort;

                //category = new CategoryBL().GetCategoryByUrl(categoryUrl);
                //ViewState.Add("category", categoryUrl);
                loadIntoForm();
                loadBrands(categoryUrl, brandIDs, category.ShowProductsFromSubCategories);
                loadFilter(categoryUrl, attributeIDs);
                loadPrices(categoryUrl, priceFrom, priceTo, category.ShowProductsFromSubCategories);

                
                //ViewState["pageTitle"] = category.Name + " | Pin Servis doo";
                //ViewState["categoryUrl"] = category.Url;

                if (category.Slider != null && category.Slider.SliderID > 0)
                {
                    slider.SliderID = category.Slider.SliderID;
                    slider.Visible = true;
                    slider.loadSlider();
                }
                else
                { 
                    slider.Visible = false;
                    //productSlider.Visible = true;
                    //productSlider.Products = new ProductBL().GetProductsForFirstPage(category.CategoryID, -1, 4, "Slučajni");
                    //productSlider.LoadSlider();
                }


                lblCategoryDescription.Text = category.Description;

                int subCategoriesCount = showSubCategories(category.CategoryID);

                if(subCategoriesCount == 0 || category.ShowProductsFromSubCategories)
                    createQueryString();

                Page.Title = category.Name + " | " + "Pin Servis str";
            }
            //Page.Title = ViewState["pageTitle"].ToString();

            //canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + "/proizvodi/" + ViewState["categoryUrl"].ToString() + @"""/>";
            canonicalUrl.Text = @"<link rel=""canonical"" href=""" + ConfigurationManager.AppSettings["webShopUrl"] + "/proizvodi/" + categoryUrl + @"""/>";

            filterBrandsDiv.Visible = bool.Parse(ConfigurationManager.AppSettings["filterBrandsVisible"]);
        }

        private void loadIntoForm()
        {
            cmbPageSize.Items.Add("16");
            cmbPageSize.Items.Add("32");
            cmbPageSize.Items.Add("96");
            cmbPageSize.SelectedValue = this.pageSize.ToString();

            cmbSort.Items.Add(new ListItem("Nazivu", "name"));
            cmbSort.Items.Add(new ListItem("Ceni opadajuće", "priceDesc"));
            cmbSort.Items.Add(new ListItem("Ceni rastuće", "priceAsc"));
            //cmbSort.Items.Add(new ListItem("Opisu", "sortIndex"));
            cmbSort.SelectedValue = this.sort;
        }

        private void loadBrands(string categoryUrl, string[] brandIDs, bool showSubCategoryBrands)
        {
            chkBrands.DataSource = new BrandBL().GetBrands(categoryUrl, showSubCategoryBrands);
            chkBrands.DataTextField = "name";
            chkBrands.DataValueField = "brandID";
            chkBrands.DataBind();

            if (chkBrands.DataSource == null)
                brandLabel.Visible = false;

            foreach (ListItem li in chkBrands.Items)
            {
                li.Attributes.Add("data-attribute-value", li.Value);
                foreach (string brandID in brandIDs)
                    if (int.Parse(brandID) == int.Parse(li.Value))
                        li.Selected = true;
                    else if(false)
                        li.Attributes.Add("style", "display:none");
                        
            }
        }

        private void loadFilter(string categoryUrl, string[] attributeIDs)
        {
            rptFilter.DataSource = new AttributeBL().GetAttributeListForFilter(categoryUrl);
            rptFilter.DataBind();

            foreach (RepeaterItem repeaterItem in rptFilter.Items)
            {
                foreach(Control control in repeaterItem.Controls)
                    if (control is CheckBoxList)
                    {
                        foreach (ListItem li in ((CheckBoxList)control).Items)
                        {
                            li.Attributes.Add("data-attribute-value", li.Value);
                            foreach (string attributeID in attributeIDs)
                                if (int.Parse(attributeID) == int.Parse(li.Value))
                                    li.Selected = true;
                        }
                    }
            }
        }

        private void loadPrices(string categoryUrl, string priceFrom, string priceTo, bool includeChildrenCategories)
        {
            cmbPriceFrom.Items.Add("0,00");
            //cmbPriceTo.Items.Add("-");

            double[] prices = new ProductBL().GetMinMaxPrice(categoryUrl, includeChildrenCategories);
            
            int priceSpan = (prices[1] - prices[0]) < 10000 ? 1000 : (prices[1] - prices[0] < 100000 ? 10000 : (prices[1] - prices[0] < 500000 ? 30000 : 50000));
            for (int i = priceSpan; i <= (int)prices[1]; i += priceSpan)
            {
                cmbPriceFrom.Items.Add(string.Format("{0:N2}", i));
                cmbPriceTo.Items.Add(string.Format("{0:N2}", i));
            }
            cmbPriceTo.Items.Add(string.Format("{0:N2}", prices[1]));
            if (priceFrom != string.Empty)
                cmbPriceFrom.SelectedValue = priceFrom;
            if (priceTo != string.Empty)
                cmbPriceTo.SelectedValue = priceTo;
            else
                cmbPriceTo.SelectedValue = cmbPriceTo.Items[cmbPriceTo.Items.Count - 1].Value;
        }

        protected void chkBrands_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void chkCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbPriceFrom_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbPriceTo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void chkValues_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cmbPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbPageSize.SelectedIndex > -1)
            {
                pageSize = int.Parse(cmbPageSize.SelectedValue);
                createQueryString();
            }
        }

        protected void cmbSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbSort.SelectedIndex > -1)
            {
                sort = cmbSort.SelectedItem.Text;
                createQueryString();
            }
        }

        protected void pgrPager_OnClick()
        {

        }

        protected void pgrPages_Click(int currentPage)
        {
            this.currentPage = currentPage;
            createQueryString();
        }

        private void createQueryString()
        {
            List<string> brands = new List<string>();
            List<AttributeValue> attributes = new System.Collections.Generic.List<AttributeValue>();
            int attributeID = 0;

            foreach (ListItem value in chkBrands.Items)
                if (value.Selected)
                    brands.Add(value.Value);

            foreach(RepeaterItem repeaterItem in rptFilter.Items)
                foreach (Control control in repeaterItem.Controls)
                {
                    if (control is HiddenField)
                        attributeID = int.Parse(((HiddenField)control).Value);
                    if (control is CheckBoxList)
                        foreach (ListItem value in ((CheckBoxList)control).Items)
                            if (value.Selected)
                                attributes.Add(new AttributeValue(int.Parse(value.Value), value.Text, attributeID, 0, string.Empty, 0));
                }

            //List<Product> products = new ProductBL().GetProducts(ViewState["categoryUrl"].ToString(), brands, attributes, sort, cmbPriceFrom.SelectedItem.Text, cmbPriceTo.SelectedItem.Text);
            List<Product> products = new ProductBL().GetProducts(categoryUrl, brands, attributes, sort, cmbPriceFrom.SelectedItem.Text, cmbPriceTo.SelectedItem.Text);

            PagedDataSource pagedDataSource = new PagedDataSource();
            pagedDataSource.DataSource = products;
            pagedDataSource.AllowPaging = true;
            pagedDataSource.PageSize = pageSize;
            //if (currentPage >= pagedDataSource.PageCount)
                //currentPage = pagedDataSource.PageCount - 1;
            //if (currentPage < 0)
                //currentPage = 0;
            pagedDataSource.CurrentPageIndex = currentPage;
            //ViewState["totalPages"] = pagedDataSource.PageCount;
            totalPages = pagedDataSource.PageCount;

            if (products != null)
            {
                //pgrPager.TotalPages = int.Parse(ViewState["totalPages"].ToString());
                pgrPager.TotalPages = totalPages;
                pgrPager.currentPage = this.currentPage;
                pgrPager.doPaging();
                //pgrPager1.TotalPages = int.Parse(ViewState["totalPages"].ToString());
                pgrPager1.TotalPages = totalPages;
                pgrPager1.currentPage = this.currentPage;
                pgrPager1.doPaging();

                rptProducts.DataSource = pagedDataSource;
                rptProducts.DataBind();
            }
            else
            {
                rptProducts.DataSource = null;
                rptProducts.DataSourceID = null;
                rptProducts.DataBind();
                divStatus.Visible = true;
            }
        }

        public void redirect(string url)
        {
            Dictionary<string, string> urls = new Dictionary<string, string>();

            string line;
            using (StreamReader sr = new StreamReader(Server.MapPath("~/categoriesRedirectUrls.txt")))
            {
                while((line = sr.ReadLine()) != null)
                {
                    urls.Add(line.Split(',')[0], line.Split(',')[1]);
                }
            }


            //urls.Add("/proizvodi/prenosni-racunari/laptopovi", "/proizvodi/prenosni-racunari/laptopovi-i-oprema/laptopovi");
            //urls.Add("/proizvodi/laptopovi", "/proizvodi/prenosni-racunari/laptopovi-i-oprema/laptopovi");
            //urls.Add("/proizvodi/laptop", "/proizvodi/prenosni-racunari/laptopovi-i-oprema/laptopovi");

            //urls.Add("/proizvodi/prenosni-racunari/dodatna-oprema", "/proizvodi/prenosni-racunari/dodatna-oprema");
            //urls.Add("/proizvodi/dodatna-oprema", "/proizvodi/prenosni-racunari/dodatna-oprema");

            //urls.Add("/proizvodi/prenosni-racunari/tableti", "/proizvodi/prenosni-racunari/tableti-i-oprema/tableti");
            //urls.Add("/proizvodi/tableti", "/proizvodi/prenosni-racunari/tableti-i-oprema/tableti");

            //urls.Add("/proizvodi/racunari/brandname", "/proizvodi/racunari/brandname-racunari");
            //urls.Add("/proizvodi/brandname", "/proizvodi/racunari/brandname-racunari");
            //urls.Add("/proizvodi/all-in-one", "/proizvodi/racunari/brandname-racunari/all-in-one");

            //urls.Add("/proizvodi/napajanja", "/proizvodi/komponente/kucista-i-napajanja/napajanja");
            //urls.Add("/proizvodi/hard-diskovi", "/proizvodi/komponente/hard-diskovi");
            //urls.Add("/proizvodi/dvd-uredjaji", "/proizvodi/komponente/opticki-uredjaji/dvd-uredjaji");
            //urls.Add("/proizvodi/maticne-ploce", "/proizvodi/komponente/maticne-ploce");

            //urls.Add("/proizvodi/tastature", "/proizvodi/periferije/tastature-i-misevi/tastature");

            //urls.Add("proizvodi/)

            //urls.Add("/proizvodi/pegle", "/proizvodi/kucni-i-kuhinjski-aparati/kucni-aparati/pegle");


            url = url.Contains('?') ? url.Substring(0, url.IndexOf('?')) : url;
            if (urls.ContainsKey(url))
                Response.RedirectPermanent(urls[url] + (Request.QueryString.ToString() != string.Empty ? "?" + Request.QueryString.ToString() : string.Empty));
        }

        private int showSubCategories(int categoryID)
        {
            rptSubCategories.DataSource = new CategoryBL().GetAllSubCategories(categoryID, false);
            rptSubCategories.DataBind();

            if(((List<Category>)rptSubCategories.DataSource) != null && ((List<Category>)rptSubCategories.DataSource).Count > 0)
            {
                divSubCategories.Visible = true;
            }

            return ((List<Category>)rptSubCategories.DataSource) != null ? ((List<Category>)rptSubCategories.DataSource).Count : 0;
        }
    }
}