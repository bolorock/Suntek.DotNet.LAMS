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
        /// ѧУ����
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
        /// ��ѧרҵ
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
        /// ѧϰ��ʽ����
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
        /// ѧ��
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
        /// ѧλ����
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
        /// ��ѧʱ��
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
        /// ��ҵʱ��
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
