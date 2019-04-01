using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.Model;
using Tool;
using TuanDai.PortalSystem.BLL; 

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 股票配资详情
    /// Allen 2015-05-16
    /// </summary>
    public partial class bond_detail : BasePage
    {
        protected ProjectDetailInfo model = null;
        protected UserBasicInfoInfo borrowUserInfo = null;
        protected Guid? projectId = Guid.Empty;
        protected WXUserCreditInfo userCreditInfo = null;
        private ProjectBLL bll = null;
        protected int lever = 2;
        protected int SubscribeUserCount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
             if (!IsPostBack) {

                 bll = new ProjectBLL();
                 if (this.projectId != Guid.Empty)
                 {
                     if (!this.GetData()) {
                         return;
                     }
                 }
                 else
                 {
                     Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                 }
            }
        }

        #region 加载数据
        protected bool GetData() {
            UserBLL userbll = new UserBLL();
            //获取项目信息
            model = bll.GetProjectDetailInfo(projectId.Value);
            if (model == null) {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }
          
            borrowUserInfo = userbll.GetUserBasicInfoModelById(model.UserId.Value);
            this.GetBorrowerData(); 
            WXProjectExpandInfo proExpend = bll.WXGetProjectExpandInfo(projectId.Value.ToText());
            if (proExpend != null)
            {
                lever = proExpend.Lever ?? 0;
            }
            SubscribeUserCount = GetSubscribeUserCount();
            return true;
        }
        protected int GetSubscribeUserCount()
        {
            //SubscribeBLL bll = new SubscribeBLL();
            //return bll.WXGetSubscribeUserCount(this.projectId.Value); 
            return TuanDai.WXApiWeb.Common.WXInvest.WXGetSubscribeUserCount(this.projectId.Value);
        }

        //获取用户信用档案
        private void GetBorrowerData()
        {
            userCreditInfo = bll.WXGetUserCreditInfo(model.UserId.Value);
        }
        #endregion



        #region 供前台调用
        /// <summary>
        /// 转换手机号码
        /// 
        protected string GetPhoneNumber(string telno)
        {
            if (string.IsNullOrEmpty(telno))
            {
                return "***";
            }
            else
            {
                string temp = telno.Substring(3, 5);
                return telno.Replace(temp, "*****");
            }
        }
        #endregion


    }
}