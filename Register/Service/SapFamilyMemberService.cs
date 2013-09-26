using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net;

using EAFrame.Core;
using EAFrame.Core.Data;
using EAFrame.Core.Caching;
using EAFrame.Core.Service;
using EAFrame.Core.Enums;
using EAFrame.Core.DataFilter;
using SunTek.Register.Domain;
using EAFrame.Core.Extensions;

namespace SunTek.Register.Service
{
   public class SapFamilyMemberService : BaseService<string, SapFamilyMember>
    {
         #region Fields
        private readonly ILog log = LogManager.GetLogger(typeof(SapFamilyMemberService));
        #endregion

        #region Constructors

        public SapFamilyMemberService() { }
        #endregion

        #region IRegisterService Imp

        #endregion

        #region Internal Methods

        #endregion
    }
}
