using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SunTek.Assessment.Domain
{
    public class SurveyResultModel:SurveyResult
    {
        #region Constructors
        public SurveyResultModel() { }
        #endregion

        public virtual List<SurveyResult> SurveyResults { get; set; }
    }
}
