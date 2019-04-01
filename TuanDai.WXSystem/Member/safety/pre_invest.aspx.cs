﻿using System;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class pre_invest : BasePage
    {
        protected UserBasicInfoInfo UserInfo = null;
        protected cgt_user_UserExt_Info CgtUser = null;

        protected cgt_user_UserExt_Info cgtmode=null;

        protected bool  isRealName = true;

        protected RedisApi.Model.RiskAssessmentInfo rInfo = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Guid userid = WebUserAuth.UserId.Value;
                UserBLL bll = new UserBLL();
                UserInfo = bll.GetUserBasicInfoModelById(userid);
                if (UserInfo == null)
                {
                    Response.Redirect("~/Member/my_account.aspx");
                    return;
                }
                CgtUser = new QueryClient().GetUserByPlatformUserNo(userid);
                //if (CgtUser == null)
                //{
                //    Response.Redirect("~/Member/my_userdetailinfo.aspx");
                //    return;
                //}
                GetShowQuanStatus();
                rInfo = new UserRiskEvaluationBLL().GetAssassTimeThisYear(userid, TdConfig.ApplicationName);
            }
        }

        /// <summary>
        /// 替换左边的东西为*号
        /// </summary>
        /// <param name="o">源数据</param>
        /// <returns></returns>
        protected string MaskLeftReplace(string o)
        {
            if (string.IsNullOrEmpty(o))
            {
                return "";
            }

            if (o.Length == 1) return o;
            if (o.Length == 2) return "*" + o.Substring(1);

            int startPotion = o.Length - 2;
            string maskstart = "";
            for (int i = 0; i < startPotion; i++)
            {
                maskstart += "*";
            }
            maskstart +=  o.Substring(startPotion);
            return maskstart;
        }

        /// <summary>
        /// 获取存管用户实体
        /// </summary>
        private void GetShowQuanStatus()
        {
            Guid userid = WebUserAuth.UserId.Value;
            cgtmode = new QueryClient().GetUserByPlatformUserNo(userid);
            if (cgtmode == null)
            {
                cgtmode = new cgt_user_UserExt_Info();
                cgtmode.accountStage = 1;
                cgtmode.isBindCard = false;
                cgtmode.isAllowRechare = false;
                isRealName = false;
            }
        }
    }
}