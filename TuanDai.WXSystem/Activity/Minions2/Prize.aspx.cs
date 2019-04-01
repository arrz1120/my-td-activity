using Kamsoft.Data.Dapper;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.Minions2
{
    public partial class Prize : System.Web.UI.Page
    {
        /// <summary>
        /// 是否已经关注团贷网微信服务号.
        /// </summary>
        protected int isSubscribed;

        /// <summary>
        /// 是否已经登录.
        /// </summary>
        protected int isLogin;

        /// <summary>
        /// 是否曾经绑定过.
        /// </summary>
        protected int isEverBind;

        /// <summary>
        /// 活动开始时间.
        /// </summary>
        private string activityStartDate = "2015-09-07";


        /// <summary>
        /// 活动代码.
        /// </summary>
        private string activityCode = "Activity_Minions2_20150827";

        /// <summary>
        /// 总抽奖机会次数.
        /// </summary>
        protected int totalChances = 0;

        /// <summary>
        /// 剩余抽奖机会次数.
        /// </summary>
        protected int chances = 0;

        /// <summary>
        /// 该活动的获奖记录.
        /// </summary>
        protected IList<PrizeRecord> awards;

        /// <summary>
        /// 我的奖品.
        /// </summary>
        protected string myPrizes;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsPostBack) return;

            var code = Tool.WEBRequest.GetQueryString("code");
            var sdk = new ThirdLoginSDK();
            sdk.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);

            //获取微信上用户信息.
            var wxUserInfo = sdk.GetWXUserSubscribeInfor(code);

            this.awards = this.GetAwardRecords(this.activityCode).ToList();

            this.awards.Add(new PrizeRecord { NickName = "Dave", PrizeName = "10元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Stuart", PrizeName = "20元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Tim", PrizeName = "10元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Mark", PrizeName = "3D通兑券" });
            this.awards.Add(new PrizeRecord { NickName = "Phil", PrizeName = "10元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Jerry", PrizeName = "10元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Jorge", PrizeName = "20元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Kevin", PrizeName = "10元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Jon", PrizeName = "10元电影折扣券" });
            this.awards.Add(new PrizeRecord { NickName = "Bob", PrizeName = "10元电影折扣券" });

            this.isSubscribed = wxUserInfo.subscribe;
            this.isLogin = WebUserAuth.IsAuthenticated ? 1 : 0;
            this.myPrizes = "无";
            if (this.isLogin == 1)
            {
                var userId = WebUserAuth.UserId.Value;

                var action = this.Request.QueryString["Action"];
                if (action.IsNotEmpty())
                {
                    if (action == "GetPrize")
                    {
                        var result = this.GetPrize(userId);
                        if (result.Success)
                        {
                            var codes = result.GetParameter<string[]>("Codes");
                            var chances = result.GetParameter<int>("Chnaces");
                            var type = result.GetParameter<int>("Type");
                            var prizeName = result.GetParameter<string>("PrizeName");

                            this.PrintJson(new
                            {
                                result.Success,
                                result.Message,
                                Type = type,
                                PrizeName = prizeName,
                                Codes = codes,
                                Chances = chances
                            });
                        }
                        else
                        {
                            this.PrintJson(new { result.Success, result.Message });
                        }
                    }
                }

                var totalChances = this.GetPrizeChances(userId);
                var usedChances = this.GetUsedChances(userId, this.activityCode);

                this.totalChances = totalChances;
                this.chances = Math.Max(0, totalChances - usedChances);

                var prizes = this.GetUserPrizes(userId, this.activityCode).ToList();
                if (prizes.Count > 0)
                {
                    if (prizes.Count == 1) this.myPrizes = prizes[0].PrizeName;
                    if (prizes.Count == 2) this.myPrizes = prizes[0].PrizeName + "，" + prizes[1].PrizeName;
                }
                else
                {
                    this.myPrizes = "无";
                }
            }

        }

        /// <summary>
        /// 进行抽奖.
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        private ProcessResult GetPrize(Guid userId)
        {
            var result = new ProcessResult { Success = true };

            try
            {
                var totalChanges = this.GetPrizeChances(userId);
                var usedChanges = this.GetUsedChances(userId, this.activityCode);

                //检测是否还有抽奖机会.
                if (totalChanges <= usedChanges)
                {
                    result.Success = false;
                    result.Message = "抽奖机会已经用完!";
                    return result;
                }

                //进行抽奖.
                var procResult = this.ProcGetPrize(userId);
                if (procResult.Result != 1)
                {
                    result.Success = false;
                    result.Message = this.TranslateProcResult(procResult.Result);
                    return result;
                }

                //转换中奖结果.
                var codes = this.GenerateResult(procResult.PrizeName);

                result.AddParameter("Codes", codes);
                result.AddParameter("Chances", totalChances - 1);
                result.AddParameter("Type", procResult.Type);
                result.AddParameter("PrizeName", procResult.PrizeName);

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取用户可以获得的抽奖机会次数.
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        private int GetPrizeChances(Guid userId)
        {
            var changes = 0;

            //检测用户是否在活动之前曾经绑定过团贷网微信服务号.
            var everBind = this.CheckUserEverBindBefore(userId, this.activityStartDate);

            this.isEverBind = everBind ? 1 : 0;

            //检测用户是否在活动期间首次在微信服务号上绑定团贷网账号.
            if (!everBind && this.CheckUserBindBetween(userId, this.activityStartDate)) changes++;

            //检测用户是否在活动期间在微信服务号中单笔投资满188元.
            if (this.CheckUserInvestBetween(userId, this.activityStartDate, 188, 6)) changes++;

            return changes;
        }

        /// <summary>
        /// 进行抽奖.
        /// </summary>
        private ProcResult ProcGetPrize(Guid userId)
        {
            var result = new ProcResult();

            var parameters = new DynamicParameters();
            parameters.Add("@UserId", userId);
            parameters.Add("@PrizeName", "", System.Data.DbType.String, System.Data.ParameterDirection.Output);
            parameters.Add("@PrizeType", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            parameters.Add("@Result", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);

            //using (var connection = this.GetPortalConnection())
            //{
            //    connection.Execute("p_Activity_Minions2_SendPrize", parameters, null, null, CommandType.StoredProcedure);
            //    result.PrizeName = parameters.Get<string>("@PrizeName");
            //    result.Type = parameters.Get<int>("@PrizeType");
            //    result.Result = parameters.Get<int>("@Result");
            //}

            return result;
        }

        /// <summary>
        /// 翻译抽奖处理结果.
        /// </summary>
        /// <param name="result"></param>
        /// <returns></returns>
        private string TranslateProcResult(int result)
        {
            switch (result)
            {
                case -1: return "活动还未开始或活动已经结束！";
                case -2: return "不存在活动规则！";
                case -3: return "抽奖机会已经用完！";
                case -9: return "奖品已经被抽完！";
                default: return string.Empty;
            }
        }

        /// <summary>
        /// 生成中奖结果.
        /// </summary>
        /// <param name="prizeName"></param>
        /// <returns></returns>
        private string[] GenerateResult(string prizeName)
        {
            switch (prizeName)
            {
                case "3D通兑券": return new string[] { "3", "3", "3" };
                case "20元电影折扣券": return new string[] { "1", "1", "1" };
                case "10元电影折扣券": return new string[] { "2", "2", "2" };
                case "5元投资红包": return this.GenerateOther();
                default: return new string[] { "0", "0", "0" };
            }
        }

        /// <summary>
        /// 生成其他中奖结果.
        /// </summary>
        /// <returns></returns>
        private string[] GenerateOther()
        {
            var list = new List<string[]> {
                new string[] { "1", "1", "2" },
                new string[] { "1", "1", "3" },

                new string[] { "1", "2", "1" },
                new string[] { "1", "2", "2" },
                new string[] { "1", "2", "3" },

                new string[] { "1", "3", "1" },
                new string[] { "1", "3", "2" },
                new string[] { "1", "3", "3" },

                new string[] { "2", "1", "1" },
                new string[] { "2", "1", "2" },
                new string[] { "2", "1", "3" },

                new string[] { "2", "2", "1" },
                new string[] { "2", "2", "3" },

                new string[] { "2", "3", "1" },
                new string[] { "2", "3", "2" },
                new string[] { "2", "3", "3" },

                new string[] { "3", "1", "1" },
                new string[] { "3", "1", "2" },
                new string[] { "3", "1", "3" },

                new string[] { "3", "2", "1" },
                new string[] { "3", "2", "2" },
                new string[] { "3", "2", "3" },

                new string[] { "3", "3", "1" },
                new string[] { "3", "3", "2" },
            };

            var seed = new Random().Next(0, list.Count);
            return list[seed];
        }



        /// <summary>
        /// 返回Json.
        /// </summary>
        /// <param name="model"></param>
        private void PrintJson(object model)
        {
            var jsonString = JsonConvert.SerializeObject(model);
            this.Response.ContentType = "application/json";
            this.Response.Write(jsonString);
            this.Response.End();
        }

        /// <summary>
        /// 获取活动库数据库连接.
        /// </summary>
        /// <returns></returns>
        //private SqlConnection GetConnection()
        //{
        //    var connection = new SqlConnection(BaseConfig.ActivityConnectionString);
        //    connection.Open();

        //    return connection;
        //}

        ///// <summary>
        ///// 获取主库数据库连接.
        ///// </summary>
        ///// <returns></returns>
        //private SqlConnection GetPortalConnection()
        //{
        //    var connection = new SqlConnection(BaseConfig.ConnectionString);
        //    connection.Open();

        //    return connection;
        //}

        /// <summary>
        /// 检测用户是否曾经绑定过微信.
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startDate"></param>
        /// <returns></returns>
        private bool CheckUserEverBindBefore(Guid userId, string startDate)
        {
            var commandText = @"select count(0) from UserWXBindHistory 
                                where UserId = @UserId and Operation = @Operation and AddDate < @StartDate";

            //using (var connection = this.GetPortalConnection())
            //{
            //    var parameters = new { UserId = userId, Operation = "Bind", StartDate = startDate };
            //    return connection.Query<int>(commandText, parameters).Sum() > 0;
            //}
            return false;
        }

        /// <summary>
        /// 检测用户在某个日期区间是否绑定了微信.
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startDate"></param>
        /// <returns></returns>
        private bool CheckUserBindBetween(Guid userId, string startDate)
        {
            var commandText = @"select count(0) from UserWXBindHistory 
                                where UserId = @UserId and Operation = @Operation and AddDate >= @StartDate";

            //using (var connection = this.GetPortalConnection())
            //{
            //    var parameters = new { UserId = userId, Operation = "Bind", StartDate = startDate };
            //    return connection.Query<int>(commandText, parameters).Sum() > 0;
            //}
            return false;
        }


        /// <summary>
        /// 检测用户在某个日期区间是否以某种方式进行了满足某个金额的投资.
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="startDate"></param>
        /// <param name="amount"></param>
        /// <param name="tenderMode"></param>
        /// <returns></returns>
        private bool CheckUserInvestBetween(Guid userId, string startDate, decimal amount, int tenderMode)
        {
            var commandText = @"select count(0) from Subscribe 
                                where SubscribeUserId = @SubscribeUserId and AddDate >= @StartDate
                                and Amount >= @Amount and TenderMode = @TenderMode";

            //using (var connection = this.GetPortalConnection())
            //{
            //    var parameters = new { SubscribeUserId = userId, StartDate = startDate, Amount = amount, TenderMode = tenderMode };
            //    return connection.Query<int>(commandText, parameters).Sum() > 0;
            //}
            return false;
        }


        /// <summary>
        /// 获取用户在某个活动中已经使用了的抽奖机会次数.
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="activityCode"></param>
        /// <returns></returns>
        private int GetUsedChances(Guid userId, string activityCode)
        {
            var commandText = @"select count(0) from Activity_Record where ActivityCode = @ActivityCode and UserId = @UserId";

            //using (var connection = this.GetPortalConnection())
            //{
            //    var parameters = new { ActivityCode = activityCode, UserId = userId };
            //    return connection.Query<int>(commandText, parameters).Sum();
            //}
            return 0;
        }

        /// <summary>
        /// 获取某个用户在某个活动中获得的奖品.
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="activityCode"></param>
        /// <returns></returns>
        private IEnumerable<PrizeRecord> GetUserPrizes(Guid userId, string activityCode)
        {
            //var commandText = @"select PrizeName from UserPrize where UserId = @UserId and ActivityCode = @ActivityCode order by CreateDate";
            //using (var connection = this.GetPortalConnection())
            //{
            //    var parameters = new { UserId = userId, ActivityCode = activityCode };
            //    return connection.Query<PrizeRecord>(commandText, parameters);
            //}
            return new ArraySegment<PrizeRecord>();
        }

        /// <summary>
        /// 获取某个活动所有的领奖记录.
        /// </summary>
        /// <param name="activityCode"></param>
        /// <returns></returns>
        private IEnumerable<PrizeRecord> GetAwardRecords(string activityCode)
        {
            var commandText = @"select top 20 NickName, PrizeName from Activity_Record where ActivityCode = @ActivityCode and PrizeName in ('3D通兑券','20元电影折扣券','10元电影折扣券') order by AddDate desc";
            //using (var connection = this.GetPortalConnection())
            //{
            //    return connection.Query<PrizeRecord>(commandText, new { ActivityCode = activityCode });
            //}
            return new ArraySegment<PrizeRecord>();
        }

        /// <summary>
        /// 处理结果.
        /// </summary>
        private class ProcResult
        {
            public string PrizeName { get; set; }
            public int Type { get; set; }
            public int Result { get; set; }
        }

        /// <summary>
        /// 奖品记录.
        /// </summary>
        public class PrizeRecord
        {
            public string NickName { get; set; }
            public string PrizeName { get; set; }
        }

    }
}