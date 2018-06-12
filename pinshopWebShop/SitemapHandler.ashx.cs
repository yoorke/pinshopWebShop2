using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using eshopBL;
using System.Xml;
using System.Text;

namespace WebShop2
{
    /// <summary>
    /// Summary description for SitemapHandler
    /// </summary>
    public class SitemapHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/xml";
            context.Response.ContentEncoding = Encoding.UTF8;
            //context.Response.Write("Hello World");

            XmlDocument xmlDoc = new WebSitemapBL().CreateSitemap();
            xmlDoc.Save(context.Response.Output);

            context.Response.End();
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