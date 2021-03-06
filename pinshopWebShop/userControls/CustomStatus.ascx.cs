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
using System.Drawing;

namespace WebShop2.UserControls
{
    public partial class CustomStatus : System.Web.UI.UserControl
    {
        private Color _foreColor;
        private string _text;
        private bool _visible;
        private string _class;

        public Color ForeColor
        {
            get { return _foreColor; }
            set { _foreColor = value; }
        }

        public string Text
        {
            get { return _text; }
            set { _text = value; }
        }

        public override bool Visible
        {
            get { return _visible; }
            set { _visible = value; }
        }

        public string Class
        {
            get { return _class; }
            set { _class = value; }
        }

        public string GetClientID
        {
            get { return divCol.ClientID; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblStatusText.ForeColor = _foreColor;
            lblStatusText.Text = _text;
            this.Visible = _visible;
            lblStatusText.Visible = false;
        }

        public void Show()
        {
            lblStatusText.Text = _text;
            //lblStatusText.ForeColor = _foreColor;
            lblStatusText.Visible = _visible;
            //lblStatusText.Attributes["class"] = _class;
            divCol.Attributes["class"] = "alert alert-" + _class + " text-center";
        }
    }
}