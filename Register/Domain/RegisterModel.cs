using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SunTek.Register.Domain
{
    public class RegisterModel
    {
        public RegisterModel() { }

        public virtual List<RegisterInfo> RegisterInfos { get; set; }

        //public virtual List<RegisterBaseInfo> RegisterBaseInfos { get; set; }

    }
}
