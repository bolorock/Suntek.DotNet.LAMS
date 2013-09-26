using System;
using System.Collections.Generic;
using System.Text;

namespace Suntek.SAPService.Model
{
    public class DegreeInfo
    {
        public DegreeInfo()
        {
            _insti = "";
            _zsxzy = "";
            _zxxfsbc = "";
            _slart = "";
            _slabs = "";

            _begda = "";
            _endda = "";
        }

        private string _insti;
        private string _zsxzy;
        private string _zxxfsbc;
        private string _slart;
        private string _slabs;

        private string _begda;
        private string _endda;

        /// <summary>
        /// 学校名称
        /// </summary>
        public string Insti
        {
            get
            {
                return this._insti;
            }
            set
            {
                this._insti = value;
            }
        }

        /// <summary>
        /// 所学专业
        /// </summary>
        public string Zsxzy
        {
            get
            {
                return this._zsxzy;
            }
            set
            {
                this._zsxzy = value;
            }
        }

        /// <summary>
        /// 学习方式补充
        /// </summary>
        public string Zxxfsbc
        {
            get
            {
                return this._zxxfsbc;
            }
            set
            {
                this._zxxfsbc = value;
            }
        }

        /// <summary>
        /// 学历
        /// </summary>
        public string Slart
        {
            get
            {
                return this._slart;
            }
            set
            {
                this._slart = value;
            }
        }

        /// <summary>
        /// 学位名称
        /// </summary>
        public string Slabs
        {
            get
            {
                return this._slabs;
            }
            set
            {
                this._slabs = value;
            }
        }

        /// <summary>
        /// 入学时间
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
        /// 毕业时间
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
    }
}
