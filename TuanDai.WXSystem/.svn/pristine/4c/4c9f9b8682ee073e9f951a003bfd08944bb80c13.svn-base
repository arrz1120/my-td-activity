using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Tool;
using TuanDai.WXApiWeb.Common;
using TuanDai.WXSystem.Core;
using System.IO;
using System.Configuration;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using BusinessDll;

namespace TuanDai.WXApiWeb.Activity.SeekLover
{
    /// <summary>
    /// 寻找我的梦中情人活动
    /// Allen 2015-08-18
    /// </summary>
    public partial class GuidPage : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string code = WEBRequest.GetQueryString("code");
            if (!IsPostBack)
            {
                ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                string SelfOpenId = sdkApi.GetCookieOpenId(code);
            }
        }



        #region 输出内容方法
        /// <summary>
        /// 打印json
        /// </summary>
        /// <param name="state"></param>
        /// <param name="msg"></param>
        protected static  string PrintJson(string strstate, string strmsg)
        {
            var objData = new ResponseData() { result = strstate, msg = strmsg };
            var jsonStr = JsonHelper.ToJson(objData);
            return jsonStr;
        }

        protected static string PrintJson(object data)
        {
            var jsonString = JsonHelper.ToJson(data);
            return jsonString;
        }
        
        #endregion


        protected static Random rand = new Random((int)DateTime.Now.Ticks);
        
        #region 速配情人
        [WebMethod]
        public static string SeekMyLover(string base64Img)
        {
            try
            {
                string HeadImage = "";
                //上传头像
                bool saveImg = SaveHeadImage(base64Img, ref HeadImage);
                if (!saveImg)
                {
                    return PrintJson("-1", "上传头像失败!");
                }
              
                Dictionary<string, string> templateDict = GetLoverTemplate();
                int rIndex = rand.Next(templateDict.Count);
                if (rIndex < 1 || rIndex > templateDict.Count)
                    rIndex = 0;
                string seekLover = templateDict.ElementAt(rIndex).Key;//匹配到的情人
                string seekLoverImg = templateDict.ElementAt(rIndex).Value;

                int MatchMark = GetRandomMark();
                int BeautyMark = GetRandomMark();
                string SelfOpenId = "";
                try
                {
                    ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                    sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                    SelfOpenId = sdkApi.GetCookieOpenId("");
                }
                catch {
                    SelfOpenId = "";
                }

                //using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ActivityConnectionString))
//                {
//                    string strSQL = @"insert into Activity_SeekLover_Record(Id,UserId,UserName,WXOpenId,HeadImage,MatchMark,BeautyMark,SeekLover,AddDate,UserAgent)
//                                     values(@Id,@UserId,@UserName,@WXOpenId,@HeadImage,@MatchMark,@BeautyMark,@SeekLover,@AddDate,@UserAgent)";

//                    DynamicParameters dyParams = new DynamicParameters();
//                    dyParams.Add("@Id", Guid.NewGuid());

//                    #region 用户数据
//                    if (WebUserAuth.IsAuthenticated)
//                    {
//                        UserBLL userbll = new UserBLL();
//                        UserBasicInfoInfo userInfo = userbll.GetUserBasicInfoModelById(WebUserAuth.UserId.Value);
//                        if (userInfo != null)
//                        {
//                            dyParams.Add("@UserId", userInfo.Id);
//                            dyParams.Add("@UserName", userInfo.UserName);
//                        }
//                        else
//                        {
//                            dyParams.Add("@UserId", null);
//                            dyParams.Add("@UserName", "");
//                        }
//                    }
//                    else
//                    {
//                        dyParams.Add("@UserId", null);
//                        dyParams.Add("@UserName", "");
//                    }
//                    #endregion
//                    dyParams.Add("@WXOpenId", SelfOpenId);
//                    dyParams.Add("@HeadImage", HeadImage);
//                    dyParams.Add("@MatchMark", MatchMark);
//                    dyParams.Add("@BeautyMark", BeautyMark);
//                    dyParams.Add("@SeekLover", seekLover);
//                    dyParams.Add("@AddDate", DateTime.Now);
//                    //获取用户浏览器信息
//                    string strAgent = "";
//                    strAgent += string.Format("用户IP: {0}\r\n", Tool.WebFormHandler.GetIP());
//                    strAgent += string.Format("用户浏览器: {0}\r\n", HttpContext.Current.Request.UserAgent);
//                    dyParams.Add("@UserAgent", strAgent);
//                    int iSuc = connection.Execute(strSQL, dyParams);

//                    if (iSuc > 0)
//                    {
//                        LoverInfo infor = new LoverInfo();
//                        infor.result = "1";
//                        infor.LoverName = seekLover;
//                        infor.LoverImage = seekLoverImg;
//                        infor.HeadImage = HeadImage;
//                        infor.MatchMark = MatchMark;
//                        infor.BeautyMark = BeautyMark;
//                        return PrintJson(infor);
//                    }
//                    else
//                    {
//                        return PrintJson("0", "保存头像失败!");
//                    }
//                }
                return "";
            }
            catch (Exception ex)
            {
                NetLog.WriteLoginHandler("速配情人活动出错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                return PrintJson("-100", "程序异常");
            }
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
            //  imgFile.Save("d:\\aa.jpg");
            BinaryReader br = new BinaryReader(stream);
            byte[] PhotoArray = stream.ToArray();
            stream.Close();


            string filePath = string.Format("Activity/SeekLover/{0}", DateTime.Now.ToString("yyyyMM"));
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
                BusinessDll.NetLog.WriteLoginHandler("速配情人活动上传图片出错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                return false;
            }
        }
        #endregion

        #region 私有方法
        //随机获取一个指数
        private static int GetRandomMark()
        {
            List<int> RankValue = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
            int mIndex = rand.Next(10);
            if (mIndex < 1 || mIndex > 10)
                mIndex = 0;
            if (mIndex < 3) //让值多些
                mIndex = 3;
            return RankValue[mIndex];
        }

        private static Dictionary<string, string> GetLoverTemplate()
        {
            Dictionary<string, string> templateArry = new Dictionary<string, string>();
            templateArry.Add("黄渤", "huangbo");
            templateArry.Add("波多野结衣", "boduoyejieyi");
            templateArry.Add("赵雅芝", "zhaoyazhi");
            templateArry.Add("杨洋", "yangyang");
            templateArry.Add("Rain", "rain");
            templateArry.Add("宁泽涛", "nizetao");
            templateArry.Add("朱茵", "zhuying");
            templateArry.Add("苍井空", "cangjinkong");

            templateArry.Add("林志玲", "lingzhling");
            templateArry.Add("胡巴", "huba");
            templateArry.Add("钟汉良", "zhonghanliang");
            templateArry.Add("范冰冰", "fanbingbing");
            templateArry.Add("吴秀波", "wuxiubo");
            templateArry.Add("凤姐", "fengjie");
            return templateArry;
        }
        #endregion

        [Serializable]
        internal class ResponseData
        {
            public string result { get; set; }
            public string msg { get; set; }
        }

        public class LoverInfo
        {
            public string result { get; set; }
            public string LoverImage { get; set; }
            public string LoverName { get; set; }
            //自已上传的头像
            public string HeadImage { get; set; }
            //般配指数
            public int MatchMark { get; set; }
            //养颜指数
            public int BeautyMark { get; set; }
        }
    }
   
}