using System;
using System.Web; 
using System.Linq;
using System.Web.SessionState;
using System.Collections;
using Tool;
using System.IO;
using System.Configuration;
using System.Globalization;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using BusinessDll;
using TuanDai.InfoSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using TuanDai.WXSystem.Core.FacePlusPlusSDK;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_files 的摘要说明
    /// </summary>
    public class ajax_files : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string Cmd = context.Request.QueryString["Cmd"] != null ? context.Request.QueryString["Cmd"] : context.Request.Form["Cmd"];
            string message = "";
            switch (Cmd)
            {
                case "BindUserHead"://上传头像
                    //验证登录
                    if (!WebUserAuth.IsAuthenticated)
                    {
                        HttpContext.Current.Response.Write("对不起，您没有权限执行此操作。");
                        HttpContext.Current.Response.End();
                    }

                    message = BindUserHead(context);
                    break; 
            }
            context.Response.Write(message);
            context.Response.End();
        }
        private System.Drawing.Image Base64ToImage(string base64Str) { 
            base64Str = base64Str.Replace(" ", "+");
            byte[] imageBytes = Convert.FromBase64String(base64Str);
            //读入MemoryStream对象
            MemoryStream memoryStream = new MemoryStream(imageBytes, 0, imageBytes.Length);
            memoryStream.Write(imageBytes, 0, imageBytes.Length);
            //转成图片
            System.Drawing.Image image = System.Drawing.Image.FromStream(memoryStream);
            return image; 
        }

        protected void Base64StringToImage(string strbase64, string filepath)
        {
            try
            {
                byte[] arr = Convert.FromBase64String(strbase64);
                MemoryStream ms = new MemoryStream(arr);
                System.Drawing.Bitmap bmp = new System.Drawing.Bitmap(ms);
                //bmp.Dispose();  
                bmp.Save(filepath, System.Drawing.Imaging.ImageFormat.Jpeg);
                ms.Close();
            }
            catch (Exception ex)
            {
            }
        }

        ///<summary>
        /// 修改用户头像
        /// </summary>
        protected string BindUserHead(HttpContext context)
        {
           
            string base64 = context.Request["base64"]; // dicParameter["base64"].ToString();//base64编码  
            //int size = Convert.ToInt32( context.Request["size"]);//base64大小  
            //string filename = context.Request["name"];//dicParameter["name"].ToString();//原文件名  

            System.Drawing.Image imgFile = Base64ToImage(base64);  

            string imageWcf = ConfigurationManager.AppSettings["ImageWcf"];
            //针对IOS上拍照图，进行旋转90度。
            if (imgFile.Width > imgFile.Height)
            {
                imgFile.RotateFlip(System.Drawing.RotateFlipType.Rotate90FlipNone);
            }
            
            MemoryStream stream = new MemoryStream();
            imgFile.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
            BinaryReader br = new BinaryReader(stream);
            byte[] PhotoArray = stream.ToArray();
            stream.Close();


            var bll = new UserBLL();
            Guid userid = WebUserAuth.UserId.Value;
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.Id == userid);
            var model = bll.GetUserBasicInfoModelById(userid);

            string filePath = string.Format("User/avator/{0}", model.AddDate.Value.ToString("yyyyMM"));

            string fileName = Guid.NewGuid().ToString() + ".jpg";

            string methodName = "UploadUserAvator";
            object[] objects = new object[] { PhotoArray, filePath, fileName };

            try
            {
                object result = Tool.WebServiceHelper.InvokeWebService(imageWcf, methodName, objects); 
                    

                if (!string.IsNullOrEmpty(result.ToString()))
                {

                    model.HeadImage =Tool.SafeConvert.ConvertHttpOrHttpsUrl(result.ToString(),"");
                    var Tresult = bll.UpdateUserBasicInfoById(model.Id, model.HeadImage);
                    if (Tresult)
                    {
                        WebLog log = new WebLog();
                        log.AddDate = DateTime.Now;
                        log.BusinessId = userid.ToString();
                        log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                        log.UserId = userid.ToString();
                        log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                        log.HandlerTypeId = (int)ConstString.LogType.UserHead;
                        log.Content1 = "更新用户头像:" + model.HeadImage;
                        log.Id = Guid.NewGuid().ToString();
                        WebLogInfo.WriteLoginHandler(log);
                    }
                    var responseObj=new {status=1, fileName=model.HeadImage};
                    return JsonConvert.SerializeObject(responseObj);
                }
                else
                {
                    return "0";
                }
            }
            catch(Exception ex)
            {
                return  "ex:"+ex.Message;
            } 
        }



        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}