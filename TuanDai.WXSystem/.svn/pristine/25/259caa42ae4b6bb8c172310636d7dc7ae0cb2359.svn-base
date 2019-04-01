using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using BusinessDll; 
using System.Text;
using System.Data.Objects;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Activity.Invitation
{
    public partial class index : AppActivityBasePage
    {
        /// <summary>
        /// 邀请链接地址.
        /// </summary>
        protected string inviteUrl { get; set; }

        /// <summary>
        /// 是否已经登录.
        /// </summary>
        protected bool isAuthenticated { get; set; }

        protected string type = string.Empty;//触屏版:wx，APP:""

        protected void Page_Load(object sender, EventArgs e)
        {
            #region APP如果已经登陆,官网自动登陆
            string appActivityToken = Tool.WEBRequest.GetString("t");
            if (!string.IsNullOrEmpty(appActivityToken))
            {
                UserBasicInfoInfo model = new TuanDai.PortalSystem.BLL.AppUserTokenRecBLL().GetAppActivityUser(appActivityToken);
                if (model != null)
                {
                    WebUserAuth.SignIn(model.Id.ToString(), Page.Request.ToString());
                }
                else
                {
                    WebUserAuth.SignOut();
                }
            }
            #endregion

            type = Tool.WEBRequest.GetString("type","wx");
            this.isAuthenticated = WebUserAuth.IsAuthenticated;
            if (this.isAuthenticated)
            {
                //var database = JunTeEntities.Read();
                //var userId = WebUserAuth.UserId.Value;
                //var user = database.UserBasicInfo.First(p => p.Id == userId);

                ////获取注册链接地址.
                //this.inviteUrl = string.Format("{0}/user/Register.aspx?extendkey={1}", GlobalUtils.WebURL, user.ExtendKey);
            }
        }

        
    }
}