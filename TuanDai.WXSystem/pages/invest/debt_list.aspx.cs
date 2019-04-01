﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 债权转让投资列表
    /// Allen 2016-03-08
    /// </summary>
    public partial class debt_list : UserPage
    {
        protected List<WXProjectListInfo> projectList = new List<WXProjectListInfo>();
        protected ProjectBLL bll;
        protected int RecordCount = 0;
        protected int pageCount = 0;
        protected MUserVipInfo vipInfo = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            if (!IsPostBack)
            {
                this.IsShowRightBar = GlobalUtils.IsWeiXinBrowser ? false : true;
                GetProjectList();
                vipInfo = MUserVipInfoBLL.GetUserVipInfoById(WebUserAuth.UserId.Value);
                if (vipInfo == null)
                {
                    vipInfo = new MUserVipInfo();
                    vipInfo.Level = 1;
                }
            }
        }

        private void GetProjectList()
        {
            bll = new ProjectBLL();
            ProjectListRequest projectRequest = new ProjectListRequest();
            projectRequest.RequestSource = 2;
            projectRequest.ProjectType = 99;
            projectRequest.PageSize = GlobalUtils.PageSize;
            projectRequest.PageIndex = 1;
            projectList = bll.WXGetZQZRProjectShowList(projectRequest, out RecordCount);

            double divide = RecordCount / GlobalUtils.PageSize;
            double floor = System.Math.Floor(divide);
            if (RecordCount % GlobalUtils.PageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
        }

        protected string GetProjectSurplusMoney(WXProjectListInfo itemInfo)
        {
            decimal amount = ((itemInfo.TotalShares ?? 0) - (itemInfo.CastedShares ?? 0)) * itemInfo.LowerUnit;
            return string.Format("<span>{0}</span>{1}", (amount >= 10000) ? ToolStatus.ConvertWanMoney(amount) : ToolStatus.ConvertLowerMoney(amount), (amount >= 10000) ? "万" : "元");
        }
    }
}