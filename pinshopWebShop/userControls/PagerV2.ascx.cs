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

namespace WebShop2.UserControls
{
    public partial class PagerV2 : System.Web.UI.UserControl
    {
        //public delegate void ChangePage(int currentPage);
        //public event ChangePage OnClick;

        private string _cssClass;
        private int _totalPages;

        private PagedDataSource _pagedDataSource;

        public string CssClass
        {
            get { return _cssClass; }
            set { _cssClass = value; }
        }

        public int currentPage { get; set; }
        //{
        //get
        //{
        //if (ViewState["currentPage"] != null)
        //return int.Parse(ViewState["currentPage"].ToString());
        //else return 0;
        //}
        //set { ViewState["currentPage"] = value; }
        //}

        private int firstIndex;
        //{
        //get
        //{
        //if (ViewState["firstIndex"] != null)
        //return int.Parse(ViewState["firstIndex"].ToString());
        //else return 0;
        //}
        //set { ViewState["firstIndex"] = value; }
        //}

        private int lastIndex;
        //{
            //get
            //{
                //if (ViewState["lastIndex"] != null)
                    //return int.Parse(ViewState["lastIndex"].ToString());
                //else return 0;
            //}
            //set { ViewState["lastIndex"] = value; }
        //}

        public int TotalPages { set { _totalPages = value; } }

        public PagedDataSource DataSource
        {
            get { return _pagedDataSource; }
            set { _pagedDataSource = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rptPaging_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            //if (e.CommandName == "paging")
            //{
                //currentPage = int.Parse(e.CommandArgument.ToString());
                //if (OnClick != null)
                    //OnClick(currentPage);
            //}
        }

        protected void rptPaging_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //LinkButton lnkPage = (LinkButton)e.Item.FindControl("lnkPage");
                //if (lnkPage.CommandArgument.ToString() == currentPage.ToString())
                //{
                    //lnkPage.Enabled = false;
                    //lnkPage.Font.Bold = true;
                    //lnkPage.Attributes["class"] = "paging-active";
                //}

                HyperLink lblPage = (HyperLink)e.Item.FindControl("lblPage");
                if(!lblPage.Text.Equals("..."))
                { 
                    lblPage.Attributes.Add("onclick", "changePage(" + lblPage.Text + ")");
                    if (lblPage.Text == (currentPage + 1).ToString())
                    {
                        //lblPage.Enabled = false;
                        lblPage.Font.Bold = true;
                        lblPage.Attributes["class"] = "paging-active";
                    }
                    else
                        lblPage.Attributes["class"] += " cursor-pointer";
                }
                else
                {
                    lblPage.Attributes["class"] = "dot";
                }
            }
        }

        public void doPaging()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PageIndex");
            dt.Columns.Add("PageText");

            DataRow newRow = dt.NewRow();
            newRow[0] = 0;
            newRow[1] = 1;
            dt.Rows.Add(newRow);

            firstIndex = currentPage - 3;


            if (firstIndex < 1)
                firstIndex = 1;

            //lastIndex = firstIndex == 1 ? 8 : currentPage + 7;
            lastIndex = currentPage < 5 ? 8 : currentPage + 4;

            if (lastIndex > _totalPages - 1) { 
                lastIndex = _totalPages - 1;
                firstIndex = lastIndex - 7;
                if (firstIndex < 1)
                    firstIndex = 1;
            }

            //if (currentPage > 3)
            //lastIndex = currentPage + 5;
            //else
            //lastIndex = 7;

            //if (lastIndex > _totalPages - 1)
            //{
            //lastIndex = _totalPages - 1;
            //firstIndex = lastIndex - 7;
            //}

            //if (firstIndex < 0)
            //firstIndex = 1;


            for (int i = firstIndex; i < lastIndex; i++)
            {
                DataRow dr = dt.NewRow();
                dr[0] = i;
                dr[1] = i + 1;
                dt.Rows.Add(dr);
            }

            if(lastIndex - firstIndex > -1)
            { 
                newRow = dt.NewRow();
                newRow[0] = _totalPages - 1;
                newRow[1] = _totalPages;
                dt.Rows.Add(newRow);
            }

            newRow = dt.NewRow();
            newRow[0] = -1;
            newRow[1] = "...";
            if (dt.Rows.Count > 1 && int.Parse(dt.Rows[1][0].ToString()) > 1)
                dt.Rows.InsertAt(newRow, 1);

            newRow = dt.NewRow();
            newRow[0] = -1;
            newRow[1] = "...";

            if(dt.Rows.Count > 2)
                if (int.Parse(dt.Rows[dt.Rows.Count - 2][0].ToString()) < _totalPages - 2)
                    dt.Rows.InsertAt(newRow, dt.Rows.Count - 1);

            rptPaging.DataSource = dt;
            rptPaging.DataBind();
        }
    }
}