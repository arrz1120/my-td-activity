using Dapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;  

namespace TuanDai.WXApiWeb.pages.news
{
    /// <summary>
    /// 公告详情
    /// Allen 2015-06-05
    /// </summary>
    public partial class noticedetails : BasePage
    {
        protected string strTitle = "", strContent = "", strAddDate = "";
        protected int NewsId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            NewsId = WEBRequest.GetInt("id", 0);
            if (NewsId.ToText().IsEmpty())
            {
                Response.Redirect("/pages/news/noticelist.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (!GetData(NewsId))
                {
                    
                }
            }
        }
        protected bool GetData(int NewsId)
        {
            NewsBLL bll = new NewsBLL();
            NewsInfo model = new NewsInfo();
            string sqlText = "select top 1 Id,Title,Content,ClickNumber,AddDate,CategoryId from News where Id=@Id order by AddDate desc";
            var param = new DynamicParameters();
            param.Add("@Id", NewsId);
            model = PublicConn.QuerySingle<NewsInfo>(sqlText, ref param);

            if (model == null)
                return false;
            strTitle = model.Title;
            strContent = model.Content;
            strAddDate = (model.AddDate ?? DateTime.Today).ToString("yyyy年MM月dd日");
            return true;
        }

    }
}