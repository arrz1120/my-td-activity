﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class xmb_guanlijigou : BasePage
    {
        protected Guid? projectId = Guid.Empty;
        /// <summary>
        /// 项目宝扩展表信息
        /// </summary>
        protected Project_XMB_Info xmbModel = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
            if (!IsPostBack)
            {
               if (this.projectId != Guid.Empty)
                {
                    if (!this.GetData())
                        return;
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                }
            }
        }

        protected bool GetData() {
            ProjectBLL projbll = new ProjectBLL();
            xmbModel = projbll.GetProjectXMBInfo(projectId.Value);
            if (xmbModel == null)
            {
                xmbModel = new Project_XMB_Info();
            }
            return true;
        }
    }
}