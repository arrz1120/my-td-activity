using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using TuanDai.PortalSystem.Model;
using Tool;
using TuanDai.PortalSystem.BLL;
using System.Data;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 债权转让申请 功能
    /// Allen 2016-02-25
    /// </summary>
    public partial class my_debt_apply : UserPage
    {
        public WebSettingInfo WebSettingEntity { get; set; }
        protected Guid TransferId { get; set; }
        protected ProjectDetailInfo model = null;
        protected double DiffDay = 0;//相隔天数
        public WebSettingInfo zqzrRateSet { get; set; } //债权转让限制
        public bool IsOpenRateLimit = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            TransferId = WEBRequest.GetGuid("Id"); 
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void LoadData() {
            ProjectBLL bll = new ProjectBLL();
            
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@SubscribeId", TransferId);
            dyParams.Add("@projectId", null, DbType.Guid, ParameterDirection.Output, 36);
            dyParams.Add("@addDate", null, DbType.DateTime, ParameterDirection.Output, 0);
            dyParams.Add("@refundedMonths", null, DbType.Int32, ParameterDirection.Output, 0);
            string strSQL = @"select @projectId=ProjectId, @addDate=AddDate,@refundedMonths= RefundedMonths FROM dbo.Subscribe WITH(NOLOCK) where Id=@SubscribeId";
            PublicConn.ExecuteTD(PublicConn.DBWriteType.Read, strSQL, ref dyParams);
            Guid projectId = dyParams.Get<Guid>("@projectId");
            //获取项目信息
            model = bll.GetProjectDetailInfo(projectId);
            DateTime investDate = dyParams.Get<DateTime>("@addDate");
            int refundedMonths = dyParams.Get<Int32>("@refundedMonths"); 
            string sql = string.Empty;
            if (model.RepaymentType.Value == 1)//到期还本息
            {
                sql = "SELECT dateDiff(day,@BeginDate,getdate())-1";
            }
            else
            {
                sql = "SELECT dateDiff(day,dbo.f_GetRepaymentAdvance_Date(@BeginDate,@Month),getdate())";
            }
            dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@BeginDate", investDate);
            dyParams.Add("@Month", refundedMonths);
            DiffDay = PublicConn.QuerySingle<int>(sql, ref dyParams);

            WebSettingBLL websetbll = new WebSettingBLL();
            WebSettingEntity = websetbll.GetWebSettingInfo("588B23C6-56EC-40C1-80A6-09B19C6F21E1");
            if (WebSettingEntity == null)
                WebSettingEntity = new WebSettingInfo();

            zqzrRateSet = websetbll.GetWebSettingInfo("63C10EF7-3961-4CA3-B277-147AAD8E7D42");
            if (zqzrRateSet.Param1Value == "1" && DateTime.Parse(zqzrRateSet.Param2Value) < DateTime.Now && DateTime.Now < DateTime.Parse(zqzrRateSet.Param3Value))
            {
                IsOpenRateLimit = true;
            }
        }
    }
}