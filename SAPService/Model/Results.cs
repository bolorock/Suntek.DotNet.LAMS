using System;
using System.Collections.Generic;
using System.Text;

namespace Suntek.SAPService.Model
{
    public class Results
    {
        private string _sapid;
        private string _ename;
        private string _esex;
        private string _zjg;
        private string _gbort;

        private string _gbdat;
        private string _icnum;
        private string _packy;
        private string _pcode;
        private string _slart;

        private string _slabs;
        private string _insti;
        private string _zsxzy;
        private string _pbtxt_plstx;
        private string _begda;
        private string _graduateTime;
        private string _graduateTime1;

        private string _worktime;
        private string _workinfo;

        private string _stell;
        private string _plans;
        private string _orgeh;
        private string _pbtxt;
        private string _orgtx;

        private string _plstx;
        private string _stltx;

        private string _slart1;
        private string _slabs1;
        private string _insti1;
        private string _zsxzy1;

        private string _ages;

        private IList<FamilyInfo> family_list;
        private IList<DegreeInfo> degree_list;
        private IList<JobInfo> job_list;
        private IList<WorkInfo> work_list;

        /// <summary>
        /// 
        /// </summary>
        public Results()
        {
            _sapid = "";
            _ename = "";
            _esex = "";
            _zjg = "";
            _gbort = "";

            _gbdat = "";
            _icnum = "";
            _packy = "";
            _pcode = "";
            _slart = "";

            _slabs = "";
            _insti = "";
            _zsxzy = "";
            _pbtxt_plstx = "";
            _begda = "";
            _graduateTime="";
            _graduateTime1="";

            _worktime = "";
            _workinfo = "";

            _stell = "";
            _plans = "";
            _orgeh = "";
            _pbtxt = "";
            _orgtx = "";

            _plstx = "";
            _stltx = "";

            _slart1 = "";
            _slabs1 = "";
            _insti1 = "";
            _zsxzy1 = "";
            _ages = "";
        }

        /// <summary>
        /// 员工编号
        /// </summary>
        public string SapID
        {
            get
            {
                return this._sapid;
            }
            set
            {
                this._sapid = value;
            }
        }

        /// <summary>
        /// 员工姓名
        /// </summary>
        public string Ename
        {
            get
            {
                return this._ename;
            }
            set
            {
                this._ename = value;
            }
        }

        /// <summary>
        /// 员工性别(男、女)
        /// </summary>
        public string Esex
        {
            get
            {
                return this._esex;
            }
            set
            {
                this._esex = value;
            }
        }

        /// <summary>
        /// 籍贯
        /// </summary>
        public string Zjg
        {
            get
            {
                return this._zjg;
            }
            set
            {
                this._zjg = value;
            }
        }

        /// <summary>
        /// 出生地
        /// </summary>
        public string Gbort
        {
            get
            {
                return this._gbort;
            }
            set
            {
                this._gbort = value;
            }
        }

        /// <summary>
        /// 出生日期
        /// </summary>
        public string Gbdat
        {
            get
            {
                return this._gbdat;
            }
            set
            {
                this._gbdat = value;
            }
        }

        /// <summary>
        /// 身份证号
        /// </summary>
        public string Icnum
        {
            get
            {
                return this._icnum;
            }
            set
            {
                this._icnum = value;
            }
        }

        /// <summary>
        /// 民族(汉族、满族)
        /// </summary>
        public string Packy
        {
            get
            {
                return this._packy;
            }
            set
            {
                this._packy = value;
            }
        }

        /// <summary>
        /// 政治面貌
        /// </summary>
        public string Pcode
        {
            get
            {
                return this._pcode;
            }
            set
            {
                this._pcode = value;
            }
        }

        /// <summary>
        /// 学历(全日制)
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
        /// 学位(全日制)
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
        /// 学校名称(全日制)
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
        /// 所学专业(全日制)
        /// </summary>
        public string zsxzy
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
        /// 毕业时间(全日制）
        /// </summary>
        public string GraduateTime
        {
            get
            {
                return this._graduateTime;
            }
            set
            {
                this._graduateTime = value;
            }
        }

        /// <summary>
        /// 学历(在岗)
        /// </summary>
        public string Slart1
        {
            get
            {
                return this._slart1;
            }
            set
            {
                this._slart1 = value;
            }
        }

        /// <summary>
        /// 学位(在岗)
        /// </summary>
        public string Slabs1
        {
            get
            {
                return this._slabs1;
            }
            set
            {
                this._slabs1 = value;
            }
        }

        /// <summary>
        /// 学校名称(在岗)
        /// </summary>
        public string Insti1
        {
            get
            {
                return this._insti1;
            }
            set
            {
                this._insti1 = value;
            }
        }

        /// <summary>
        /// 所学专业(在岗)
        /// </summary>
        public string zsxzy1
        {
            get
            {
                return this._zsxzy1;
            }
            set
            {
                this._zsxzy1 = value;
            }
        }
        /// <summary>
        /// 毕业时间(在岗）
        /// </summary>
        public string GraduateTime1
        {
            get
            {
                return this._graduateTime1;
            }
            set
            {
                this._graduateTime1 = value;
            }
        }

        /// <summary>
        /// 现何单位从事何工作
        /// </summary>
        public string Pbtxt_Plstx
        {
            get
            {
                return this._pbtxt_plstx;
            }
            set
            {
                this._pbtxt_plstx = value;
            }
        }

        /// <summary>
        /// 从事本专业工作时间
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
        /// 参加工作时间
        /// </summary>
        public string WorkTime
        {
            get
            {
                return this._worktime;
            }
            set
            {
                this._worktime = value;
            }
        }

        /// <summary>
        /// 工作简历
        /// </summary>
        public string WorkInfo
        {
            get
            {
                return this._workinfo;
            }
            set
            {
                this._workinfo = value;
            }
        }

        /// <summary>
        /// 职务编码
        /// </summary>
        public string Stell
        {
            get
            {
                return this._stell;
            }
            set
            {
                this._stell = value;
            }
        }

        /// <summary>
        /// 职位编码
        /// </summary>
        public string Plans
        {
            get
            {
                return this._plans;
            }
            set
            {
                this._plans = value;
            }
        }

        /// <summary>
        /// 组织单位
        /// </summary>
        public string Orgeh
        {
            get
            {
                return this._orgeh;
            }
            set
            {
                this._orgeh = value;
            }
        }

        /// <summary>
        /// 人事范围文本(所属单位)
        /// </summary>
        public string Pbtxt
        {
            get
            {
                return this._pbtxt;
            }
            set
            {
                this._pbtxt = value;
            }
        }

        /// <summary>
        /// 组织单位文本(部门)
        /// </summary>
        public string Orgtx
        {
            get
            {
                return this._orgtx;
            }
            set
            {
                this._orgtx = value;
            }
        }

        /// <summary>
        /// 职位名称(岗位名称)
        /// </summary>
        public string Plstx
        {
            get
            {
                return this._plstx;
            }
            set
            {
                this._plstx = value;
            }
        }

        /// <summary>
        /// 职务名称(岗位等级)
        /// </summary>
        public string Stltx
        {
            get
            {
                return this._stltx;
            }
            set
            {
                this._stltx = value;
            }
        }

        /// <summary>
        /// 年龄
        /// </summary>
        public string Ages
        {
            get
            {
                return this._ages;
            }
            set
            {
                this._ages = value;
            }
        }

        /// <summary>
        /// 家庭成员信息列表
        /// </summary>
        public IList<FamilyInfo> Family_List
        {
            get
            {
                return this.family_list;
            }
            set
            {
                this.family_list = value;
            }
        }

        /// <summary>
        /// 学历信息列表
        /// </summary>
        public IList<DegreeInfo> Degree_List
        {
            get
            {
                return this.degree_list;
            }
            set
            {
                this.degree_list = value;
            }
        }

        /// <summary>
        /// 专业技术职务列表
        /// </summary>
        public IList<JobInfo> Job_List
        {
            get
            {
                return this.job_list;
            }
            set
            {
                this.job_list = value;
            }
        }

        /// <summary>
        /// 工作经历列表
        /// </summary>
        public IList<WorkInfo> Work_List
        {
            get
            {
                return this.work_list;
            }
            set
            {
                this.work_list = value;
            }
        }
    }
}
