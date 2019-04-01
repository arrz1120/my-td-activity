using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.Mall.GameList
{
    public partial class List : AppActivityBasePage
    {
        protected List<TuanDai.VipSystem.Model.MVipBanner> GameList = new List<TuanDai.VipSystem.Model.MVipBanner>();
        protected bool Islogin = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //强制跳转到mvip.tdw.cn站点，不再维护m.tuandai.com站点
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            //Response.Redirect()
            if (WebUserAuth.IsAuthenticated) 
            {
                Islogin = true;
            } 
            string sql = "select top 5 * from MVipBanner where IsShow=1 and LocationType=2 order by DisplaySequence";
            Dapper.DynamicParameters param = new Dapper.DynamicParameters();
            GameList = TuanDai.DB.TuanDaiDB.Query<TuanDai.VipSystem.Model.MVipBanner>(TdConfig.ApplicationName, TdConfig.DBVipWrite, sql, ref param);
        }
    }
}