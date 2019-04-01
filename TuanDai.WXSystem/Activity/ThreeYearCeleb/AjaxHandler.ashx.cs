using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Tool;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using TuanDai.WXApiWeb.Common;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core;
using System.Data;

namespace TuanDai.WXApiWeb.Activity.ThreeYearCeleb
{
    /// <summary>
    ///  三周年庆典活动
    ///  Allen 2015-07-06
    /// </summary>
    public class AjaxHandler : SafeHandlerBase
    {
         

        #region 开始做蛋糕
        /// <summary>
        /// 开始做蛋糕
        /// </summary>
        public void StartDoCake()
        {
            PrintJson("-2", "您帐号在微信上未授权!");
            return;
            //改为从DB中读取活动起止日期
            GamePrizeInfo gprizeInfo = CelebHelper.GetPrizeInfor("FirstPrize");
            if (gprizeInfo != null)
            {
                CelebHelper.ActivityStartDate = gprizeInfo.ActivityStartDate;
                CelebHelper.ActivityEndDate = gprizeInfo.ActivityEndDate;
            }

            bool isLogin = WebUserAuth.IsAuthenticated;
            string code = WEBRequest.GetFormString("code");
            if (code.IsEmpty())
            {
                PrintJson("-2", "您帐号在微信上未授权!");
                return;
            } 
            if (DateTime.Now < CelebHelper.ActivityStartDate)
            {
                PrintJson("-3", "您来得太早了，<br/>活动还未开始!");
                return;
            }
            if (DateTime.Now > CelebHelper.ActivityEndDate) {
                PrintJson("-3", "您来得太晚了，<br/>活动已结束了!");
                return;
            }
            string ExtendOpenId = WEBRequest.GetFormString("ExtendKey");//推广人OpenId
            Guid? userId = WebUserAuth.UserId;
            bool isSelfUser = true; //是否自已在做蛋糕
            if (ExtendOpenId.IsNotEmpty())
            {
                isSelfUser = false;
                if (!CheckUserIsExists(ExtendOpenId))
                {
                    PrintJson("-2", "对不起，该邀请码无效！");
                    return;
                }
            }

            string HostOpenId = GetCurrentOpenId(code);
            //判断OpenId为空
            if (HostOpenId.IsEmpty()) {
                PrintJson("-2", "您帐号在微信上未授权!");
                return;
            }
            bool isDoCake = false;
            if (ExtendOpenId.IsNotEmpty())
            {
                //帮好友做蛋糕
                isDoCake = CheckUserHasDoCake(ExtendOpenId, HostOpenId);
            }
            else {
                isDoCake = CheckUserHasDoCake(HostOpenId, HostOpenId);
            }
            if (isDoCake)
            {
                string errMsg = "您已经做过蛋糕了!";
                if (isSelfUser == false)
                    errMsg = "您已帮好友做过一次蛋糕!";
                PrintJson("-1", errMsg);
                return;
            }

            ThirdLoginSDK sdk = new ThirdLoginSDK();
            sdk.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            //获取微信上用户信息
            TuanDai.WXApiWeb.Common.ThirdLoginSDK.WXOAuthUser wxUserInfo = sdk.GetWXUserSubscribeInfor(code);
            if (wxUserInfo == null || wxUserInfo.nickname.IsEmpty())
            {
                PrintJson("-2", "您帐号获取微信授权失败!");
                return;
            }

            string strSQL = "";
            bool IsAddSuccess = false;
            //给自已做蛋糕
            if (isSelfUser)
            {
                GamePrizeInfo prizeInfo = CelebHelper.GetPrizeInfor("RedPacket");
                if (prizeInfo == null)
                {
                    PrintJson("-4", "对不起，该活动参与人数已满,<br/>下次再参与吧!");
                    return;
                }

                #region 写入做蛋糕记录
//                using (SqlConnection connection = CelebHelper.OpenConnection(2))
//                {
//                    UserBLL userbll = new UserBLL();
//                    UserBasicInfoInfo userInfo = null;
//                    if (isLogin)
//                    {
//                        userInfo = userbll.GetUserBasicInfoModelById(userId.Value);
//                    }
//                    strSQL = @"insert into Activity_ThreeYearGame_Record(Id,UserId,UserName,NickName,WXOpenId,AddDate,CakeNum,ExpirationDate,GetPrizeDate)
//                               values(@Id,@UserId,@UserName,@NickName,@WXOpenId,@AddDate,@CakeNum,@ExpirationDate,@GetPrizeDate)";

//                    DynamicParameters dyParams = new DynamicParameters();
//                    dyParams.Add("@Id", Guid.NewGuid());
//                    if (userInfo != null)
//                    {
//                        dyParams.Add("@UserId", userInfo.Id);
//                        dyParams.Add("@UserName", userInfo.UserName);
//                        dyParams.Add("@NickName", userInfo.NickName);
//                        dyParams.Add("@ExpirationDate", null);//已登录时，奖品就已发送至团宝箱，这里没过期时间
//                    }
//                    else
//                    {
//                        dyParams.Add("@UserId", null);
//                        dyParams.Add("@UserName", "");
//                        dyParams.Add("@NickName", "");
//                        dyParams.Add("@ExpirationDate", CelebHelper.GetPrizeEndDate);
//                    }
//                    dyParams.Add("@WXOpenId", HostOpenId);
//                    dyParams.Add("@AddDate", DateTime.Now);
//                    dyParams.Add("@CakeNum", 0);
//                    if (userInfo != null)
//                        dyParams.Add("@GetPrizeDate", DateTime.Now);
//                    else
//                        dyParams.Add("@GetPrizeDate", null);

//                    IsAddSuccess = connection.Execute(strSQL, dyParams) > 0;

//                    //登录后将奖品自动插入我的团宝箱
//                    if (IsAddSuccess && userInfo != null)
//                    {
//                        CelebHelper.AddToMyPrize(prizeInfo, WebUserAuth.UserId.Value, false);
//                    }
//                }
                #endregion
            } 

            //往做蛋糕好友表中添加一笔
            AddOneFriendDataDelegate addFriend = new AddOneFriendDataDelegate(AddOneFriendData);
            if (isSelfUser)
            {
                //自已做蛋糕
                addFriend.Invoke(HostOpenId, HostOpenId, isLogin, wxUserInfo);
            }
            else
            {
                //好友做蛋糕
                addFriend.Invoke(ExtendOpenId, HostOpenId, isLogin, wxUserInfo);
            }
            string showMsg = "";
            if (isSelfUser)
                showMsg = "<p>恭喜您，参与成功！</p><p>获得<span class=\"c-ffde00\">10元</span>投资红包！</p><p style=\"text-align:center\">(详见\"我的奖品\")</p>";
            else
            {
                string friendNickName = GetFriendNickName(ExtendOpenId);
                showMsg = string.Format("<p>恭喜您！成功帮好友“{0}”做蛋糕!</p>", friendNickName.IsEmpty() ? "他" : friendNickName);
            }

            PrintJson("1", showMsg);
        }
        #endregion


        #region 蛋糕与投资排行榜
        //蛋糕排行榜前10名
        public void GetTopDoCakeUserRank()
        {
            string code = WEBRequest.GetFormString("code");
            int pageIndex = WEBRequest.GetFormInt("pageindex", 1);
            string selfOpenId = GetCurrentOpenId(code);
//            using (SqlConnection connection = CelebHelper.OpenConnection(2))
//            {

//               string strSQL = @"SELECT @total=COUNT(1) from Activity_ThreeYearGame_Record;
//                                WITH oa AS(
//                                   SELECT * FROM ( 
//                                        SELECT ROW_NUMBER() OVER(ORDER BY A.CakeNum DESC) AS RankNo, A.UserId,
//                                        CASE WHEN isnull(A.NickName,'')!='' THEN A.NickName ELSE (SELECT TOP 1  ISNULL(NickName,'未知') FROM Activity_ThreeYearGame_Friend sub WHERE sub.WXOpenId=A.WXOpenId and sub.WXOpenId=sub.FriendOpenId)  END AS NickName,
//                                        A.CakeNum, 
//                                        0 IsSelf, 0 as Tag
//                                        FROM Activity_ThreeYearGame_Record  A 
//                                    ) Main WHERE  Main.CakeNum>0 AND  Main.RankNo<=50
//                                    UNION ALL 
//                                    SELECT * FROM ( 
//                                        SELECT ROW_NUMBER() OVER(ORDER BY A.CakeNum DESC) AS RankNo, A.UserId, CASE WHEN isnull(A.NickName,'')!='' THEN A.NickName ELSE (SELECT TOP 1  ISNULL(NickName,'未知') FROM Activity_ThreeYearGame_Friend sub WHERE sub.WXOpenId=A.WXOpenId and sub.WXOpenId=sub.FriendOpenId) END AS NickName, 
//                                        A.CakeNum, 
//                                        CASE WHEN A.WXOpenId=@WXOpenId THEN 1 ELSE 0 END AS IsSelf, 1 as Tag
//                                        FROM Activity_ThreeYearGame_Record  A 
//                                   ) Main WHERE Main.IsSelf=1
//                                 )
//                                SELECT * FROM oa WHERE RankNo  between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize OR Tag=1
//                                ORDER BY Tag, cakenum DESC ";

//                DynamicParameters dyParams = new DynamicParameters();
//                dyParams.Add("@WXOpenId", selfOpenId);
//                dyParams.Add("@pageIndex", pageIndex);
//                dyParams.Add("@pageSize", 10);
//                dyParams.Add("@total", 0, DbType.Int32, ParameterDirection.Output);

//                List<TopUserCakeRank> dataList = new List<TopUserCakeRank>();
//                dataList = connection.Query<TopUserCakeRank>(strSQL, dyParams).ToList(); 

//                //获取总记录数 
//                int totalCount = dyParams.Get<int>("@total");
//                int pageCount = totalCount > 50 ? 5 : GetPageCount(totalCount, 10);

//                if (dataList.Any())
//                {
//                    var responseObj = new { status = "1", msg = "", list = dataList, pagecount = pageCount };
//                    PrintJson(responseObj);
//                }
//                else
//                {
//                    var responseObj = new { status = "0", msg = "没有找到数据!" };
//                    PrintJson(responseObj);
//                }
//            }
        }

        //投资排行榜前10名
        public void GetTopInvestUserRank() {
            string userId = "";
            string strSQL="";
            int pageIndex = WEBRequest.GetFormInt("pageindex", 1);
            if (WebUserAuth.IsAuthenticated)
            {
                userId = WebUserAuth.UserId.Value.ToString();
            }
            else
            {
                //根据OpenId反查询出用户ID
                string code = WEBRequest.GetFormString("code");
                string wxopenid = GetCurrentOpenId(code);
                //using (SqlConnection connection = CelebHelper.OpenConnection(2))
                //{
                //    strSQL = "select convert(varchar(40),UserId) as userid from Activity_ThreeYearGame_Record where WXOpenId=@WXOpenId";
                //    DynamicParameters dyParams = new DynamicParameters();
                //    dyParams.Add("@WXOpenId", wxopenid);
                //    userId = connection.Query<string>(strSQL, dyParams).FirstOrDefault();
                //}
            }
//            using (SqlConnection connection = CelebHelper.OpenConnection(1))
//            {
//                DateTime startDate = CelebHelper.ActivityStartDate;
//                DateTime endDate = CelebHelper.ActivityEndDate;


//                strSQL = @"SELECT @total=COUNT( DISTINCT A.SubscribeUserId) from Subscribe A WHERE A.TenderMode=6  AND  A.[Status]>1 AND  A.AddDate>=@StartDate AND A.AddDate<=@EndDate  ;
//                            WITH oa AS(
//                                SELECT * FROM (
//                                    SELECT ROW_NUMBER() OVER(ORDER BY sum(A.Amount) DESC) AS RankNo, A.SubscribeUserId AS UserId, C.NickName, 
//                                    sum(A.Amount) as Amount, 0 AS IsSelf, 0 AS Tag
//                                    FROM Subscribe  A  
//                                    INNER JOIN dbo.UserBasicInfo C ON C.Id=A.SubscribeUserId
//                                    WHERE A.TenderMode=6  AND  A.[Status]>1 AND  A.AddDate>=@StartDate AND A.AddDate<=@EndDate  
//                                    GROUP BY A.SubscribeUserId, C.NickName 
//                                ) Main WHERE Main.RankNo<=50
//                              UNION ALL
//                              SELECT * FROM (
//                                    SELECT ROW_NUMBER() OVER(ORDER BY sum(A.Amount) DESC) AS RankNo, A.SubscribeUserId AS UserId, C.NickName, 
//                                    sum(A.Amount) as Amount, CASE WHEN A.SubscribeUserId=@UserId THEN 1 ELSE 0 END AS IsSelf, 1 AS Tag
//                                    FROM Subscribe  A  
//                                    INNER JOIN dbo.UserBasicInfo C ON C.Id=A.SubscribeUserId
//                                    WHERE A.TenderMode=6  AND  A.[Status]>1 AND  A.AddDate>=@StartDate AND A.AddDate<=@EndDate  
//                                    GROUP BY A.SubscribeUserId, C.NickName 
//                                ) Main WHERE Main.IsSelf=1
//                            )
//                            SELECT * FROM oa WHERE RankNo  between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize OR Tag=1
//                            ORDER BY Tag, Amount DESC ";
 
//                DynamicParameters dyParams = new DynamicParameters();
//                dyParams.Add("@UserId", userId);
//                dyParams.Add("@StartDate", startDate);
//                dyParams.Add("@EndDate", endDate); 
//                dyParams.Add("@pageIndex", pageIndex);
//                dyParams.Add("@pageSize", 10);
//                dyParams.Add("@total", 0, DbType.Int32, ParameterDirection.Output);

//                List<TopUserInvestRank> dataList = new List<TopUserInvestRank>();
//                dataList = connection.Query<TopUserInvestRank>(strSQL, dyParams).ToList();

//                //获取总记录数 
//                int totalCount = dyParams.Get<int>("@total");
//                int pageCount = totalCount > 50 ? 5 : GetPageCount(totalCount, 10); 

//                if (dataList.Any())
//                {
//                    var responseObj = new { status = "1", msg = "", list = dataList, pagecount = pageCount };
//                    PrintJson(responseObj);
//                }
//                else
//                {
//                    var responseObj = new { status = "0", msg = "没有找到数据!" };
//                    PrintJson(responseObj);
//                }
//            }
        }
        #endregion

        #region 获取蛋糕数
        //获取当前有多少好友为活动发起者做了蛋糕
        public void GetSelfCakeNum()
        {
            string code = WEBRequest.GetFormString("code");
            string ExtendOpenId = WEBRequest.GetFormString("ExtendKey");
            //using (SqlConnection connection = CelebHelper.OpenConnection(2))
            //{
            //    string queryOpenId = "";
            //    if (ExtendOpenId.IsNotEmpty())
            //    {
            //        queryOpenId = ExtendOpenId;
            //    }
            //    else
            //    {
            //        queryOpenId = this.GetCurrentOpenId(code);
            //    }
            //    string strSQL = "select count(1) as cnt from Activity_ThreeYearGame_Friend where WXOpenId=@WXOpenId";
            //    DynamicParameters dyParams = new DynamicParameters();
            //    dyParams.Add("@WXOpenId", queryOpenId);
            //    int iCount = connection.Query<Int32>(strSQL, dyParams).Sum();
            //    PrintJson("1", iCount.ToString());
            //}
        }
        #endregion

        #region 获取我的奖品
        public void GetMyPrizeList() { 
           string code= WEBRequest.GetFormString("code");
           //using (SqlConnection connection = CelebHelper.OpenConnection(2))
           //{
           //    string queryOpenId = this.GetCurrentOpenId(code);
           //    string strSQL = "select *  from Activity_ThreeYearGame_WinRecord where {0} order by AddDate desc ";
           //    //PrizeName, MIN(AddDate)
           //    DynamicParameters dyParams = new DynamicParameters();
           //    string strWhere = "";
           //    if (WebUserAuth.IsAuthenticated)
           //    {
           //        strWhere = " UserId=@UserId";
           //        dyParams.Add("@UserId", WebUserAuth.UserId.Value);
           //    }
           //    else { 
           //        strWhere = " WXOpenId=@WXOpenId";
           //        dyParams.Add("@WXOpenId", queryOpenId);
           //    }
           //    strSQL = string.Format(strSQL, strWhere);
           //    List<UserWinPrizeInfo> dataList = connection.Query<UserWinPrizeInfo>(strSQL, dyParams).ToList();

           //    strSQL = " select * from Activity_ThreeYearGame_Record where WXOpenId=@WXOpenId and UserId is null  and ExpirationDate<=@ExpirationDate";
           //    dyParams = new DynamicParameters();
           //    dyParams.Add("@WXOpenId", queryOpenId);
           //    dyParams.Add("@ExpirationDate", CelebHelper.GetPrizeEndDate);
           //    GameRecordInfo recordInfo = connection.Query<GameRecordInfo>(strSQL, dyParams).FirstOrDefault();
           //    string jsonStr = ""; 
           //    bool isHasRedPacket = false;
           //    if (dataList.Any()) {
           //        foreach (UserWinPrizeInfo info in dataList)
           //        {
           //            if (info.PrizeName.IndexOf("10元投资红包") != -1 && isHasRedPacket) continue;
           //            string prizeName = "";
           //            if (info.PrizeName.IndexOf("智能手环") != -1)
           //                prizeName = " 获取" + info.PrizeName + "一块";
           //            else if (info.PrizeName.IndexOf("苹果6") != -1)
           //                prizeName = " 获取" + info.PrizeName + "一部";
           //            else if (info.PrizeName.IndexOf("苹果电脑") != -1)
           //                prizeName = " 获取" + info.PrizeName + "一台";
           //            else if (info.PrizeName.IndexOf("IPAD") != -1)
           //            {
           //                prizeName = " 获取" + info.PrizeName + "一台";
           //            }
           //            else
           //            {
           //                isHasRedPacket = true;
           //                prizeName = " 抽中10元投资红包";
           //            }
           //            jsonStr += "<li>" + info.AddDate.ToString("M月dd日HH:mm") + prizeName + "</li>";
           //        }
           //    }
           //    if (recordInfo != null && isHasRedPacket==false)
           //    {
           //        jsonStr += "<li>" + recordInfo.AddDate.ToString("M月dd日HH:mm") + " 抽中10元投资红包</li>";
           //    }
           //    if(jsonStr!="")
           //        this.PrintJson("1",jsonStr);
           //    else
           //        this.PrintJson("0", "");
           //}
        }
        #endregion

        #region 私有方法
        protected delegate bool AddOneFriendDataDelegate(string WXOpenId, string FriendOpenId, bool isLogin, ThirdLoginSDK.WXOAuthUser wxUserInfo);

        //写入一笔好友做蛋糕记录
        private bool AddOneFriendData(string WXOpenId, string FriendOpenId, bool isLogin, ThirdLoginSDK.WXOAuthUser wxUserInfo)
        {
            try
            {
//                using (SqlConnection connection = CelebHelper.OpenConnection(2))
//                {

//                    if (wxUserInfo == null)
//                    {
//                        wxUserInfo = new ThirdLoginSDK.WXOAuthUser() { sex = 0, nickname = "", };
//                    }
//                    //从微信端取不到数据时，就不插入到好友邀请表中
//                    if (wxUserInfo != null && wxUserInfo.nickname.ToText().IsEmpty())
//                        return false;

//                    //再加一次检测是否有做过
//                    bool isDoCake = CheckUserHasDoCake(WXOpenId, wxUserInfo.openid.ToText() != "" ? wxUserInfo.openid.ToText() : FriendOpenId);
//                    if (isDoCake)
//                        return false;

//                    string strSQL = @"insert into Activity_ThreeYearGame_Friend(Id, WXOpenId, FriendOpenId, MobileNo, NickName, HeadImage, AddDate, IsLogin, Sex, Province,City,IsSubscribe,SubscribeDate)
//                                      values(@Id, @WXOpenId, @FriendOpenId, @MobileNo, @NickName, @HeadImage, @AddDate, @IsLogin, @Sex, @Province, @City,@IsSubscribe,@SubscribeDate)";
//                    DynamicParameters dyParams = new DynamicParameters();
//                    dyParams.Add("@Id", Guid.NewGuid());
//                    dyParams.Add("@WXOpenId", WXOpenId);
//                    dyParams.Add("@FriendOpenId", wxUserInfo.openid.ToText() != "" ? wxUserInfo.openid.ToText() : FriendOpenId);
//                    dyParams.Add("@MobileNo", "");
//                    dyParams.Add("@NickName", wxUserInfo.nickname);
//                    dyParams.Add("@HeadImage", wxUserInfo.headimgurl);
//                    dyParams.Add("@Sex", wxUserInfo.sex);
//                    dyParams.Add("@Province", wxUserInfo.province);
//                    dyParams.Add("@City", wxUserInfo.city);
//                    dyParams.Add("@AddDate", DateTime.Now);
//                    dyParams.Add("@IsLogin", isLogin ? 1 : 0);
//                    dyParams.Add("@IsSubscribe", wxUserInfo.subscribe.ToString().IsIn("1", "0") ? wxUserInfo.subscribe : 0);

//                    //获取用户浏览器信息
//                    //string strAgent = "";
//                    //strAgent += string.Format("用户IP: {0}\r\n", Tool.WebFormHandler.GetIP());
//                    //strAgent += string.Format("用户浏览器: {0}\r\n", HttpContext.Current.Request.UserAgent); 
//                    //dyParams.Add("@UserAgent", strAgent);
//                    //关注时间
//                    if (wxUserInfo.subscribe_time > 0)
//                    {
//                        dyParams.Add("@SubscribeDate", CelebHelper.GetSubscribeDate(wxUserInfo.subscribe_time.ToString()));
//                    }
//                    else
//                    {
//                        dyParams.Add("@SubscribeDate", null);
//                    }
//                    bool isSuc = connection.Execute(strSQL, dyParams) > 0;

//                    if (isSuc)
//                    {
//                        //汇总好友做蛋糕次数
//                        // strSQL = "update Activity_ThreeYearGame_Record set CakeNum=ISNULL((select count(1) from Activity_ThreeYearGame_Friend sub where sub.WXOpenId=@WXOpenId),0) where WXOpenId=@WXOpenId";
//                        strSQL = "UPDATE Activity_ThreeYearGame_Record SET CakeNum=ISNULL(CakeNum,0)+1 WHERE WXOpenId=@WXOpenId";
//                        dyParams = new DynamicParameters();
//                        dyParams.Add("@WXOpenId", WXOpenId);
//                        connection.Execute(strSQL, dyParams);
//                    }
//                    return isSuc;
//                }
                return false;
            }
            catch (Exception ex)
            {
                BusinessDll.NetLog.WriteLoginHandler("添加好友资料时报错", ex.Message + " \r\n" + ex.StackTrace, "触屏版");
                return false;
            }
        }
       
        
        //判断当前用户是否有自已做过蛋糕
        public static bool CheckUserHasDoCake(string ExtendKey, string WXOpenId)
        {
            //using (SqlConnection connection = CelebHelper.OpenConnection(2))
            //{
            //    string strSQL = "select count(1) as cnt from Activity_ThreeYearGame_Friend where {0}";
            //    string strWhere = "FriendOpenId=@FriendOpenId and WXOpenId=@WXOpenId";
            //    DynamicParameters dyParams = new DynamicParameters();
            //    dyParams.Add("@WXOpenId", ExtendKey); 
            //    dyParams.Add("@FriendOpenId", WXOpenId); 
            //    strSQL = string.Format(strSQL, strWhere);
            //    return connection.Query<Int32>(strSQL, dyParams).Sum() > 0;
            //}
            return false;
        }
        //检查传入的邀请人是否存在
        private bool CheckUserIsExists(string ExtendKey) {
            //using (SqlConnection connection = CelebHelper.OpenConnection(2))
            //{
            //    string strSQL = " select count(1) as cnt from Activity_ThreeYearGame_Record where WXOpenId=@WXOpenId";
            //    DynamicParameters dyParams = new DynamicParameters();
            //    dyParams.Add("@WXOpenId", ExtendKey); 
            //    return connection.Query<Int32>(strSQL, dyParams).Sum() > 0;
            //}
            return false;
        }

        //获取当前用户的OpenId
        private string GetCurrentOpenId(string code)
        {
            ThirdLoginSDK sdkApi = new ThirdLoginSDK();
            sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            string HostOpenId = sdkApi.GetCookieOpenId(code);
            //if (GlobalUtils.OpenId.ToText().IsNotEmpty())
            //{
            //    HostOpenId = GlobalUtils.OpenId;
            //}
            //else
            //{
            //    HostOpenId = WeiXin.GetOpenid(code);
            //    GlobalUtils.WriteOpenIdToCookie(HostOpenId);
            //}
            return HostOpenId;
        }

        //获取好友昵称
        private string GetFriendNickName(string friendOpenId) {
//            using (SqlConnection connection = CelebHelper.OpenConnection(2))
//            {
//                string strSQL = @"SELECT CASE WHEN ISNULL(B.NickName,'')!='' THEN  B.NickName ELSE A.NickName END  AS NickName FROM dbo.Activity_ThreeYearGame_Record A
//                                  INNER JOIN dbo.Activity_ThreeYearGame_Friend B ON B.WXOpenId=A.WXOpenId AND B.WXOpenId=B.FriendOpenId
//                                  WHERE A.WXOpenId=@WXOpenId";
//                DynamicParameters dyParams = new DynamicParameters();
//                dyParams.Add("@WXOpenId", friendOpenId);
//                return connection.Query<string>(strSQL, dyParams).FirstOrDefault().ToText();
//            }
            return "";
        }

        /// <summary>
        /// 得到页数
        /// </summary>
        /// <returns></returns>
        private int GetPageCount(int totalItemCount, int pagesize)
        {
            double divide = totalItemCount / pagesize;
            double floor = System.Math.Floor(divide);
            if (totalItemCount % pagesize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数
            return pageCount;
        }
        #endregion

         
    }
}