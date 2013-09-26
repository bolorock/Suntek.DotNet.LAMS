using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using EAFrame.Core.Domain;
using EAFrame.Core.Extensions;
using Newtonsoft.Json;
using Iesi.Collections.Generic;

namespace EAFrame.Workflow.Domain
{
    public class ProcessForm : DomainObject<string>
    {
        #region Methods

        public override int GetHashCode()
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(this.GetType().FullName);
            sb.Append(ProcessInstID);
            sb.Append(BizTable);
            sb.Append(Creator);
            sb.Append(BizID);
            sb.Append(ID);
            sb.Append(KeyWord);
            return sb.ToString().GetHashCode();
        }

        public virtual bool Validate()
        {
            return true;
        }

        #endregion

        public virtual string ProcessInstID
        {
            get;
            set;
        }
        public virtual string KeyWord
        {
            get;
            set;
        }
        public virtual string BizTable
        {
            get;
            set;
        }

        public virtual string BizID
        {
            get;
            set;
        }

        public virtual DateTime CreateTime
        {
            get;
            set;
        }

        public virtual string Creator
        {
            get;
            set;
        }
    }
}
