﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL; 
using Dapper;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.RedisApi.Model;
using TuanDai.WXSystem.Core.Common;
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.Member
{
    public partial class my_userdetailinfo : UserPage
    {
        protected string headImage = "/imgs/users/avatar/bav_head.gif?v=20160714";
        protected WXFundAccountInfo accountModel;
        protected UserBasicInfoInfo userModel;
        protected UserBasicInfoExtInfo ExtModel;
        protected Guid userId;
        protected NewVipUserInfo UserVipModel = null;
        protected bool IsTenderNeedPayPassword = false;
        protected cgt_user_UserExt_Info CgtUser = null;
        protected RiskAssessmentInfo rInfo = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            //Response.Redirect(GlobalUtils.WebURL + "/Member/my_userdetailinfo.aspx");
            userId = WebUserAuth.UserId.Value;
            if (!this.IsPostBack)
            {
                InitFormData();
                rInfo = new UserRiskEvaluationBLL().GetAssassTimeThisYear(userId, TdConfig.ApplicationName);
            }
        }

        protected void InitFormData()
        {
            UserBLL bll = new UserBLL();
            userModel = bll.GetUserBasicInfoModelById(userId);
            ExtModel = bll.GetUserBasicInfoExtInfo(userId);
            if (!string.IsNullOrWhiteSpace(userModel.HeadImage))
            {
                headImage = userModel.HeadImage;
            }
            accountModel = bll.GetWXFundAccountInfo(userId);

            //获取紧急联系人信息
            UserBasicInfo_Ext _userBasicInfo_Ext = new UserBLL().GetEmergencyContact(userId);
            if (_userBasicInfo_Ext != null)
            {
                ExtModel.ContactName = _userBasicInfo_Ext.ContactName;
                ExtModel.ContactTelNo = _userBasicInfo_Ext.ContactTelNo;
                ExtModel.ContactRelationShip = _userBasicInfo_Ext.ContactRelationShip;
            }
            
            UserVipModel = this.GetNewVipUserInfo();
            UserSettingInfo UserSetting = new UserSettingBLL().GetUserSettingInfo(userId);
            if (UserSetting != null)
            {
                IsTenderNeedPayPassword = UserSetting.IsTenderNeedPayPassword;
            }

            //存管通用户
            CgtUser = new QueryClient().GetUserByPlatformUserNo(userId);
            if (GlobalUtils.IsBankService)
            {
                var bankInfo = new BankFromJavaService().GetBankInfo(userId, ServiceType.TuoMin);
                if (bankInfo != null && bankInfo.respData != null)
                {
                    userModel.OpenBankName = bankInfo.respData.openBankName;
                }
            }
        }
        private NewVipUserInfo GetNewVipUserInfo()
        {
            //p_GetUserLevelInfo 
            string strSQL = "SELECT [Level], LevelName FROM dbo.MUserVipInfo where UserId=@UserId ";
            var dyParams = new DynamicParameters();
            dyParams.Add("@UserId", userId);
            NewVipUserInfo vipUserInfo = PublicConn.QueryVipSingle<NewVipUserInfo>(strSQL, ref dyParams);
            if (vipUserInfo == null)
            {
                vipUserInfo = new NewVipUserInfo();
                vipUserInfo.Level = 1;
                vipUserInfo.LevelName = "投资学徒";
            }
            return vipUserInfo;
        }
        public class NewVipUserInfo
        {
            public int Level { get; set; }
            public string LevelName { get; set; }
        }

         
    }
}