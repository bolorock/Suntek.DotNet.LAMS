using System;
using System.Collections;
using System.Collections.Generic;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace SunTek.LAMS.Domain
{
    public class CandidateManagerEmployee : DomainObject<string>
    {
        public CandidateManagerEmployee() { }

        public virtual string ID { get; set; }
        public virtual string Name { get; set; }
        public virtual string Grade { get; set; }
        public virtual short IsChief { get; set; }
        public virtual string CorpID { get; set; } 
    }
}
