﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.VipSystem.BLL;
using TuanDai.VipSystem.Model;
using TuanDai.VipSystem.Model.Entities;

namespace TuanDai.WXApiWeb.Member.Mall
{
    public partial class allTask : UserPage
    {
        public List<MTuanBiSetting> setting = null;
        /// <summary>
        /// 首次实名认证
        /// </summary>
        public bool IsRealName = false;
        /// <summary>
        /// 首次绑定手机
        /// </summary>
        public bool IsBindPhone = false;
        /// <summary>
        /// 首次验证邮箱
        /// </summary>
        public bool IsBindEmail = false;
        /// <summary>
        /// 首次绑定银行卡
        /// </summary>
        public bool IsBindBankCard = false;
        /// <summary>
        /// 首次设置交易密码
        /// </summary>
        public bool IsSetPayPassword = false;
        /// <summary>
        /// 首次完善个人信息
        /// </summary>
        public bool IsFinishPersonal = false;
        /// <summary>
        /// 首次充值
        /// </summary>
        public bool IsRecharge = false;
        /// <summary>
        /// 首次设置自动投标
        /// </summary>
        public bool IsSetAuto = false;
        /// <summary>
        /// 是否是App访问
        /// </summary>
        public bool IsApp = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            string url = "//mvip.tdw.cn" + Request.RawUrl;
            Context.Response.Redirect(url);
            return;
            var type = Tool.WEBRequest.GetString("type").ToLower();
            if (string.IsNullOrEmpty(type))
            {
                type = Tool.CookieHelper.GetCookie("TDW_WapType").ToLower();
            }
            IsApp = type == "mobileapp";

            setting = MTuanBiSettingBLL.GetTuanBiSettingByUserId(WebUserAuth.UserId.Value);
            setting = setting.OrderBy(o => o.HasFinish).ToList();
            if (setting != null)
            {
                //首次实名认证
                var setting1 = setting.Where(en => en.SubTypeId == 2).FirstOrDefault();
                IsRealName = setting1 == null ? false : setting1.HasFinish;
                //首次绑定手机
                var setting2 = setting.Where(en => en.SubTypeId == 3).FirstOrDefault();
                IsBindPhone = setting2 == null ? false : setting2.HasFinish;
                //首次绑定邮箱
                var setting3 = setting.Where(en => en.SubTypeId == 4).FirstOrDefault();
                IsBindEmail = setting3 == null ? false : setting3.HasFinish;
                //首次首次绑定银行卡
                var setting4 = setting.Where(en => en.SubTypeId == 5).FirstOrDefault();
                IsBindBankCard = setting4 == null ? false : setting4.HasFinish;
                //首次首次设置交易密码
                var setting5 = setting.Where(en => en.SubTypeId == 6).FirstOrDefault();
                IsSetPayPassword = setting5 == null ? false : setting5.HasFinish;
                //首次完善所有信息
                var setting6 = setting.Where(en => en.SubTypeId == 7).FirstOrDefault();
                IsFinishPersonal = setting6 == null ? false : setting6.HasFinish;
                //首次成功充值
                var setting7 = setting.Where(en => en.SubTypeId == 8).FirstOrDefault();
                IsRecharge = setting7 == null ? false : setting7.HasFinish;
                //首次设置自动投标并成功投资
                var setting8 = setting.Where(en => en.SubTypeId == 18).FirstOrDefault();
                IsSetAuto = setting8 == null ? false : setting8.HasFinish;
            }
            
        }
    }
}