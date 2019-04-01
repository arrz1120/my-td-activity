using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kamsoft.Data.Dapper;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class mallIndex : UserPage
    {
        protected List<MVipBanner> BannerList;
        public MUserVipInfo UserVipInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            GetBannerList();
            this.UserVipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
        }

        //获取头部广告图
        private void GetBannerList()
        {
            string sql = "SELECT top 8 ImageUrl,Url FROM dbo.MVipBanner with(nolock) WHERE LocationType=1 and isshow = 1 order by DisplaySequence ASC,AddDate DESC";
            
            var para = new Dapper.DynamicParameters();
            BannerList = PublicConn.QueryVipBySql<MVipBanner>(sql, ref para);
        } 
    }

    public class MVipBanner
    {
        public string ImageUrl { get; set; }

        public string Url { get; set; }
    }
}