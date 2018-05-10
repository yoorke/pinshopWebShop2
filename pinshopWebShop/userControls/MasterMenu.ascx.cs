using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace WebShop2.UserControls
{
    public partial class MasterMenu : System.Web.UI.UserControl
    {
        private int _masterMenuID;

        public int MasterMenuID
        {
            get { return _masterMenuID; }
            set { _masterMenuID = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
                loadMasterMenu();
        }

        private void loadMasterMenu()
        {
            DataTable dtMasterMenu = new DataTable();
            dtMasterMenu.Columns.Add("name");
            dtMasterMenu.Columns.Add("url");
            DataRow newRow = null;
            
            newRow = dtMasterMenu.NewRow();
            newRow["name"] = "Moj nalog";
            newRow["url"] = "moj-nalog";
            dtMasterMenu.Rows.Add(newRow);

            //newRow = dtMasterMenu.NewRow();
            //newRow["name"] = "Gde kupiti";
            //newRow["url"] = "gde-kupiti";
            //dtMasterMenu.Rows.Add(newRow);

            //newRow = dtMasterMenu.NewRow();
            //newRow["name"] = "Galerija";
            //newRow["url"] = "galerija";
            //dtMasterMenu.Rows.Add(newRow);

            newRow = dtMasterMenu.NewRow();
            newRow["name"] = "O nama";
            newRow["url"] = "o-nama";
            dtMasterMenu.Rows.Add(newRow);

            newRow = dtMasterMenu.NewRow();
            newRow["name"] = "Kontakt";
            newRow["url"] = "kontakt";
            dtMasterMenu.Rows.Add(newRow);
            

            
            rptMasterMenu.DataSource = dtMasterMenu;
            rptMasterMenu.DataBind();
        }
    }
}