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
    /// 新闻详情
    /// Allen 2015-05-23
    /// </summary>
    public partial class newsdetail :BasePage
    {
        private string NewsId = "";
        protected int InfoType = 1;
        protected string strTitle = "";
        protected string AddDate = "";
        protected string Content = "";
        protected string VideoPath = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            InfoType = WEBRequest.GetQueryInt("type", 1);
            NewsId = WEBRequest.GetQueryString("id");
            if (NewsId.ToText().IsEmpty())
            {
                Response.Redirect("/pages/news/newslist.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (!GetData())
                {
                    Response.Redirect("/pages/news/newslist.aspx");
                    return;
                }
            }
        }

        protected bool GetData() {
            if (!InfoType.ToText().IsIn("1;2"))
                return false;
            if (InfoType == 1)
            {
                NewsBLL bll = new NewsBLL();
                NewsInfo model = bll.GetNewsInfo(NewsId.ToInt(0));
                if (model == null)
                    return false;
                strTitle = model.Title;
                Content = model.Content;
                AddDate = (model.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd");
            }
            else if(InfoType==2) {
                VideoBLL bll = new VideoBLL();
                VideoInfo model = bll.GetVideoInfo(SafeConvert.ToGuid(NewsId).Value);
                if (model == null)
                    return false;
                strTitle = model.Title; 
                AddDate = (model.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd");
                VideoPath = model.videopath;
            }
           return true;
        }
    }
}