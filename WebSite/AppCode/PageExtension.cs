using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using EAFrame.Core;
using EAFrame.Core.Authentication;
using EAFrame.Core.Enums;
using EAFrame.Core.Web;
using EAFrame.Core.Utility;
using EAFrame.WebControls;
using EAFrame.Core.Extensions;

namespace WebSite
{
    public static class PageExtension
    {
        public static void BindCombox(this Combox combox, Enum value)
        {
            IList<KeyValuePair<string, string>> values = value.GetRemarks();
            combox.Items = values.Select(v => new ComboxItem() { Tag = "combox", Text = v.Value, Value = v.Key }).ToList();
            combox.SelectedValue = ((int)(object)value).ToSafeString();
        }
    }
}