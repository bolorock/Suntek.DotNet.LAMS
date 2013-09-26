using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Suntek.SAPService.Model
{
    public  class AppointInfo
    {
        private string _begda;
        private string _endda;
        private string _jobds;
        private string _appru;
        private string _jobty;

        public AppointInfo()
        {
            _begda = "";
            _endda = "";
            _jobds = "";
            _appru = "";
            _jobty = "";
        }

        /// <summary>
        /// 起始时间
        /// </summary>
        public string Begda
        {
            get
            {
                return this._begda;
            }
            set
            {
                this._begda = value;
            }
        }

        /// <summary>
        /// 结束时间
        /// </summary>
        public string Endda
        {
            get
            {
                return this._endda;
            }
            set
            {
                this._endda = value;
            }
        }

        /// <summary>
        /// 职位名称
        /// </summary>
        public string Jobds
        {
            get
            {
                return this._jobds;
            }
            set
            {
                this._jobds = value;
            }
        }

        /// <summary>
        /// 批准文号
        /// </summary>
        public string Appru
        {
            get
            {
                return this._appru;
            }
            set
            {
                this._appru = value;
            }
        }
    
        /// <summary>
        /// 职务岗位等级
        /// </summary>
        public string Jobty
        {
            get
            {
                return this._jobty;
            }
            set
            {
                this._jobty = value;
            }
        }
    }
}
