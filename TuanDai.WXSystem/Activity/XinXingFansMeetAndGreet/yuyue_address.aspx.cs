using Kamsoft.Data.Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;


namespace TuanDai.WXApiWeb.Activity.XinXingFansMeetAndGreet
{
    public partial class yuyue_address : BasePage
    {
        protected string strAction = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            strAction = WEBRequest.GetQueryString("action");
            if (strAction.ToLower() == "register")
            {
                submitData();
            }

        }

        protected void submitData()
        {
            Response.ContentType = "application/json";
            try
            {

                var result = new ProcessResult() { Success = true };
                string area = WEBRequest.GetFormString("Area");
                string currentCity = WEBRequest.GetFormString("Current");
                string userName = WEBRequest.GetFormString("UserName");
                string email = WEBRequest.GetFormString("Email");
                string mobile = WEBRequest.GetFormString("Mobile");

                result = this.Register(area, currentCity, userName, mobile, email);
                var sessionId = result.GetParameter<string>("SessionId");
                PrintJson(new { Success = result.Success, Message = result.Message, SessionId = sessionId });
            }
            catch (Exception ex)
            {
                BusinessDll.NetLog.WriteLoginHandler("粉丝见面会预约报错", Tool.ExceptionHelper.GetExceptionMessage(ex), "触屏版");
                PrintJson(new { Success = false, Message = "保存失败，请重试！" });
            }
            finally
            {
                Response.End();
            }
        }

        /// <summary>
        /// 活动报名.
        /// </summary>
        /// <param name="area"></param>
        /// <param name="current"></param>
        /// <param name="userName"></param>
        /// <param name="mobile"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public ProcessResult Register(string area, string current, string userName, string mobile, string email)
        {
            var result = new ProcessResult() { Success = true };

            //校验活动地区是否有效.
            if (area.IsEmpty() || !this.IsContainsArea(area))
            {
                result.Success = false;
                result.Message = "报名地区无效！";
                return result;
            }

            //校验姓名是否有效.
            if (userName.IsEmpty() || !userName.IsChinese())
            {
                result.Success = false;
                result.Message = "姓名无效！";
                return result;
            }

            //校验手机号是否有效.
            if (mobile.IsEmpty() || !mobile.IsPhone())
            {
                result.Success = false;
                result.Message = "手机号码无效！";
                return result;
            }

            //校验邮箱地址是否有效.
            if (email.IsNotEmpty() && !email.IsEmail())
            {
                result.Success = false;
                result.Message = "邮箱地址无效！";
                return result;
            }

            //检测该用户是否已经报名.
            if (this.IsAlreadyRegistered(area, mobile, email))
            {
                if (area.IndexOf("市") > 0) area = area.Substring(0, area.Length - 1);
                result.Success = false;
                result.Message = string.Format("您已经报名{0}站，不需要重复报名！", area);
                return result;
            }

            //新增会话记录.
            var session = new
            {
                Id = Guid.NewGuid(),
                Area = area,
                UserName = userName,
                Mobile = mobile,
                Email = email,
                AddDate = DateTime.Now
            };
            bool isResult = false;
//            using (var connection = new SqlConnection(TuanDai.Config.BaseConfig.ActivityConnectionString))
//            {
//                var commandText = @"insert into [20150705_XinXingFansMeetAndGreet_Session]
//                                    (Id, Mobile, UserName, Area, Email, AddDate) values 
//                                    (@Id, @Mobile, @UserName, @Area, @Email, @AddDate)";

//                isResult = connection.Execute(commandText, session) > 0;
//                connection.Close();
//            }

            //保存会话记录.
            if (!isResult)
            {
                result.Success = false;
                result.Message = "保存失败！";
                return result;
            }

            if (area == current) result.AddParameter("SessionId", session.Id.ToString());
            result.Success = true;
            result.Message = "报名成功！";

            return result;
        }

        public bool IsAlreadyRegistered(string area, string mobile, string email)
        {
            var result = false;
//            using (var connection = new SqlConnection(TuanDai.Config.BaseConfig.ActivityConnectionString))
//            {
//                var commandText = @"select count(0) from [20150705_XinXingFansMeetAndGreet_Session]
//                                    where Area = @Area and (Mobile = @Mobile or Email = @Email)";

//                var parameters = new DynamicParameters();
//                parameters.Add("@Area", area);
//                parameters.Add("@Mobile", mobile);
//                parameters.Add("@Email", email);

//                result = connection.Query<int>(commandText, parameters).FirstOrDefault() > 0;

//                connection.Close();
//            }
            return result;
        }

        #region 私有方法
        protected void PrintJson(string strstate, string strmsg)
        {
            var objData = new { result = strstate, msg = strmsg };
            var jsonStr = TuanDai.WXSystem.Core.JsonHelper.ToJson(objData);
            Response.ClearContent();
            Response.Write(jsonStr);
        }
        protected void PrintJson(object obj) { 
            var jsonString = TuanDai.WXSystem.Core.JsonHelper.ToJson(obj);
            Response.ClearContent();
            Response.Write(jsonString);
        }
        /// <summary>
        /// 检测活动是否包含指定地区.
        /// </summary>
        /// <param name="area"></param>
        /// <returns></returns>
        private bool IsContainsArea(string area)
        {
            var list = new List<string>(){
                /*北京市*/"北京",
                /*广东省*/"东莞市","佛山市","珠海市","湛江市",
                /*福建省*/"福州市","厦门市","泉州市",                                 
                /*湖北省"*/"武汉市",                        
                /*湖南省"*/"长沙市",                        
                /*江苏省"*/"苏州市","无锡市",
                /*江西省"*/"南昌市",                        
                /*山东省"*/"济南市","青岛市","太原市",
                /*陕西省"*/"西安市",                        
                /*河南省"*/"郑州市",                        
                /*重庆市"*/"重庆市",
                /*河北省"*/"石家庄市",
                /*天津市"*/"天津市",   
                /*广西壮族自治区"*/"南宁市",
                /*云南省"*/"昆明市",
                /*安徽省"*/"合肥市",
                /*江苏省"*/"南京市",
                /*浙江省"*/"杭州市","宁波市","温州市"
            }; 
            return list.Contains(area);
        }
        #endregion


    }
}