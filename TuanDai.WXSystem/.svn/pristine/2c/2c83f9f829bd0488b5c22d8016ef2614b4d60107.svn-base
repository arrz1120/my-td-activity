using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using Tool;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Dapper;

namespace TuanDai.WXApiWeb.Member.withdrawal
{
    public partial class withdrawal_suc : UserPage
    {
      
        protected UserBasicInfoInfo userModel;
        protected decimal Amout = 0;
        protected Guid userId;
        protected int DrawType = 2;
        protected void Page_Load(object sender, EventArgs e)
        {
            userId = WebUserAuth.UserId.Value;
            if (!IsPostBack)
            {
                UserBLL userBll = new UserBLL();
                userModel = userBll.GetUserBasicInfoModelById(userId);

                DrawType = WEBRequest.GetQueryInt("drawtype", 2);
                if (DrawType != 1 && DrawType != 2)
                    DrawType = 2;
                string strSQL = "select Id, ActualWithdrawDeposit, merchanType from AppWithdrewFund where UserId=@userId  order by AppDate desc";
                DynamicParameters dyParams=new DynamicParameters();
                dyParams.Add("@userId",userId);

                WXAppWithdrewFund appWith = PublicConn.QuerySingleWrite<WXAppWithdrewFund>(strSQL, ref dyParams); 
                if (appWith != null)
                {
                    Amout = appWith.ActualWithdrawDeposit ?? 0;
                    if (DrawType == 1)
                    {
                        strSQL = " update AppWithdrewFund set merchanType=9 where Id=@id";
                        dyParams = new DynamicParameters();
                        dyParams.Add("@id", appWith.Id);
                        PublicConn.ExecuteTD(PublicConn.DBWriteType.FundWrite, strSQL, ref dyParams);
                    }
                }
            }
        }
    }
}