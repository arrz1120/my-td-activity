using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool; 

namespace TuanDai.WXApiWeb.pages.loan
{
    /// <summary>
    /// 正合普惠借款
    /// Allen 2016-03-26
    /// </summary>
    public partial class ZhphApply : UserPage
    {
        protected int ApplyType = 0;
        protected string ApplyTypeName = "快速借款";
        protected List<AddressInfo> provinceList;
        protected void Page_Load(object sender, EventArgs e)
        {
            ApplyType = WEBRequest.GetQueryInt("applytype",0);
            switch (ApplyType)
           { 
                case 1:
                   ApplyTypeName = "公务员方案";
                    break;
                case 2:
                    ApplyTypeName = "公积金方案";
                    break;
                 case 3:
                    ApplyTypeName = "精英方案";
                    break;
                 case 4:
                    ApplyTypeName = "保单方案";
                    break;
            }
           if (!IsPostBack) {
               GetProvinceList();
           }

        }

        protected void GetProvinceList() {
            string strSQL = "SELECT AreaCode, AreaName FROM dbo.fq_AreaRegion WHERE   ParentCode=0 ORDER BY AreaCode";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            provinceList =  PublicConn.QueryBySql<AddressInfo>(strSQL, ref dyParams);
        }

        public class AddressInfo
        {
            /// <summary>
            /// 名称
            /// </summary>
            public string AreaName { get; set; }
            /// <summary>
            /// Id
            /// </summary>
            public int AreaCode { get; set; }
        }

    }
}