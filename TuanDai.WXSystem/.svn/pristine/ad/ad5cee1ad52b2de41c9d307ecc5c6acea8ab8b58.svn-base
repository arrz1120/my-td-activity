using Kamsoft.Data.Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace TuanDai.WXApiWeb.Activity.XinXingFansMeetAndGreet
{
    public partial class Index : BasePage
    {
        protected string NickName = string.Empty;
        protected int count = 0;
        protected string strAction = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            strAction = WEBRequest.GetQueryString("action");
            if (strAction == "")
            {
                if (!IsPostBack)
                {
                    Guid? userId = WebUserAuth.UserId;
                    if (userId != Guid.Empty)
                    {
                        TuanDai.PortalSystem.BLL.UserBLL userbll = new PortalSystem.BLL.UserBLL();
                        TuanDai.PortalSystem.Model.UserBasicInfoInfo userInfo = userbll.GetUserBasicInfoModelById(userId.Value);
                        if (userInfo != null)
                            NickName = userInfo.NickName;
                        GetData(userId);
                    }
                }
            }
            else if (strAction == "GetFinanceDraw")
            {
                GetFinanceDraw();
            }
        }

        #region 窗体加载数据
        private void GetData(Guid? userId)
        {
            //using (IDbConnection conn = CreateReadConnection())
            //{
            //    string sqlText = @"select top 20 NickName,PrizeName,CONVERT(varchar(100), AddDate, 23) AddDate  from dbo.[20150705_XinXingFansMeetAndGreet_Prize_Record] where PrizeType!=-1  ORDER BY AddDate desc";
            //    List<DrawRecordInfo> list = SqlMapper.Query<DrawRecordInfo>(conn, sqlText, null).ToList();
            //    if (userId != Guid.Empty)
            //    {
            //        var parameter = new DynamicParameters();
            //        parameter.Add("@UserId", userId);
            //        int count2 = conn.Query<int>("select count(1) from TuanDai_Activity.dbo.[20150705_XinXingFansMeetAndGreet_Prize_Record] where UserId=@UserId", parameter).FirstOrDefault();
            //        int count3 = conn.Query<int>("select count(1) from dbo.[20150705_XinXingFansMeetAndGreet_Answer] where UserId=@UserId", parameter).FirstOrDefault();
            //        count = ((count2 == 1) || (count3 == 0)) ? 0 : 1; 
            //    }

            //    conn.Close();
            //    conn.Dispose();
            //}
        }
        #endregion

        #region 开始抽奖
        protected void GetFinanceDraw() {
            Response.ContentType = "application/json";
            try
            {
                DrawResult model = new DrawResult();
                Guid? userId = WebUserAuth.UserId;
                if (userId == Guid.Empty)
                {
                    model.Status = -99;
                }
                else
                {
                    TuanDai.PortalSystem.BLL.UserBLL userbll = new TuanDai.PortalSystem.BLL.UserBLL();

                    TuanDai.PortalSystem.Model.UserBasicInfoInfo userInfo = userbll.GetUserBasicInfoModelById(userId.Value);
                    if (userInfo == null)
                    {
                        model.Status = -99;
                        PrintJson(model);
                    }
                    var param = new DynamicParameters();
                    param.Add("@userId", userId);
                    param.Add("@NickName", userInfo.NickName);
                    param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                    param.Add("@PrizeName", "", System.Data.DbType.String, System.Data.ParameterDirection.Output);
                    param.Add("@PrizeType", -1, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
                    param.Add("@PrizeAmount", 0, System.Data.DbType.Decimal, System.Data.ParameterDirection.Output);
                    param.Add("@PrizeId", Guid.Empty, System.Data.DbType.Guid, System.Data.ParameterDirection.Output);
                    param.Add("@PrizeRecordId", Guid.Empty, System.Data.DbType.Guid, System.Data.ParameterDirection.Output);

                    //using (SqlConnection connection = CreateReadConnection())
                    //{
                    //    connection.Execute("p_activity_GetPrize_XinXingFansMeet", param, null, null,
                    //        CommandType.StoredProcedure);
                    //    model.Status = param.Get<int>("@outStatus");
                    //    model.PrizeName = param.Get<string>("@PrizeName");
                    //    model.PrizeType = param.Get<int>("@PrizeType");
                    //    model.PrizeAmount = param.Get<decimal>("PrizeAmount");
                    //    model.PrizeId = param.Get<Guid?>("@PrizeId");
                    //    model.PrizeRecordId = param.Get<Guid?>("@PrizeRecordId");
                    //    connection.Close();
                    //    connection.Dispose();
                    //}

                    if (model.Status == 1)
                    {
                        model.NickName = userInfo.NickName;
                        int subTypeId = 1;
                        string description = string.Empty;
                        if (model.PrizeType == 3)
                        {
                            subTypeId = 20;
                            description = string.Format("单笔投资满{0}元即可使用{1}元", model.PrizeAmount * 10, model.PrizeAmount);
                        }
                        else if (model.PrizeType == 10)
                        {
                            description = model.PrizeName;
                        }
                        else
                        {
                            description = "谢谢参与";
                        }
                        #region  写入团宝箱
                        if (model.PrizeType == 3 || model.PrizeType == 10)
                        {

                            TuanDai.PortalSystem.Model.SendUserPrizeInfo prizeInfo = new TuanDai.PortalSystem.Model.SendUserPrizeInfo();
                            prizeInfo.UserId = userId.Value;
                            string strRuleId = "";
                            if (model.PrizeType == 3)
                            {
                                if (model.PrizeAmount == 100)
                                    strRuleId = "4a00620e-934c-407b-8d94-28b0ec8a785f";
                                else if (model.PrizeAmount == 50)
                                    strRuleId = "5e12a736-bc66-4bd5-8f1a-e99ac134a77b";
                                else if (model.PrizeAmount == 10)
                                    strRuleId = "ddaddc5b-bb05-45bc-8242-8fb313373acf";
                                else if (model.PrizeAmount == 5)
                                    strRuleId = "b3b24200-e9df-4241-b94b-290be8185215";
                            }
                            else if (model.PrizeType == 10)
                            {
                                strRuleId = "05453294-23f7-4c19-bfe8-6f98e3c0d138";
                            }
                            if (strRuleId.IsNotEmpty())
                                prizeInfo.RuleId = Guid.Parse(strRuleId);//规则Id 
                            else
                                prizeInfo.RuleId = Guid.Empty;
                            prizeInfo.PrizeName = model.PrizeName;
                            prizeInfo.PrizeValue = model.PrizeAmount;
                            prizeInfo.Description = "信者行万里团粉见面会抽奖-" + description;
                            int pStatus = -1;
                            userbll.SendUserPrizeNew(prizeInfo, out pStatus);

                            if (pStatus != 1)
                            {
                                //写入失败时，回滚之前数据
                                model.Status = -5;
                                this.RollBackGamePrizeData(userId.Value, model.PrizeId.Value);
                            }
                        }
                        #endregion
                    }

                }
                model.CurrentDate = DateTime.Now.ToString("yyyy-MM-dd");
                PrintJson(model);
            }
            finally {
                Response.End();
            } 
        }
        private void RollBackGamePrizeData(Guid userId, Guid prizeId)
        {
            //using (SqlConnection connection = CreateReadConnection())
            //{
            //    string strSQL = " delete from [dbo].[20150705_XinXingFansMeetAndGreet_Prize_Record] where UserId=@UserId ";
            //    var param = new DynamicParameters();
            //    param.Add("@userId", userId);
            //    if (connection.Execute(strSQL, param) > 0)
            //    {
            //        param = new DynamicParameters();
            //        param.Add("@PrizeId", prizeId);
            //        strSQL = "update  [dbo].[20150705_XinXingFansMeetAndGreet_Prize] set PrizeNumber -= 1 where   Id = @PrizeId";
            //        connection.Execute(strSQL, param);
            //    }
            //    connection.Close();
            //    connection.Dispose();
            //}
        }
        #endregion


        #region 私有方法
        protected void PrintJson(object obj)
        {
            var jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(obj);
            Response.ClearContent();
            Response.Write(jsonString);
        }

        //protected SqlConnection CreateReadConnection()
        //{
        //    string connectionString = TuanDai.Config.BaseConfig.ActivityConnectionString;
        //    SqlConnection connection = new SqlConnection(connectionString);
        //    connection.Open();
        //    return connection;
        //}

        #endregion


        #region 私有Model
        public class DrawRecordInfo
        {
            public DateTime AddDate { get; set; }
            public string NickName { get; set; }
            public string PrizeName { get; set; }
        }
        public class DrawResult
        {
            public int Status { get; set; }
            public string PrizeName { get; set; }
            public string NickName { get; set; }
            public int PrizeType { get; set; }
            public Guid? PrizeId { get; set; }
            public decimal PrizeAmount { get; set; }
            public string CurrentDate { get; set; }
            public Guid? PrizeRecordId { get; set; }
            public string Error { get; set; }
        }
        #endregion

    }
}