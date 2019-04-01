﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member
{
    /// <summary>
    /// 用户资料--升级会员
    /// Allen 2015-07-30
    /// </summary>
    public partial class upgradeaccount : AppActivityBasePage
    {
        protected bool IsOpenCgt = false;
        protected WXFundAccountInfo accountModel;
        protected UserBasicInfoInfo userModel;
        protected string headImage = "/imgs/users/avatar/bav_head.gif?v=20160714";

        protected void Page_Load(object sender, EventArgs e)
        {
            IsOpenCgt = ConfigHelper.getConfigString("IsOpenCGT") == "1";
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == Guid.Empty)
            {
                Response.Redirect("/Member/my_userdetailinfo.aspx");
            }
            if (!this.IsPostBack)
            {
                UserBLL bll = new UserBLL();
                userModel = bll.GetUserBasicInfoModelById(userId);
                if (userModel != null)
                {
                    if (!string.IsNullOrEmpty(userModel.HeadImage))
                        headImage = userModel.HeadImage;
                    //登录时判断超级会员是否过期
                    userModel.Level = BusinessDll.Users.JudgeUserLevel(userModel.Level.Value, userModel.LevelEndDate);
                }
                accountModel = bll.GetWXFundAccountInfo(userId);


            }
        }
    }
}