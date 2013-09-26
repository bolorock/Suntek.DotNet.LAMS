using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebSite
{
    public static class Extension
    {
        static readonly IDictionary<int, string> ABCMap = new Dictionary<int, string>();

        static Extension()
        {
            for (int i = 1; i <= 26; i++)
            {
                ABCMap.Add(i, ((char)(64 + i)).ToString());
            }
        }

        public static string ToANSIChar(this int i)
        {
            return i <= 26 && i > 0 ? ABCMap[i] : i.ToString();
        }
    }
}