using System;
using System.Collections.Generic;
using System.Text;

namespace Suntek.SAPService.Model
{
   public class FamilyInfo
    {
       public FamilyInfo()
       {
           _famsa = "";
           _fcnam = "";
           _fasex = "";
           _fgbdt = "";
           _zdw = "";

           _zzw = "";
           _zdw_zzw = "";
       }

       private string _famsa;
       private string _fcnam;
       private string _fasex;
       private string _fgbdt;
       private string _zdw;

       private string _zzw;
       private string _zdw_zzw;

       /// <summary>
       /// 家庭记录类型
       /// </summary>
       public string Famsa
       {
           get
           {
               return this._famsa;
           }
           set
           {
               this._famsa = value;
           }
       }

       /// <summary>
       /// 全名
       /// </summary>
       public string Fcnam
       {
           get
           {
               return this._fcnam;
           }
           set
           {
               this._fcnam = value;
           }
       }

       /// <summary>
       /// 性别
       /// </summary>
       public string Fasex
       {
           get
           {
               return this._fasex;
           }
           set
           {
               this._fasex = value;
           }
       }

       /// <summary>
       /// 出生日期
       /// </summary>
       public string Fgbdt
       {
           get
           {
               return this._fgbdt;
           }
           set
           {
               this._fgbdt = value;
           }
       }

       /// <summary>
       /// 工作单位
       /// </summary>
       public string Zdw
       {
           get
           {
               return this._zdw;
           }
           set
           {
               this._zdw = value;
           }
       }

       /// <summary>
       /// 职位
       /// </summary>
       public string Zzw
       {
           get
           {
               return this._zzw;
           }
           set
           {
               this._zzw = value;
           }
       }

       /// <summary>
       /// 工作单位及职务
       /// </summary>
       public string Zdw_Zzw
       {
           get
           {
               return this._zdw_zzw;
           }
           set
           {
               this._zdw_zzw = value;
           }
       }
    }
}
