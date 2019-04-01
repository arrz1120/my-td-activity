using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using Tool;
using TuanDai.News.Contract;
using TuanDai.News.Client;


namespace TuanDai.WXApiWeb.pages.helpCenter
{
    public partial class secondQuestion : BasePage
    {
        protected List<WXHelpCategoryInfo> categroyList;
        protected List<WXHelpDetialInfo>  NewsList;//热门问题
        protected int TypeId = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            TypeId = WEBRequest.GetQueryInt("typeid", 0);
            if (!IsPostBack)
            {
                BinderData();
            }
        }
        protected void BinderData()
        {
            //从APP跳转过来不显示导航条
            string strType = Tool.CookieHelper.GetCookie("HelpCenterType").ToText();
            if (strType.ToLower() == "mobileapp")
            {
                IsShowRightBar = false;
            }

            categroyList = WXHelpService.GetCategoryInfoTop(TypeId, 9);

            NewsList = WXHelpService.GetDetailInfoTopByCategoryId(40, TypeId);
        }
    }
}