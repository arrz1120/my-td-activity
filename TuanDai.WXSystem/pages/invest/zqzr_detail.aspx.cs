﻿using Dapper;
using System;
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
    /// <summary>
    /// 债权转让标详情页
    /// Allen 2016-02-18
    /// </summary>
    public partial class zqzr_detail : BasePage
    {
        protected Guid projectId { get; set; }
        protected ProjectZQZRDetailInfo model { get; set; }
        private SubScriberansferBLL bll = null;
        protected int SubscribeUserCount = 0;//申购人数 
        protected UserBasicInfoInfo borrowUserInfo = null;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
            if (!IsPostBack)
            {
                
                bll = new SubScriberansferBLL();
                if (this.projectId != Guid.Empty)
                {
                    if (!this.GetData())
                    {
                        return;
                    }
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                }
            }
        }

        protected bool GetData()
        {
            model = bll.GetSubScriberansfer(projectId); 

            //获取项目信息
            DynamicParameters dyParams = new DynamicParameters();
            dyParams.Add("@id", projectId);
            string strSQL = "select top 1  SubscribeUserId from Subscribe with(nolock) where Id=(select m_FromSubscribeId from t_SubScribeTransfer  with(nolock) where m_id=@id)";
            var SubscribeUserId = PublicConn.QuerySingle<Guid?>(strSQL, ref  dyParams);

            dyParams = new DynamicParameters();
            dyParams.Add("@userid", SubscribeUserId);
            strSQL = "select * from UserBasicInfo with(nolock) where Id=@userid";
            borrowUserInfo = PublicConn.QuerySingle<UserBasicInfoInfo>(strSQL, ref  dyParams);

            //申购笔数
            strSQL = @"select COUNT(0)
						from dbo.Subscribe S with(nolock) 
						inner join UserBasicInfo C  with(nolock)  on S.SubscribeUserId=C.Id 
						inner join t_SubScribeTransfer as D  with(nolock) 
						on D.m_id=S.TranId
						where s.tranid=@ProjectId";
            dyParams = new DynamicParameters();
            dyParams.Add("@ProjectId", projectId);
            SubscribeUserCount = PublicConn.QuerySingle<int>(strSQL, ref dyParams);

            return true;
        }
    }
}