using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SunTek.EAFrame.AuthorizeCenter.Domain;

namespace SunTek.LAMS.Domain
{
    public class CandidateManagerModel:CandidateManager
    {

        #region Constructors
        public CandidateManagerModel() { }
        #endregion

        public virtual List<CandidateManager> CandidateManagers { get; set; }

        public virtual List<Employee> Employees { get; set; }
    }
}
