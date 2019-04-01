using BusinessDll;
using System.Web;
using Tool;
using TuanDai.PortalSystem.DAL;
using TuanDai.PortalSystem.Model;
using TuanDai.WXApiWeb.Common;
using System.Linq;
using System; 
using Kamsoft.Data.Dapper;
using System.Data;
using TuanDai.InfoSystem.Model;
using System.Collections.Generic;
using TuanDai.PortalSystem.Model.Enums;
using System.Data.SqlClient; 
using System.Text; 
using TuanDai.PortalSystem.BLL;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// 净股专区处理器.
    /// </summary>
    public class ajax_loan : SafeHandlerBase
    {
        
        #region 资产标借款
        /// <summary>
        /// 提交发标请求.
        /// </summary>
        public void Submit()
        {
            PrintJson("-1","触屏版不支持发资产标，请前往PC或APP");
            return;
            //将用户提交的请求信息转换成视图模型.
            var model = WXInvest.ConvertTo<ProjectViewModel>(HttpContext.Current.Request, HttpMethod.POST);
            if (model.Unit > 1000)
            {
                this.PrintJson("-1", "最小单位不能大于1000");
            }
            if (model.InterestRate.HasValue)
            {
                int totalLength = model.InterestRate.ToString().Length;//总长度
                int floatLength = totalLength -1 - Math.Floor(model.InterestRate.Value).ToString().Length;//小数位数
                int dataLength = int.Parse(new WebSettingBLL().GetWebSettingInfo("3F902315-6986-44FF-9F00-9D420C07FCDA").Param1Value);//数据库配置位数
                if (floatLength > dataLength)
                {
                    this.PrintJson("-1", "利率的小数位数不能超过"+dataLength+"位");
                }
            }
            
            if (model.Repayment != 1 && model.Repayment != 2)
            {
                this.PrintJson("-1", "还款方式不对");
            }
            string PayPwd = Tool.Encryption.MD5(Context.Request["PayPwd"]);
            decimal rate = decimal.Parse(Context.Request["rate"]);

            //校验用户信息.
            var userId = WebUserAuth.UserId.Value;
            var userbll = new UserBLL();
            var user = userbll.GetUserBasicInfoModelById(userId);
            if (user == null) this.PrintJson("-2", "用户不存在");

            if (string.IsNullOrEmpty(user.PayPwd) || user.PayPwd == user.Pwd)
            {
                this.PrintJson("-4", "请先到安全中心设置交易密码");
            }

            //DB.UserSetting usersetting = db.UserSettings.FirstOrDefault(p=>p.UserId==userId);
            //modify by ShellBen 2015-12-26
            UserSettingDAL usDal = new UserSettingDAL();
            UserSettingInfo usersetting = usDal.GetUserSettingInfo(userId);
            if (usersetting != null)
            {
                if (usersetting.PayPwdErrorDate.HasValue)
                {
                    DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
                    DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
                    if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
                    {
                        this.PrintJson("-5", "交易密码已错误5次，请24小时后再进行此操作");
                    }
                    if (date1 != date2 && usersetting.PayPwdErrorCount > 1)
                    {
                        usersetting.PayPwdErrorCount = 0;
                        usersetting.PayPwdErrorDate = null;
                    }
                }

            }
            else
            {
                //usersetting = new DB.UserSetting();
                usersetting = new UserSettingInfo();
                usersetting.Id = Guid.NewGuid();
                usersetting.UserId = userId;
                usersetting.IsTenderNeedPayPassword = false;
                usersetting.IsAllowChangePwd = true;
                usersetting.PayPwdErrorCount = 0;
                usersetting.PayPwdErrorDate = null;
                //db.UserSettings.AddObject(usersetting);
                //db.SaveChanges();
                usDal.AddUserSettingInfo(usersetting);
            }

            if (user.PayPwd != PayPwd)
            {
                //记录登录错误次数
                if (usersetting.PayPwdErrorCount == null)
                {
                    usersetting.PayPwdErrorCount = 0;
                }
                usersetting.PayPwdErrorCount += 1;
                usersetting.PayPwdErrorDate = DateTime.Now;
                //db.SaveChanges();
                usDal.UpdateUserSettingInfo(usersetting);
                if (usersetting.PayPwdErrorCount >= 5)
                {
                    this.PrintJson("-6", "今日交易密码已错误5次，请24小时后再进行此操作！");
                }
                else
                {
                    this.PrintJson("-7", "交易密码错误，今日还有" + (5 - usersetting.PayPwdErrorCount) + "次机会，错误5次将锁定24小时！");
                }
                return;
            }
            else
            {
                //清除错误记录
                usersetting.PayPwdErrorCount = 0;
                usersetting.PayPwdErrorDate = null;
                //db.SaveChanges();
                usDal.UpdateUserSettingInfo(usersetting);
            }

            //校验项目信息.
            var result = WXInvest.CheckProjectInfo(model, user);
            if (!result.Success) this.PrintJson(result.Code.ToString(), result.Message);

            //生成项目流水号.
            var handler = new NoHandler();
            var projectNo = handler.ProjectNo();
            if (projectNo == "0") this.PrintJson("-3", "项目流水号生成出错");

            //保存项目信息.
            var setting = result.GetParameter<WebSettingInfo>("Setting");
            result = result + WXInvest.SaveProject(model, user, setting, projectNo, rate);
            if (!result.Success)
            {
                this.PrintJson(result.Code.ToString(), result.Message);
            }
            
            this.PrintJson("1", "提交成功");
        }
        /// <summary>
        /// 检测用户是否可以发标.
        /// </summary>
        public void Check()
        {
            var result = WXInvest.CheckIssueConditions(WebUserAuth.UserId.Value);
            this.PrintJson(result);
        }
        #endregion

       

        #region 正合普惠快速借款
        public void GetZhphCity()
        {
            PrintJson("-1", "触屏版不支持正合普惠借款，请前往PC或APP");
            return;
            StringBuilder sb = new StringBuilder();
            string parentCode = WEBRequest.GetFormString("AreaCode");
            List<AddressInfo> list = null;
            //using (SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateReadConnection())
            //{
            string sqlText = string.Empty;
            //var para = new { parentCode = parentCode };
            var para = new Dapper.DynamicParameters();
            para.Add("@parentCode",parentCode);
            sqlText = @"SELECT AreaCode, AreaName FROM dbo.fq_AreaRegion with(nolock) WHERE   ParentCode=@parentCode ORDER BY AreaCode";
            list = TuanDai.DB.TuanDaiDB.Query<AddressInfo>(TdConfig.DBRead, sqlText, ref para);
            //    list = SqlMapper.Query<AddressInfo>(connection, sqlText, para).ToList();
            //    connection.Close();
            //    connection.Dispose();
            //}
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"list\":[");
                foreach (AddressInfo model in list)
                {
                    if (index == list.Count())
                    {
                        sb.Append("{\"ProId\":\"" + model.AreaCode + "\",\"ProName\":\"" + model.AreaName + "\"}]}");
                    }
                    else
                    {
                        sb.Append("{\"ProId\":\"" + model.AreaCode + "\",\"ProName\":\"" + model.AreaName + "\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }


        public void SubmitZhphLoan()
        {
            PrintJson("-1", "触屏版不支持正合普惠借款，请前往PC或APP");
            return;
            Guid userId = WebUserAuth.UserId.Value;
            int ApplyType = WEBRequest.GetFormInt("ApplyType", 0);
            if (!ApplyType.ToString().IsIn("1", "2", "3", "4"))
            {
                PrintJson("0", "借款方案不支持");
                return;
            }
            var userbll = new UserBLL();
            var user = userbll.GetUserBasicInfoModelById(userId);
            if (user == null)
                this.PrintJson("-2", "用户不存在");
            string code = WEBRequest.GetFormString("code");
            string telno = WEBRequest.GetFormString("phone");
            if (telno.IsEmpty())
            {
                PrintJson("0", "手机号不能为空!");
                return;
            }
            if (code.IsEmpty())
            {
                PrintJson("0", "验证码不能为空!");
                return;
            }
            int msgCode = new TuanDai.PortalSystem.BLL.CodeRecordBLL().CheckCodeRecord(code, telno, MsCodeType.PhoneCode, MsCodeType2.ZhphFastLoanCode, userId, true);
            /*1：验证通过；0:参数错误；-1：验证码不存在；-2：验证码已过期；-3：验证码已使用；-4：验证已过期*/
            string msg = string.Empty;
            switch (msgCode)
            {
                case 0:
                    msg = "参数错误";
                    break;
                case -1:
                    msg = "验证码不存在";
                    break;
                case -2:
                    msg = "验证码已过期";
                    break;
                case -3:
                    msg = "验证码已使用";
                    break;
                case -4:
                    msg = "验证已过期";
                    break;
                default:
                    break;
            }
            if (msgCode != 1)
            {
                PrintJson(msgCode.ToString(), msg);
                return;
            }


            ProjectBLL projectbll = new ProjectBLL();
            TuanDai.PortalSystem.Model.WXZhphApplyLoanInfo loanInfo = new TuanDai.PortalSystem.Model.WXZhphApplyLoanInfo();
            loanInfo.Id = Guid.NewGuid();
            loanInfo.AppTypeId = ApplyType;
            loanInfo.UserId = userId;
            loanInfo.AddDate = DateTime.Now;
            loanInfo.AppName = WEBRequest.GetFormString("name");
            loanInfo.Phone = WEBRequest.GetFormString("phone");
            loanInfo.Provice = WEBRequest.GetFormString("sel_city1");
            loanInfo.City = WEBRequest.GetFormString("sel_city2");
            loanInfo.AreaCode = WEBRequest.GetFormString("areacode");
            //1:pc  2: ios 3:android  4:触屏版 5：服务号
            loanInfo.DeviceType = 4;
            if (GlobalUtils.IsWeiXinBrowser)
                loanInfo.DeviceType = 5;

            bool isSave = projectbll.SubmitZhphLoan(loanInfo);
            if (!isSave)
            {
                PrintJson("0", "数据保存异常，请重试!");
                return;
            }
            PrintJson("1", "");
        }

        public void GetZhphApplySMSCode() {
            Guid userid = WebUserAuth.UserId.Value;
            //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.Id == userid);
            var model = new UserBLL().GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-1", "用户不存在");
            }
            string mobileNo = WEBRequest.GetFormString("mobileno");
            if (mobileNo.ToText().IsEmpty()) {
                PrintJson("-1", "未输入手机号");
            }

            //string random = StringUtilily.GetRandomString(6);
            string telNo = mobileNo;
            string token = Tool.Encryption.MD5(userid.ToString());

            //CodeRecord codeRecord = new CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = userid;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now;
            //codeRecord.Status = 0;
            //codeRecord.Type = MsCodeType.PhoneCode;
            //codeRecord.Type2 = MsCodeType2.ZhphFastLoanCode;
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(telNo, MsCodeType.PhoneCode, MsCodeType2.ZhphFastLoanCode,
               null, 1, token);
            if (!canSend.Success)
            {
                PrintJson("-1", "一天之内最多发送5次！");
            }
            var code = new CodeRecordBLL().CreateCodeRecordInfo(userid, Tool.WebFormHandler.GetIP(),
                MsCodeType.PhoneCode, MsCodeType2.ZhphFastLoanCode, telNo);
            //if (db.SaveChanges() > 0)
            if (code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);
                var msgSender = new BusinessDll.MessageSend();
                var sendResult = msgSender.SendMessage2(option: SendOption.Sms,
                    eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: telNo, content: code.Code);
                if (sendResult != "1")
                {
                    PrintJson("-1", "短信发送失败");
                }
                else
                {
                    PrintJson("1", "");
                }
            }
            else
            {
                PrintJson("-1", "短信发送失败");
            }
        }
        #endregion


        #region 内部Model
        public class AddressInfo
        {
            public string AreaCode { get; set; }
            public string AreaName { get; set; }
        }
        #endregion
    }
}