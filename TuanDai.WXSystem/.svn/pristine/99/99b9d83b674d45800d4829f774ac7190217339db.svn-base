using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.WXApiWeb.Common;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using TuanDai.WXSystem.Core;
using System.Web.Services;
using System.Configuration;
using System.IO;

namespace TuanDai.WXApiWeb.Activity.GodWealth
{
    public partial class WealthPage : System.Web.UI.Page
    {
        protected string code { get; set; }
        protected string ExtendKey { get; set; }
        //自已的OpenId
        protected string SelfOpenId { get; set; }

        protected string GodHeadImage = "";
        protected string GodShowName = "";
        protected int FriendNum = 0;
        //当前页面显示状态  1:活动已结束 2:自已上传图片当财神爷界面 3.自已进来有当过财神爷
        //4:点好友链接领取好友红包,并自已可当财神 ，5:点好友链接，判断已领取过  6:红包已领完
        protected string UserStatus = "0";
        //当前红包状态 0：未领取  1:已领取未使用 2:红包已使用 3:红包已过期
        protected string RedPackedStatus = "1";

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = WEBRequest.GetQueryString("action");
            if (action == "")
            {
                code = WEBRequest.GetQueryString("code");
                ExtendKey = WEBRequest.GetQueryString("ExtendKey");
                if (!IsPostBack)
                {
                    this.InitPageData();
                    //前台不允许图像为空
                    if (GodHeadImage.IsEmpty())
                    {
                        GodHeadImage = "images/imgdone.jpg";
                    }
                    if (GodShowName.ToText().IsEmpty())
                    {
                        GodShowName = "团贷网";
                    }
                }
            }
            else if (action == "DoMakeWealthGod")
            {
                DoMakeWealthGod();
            }
            else if (action == "GetGodSendRedPacket")
            {
                GetGodSendRedPacket();
            }
        }

        #region 页面加载
        /*
          进来时逻辑判断：
         1.第一次直接扫码进来时，就显示上传图片界面。
         2.第二次扫码进来时，显示自已头像，显示好友个数。
         2.从第一位好友分享进来时。显示好友头像，再做相片
         3.从第二次好友分享进来时，显示自已头像，再加提示“红包已领取过”
         4. 活动已结束时，任何动作进来直接 显示自已头像，显示“活动已结束，感谢参与”
         5. 领取奖品结束时，自已进来时，显示“红包已过期”
         */

        private void InitPageData()
        {
            //读取活动的配置信息
            ActivityConfigInfo configInfo = GetActivityConfig();
            if (configInfo != null)
            {
                WealthPage.ActivityStartDate = configInfo.ActivityStartDate;
                WealthPage.ActivityEndDate = configInfo.ActivityEndDate;
            }

            ThirdLoginSDK sdkApi = new ThirdLoginSDK();
            sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            SelfOpenId = sdkApi.GetCookieOpenId(code);

            WealthPage.GodWealthRecordInfo wealthInfo  = WealthPage.GetUserGodWealthInfo(SelfOpenId);
            #region 活动已结束情况
            if (WealthPage.ActivityEndDate <= DateTime.Now)
            {
                this.UserStatus = "1";
                //活动已结束时，这里显示自已的头像，姓名 
                this.GetCaiShengInfo(wealthInfo);
                return;
            }
            #endregion 

            //判断奖品是否已发送完毕 (前提自已没有当过财神进来时才提示)
            if (configInfo == null || (wealthInfo == null && configInfo.UsePrizeNum >= configInfo.TotalPrizeNum))
            {
                //活动已结束时，这里显示自已的头像，姓名
                wealthInfo = WealthPage.GetUserGodWealthInfo(ExtendKey != "" ? ExtendKey : SelfOpenId);
                this.GetCaiShengInfo(wealthInfo);
                this.UserStatus = "6";
                return;
            }

            //自已直接进来或点自已分享链接时
            if (ExtendKey.IsEmpty()|| ExtendKey==SelfOpenId)
            {
                #region 自已做财神
                wealthInfo = WealthPage.GetUserGodWealthInfo(SelfOpenId);
                if (wealthInfo == null)
                {
                    this.UserStatus = "2";
                    return;
                }
                else
                {
                    this.UserStatus = "3";
                    this.GetCaiShengInfo(wealthInfo);
                    RedPackedStatus = CheckRedPacketStatus().ToString();
                }
                #endregion
            }
            else
            {
                #region 好友派发红包时
                WealthPage.GodWealthRecordInfo selfWealthInfo = WealthPage.GetUserGodWealthInfo(SelfOpenId);
                if (selfWealthInfo != null)
                {
                    //第二个好友分享后，点进来判断有领过红包
                    this.GetCaiShengInfo(selfWealthInfo);
                    this.UserStatus = "5";
                }
                else
                {
                    wealthInfo = WealthPage.GetUserGodWealthInfo(ExtendKey);
                    //如果财神爷数据找不到，就跳转
                    if (wealthInfo == null)
                    {
                        Response.Redirect(GlobalUtils.WebURL + "/Activity/GodWealth/AuthorIndex.aspx");
                        return;
                    }
                    this.UserStatus = "4";
                    this.GetCaiShengInfo(wealthInfo);
                }
                #endregion
            }
        }

        private void GetCaiShengInfo(GodWealthRecordInfo wealthInfo)
        {
            if (wealthInfo != null)
            {
                GodHeadImage = wealthInfo.GodImage;
                GodShowName = wealthInfo.ShowName;
                FriendNum = wealthInfo.FriendNum;
            }
        }
        #endregion


        #region 输出内容方法
        /// <summary>
        /// 打印json
        /// </summary>
        /// <param name="state"></param>
        /// <param name="msg"></param>
        protected  void PrintJson(string strstate, string strmsg)
        {
            var objData = new ResponseData() { result = strstate, msg = strmsg };
            var jsonStr = JsonHelper.ToJson(objData);
            Response.ClearContent();
            Response.Write(jsonStr); 
        }

        protected void PrintJson(object data)
        {
            var jsonString = JsonHelper.ToJson(data);
            Response.Write(jsonString); 
        }
        #endregion


        

        #region 上传头像
        private static System.Drawing.Image Base64ToImage(string base64Str)
        {
            if (base64Str.ToText().Trim().IsEmpty())
                return null;
            base64Str = base64Str.Replace(" ", "+");
            byte[] imageBytes = Convert.FromBase64String(base64Str);
            //读入MemoryStream对象
            MemoryStream memoryStream = new MemoryStream(imageBytes, 0, imageBytes.Length);
            memoryStream.Write(imageBytes, 0, imageBytes.Length);
            //转成图片
            System.Drawing.Image image = System.Drawing.Image.FromStream(memoryStream);
            return image;
        }

        protected static void Base64StringToImage(string strbase64, string filepath)
        {
            try
            {
                byte[] arr = Convert.FromBase64String(strbase64);
                MemoryStream ms = new MemoryStream(arr);
                System.Drawing.Bitmap bmp = new System.Drawing.Bitmap(ms);
                bmp.Save(filepath, System.Drawing.Imaging.ImageFormat.Jpeg);
                ms.Close();
            }
            catch (Exception ex)
            {
            }
        }
        private static bool SaveHeadImage(string base64, ref string imagePath)
        {

            imagePath = "";
            System.Drawing.Image imgFile = Base64ToImage(base64);
            if (imgFile == null)
                return false;
            string imageWcf = ConfigurationManager.AppSettings["ImageWcf"];


            MemoryStream stream = new MemoryStream();
            imgFile.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg); 
            BinaryReader br = new BinaryReader(stream);
            byte[] PhotoArray = stream.ToArray();
            stream.Close();


            string filePath = string.Format("Activity/GodWealth/{0}", DateTime.Now.ToString("yyyyMM"));
            string fileName = Guid.NewGuid().ToString() + ".jpg";

            string methodName = "UploadFile";
            object[] objects = new object[] { PhotoArray, filePath, fileName };
            try
            {
                object result = Tool.WebServiceHelper.InvokeWebService(imageWcf, methodName, objects);

                imagePath = result.ToText();
                return !result.ToText().IsEmpty();
            }
            catch (Exception ex)
            {
                BusinessDll.NetLog.WriteLoginHandler("财神爷活动上传图片出错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                return false;
            }
        }
        #endregion

        #region 自已当财神 
        public void DoMakeWealthGod()
        {
            try
            {
                Response.ContentType = "application/json";
                string nickName = this.Request.Form["nickName"];
                string base64Img = this.Request.Form["base64Img"];

                string godImagePath = "";
                //上传头像
                bool saveImg = SaveHeadImage(base64Img, ref godImagePath);
                if (!saveImg)
                {
                    PrintJson("-1", "上传头像失败!");
                    return;
                }

                if (DateTime.Now < WealthPage.ActivityStartDate)
                {
                    PrintJson("-3", "您来得太早了，活动还未开始!");
                    return;
                }
                if (DateTime.Now > WealthPage.ActivityEndDate)
                {
                    PrintJson("-3", "您来得太晚了，活动已结束了!");
                    return;
                }


                ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                string OpenId = sdkApi.GetCookieOpenId("");
                if (OpenId.IsEmpty())
                {
                    PrintJson("-2", "微信授权失败，请重试！");
                    return;
                }
                bool isLogin = WebUserAuth.IsAuthenticated;
                Guid? userId = WebUserAuth.UserId;
//                using (SqlConnection connection = WealthPage.OpenConnection(2))
//                {
//                    string strSQL = " select count(1) as cnt from Activity_GodWealth_Record where WXOpenId=@WXOpenId";
//                    DynamicParameters dyParams = new DynamicParameters();
//                    dyParams.Add("@WXOpenId", OpenId);
//                    int iCount = connection.Query<Int32>(strSQL, dyParams).FirstOrDefault();
//                    if (iCount > 0)
//                    {
//                        PrintJson("-1", "您已做过一回财神!");
//                        return;
//                    }

//                    strSQL = @" insert into Activity_GodWealth_Record(Id,UserId,UserName,WXOpenId,ShowName,GodImage,FriendNum,AddDate,ExpirationDate,GetPrizeDate,IsGetPrize)
//                                values(@Id,@UserId,@UserName,@WXOpenId,@ShowName,@GodImage,@FriendNum,@AddDate,@ExpirationDate,@GetPrizeDate,@IsGetPrize)";
//                    dyParams = new DynamicParameters();
//                    dyParams.Add("@Id", Guid.NewGuid());
//                    dyParams.Add("@UserId", null);
//                    dyParams.Add("@UserName", "");
//                    dyParams.Add("@WXOpenId", OpenId);
//                    dyParams.Add("@ShowName", nickName);
//                    dyParams.Add("@GodImage", godImagePath);
//                    dyParams.Add("@FriendNum", 0);
//                    dyParams.Add("@AddDate", DateTime.Now);
//                    dyParams.Add("@ExpirationDate", DateTime.Today.AddMonths(1));
//                    dyParams.Add("@GetPrizeDate", null);
//                    dyParams.Add("@IsGetPrize", 0);
//                    bool isSuccess = connection.Execute(strSQL, dyParams) > 0;
//                    if (isSuccess)
//                    {
//                        var responseObj = new { result = "1", NickName = nickName, GodImage = godImagePath };
//                        PrintJson(responseObj);
//                        return;
//                    }
//                    else
//                    {
//                        PrintJson("-1", "做财神失败，请重试!");
//                        return;
//                    }
//                }
            }
            catch (Exception ex)
            {
                PrintJson("-1", "做财神失败，请重试!");
                BusinessDll.NetLog.WriteLoginHandler("财神爷活动上传图片出错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
            }
            finally {
                Response.End();
            }
        }
        #endregion

        #region 获取派发给我的红包 
        public void GetGodSendRedPacket()
        {
            try
            {
                Response.ContentType = "application/json";
                string ExtendOpenId = WEBRequest.GetFormString("extendkey"); //财神爷OpenId 

                if (DateTime.Now < WealthPage.ActivityStartDate)
                {
                    PrintJson("-3", "您来得太早了，活动还未开始!");
                    return;
                }
                if (DateTime.Now > WealthPage.ActivityEndDate)
                {
                    PrintJson("-3", "您来得太晚了，活动已结束了!");
                    return;
                }

                if (ExtendOpenId.IsNotEmpty())
                {
                    if (!WealthPage.CheckGodIsExists(ExtendOpenId))
                    {
                        PrintJson("-3", "对不起，该财神爷不存在！");
                        return;
                    }
                }
                ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                string OpenId = sdkApi.GetCookieOpenId("");

                bool isGetHisPrize = WealthPage.CheckUserHasGetRedPacket(ExtendOpenId, OpenId);
                if (isGetHisPrize)
                {
                    //这里必须要判断自已是否有做过财神，不然没法得到红包
                    WealthPage.GodWealthRecordInfo wealthInfo = WealthPage.GetUserGodWealthInfo(SelfOpenId);
                    if (wealthInfo != null)
                        PrintJson("-2", "对不起，您已经领过他派的红包！");
                    else
                        PrintJson("1", "");
                    return;
                }
//                using (SqlConnection connection = WealthPage.OpenConnection(2))
//                {
//                    string strSQL = @"insert into Activity_GodWealth_Friend(Id,WXOpenId,FriendOpenId,UserAgent,AddDate)
//                                  values(@Id,@WXOpenId,@FriendOpenId,@UserAgent,@AddDate)";

//                    DynamicParameters dyParams = new DynamicParameters();
//                    dyParams.Add("@Id", Guid.NewGuid());
//                    dyParams.Add("@WXOpenId", ExtendOpenId);
//                    dyParams.Add("@FriendOpenId", OpenId);
//                    //获取用户浏览器信息
//                    string strAgent = "";
//                    strAgent += string.Format("用户IP: {0}\r\n", Tool.WebFormHandler.GetIP());
//                    strAgent += string.Format("用户浏览器: {0}\r\n", HttpContext.Current.Request.UserAgent);
//                    dyParams.Add("@UserAgent", strAgent);
//                    dyParams.Add("@AddDate", DateTime.Now);
//                    int iCount = connection.Execute(strSQL, dyParams);
//                    //领取成功时，更新财神爷派发个数
//                    if (iCount > 0)
//                    {
//                        strSQL = " update Activity_GodWealth_Record set FriendNum=isnull(FriendNum,0)+1 where WXOpenId=@WXOpenId";
//                        dyParams = new DynamicParameters();
//                        dyParams.Add("@WXOpenId", ExtendOpenId);
//                        connection.Execute(strSQL, dyParams);
//                    }
//                }
                PrintJson("1", "");
            }
            catch (Exception ex)
            {
                BusinessDll.NetLog.WriteLoginHandler("财神爷活动上传图片出错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                PrintJson("0", "获取红包失败！");
            }
            finally
            {
                Response.End();
            }
        }
        #endregion


        #region 内部Model对象
        [Serializable]
        internal class ResponseData
        {
            public string result { get; set; }
            public string msg { get; set; }
        }
        /// <summary>
        /// 用户当财神爷记录
        /// </summary>
        public class GodWealthRecordInfo
        {
            public string ShowName { get; set; }
            public string GodImage { get; set; }
            public int FriendNum { get; set; }
            public Guid? UserId { get; set; }
            public string UserName { get; set; }
            public string WXOpenId { get; set; }
            public DateTime? AddDate { get; set; }
            public DateTime? ExpirationDate { get; set; }
            public DateTime? GetPrizeDate { get; set; }
            public bool IsGetPrize { get; set; }
        }

        //活动配置信息
        public class ActivityConfigInfo
        {
            public DateTime ActivityStartDate { get; set; }
            public DateTime ActivityEndDate { get; set; }
            /// <summary>
            /// 总共数量
            /// </summary>
            public int TotalPrizeNum { get; set; }
            /// <summary>
            /// 已领取数量
            /// </summary>
            public int UsePrizeNum { get; set; }
        }
        //团宝箱信息
        public class UserPrizeInfo {
            public bool IsReceive { get; set; }
            public bool IsUsed { get; set; } 
        }
        #endregion

        #region 外部调用方法
        //private readonly static string sqlconnection = TuanDai.Config.BaseConfig.ConnectionString;
        //private readonly static string sqlActivityConn = TuanDai.Config.BaseConfig.ActivityConnectionString;

        //活动开始时间
        public static DateTime ActivityStartDate = DateTime.Parse("2015-09-11 00:00:00");
        public static DateTime ActivityEndDate = DateTime.Parse("2016-12-31 23:59:59"); 

        
        /// <summary>
        /// 创建连接对象
        /// </summary>
        /// <param name="tag">数据库对象 1:官网主库 2:活动库</param>
        /// <returns></returns>
        //public static System.Data.SqlClient.SqlConnection OpenConnection(int tag = 1)
        //{
        //    System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(tag == 1 ? sqlconnection : sqlActivityConn);
        //    connection.Open();
        //    return connection;
        //}
        /// <summary>
        /// 获取本次活动的配置
        /// </summary>
        /// <returns></returns>
        public static ActivityConfigInfo GetActivityConfig()
        {
            //using (SqlConnection connection = WealthPage.OpenConnection(1))
            //{
            //    string strSQL = "SELECT TOP 1 ActivityStartDate,ActivityEndDate,isnull(TotalPrizeNum,0) as TotalPrizeNum, isnull(UsePrizeNum,0) as UsePrizeNum FROM Activity_Prize WHERE ActivityCode='20150820'";
            //    ActivityConfigInfo result = connection.Query<ActivityConfigInfo>(strSQL, null).FirstOrDefault();
            //    return result;
            //}
            return new ActivityConfigInfo();
        }
        /// <summary>
        /// 更新奖品发送数量
        /// </summary>
        public static void UpdateUsedPrizeNum()
        {
            //using (SqlConnection connection = WealthPage.OpenConnection(1))
            //{
            //    string strSQL = " UPDATE  Activity_Prize SET  UsePrizeNum=isnull(UsePrizeNum,0)+1  WHERE ActivityCode='20150820'";
            //    connection.Execute(strSQL, null);
            //}
        } 

        /// <summary>
        /// 获取用户当财神爷信息
        /// </summary>
        /// <param name="openId"></param>
        /// <returns></returns>
        public static GodWealthRecordInfo GetUserGodWealthInfo(string openId)
        {
//            using (SqlConnection connection = WealthPage.OpenConnection(2))
//            {
//                string strSQL = @"select ShowName,GodImage, isnull(FriendNum,0) as FriendNum,UserId,UserName,WXOpenId,AddDate,
//                                  ExpirationDate,GetPrizeDate, isnull(IsGetPrize,0) as IsGetPrize
//                                  from Activity_GodWealth_Record 
//                                  where WXOpenId=@OpenId";
//                DynamicParameters dyParams = new DynamicParameters();
//                dyParams.Add("@OpenId", openId);
//                GodWealthRecordInfo result = connection.Query<GodWealthRecordInfo>(strSQL, dyParams).FirstOrDefault();
//                return result;
//            }
            return new GodWealthRecordInfo();
        }  

        public static bool CheckGodIsExists(string godOpenId)
        {
            //using (SqlConnection connection = WealthPage.OpenConnection(2))
            //{
            //    string strSQL = "SELECT  count(1) as cnt FROM Activity_GodWealth_Record WHERE WXOpenId=@WXOpenId";
            //    DynamicParameters dyParams = new DynamicParameters();
            //    dyParams.Add("@WXOpenId", godOpenId);
            //    return connection.Query<Int32>(strSQL, dyParams).FirstOrDefault() > 0;
            //}
            return false;
        }
        //判断当前用户是否领取
        public static bool CheckUserHasGetRedPacket(string ExtendKey, string WXOpenId)
        {
            //using (SqlConnection connection = WealthPage.OpenConnection(2))
            //{
            //    string strSQL = "select count(1) as cnt from Activity_GodWealth_Friend where WXOpenId=@WXOpenId and FriendOpenId=@FriendOpenId";

            //    DynamicParameters dyParams = new DynamicParameters();
            //    dyParams.Add("@WXOpenId", ExtendKey);
            //    dyParams.Add("@FriendOpenId", WXOpenId);
            //    return connection.Query<Int32>(strSQL, dyParams).Sum() > 0;
            //}
            return false;
        }
        //检测此次活动红包状态
        public static int  CheckRedPacketStatus() {
            try
            {

                //若没有登录，则根据OpenId先去活动表中查询Userid
                string openId = GlobalUtils.OpenId;
                if (openId.IsEmpty())
                    return 0;

                GodWealthRecordInfo recordInfo = GetUserGodWealthInfo(openId);
                if (recordInfo == null || recordInfo.UserName.ToText().IsEmpty())
                    return 0;

                if (recordInfo.ExpirationDate == null || recordInfo.ExpirationDate.HasValue == false)
                {
                    #region
                    //using (SqlConnection connection = WealthPage.OpenConnection(1))
                    //{
                    //    string strSQL = " SELECT IsUsed, IsReceive FROM UserPrize WITH(NOLOCK) WHERE  RuleId='918f88a9-f3f7-4687-b239-8db70c4e483b' AND UserId=@UserId";
                    //    DynamicParameters dyParams = new DynamicParameters();
                    //    if (WebUserAuth.IsAuthenticated)
                    //    {
                    //        //判断有登录时，根据UserId查询
                    //        dyParams.Add("@UserId", WebUserAuth.UserId.Value);
                    //    }
                    //    else
                    //    {
                    //        //若没有登录，则根据OpenId先去活动表中查询Userid 
                    //        using (SqlConnection con = WealthPage.OpenConnection(2))
                    //        {
                    //            string tmpSQL = "select top 1 UserId from Activity_GodWealth_Record where WXOpenId=@WXOpenId";
                    //            DynamicParameters tmpParams = new DynamicParameters();
                    //            tmpParams.Add("@WXOpenId", openId);
                    //            Guid? userId = con.Query<Guid?>(tmpSQL, tmpParams).FirstOrDefault();
                    //            if (userId == null || userId.HasValue == false)
                    //                return 0;
                    //            else
                    //                dyParams.Add("@UserId", userId.Value);
                    //        }
                    //    }
                    //    //当前红包状态 0：未领取  1:已领取未使用 2:红包已使用 3:红包已过期
                    //    UserPrizeInfo prizeInfo = connection.Query<UserPrizeInfo>(strSQL, dyParams).FirstOrDefault();
                    //    if (prizeInfo == null || prizeInfo.IsReceive == false)
                    //    {
                    //        return 0;
                    //    }
                    //    if (prizeInfo.IsReceive && !prizeInfo.IsUsed)
                    //    {
                    //        return 1;
                    //    }
                    //    if (prizeInfo.IsUsed)
                    //        return 2; 
                    //}
                    #endregion
                }
                else
                {
                    if (recordInfo.ExpirationDate < DateTime.Now)
                    {
                        return 3;
                    }
                } 
                return 0;
            }
            catch
            {
                return 0;
            }
        }
        #endregion

    }  
    
}