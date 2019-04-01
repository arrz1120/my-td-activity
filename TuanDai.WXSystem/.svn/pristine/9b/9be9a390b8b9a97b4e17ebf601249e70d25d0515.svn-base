using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using Tool;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class income_trend : BasePage
    {
        protected Guid ProjectId = Guid.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            ProjectId = WEBRequest.GetGuid("projectId");
        }

        //public void GetData(Guid projectId)
        //{
        //    string sql = @"SELECT PriceDate,Price,TotalPrice FROM ProjectFundDetail_SM(NOLOCK) WHERE projectId=@projectId  ";
        //    var whereParams = new SqlParameter[] { new SqlParameter("@projectId", projectId) };  
        //    fundDeatilList = dbread.ExecuteStoreQuery<TuanDai.PortalSystem.Model.SMBProjectFundDetailInfo>(sql, whereParams).ToList();
        //}
    }
}