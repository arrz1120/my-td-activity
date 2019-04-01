using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Tool;
using Kamsoft.Data.Dapper;
using System.Data.SqlClient;
using System.Data;
using TuanDai.WXSystem.Core;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXApiWeb.Activity;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// 高铁广告游戏处理
    /// Allen 2015-06-08
    /// </summary>
    public class HighSpeedGameAjax : SafeHandlerBase
    {

        //private readonly string sqlconnection = TuanDai.Config.BaseConfig.ConnectionString;
        //private readonly string sqlActivityConn = TuanDai.Config.BaseConfig.ActivityConnectionString;

        #region  高铁游戏抽奖
        //开始抽奖
        public void StartLottery()
        {
            Guid? userId = WebUserAuth.UserId;
            GamePrizeResultInfor resultObj = new GamePrizeResultInfor();
            resultObj.Msg = resultObj.Title = resultObj.PrizeName = "";
            //判断是否登陆，得到用户ID
            if (userId == Guid.Empty)
            {
                resultObj.Status = 2;
                resultObj.Msg = "对不起，你未登录，请先登录!";
                PrintJson(resultObj);
                return;
            }
            int starNum = WEBRequest.GetFormInt("StarNum", 0);
            
            if (starNum <= 0)
            {
                resultObj.Status = 0;
                resultObj.Msg = "对不起,您的财经敏感度为0,不能进行抽奖!";
                PrintJson(resultObj);
                return;
            }
            UserBLL userBll=new UserBLL();
            UserBasicInfoInfo userInfor= userBll.GetUserBasicInfoModelById(userId.Value);

            int isNewUser =0;

            var param = new DynamicParameters();
            param.Add("@userId", userId);
            param.Add("@userName", userInfor.UserName);
            param.Add("@StarNum", starNum);
            param.Add("@userAddDate", userInfor.AddDate);
            param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@PrizeId",Guid.Empty, System.Data.DbType.Guid, System.Data.ParameterDirection.Output);
            param.Add("@PrizeType", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@PrizeValue", 0, System.Data.DbType.Decimal, System.Data.ParameterDirection.Output);
            param.Add("@PrizeName", "", System.Data.DbType.String, System.Data.ParameterDirection.Output);
            param.Add("@TargetProductId", Guid.Empty, System.Data.DbType.Guid, System.Data.ParameterDirection.Output);
            param.Add("@IsNewUser", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@PrizeRecordId", Guid.Empty, System.Data.DbType.Guid, System.Data.ParameterDirection.Output);
            /*
            @userId UNIQUEIDENTIFIER , --申购人
	        @userName NVARCHAR(50) ,--申购人姓名 
	        @StarNum INT, --答题所得星星数
            @outStatus INT OUTPUT ,   --1:已中奖 -1:活动未开始 -2:活动未已结束 -3:无抽奖机会  -4:奖品已全部抽完  -5 未抽中奖品
            @PrizeId UNIQUEIDENTIFIER OUTPUT, --奖品ID
            @PrizeType INT OUTPUT,--奖品类型 
            @PrizeValue DECIMAL(18, 2) OUTPUT,--奖品价值
            @PrizeName NVARCHAR(200) OUTPUT , --中奖名称 
            @TargetProductId UNIQUEIDENTIFIER   OUTPUT --实物ID 
             */
            int status = 0, PrizeType=0; 
            string prizeName = "";
            Guid? PrizeId = null;
            Guid? TargetProductId = null;
            Guid? PrizeRecordId = null;
            decimal PrizeValue = 0;
            //using (SqlConnection connection = OpenConnection(2))
            //{
            //    connection.Execute("p_Activity_GetPrize_HighSpeedGame", param, null, null, CommandType.StoredProcedure);
            //    status = param.Get<int>("@outStatus");
            //    PrizeType = param.Get<int>("@PrizeType"); 
            //    prizeName = param.Get<string>("@PrizeName");
            //    PrizeId = param.Get<Guid?>("@PrizeId");
            //    TargetProductId = param.Get<Guid?>("@TargetProductId");
            //    PrizeValue = param.Get<decimal>("@PrizeValue");
            //    isNewUser = param.Get<int>("@IsNewUser");
            //    PrizeRecordId = param.Get<Guid?>("@PrizeRecordId");
            //    resultObj.IsNewUser = isNewUser;
            //    connection.Close();
            //    connection.Dispose();
            //}
            //if (status == 1)
            //{
            //    #region  写入团宝箱
            //    using (SqlConnection connection = OpenConnection(1))
            //    {
            //        try
            //        {
            //            //param = new DynamicParameters();
            //            //param.Add("@UserId", userId);
            //            //param.Add("@Type", PrizeType);
            //            //param.Add("@SubTypeId", 1);
            //            //param.Add("@ActivityCode", "20150619_" + PrizeRecordId.Value.ToString());//为了插入数据不重复,此处为两个值串联
            //            //param.Add("@PrizeName", prizeName);
            //            //param.Add("@PrizeValue", PrizeValue);
            //            //param.Add("@TargetProductId", TargetProductId);
            //            //param.Add("@Description", "高铁广告小游戏抽奖活动");
            //            ////0赠送失败，1赠送成功,-1提现券无库存
            //            //param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output); 
                       
            //            ////调用此过程必须要用到事务
            //            //connection.Execute("p_sendUserPrize", param, null, null, CommandType.StoredProcedure);
            //            //
                       
            //            SendUserPrizeInfo prizeInfo = new SendUserPrizeInfo();
            //            prizeInfo.UserId = userId.Value;
            //            prizeInfo.RuleId = Guid.Parse("d6f32f98-a85f-4180-b180-57f3bef8cfa2");//规则Id 
            //            prizeInfo.PrizeName = prizeName;
            //            prizeInfo.PrizeValue = PrizeValue;
            //            prizeInfo.Description = "高铁广告小游戏抽奖活动";
            //            int outStatus = -1;
            //            userBll.SendUserPrizeNew(prizeInfo, out outStatus);

            //            if (outStatus != 1)
            //            {
            //                //写入失败时，回滚之前数据
            //                status = -5;
            //                this.RollBackGamePrizeData(userId.Value, PrizeId.Value);
            //            } 
            //        }
            //        finally
            //        {
            //            connection.Close();
            //            connection.Dispose();
            //        }
            //    }
            //    #endregion
            //}
            //-- -1:活动未开始 -2:活动未已结束 -3:无抽奖机会  -4:奖品已全部抽完  -5 未抽中奖品  1:已中奖
            switch (status)
            {
                case 1:
                    {
                        //有抽到奖品
                        resultObj.Status = 1;
                        resultObj.IsPrized = 1;
                        resultObj.PrizeName = GetShowPrizeName(prizeName);
                        if (isNewUser == 0)
                        {
                            //老用户抽中奖
                            resultObj.Title = "恭喜您!";
                        }
                        else
                        {
                            resultObj.Title = "这次大发啦!!";
                        }
                    }
                    break;
                case -5:
                    {
                        resultObj.Status = 3;
                        if (isNewUser == 0)
                        {
                            //老用户抽中奖
                            resultObj.Title = "很遗憾!";
                            resultObj.PrizeName = "谢谢您的参与传递力量分享吧";
                        }
                        else
                        {
                            resultObj.Title = "恭喜您!";
                            resultObj.PrizeName = "获得团贷网388元新手现金红包";
                        }
                    }
                    break;
                case -1:
                    resultObj.Status = 0;
                    resultObj.Msg = "您来得太早了，活动还未开始!";
                    break;
                case -2:
                    resultObj.Status = 0;
                    resultObj.Msg = "对不起，您来晚了,活动已结束了!";
                    break;
                case -3:
                    resultObj.Status = 4;
                    resultObj.Msg = "每个账号只有一次机会，您已抽过奖!";
                    break;
                case -4:
                    resultObj.Status = 0;
                    resultObj.Msg = "您来晚了,奖品已全部抽完!";
                    break;
                case 0:
                    resultObj.Status = 0;
                    resultObj.Msg = "抽奖失败，请重试!";
                    break;
            }
             
            PrintJson(resultObj);
        }
        #endregion

        #region 回答问题
        public void AnswerQuestion()
        {
            int examId = WEBRequest.GetFormInt("ExamId", 0);
            string rightAnswer = WEBRequest.GetFormString("Answer");
            int chkResult = GameHelper.Instance.CheckAnswerIsRight(examId, rightAnswer);
            if (chkResult == -1) {
                PrintJson("-1","所答题目不存在!");
                return;
            }
            else if (chkResult == 0) {
                PrintJson("0", "答错了!");
                return;
            } 
            PrintJson("1", "恭喜您，答对了!");
        }
        #endregion


        #region 私有方法
        private string GetShowPrizeName(string prizeName) {
            if (prizeName.IndexOf("苹果6") != -1)
            {
                return "<span class='prize1'>获得苹果6PLUS</span></br>手机一台"; //"获得苹果6PLUS一台";
            }
            else {
                return string.Format("获得团贷网定制</br><span class='prize1'>{0}</span>一个", prizeName); // "获得团贷网定制"+prizeName+"一个";
            }
        }
        //回滚抽奖数据
        private void RollBackGamePrizeData(Guid userId, Guid prizeId)
        {
            //using (SqlConnection connection = OpenConnection(2))
            //{
            //    string strSQL = "DELETE FROM Activity_HighSpeedGame_Record WHERE UserId=@userId";
            //    var param = new DynamicParameters();
            //    param.Add("@userId", userId);
            //    if (connection.Execute(strSQL, param)>0) {
            //        param = new DynamicParameters();
            //        param.Add("@PrizeId", prizeId);
            //        strSQL = " UPDATE  dbo.Activity_HighSpeedGame_Prize  SET  PrizeNumber-= 1 WHERE  Id = @PrizeId";
            //        connection.Execute(strSQL, param);
            //    }
            //    connection.Close();
            //    connection.Dispose();
            //}
        } 

        //protected System.Data.SqlClient.SqlConnection OpenConnection(int tag=1)
        //{
        //    System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(tag == 1 ? sqlconnection : sqlActivityConn);
        //    connection.Open();
        //    return connection;
        //}

        private void PrintJson(GamePrizeResultInfor data) { 
            var jsonStr = JsonHelper.ToJson(data);
            this.Context.Response.Write(jsonStr);
            this.Context.Response.End();
        }
        #endregion

    }

    #region 内部类对象
    //高铁游戏抽奖结果
    public class GamePrizeResultInfor
    {
        public GamePrizeResultInfor() {
            IsNewUser = 0;
            IsPrized = 0;
        }

        //是否活动期间注册的新用户
        public int IsNewUser { get; set; }
        //是否中奖
        public int IsPrized { get; set; }
        /// <summary>
        /// 中奖品名称
        /// </summary>
        public string PrizeName { get; set; }
        /// <summary>
        /// 抽奖标题
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// 状态 0：检测不通过  1：已中奖  2:未登陆  3：未中奖 4:中奖机会已用完
        /// </summary>
        public int Status { get; set; }
        public string Msg { get; set; }
    }
   #endregion

}