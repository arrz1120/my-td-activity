using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using Tool;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.news
{
    /// <summary>
    /// 团队热点
    /// Allen 2015-05-22
    /// </summary>
    public partial class newslist : BasePage
    {
        protected List<WXNewsVideoInfo> newsList; //新闻 
        protected int pageCount = 0; 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                this.GetData();
            }
        }

        private void GetData() {
            NewsBLL bll = new NewsBLL();
            int recordCount = 0;
            newsList = bll.GetNewsVideoList(GlobalUtils.PageSize, 1, out recordCount); 

            double divide = recordCount / GlobalUtils.PageSize;
            double floor = System.Math.Floor(divide);
            if (recordCount % GlobalUtils.PageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
        }

        public static string GetShownNewsImg(string headImg)
        {
            if (headImg.ToText().IsEmpty())
            {
                return "/imgs/bav_head.gif";
            }
            else
            {
                return headImg;
            }
        }
    }
}