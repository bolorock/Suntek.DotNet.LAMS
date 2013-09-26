using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SunTek.Register.Domain
{
    public class RowExchanger
    {
        public string RowID1 { get; set; }
        /// <summary>
        /// 公司2 ID
        /// </summary>
        public string RowID2 { get; set; }

        public RowExchanger(string rowID1, string rowID2)
        {
            this.RowID1 = rowID1;
            this.RowID2 = rowID2;
        }

        public RowExchanger() { }
    }
}
