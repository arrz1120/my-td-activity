using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using Tool;
using System.Data;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.ThreeYearCeleb
{
    /// <summary>
    /// 三周年庆典活动 处理类
    /// </summary>
    public class CelebHelper {
        //private readonly static string sqlconnection = TuanDai.Config.BaseConfig.ConnectionString;
        //private readonly static string sqlActivityConn = TuanDai.Config.BaseConfig.ActivityConnectionString;

        //活动开始时间
        public static DateTime ActivityStartDate = DateTime.Parse("2015-07-14 00:00:00");
        public static DateTime ActivityEndDate =  DateTime.Parse("2015-07-31 23:59:59");
        public static DateTime GetPrizeEndDate = DateTime.Parse("2015-08-20 23:59:59");
        static CelebHelper() {
            //改为从DB中读取活动起止日期
            GamePrizeInfo prizeInfo = CelebHelper.GetPrizeInfor("FirstPrize");
            if (prizeInfo != null)
            {
                CelebHelper.ActivityStartDate = prizeInfo.ActivityStartDate;
                CelebHelper.ActivityEndDate = prizeInfo.ActivityEndDate;
            }
        }

        //public static System.Data.SqlClient.SqlConnection OpenConnection(int tag = 1)
        //{
        //    System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(tag == 1 ? sqlconnection : sqlActivityConn);
        //    connection.Open();
        //    return connection;
        //}

        //获取指定类型的奖品记录
        public static GamePrizeInfo GetPrizeInfor(string prizeCode)
        {
            //using (SqlConnection connection = CelebHelper.OpenConnection(2))
            //{
            //    //限制数量
            //    string strSQL = "SELECT TOP 1 * FROM Activity_ThreeYearGame_Prize WHERE PrizeCode=@PrizeCode and UsePrizeNum<TotalPrizeNum";
            //    DynamicParameters dyParams = new DynamicParameters();
            //    dyParams.Add("@PrizeCode", prizeCode);
            //    return connection.Query<GamePrizeInfo>(strSQL, dyParams).FirstOrDefault();
            //}
            return new GamePrizeInfo();
        }
        /// <summary>
        /// 检查团宝箱中是否存在10元投资红包
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static bool CheckInvestRedPrizeIsExists(Guid userId)
        {
            //try
            //{
            //    using (SqlConnection connection = OpenConnection(1))
            //    {

            //        string strSQL = " SELECT COUNT(1) AS CNT FROM UserPrize WHERE ActivityCode LIKE '%201500714%' AND TypeId=3 AND SubTypeId=20 AND UserId=@UserId";
            //        DynamicParameters dyParams = new DynamicParameters();
            //        dyParams.Add("@UserId", userId);
            //        return connection.Query<Int32>(strSQL, dyParams).Sum() > 0; 
            //    }
            //}
            //catch (Exception ex) {
            //    BusinessDll.NetLog.WriteLoginHandler("应用系统错误:CheckInvestRedPrizeIsExists", ex.Message+" \r\n"+ex.StackTrace, "触屏版");
            //    return false;
            //}
            return false;
        }

        /// <summary>
        /// 发送奖品到团宝箱中
        /// </summary>
        /// <param name="prizeInfo"></param>
        /// <param name="userId"></param>
        /// <param name="IsAutoGet">是否自动领取</param>
        public static void AddToMyPrize(GamePrizeInfo prizeInfo, Guid userId, bool IsAutoGet)
        {
            string strSQL = "";
            int pStatus = 0;
            Guid prizeRecordId = Guid.NewGuid();
            bool isAddPrize = false;

            #region 写入中奖记录

//            using (SqlConnection connection = OpenConnection(2))
//            {
//                strSQL = " select WXOpenId from Activity_ThreeYearGame_Record where UserId=@UserId";
//                DynamicParameters dyParams = new DynamicParameters();
//                dyParams.Add("@UserId", userId);
//                string wxOpenId = connection.Query<string>(strSQL, dyParams).FirstOrDefault().ToText();

//                strSQL = @"insert into Activity_ThreeYearGame_WinRecord(Id,UserId,PrizeId,PrizeType,PrizeName,PrizeAmount,AddDate, WXOpenId)
//                               values(@Id,@UserId,@PrizeId,@PrizeType,@PrizeName,@PrizeAmount,@AddDate,@WXOpenId)";

//                dyParams = new DynamicParameters();
//                dyParams.Add("@Id", prizeRecordId);
//                dyParams.Add("@UserId", userId);
//                dyParams.Add("@PrizeId", prizeInfo.Id);
//                dyParams.Add("@PrizeType", prizeInfo.PrizeType);
//                dyParams.Add("@PrizeName", prizeInfo.PrizeName);
//                dyParams.Add("@PrizeAmount", prizeInfo.PrizeValue);
//                dyParams.Add("@AddDate", DateTime.Now); 
//                dyParams.Add("@WXOpenId", wxOpenId); 
//                isAddPrize = connection.Execute(strSQL, dyParams) > 0;
//                connection.Close();
//            }
            #endregion

            #region 插入团宝箱
            //if (isAddPrize)
            //{
            //    using (SqlConnection connection = OpenConnection(1))
            //    {
            //        try
            //        {

            //            //DynamicParameters dyParam = new DynamicParameters();
            //            //dyParam.Add("@UserId", userId);
            //            //dyParam.Add("@Type", prizeInfo.PrizeType);
            //            //dyParam.Add("@SubTypeId", prizeInfo.PrizeType == 9 ? 1: 20);
            //            //dyParam.Add("@ActivityCode", "201500714_" + prizeRecordId.ToString());//为了插入数据不重复,此处为两个值串联
                         
            //            //dyParam.Add("@PrizeName", prizeInfo.PrizeName);
            //            //dyParam.Add("@PrizeValue", prizeInfo.PrizeValue);
            //            //if (prizeInfo.TargetProductId.HasValue)
            //            //    dyParam.Add("@TargetProductId", prizeInfo.TargetProductId.Value);
            //            //else
            //            //    dyParam.Add("@TargetProductId", null);
            //            //if(prizeInfo.PrizeType==3)
            //            //    dyParam.Add("@Description", "团贷网三周年庆典-单笔投资满1000元即可使用10元,过期时间为:" + DateTime.Today.AddMonths(1).AddDays(-1).ToString("yyyy/MM/dd"));
            //            //else
            //            //    dyParam.Add("@Description", "团贷网三周年庆典");

            //            ////0赠送失败，1赠送成功,-1提现券无库存
            //            //dyParam.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);

            //            ////调用此过程必须要用到事务
            //            //connection.Execute("p_sendUserPrize", dyParam,null, null, CommandType.StoredProcedure); 
            //            //pStatus = dyParam.Get<int>("@outStatus"); 
            //        }
            //        catch (Exception ex)
            //        { 

            //        }
            //        finally
            //        {
            //            connection.Close();
            //            connection.Dispose();
            //        }
            //    }
            //}
            #endregion

            #region 更新奖品数量
            //if (pStatus == 1)
            //{
            //    using (SqlConnection connection = OpenConnection(2))
            //    {
            //        //写入成功时，更新奖品领用数量
            //        strSQL = " update Activity_ThreeYearGame_Prize set UsePrizeNum=isnull(UsePrizeNum,0)+1 where Id=@Id";
            //        DynamicParameters dyParam = new DynamicParameters();
            //        dyParam.Add("@Id", prizeInfo.Id);
            //        connection.Execute(strSQL, dyParam);
            //        connection.Close();
            //    }
            //}
            #endregion
        } 

        /// <summary>
        /// 时间戳转为C#格式时间
        /// </summary>
        /// <param name="timeStamp">Unix时间戳格式</param>
        /// <returns>C#格式时间</returns>
        public static DateTime GetSubscribeDate(string timeStamp)
        {
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp + "0000000");
            TimeSpan toNow = new TimeSpan(lTime);
            return dtStart.Add(toNow);
        }

    }

    #region Model对象
    /// <summary>
    /// 奖品对象
    /// </summary>
    public class GamePrizeInfo
    {
        /// <summary>
        /// 主键Id
        /// </summary>
        public Guid Id { get; set; }
        /// <summary>
        /// 奖品编号
        /// </summary>
        public string PrizeCode { get; set; }
        /// <summary>
        /// 奖品名称
        /// </summary>
        public string PrizeName { get; set; }
        /// <summary>
        /// 奖品价值
        /// </summary>
        public decimal PrizeValue { get; set; }
        /// <summary>
        /// 总数量
        /// </summary>
        public int TotalPrizeNum { get; set; }
        /// <summary>
        /// 已抽数量
        /// </summary>
        public int UsePrizeNum { get; set; }
        /// <summary>
        /// 活动开始时间
        /// </summary>
        public DateTime ActivityStartDate { get; set; }
        /// <summary>
        /// 活动结束时间
        /// </summary>
        public DateTime ActivityEndDate { get; set; }
        public int PrizeType { get; set; }
        /// <summary>
        /// 产品Id
        /// </summary>
        public Guid? TargetProductId { get; set; }
        /// <summary>
        /// 过期时间
        /// </summary>
        public DateTime ExpirationDate { get; set; }

    }

    /// <summary>
    /// 三周年庆典参与记录
    /// </summary>
    public class GameRecordInfo {
        public Guid Id { get; set; }
        public Guid? UserId { get; set; }
        public string UserName { get; set; }
        public string NickName { get; set; } 
        public string WXOpenId { get; set; }
        public DateTime AddDate { get; set; }
        public int CakeNum { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? GetPrizeDate { get; set; } 
    }

    /// <summary>
    /// 好友做蛋糕次数排行榜
    /// </summary>
    public class TopUserCakeRank
    {
        /// <summary>
        /// 排名
        /// </summary>
        public int RankNo { get; set; }
        /// <summary>
        /// 用户Id
        /// </summary>
        public Guid UserId { get; set; }
        /// <summary>
        /// 用户昵称
        /// </summary>
        public string NickName { get; set; }
        /// <summary>
        /// 做蛋糕次数
        /// </summary>
        public int CakeNum { get; set; }
        /// <summary>
        /// 是否自已
        /// </summary>
        public int IsSelf { get; set; }
    }

    /// <summary>
    /// 微信服务号投资排行榜
    /// </summary>
    public class TopUserInvestRank {
        /// <summary>
        /// 排名
        /// </summary>
        public int RankNo { get; set; }
        /// <summary>
        /// 用户Id
        /// </summary>
        public Guid UserId { get; set; }
        /// <summary>
        /// 用户昵称
        /// </summary>
        public string NickName { get; set; }
        /// <summary>
        /// 投资金额
        /// </summary>
        public decimal Amount { get; set; }
        /// <summary>
        /// 是否自已
        /// </summary>
        public int IsSelf { get; set; }
    }

    /// <summary>
    /// 用户获取记录
    /// </summary>
    public class UserWinPrizeInfo
    {
        public Guid Id { get; set; }
        public string WXOpenId { get; set; }
        public Guid UserId { get; set; }
        public Guid PrizeId { get; set; }
        public int PrizeType { get; set; }
        public string PrizeName { get; set; }
        public decimal PrizeAmount { get; set; }
        public DateTime AddDate { get; set; }
    } 
   
    #endregion

}