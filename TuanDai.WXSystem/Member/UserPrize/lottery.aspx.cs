﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.UserPrize
{
    public partial class lottery : UserPage
    {
        //protected List<WXUserPrizeListInfo> UserPrizeList;
        //UserBLL bll = new UserBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    Guid UserId = WebUserAuth.UserId.Value;
            //    UserPrizeList = bll.WXGetUserPrize(UserId, "5").ToList();
            //    foreach (WXUserPrizeListInfo item in UserPrizeList)
            //    {
            //        if (item.Description.Contains("|"))
            //        {
            //            string[] Strs = item.Description.Split(new char[] { '|' });
            //            item.Description = Strs[1];
            //        }
            //    }
            //}
        }
    }
}