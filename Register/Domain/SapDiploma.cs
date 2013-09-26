using System;
using System.Collections;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace SunTek.Register.Domain
{
    public class SapDiploma : DomainObject<string>
   {

      public SapDiploma()
      {}


      #region 属性

      public  virtual string PERNR
      {
          get;
          set;
      }

      public  virtual string INSTI
      {
          get;
          set;
      }

      public  virtual string ZSXZY
      {
          get;
          set;
      }

      public  virtual string ZXXFSBC
      {
          get;
          set;
      }

      public  virtual string SLART
      {
          get;
          set;
      }

      public  virtual string SLABS
      {
          get;
          set;
      }

      public virtual string BEGDA
      {
          get;
          set;
      }

      public virtual string ENDDA
      {
          get;
          set;
      }

      #endregion

   }
}
