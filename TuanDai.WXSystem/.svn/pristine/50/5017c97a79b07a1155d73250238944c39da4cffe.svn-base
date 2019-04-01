using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    public partial class my_return_list : UserPage
    {
        protected string StatusTab;
        protected string TypeTab;
        protected string OrderTab;
        protected WebSettingInfo curSellSet; //1218当天配置
        protected bool IsAct1248 = false; //是否1218后显示 
        protected void Page_Load(object sender, EventArgs e)
        {
            StatusTab = WEBRequest.GetQueryString("tab");
            if (StatusTab == "")
                StatusTab = "Inprogress";

            TypeTab = WEBRequest.GetQueryString("typeTab");
            if (TypeTab == "")
                TypeTab = "WePlan";

            OrderTab = WEBRequest.GetQueryString("orderTab");
            if (OrderTab == "")
                OrderTab = "1";

            WebSettingBLL webSettingBll = new WebSettingBLL();
            curSellSet = webSettingBll.GetWebSettingInfo("B11558CB-3C6B-4DAD-9D2F-D6D2DE13CCF7"); 
         
            if (DateTime.Now >= DateTime.Parse(curSellSet.Param1Value) && DateTime.Now <= DateTime.Parse("2016-12-25 23:59:59"))
            {
                IsAct1248 = true;
            }
        }

    }
}