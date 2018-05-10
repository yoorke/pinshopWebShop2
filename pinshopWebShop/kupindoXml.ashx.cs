using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using eshopBL;

namespace WebShop2
{
    /// <summary>
    /// Summary description for kupindoXml
    /// </summary>
    public class kupindoXml : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            XmlDocument doc = new XmlDocument();
            if (context.Request.QueryString.ToString().Contains("type") && int.Parse(context.Request.QueryString["type"]) == 1)
            {
                doc = new kupindoBL().GetProducts(int.Parse(context.Request.QueryString["type"]));
            }
            else
                doc.Load(context.Server.MapPath("~/xml/products.xml"));

            context.Response.ContentType = "text/xml";
            context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Expires = -1;
            context.Response.Cache.SetAllowResponseInBrowserHistory(true);

            doc.Save(context.Response.Output);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}