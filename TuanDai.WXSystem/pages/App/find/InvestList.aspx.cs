using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.App.find
{
    public partial class InvestList : AppActivityBasePage
    {

        public int invitationCount = 0;
        protected Guid? userId;
        string extendkey = Tool.WEBRequest.GetString("extendkey");

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect(GlobalUtils.WebURL + "/pages/app/find/InvestList.aspx?extendkey="+extendkey);
            if (!this.IsPostBack && !string.IsNullOrEmpty(extendkey))
            {
                invitationCount = GetInvitationCount();
            }
        }

        /// <summary>
        /// 获取邀请人数
        /// add by linhelin 
        /// 2016-08-26
        /// </summary>
        /// <returns></returns>
        private int GetInvitationCount()
        {

            WebSettingInfo timeset = new WebSettingBLL().GetWebSettingInfo("CF25D857-6144-4242-AA51-1227D5918024");
            DateTime NewPartnerBeginDate = DateTime.Parse(timeset.Param1Value);
            DateTime NewPartnerEndDate = DateTime.Parse(timeset.Param2Value);

            int count = 0;

            string sql = @"SELECT COUNT(1)
                                FROM dbo.ExtenderRelation(nolock) r 
                                LEFT JOIN dbo.UserBasicInfo(nolock) u ON u.Id = r.UserId 
                                WHERE r.ExtenderKey =@extendkey AND r.AddDate >= @begintime --AND r.AddDate < @activityEndTime";

            Dapper.DynamicParameters whereParame = new Dapper.DynamicParameters();
            whereParame.Add("@extendkey", extendkey);
            whereParame.Add("@begintime", NewPartnerBeginDate);
            whereParame.Add("@activityEndTime", NewPartnerEndDate);
            count = PublicConn.QuerySingle<int?>(sql, ref whereParame) ?? 0;
            return count;
            
        }
    }
}