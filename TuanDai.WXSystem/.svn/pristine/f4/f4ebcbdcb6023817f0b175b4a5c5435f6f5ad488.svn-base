using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.pages.news
{
    /// <summary>
    /// 团贷公告列表
    /// Allen 2015-06-05
    /// </summary>
    public partial class noticelist :BasePage
    {

        protected List<NewsInfo> newsList; //新闻 
        protected int pageCount = 0; 

        protected void Page_Load(object sender, EventArgs e)
        { 
            if (!IsPostBack)
            {
                this.GetData();
            }
        }

        private void GetData()
        {
            NewsBLL bll = new NewsBLL();
            int recordCount = 0;
            newsList = bll.GetNewsList(33, GlobalUtils.PageSize, 1, out recordCount);

            double divide = recordCount / GlobalUtils.PageSize;
            double floor = System.Math.Floor(divide);
            if (recordCount % GlobalUtils.PageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
        }

    }
}