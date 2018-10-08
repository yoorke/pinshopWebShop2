using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace WebShop2
{
    public class Redirect
    {
        public void RedirectUrl(string url)
        {
            Dictionary<string, string> urls = new Dictionary<string, string>();

            string line;
            using (StreamReader sr = new StreamReader(HttpContext.Current.Server.MapPath("~/redirect.txt")))
            {
                while ((line = sr.ReadLine()) != null)
                    urls.Add(line.Split(',')[0], line.Split(',')[1]);
            }

            url = url.Contains('?') ? url.Substring(0, url.IndexOf('?')) : url;

            if(urls.ContainsKey(url))
                HttpContext.Current.Response.RedirectPermanent(urls[url] + (HttpContext.Current.Request.QueryString.ToString() != string.Empty ? "?" + HttpContext.Current.Request.QueryString.ToString() : string.Empty));
        }

        public Dictionary<string, string> LoadUrls()
        {
            Dictionary<string, string> urls = new Dictionary<string, string>();
            string line;
            using (StreamReader sr = new StreamReader(HttpContext.Current.Server.MapPath("~/redirect.txt")))
            {
                while ((line = sr.ReadLine()) != null)
                    urls.Add(line.Split(',')[0], line.Split(',')[1]);
            }

            return urls;
        }
    }
}