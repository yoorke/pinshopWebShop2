using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using eshopBE;
using eshopBL;

namespace WebShop2
{
    public class SettingsHandler
    {
        public Settings GetSettings()
        {
            if (HttpContext.Current.Application["settings"] != null)
                return (Settings)HttpContext.Current.Application["settings"];

            Settings settings = new SettingsBL().GetSettings();
            HttpContext.Current.Application.Add("settings", settings);
            return settings;
        }
    }
}