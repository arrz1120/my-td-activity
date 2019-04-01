using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.Member.safety
{
    public partial class trade_password : UserPage
    {
        protected bool? IsTenderNeedPayPassword = false;
        protected int? vailStatus = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Guid userId = WebUserAuth.UserId.Value;
                UserBLL bll = new UserBLL();
                UserSettingInfo UserSetting = new UserSettingBLL().GetUserSettingInfo(userId);
                UserBasicInfoInfo basicinfo = bll.GetUserBasicInfoModelById(userId);
                vailStatus = getVailStatusByUserModel(basicinfo);
                if (UserSetting != null)
                {
                    IsTenderNeedPayPassword = UserSetting.IsTenderNeedPayPassword;
                }
            }
        }

        /// <summary>
        /// 根据用户实体类得到用户验证状态
        /// </summary>
        /// <param name="model"></param>
        /// <returns>返回用户状态 小于4：未通过实名认证 4：已通过实名认证 11：未修改昵称 12：未修改交易密码</returns>
        public int getVailStatusByUserModel(UserBasicInfoInfo model)
        {
            int vailStatus = 0;
            if (model != null)
            {
                if (string.IsNullOrEmpty(model.PayPwd) || model.PayPwd.ToLower() == model.Pwd.ToLower())//如果没有修改交易密码
                {
                    vailStatus = 12;
                }
            }
            return vailStatus;
        }
    }
}