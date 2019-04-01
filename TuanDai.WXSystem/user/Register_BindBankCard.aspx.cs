using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.user
{
    public partial class Register_BindBankCard : UserPage
    {
       
        protected string returnUrl;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.returnUrl = Tool.WEBRequest.GetString("ReturnUrl");
            string strSQL = "select ProID, ProName from T_Province (nolock) order by ProSort";
            DynamicParameters dyParams = new DynamicParameters();
            List<T_ProvinceInfo> provincelist = TuanDai.DB.TuanDaiDB.Query<T_ProvinceInfo>(TdConfig.DBRead, strSQL, ref dyParams);
            this.sel_city1.DataSource = provincelist;
            this.sel_city1.DataTextField = "ProName";
            this.sel_city1.DataValueField = "ProName";
            this.sel_city1.DataBind();

            this.sel_city2.Items.Clear();
            strSQL = "select CityName from T_City (nolock) where ProID=@proId";
            dyParams = new DynamicParameters();
            dyParams.Add("@proId", provincelist.FirstOrDefault().ProID);
            List<T_CityInfo> citylist = TuanDai.DB.TuanDaiDB.Query<T_CityInfo>(TdConfig.DBRead, strSQL, ref dyParams);
            this.sel_city2.DataSource = citylist;
            this.sel_city2.DataTextField = "CityName";
            this.sel_city2.DataValueField = "CityName";
            this.sel_city2.DataBind();
        }
    }
}