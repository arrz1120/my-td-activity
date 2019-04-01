using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class bindBankCardNew : UserPage
    {
        /// <summary>
        /// 电话号码
        /// </summary>
        protected string TelNo = string.Empty;
        /// <summary>
        /// 真实姓名
        /// </summary>
        protected string RealName = string.Empty;
        /// <summary>
        /// 验证状态
        /// </summary>
        protected int? vailStatus = 0;

        protected string rechargeMoney = string.Empty;
        protected string selectType = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (GlobalUtils.IsOpenCGT)
            {
                Response.Redirect("/Member/cgt/cgtBindCard.aspx");
            }
            rechargeMoney = Tool.CookieHelper.GetCookie("WxRechargeMoney");
            selectType = Tool.CookieHelper.GetCookie("WxRechargeType");
            if (!IsPostBack)
            {
                Guid userid = WebUserAuth.UserId.Value;
                UserBLL bll = new UserBLL();
                UserBasicInfoInfo userModel = bll.GetUserBasicInfoModelById(userid);
                if (userModel != null)
                {
                    TelNo = userModel.TelNo;
                    RealName = userModel.RealName;

                    //if ((!userModel.IsValidateIdentity || !userModel.IsValidateMobile) && (string.IsNullOrEmpty(userModel.PayPwd) || userModel.PayPwd.ToLower() == userModel.Pwd.ToLower()))//既没有身份认证又没有修改交易密码
                    //{
                    //    vailStatus = 0;
                    //}
                    if (!userModel.IsValidateIdentity)
                    {
                        //没有身份认证
                        vailStatus = 1;
                    }
                    else if (!userModel.IsValidateMobile) //没有手机认证
                    {
                        vailStatus = 3;
                    }
                    //else if (string.IsNullOrEmpty(userModel.PayPwd) ||
                    //          userModel.PayPwd.ToLower() == userModel.Pwd.ToLower()) //没有修改交易密码
                    //{
                    //    vailStatus = 2;
                    //}
                    else
                    { //验证通过
                        vailStatus = 4;
                    }
                }
            }
        }
    }
}