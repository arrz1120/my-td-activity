using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Activity.Invitation
{
    public partial class InvitationHistory_None : System.Web.UI.Page
    {
        /// <summary>
        /// 邀请链接地址.
        /// </summary>
        protected string inviteUrl { get; set; }
        /// <summary>
        /// 来源类型 wx:微信 APP：APP
        /// </summary>
        public string SourceType
        {
            get
            {
                return Tool.WEBRequest.GetString("type").ToLower();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (WebUserAuth.IsAuthenticated)
            {
                Guid userId = WebUserAuth.UserId.Value;
                UserBLL bll = new UserBLL();
                UserBasicInfoInfo info = bll.GetUserBasicInfoModelById(userId);
                string ExtendKey = info.ExtendKey;

                //获取注册链接地址.
                this.inviteUrl = string.Format("{0}/user/Register.aspx?extendkey={1}", GlobalUtils.WebURL, ExtendKey);
            }
        }
    }
}