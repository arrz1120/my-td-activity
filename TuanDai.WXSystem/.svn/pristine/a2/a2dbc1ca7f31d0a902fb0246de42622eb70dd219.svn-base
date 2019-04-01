<%@ WebHandler Language="C#" Class="TuanDai.WXApiWeb.ajaxCross.ajax_Acticity" %>

using System;
using System.Web;
using System.Data.Objects;
using System.Data;
using System.Linq;
using Kamsoft.Data;
using System.Configuration;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Kamsoft.Data.Dapper;
using System.Collections.Generic;
using System.Text;
using TuanDai.VipSystem.Model;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.ajaxCross
{
    public class ajax_Acticity : SafeHandlerBase
    {
        private readonly string sqlconnection = TuanDai.Config.BaseConfig.ConnectionString;
        TuanDai.VipSystem.BLL.UserBLL bll = new TuanDai.VipSystem.BLL.UserBLL();
        Guid UserId = WebUserAuth.UserId.Value;
        /// <summary>
        /// 领取兑换券
        /// </summary>
        public void ExchangeCode()
        {
            Guid? userId= WebUserAuth.UserId;
            //判断是否登陆，得到用户ID
            if (userId==Guid.Empty)
            {
                this.PrintJson("2", "对不起，你未登录，请先登录。");
            }

            string code=Context.Request.Form["Code"];
            if (string.IsNullOrEmpty(code))
            {
                this.PrintJson("3", "兑换密码不能为空");
            }

            var param = new Dapper.DynamicParameters();
            param.Add("@userId",userId);
            param.Add("@exchangeCode", code.ToUpper());
            param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);
            param.Add("@outMsg","", System.Data.DbType.String, System.Data.ParameterDirection.Output);

            int status = 0;
            string errMsg="";
            //using (SqlConnection connection = OpenConnection())
            //{
            //    connection.Execute("p_Activity_GetPrize_ExchangeCoupon", param, null, null, CommandType.StoredProcedure);
            //    status = param.Get<int>("@outStatus");
            //    errMsg = param.Get<string>("@outMsg");
            //    connection.Close();
            //    connection.Dispose();
            //}
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBUserWrite, "p_Activity_GetPrize_ExchangeCoupon", ref param,
                CommandType.StoredProcedure);
            status = param.Get<int>("@outStatus");
            errMsg = param.Get<string>("@outMsg");
            this.PrintJson(status.ToString(), errMsg);
        }


        protected System.Data.SqlClient.SqlConnection OpenConnection()
        {
            System.Data.SqlClient.SqlConnection connection = new System.Data.SqlClient.SqlConnection(sqlconnection);
            connection.Open();
            return connection;
        }

        public void ReceivePrize()
        {
            if (WebUserAuth.UserId != Guid.Empty)
            {
                Guid userId = WebUserAuth.UserId.Value;
                int type = Tool.SafeConvert.ToInt32(Context.Request.Form["rType"]);
                Guid LevelId;
                if (type == 1)
                    LevelId = Guid.Parse("72E27C86-E066-4609-A15E-DB7005B7DDC7");
                else if (type == 2)
                    LevelId = Guid.Parse("B58F1011-F67F-451D-B589-17E20145CA18");
                else
                    LevelId = Guid.Parse("87D354C4-FB31-4FD1-956A-549191574BB1");
                TuanDai.VipSystem.Model.UserInfo model = new TuanDai.VipSystem.BLL.UserBLL().GetUserInfo(userId);
                if (model != null && model.Level < type + 1)
                {
                    Context.Response.Write("{\"Result\":\"3\",\"msg\":\"对不起，您还未达到领取等级\"}");
                }
                else
                {
                    int status = new TuanDai.VipSystem.BLL.PrizeBLL().ReceiveInvestRedPacket(userId, LevelId, type);
                    string msg = "";
                    if (status == 0)
                    {
                        status = -4;
                        msg = "对不起, 领取失败!";
                    }
                    else if (status == 2) {
                        status = -5;
                        msg = "该红包已不存在!";
                    }
                    else if (status == 3) {
                        status = -6;
                        msg = "该红包已经领取!";
                    }
                    else if (status == 4) {
                        status = -7;
                        msg = "赠送失败!";
                    }
                    else if (status ==5)
                    {
                        status = -8;
                        msg = "已经赠送!";
                    }
                    //0领取失败，1领取成功,2-不存在 3-已领取 
                    Context.Response.Write("{\"Result\":\"" + status + "\",\"msg\":\"" + msg + "\"}");
                }
            }
            else
            {
                Context.Response.Write("{\"Result\":\"2\",\"msg\":\"对不起，您还未登录\"}");
            }
        }
        //领取礼物
        public void ReceiveGift() {
            if (WebUserAuth.UserId != Guid.Empty)
            {
                Guid userId = WebUserAuth.UserId.Value;
                Guid ActivityId = Tool.SafeConvert.ToGuid(Context.Request.Form["ActivityId"]) ?? Guid.Empty;
                string Telno = new TuanDai.VipSystem.BLL.UserBLL().GetUserTelNo(userId);
                if (string.IsNullOrEmpty(Telno))
                {
                    Context.Response.Write("{\"Result\":\"4\",\"msg\":\"您还未绑定手机号\"}");
                }
                else if (ActivityId == Guid.Empty)
                {
                    Context.Response.Write("{\"Result\":\"3\",\"msg\":\"参数错误\"}");
                }
                else
                {
                    string msg = "";
                    bool IsSendMsg = false;
                    int result = new TuanDai.VipSystem.BLL.PrizeBLL().ReceiveGift(userId, ActivityId, out msg, out IsSendMsg);
                    if (IsSendMsg)
                    {
                        new BusinessDll.MessageSend().AsyncSendNoteHandler("Note", userId, Telno, msg);
                        msg = "短信已发送至您的手机，5分钟之内如未收到请联系客服";
                    }
                    Context.Response.Write("{\"Result\":\"" + result + "\",\"msg\":\"" + msg + "\"}");
                }
            }
            else
            {
                Context.Response.Write("{\"Result\":\"2\",\"msg\":\"对不起，您还未登录\"}");
            }
        }

        /// <summary>
        /// 获取成长明细列表
        /// </summary>
        public void GetGrowthDetailList()
        {
            int pageIndex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            int pageSize = Tool.SafeConvert.ToInt32(Context.Request.Form["pageSize"], 15);

            string DateType = Context.Request.Form["DateType"].ToString(); 

            if (pageIndex < 1)
            {
                pageIndex = 1;
            }
            int totalCount = 0;
            StringBuilder sb = new StringBuilder();
            List<UserGrowthDetailInfo> list = bll.GetGrowthDetail(UserId, DateType, pageIndex, pageSize, out totalCount).ToList();

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalCount + "\",\"list\":[");
                string strType = "";
                foreach (UserGrowthDetailInfo temp in list)
                {
                    if (temp.TypeId == 100)
                    {
                        strType = "补发成长值";
                    }
                    else
                    {
                        strType = Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.UserGrowthType), temp.TypeId);
                    }
                    if (index == list.Count())
                    {
                        sb.Append("{\"CreateDate\":\"" + temp.CreateDate.ToString("yyyy-MM-dd HH:mm:ss") + "\",\"TypeId\":\"" + strType
                            + "\",\"AddGrowth\":\"" + temp.AddGrowth + "\",\"Growth\":\"" + temp.Growth + "\"}]}");
                    }
                    else
                    {
                        sb.Append("{\"CreateDate\":\"" + temp.CreateDate.ToString("yyyy-MM-dd HH:mm:ss") + "\",\"TypeId\":\"" + strType
                            + "\",\"AddGrowth\":\"" + temp.AddGrowth + "\",\"Growth\":\"" + temp.Growth + "\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        //设置1218活动中的框已弹过
        public void Set1218PopIsShowed()
        {
            string popType = Tool.WEBRequest.GetFormString("PopType");
            if (WebUserAuth.UserId != Guid.Empty)
            {
                Guid userId = WebUserAuth.UserId.Value;
                //using (var connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
                //{
                string strSQL = "update RateCoupon20151218 set  IsShowed=1, ShowAddress=2 where UserId=@userId and SourceFromType=@fromType";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@userId", userId);
                dyParams.Add("@fromType", popType);
                TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBUserWrite, strSQL, ref dyParams);
                    //connection.Execute(strSQL, dyParams);
                PrintJson("1", "");
                //}
            }
            else
            {
                PrintJson("2", "对不起，您还未登录");
            }
        }

        #region SaveQuestionAnswers(保存问卷答案)

        public void SaveSurvey()
        {
            string result = string.Empty;
            string surveyType = "问卷调查问卷";
            try
            {                
                string survey = Context.Request.Form["survey"].ToString();
                string sessionid = Context.Request.Form["sessionid"];
                survey = survey.Replace("\n", "").Replace("\t", "");
                string[] surveyArray = survey.Substring(1, survey.Length - 1).Split('&');
                if (surveyArray.Length < 12)
                {
                    result = "{\"Result\":\"0\",\"msg\":\"未达到12到题目\"}";
                }
                else
                {
                    if (IsAlreadySubmited(surveyType, 12, UserId))
                    {
                        result = "{\"Result\":\"2\",\"msg\":\"已完成调查问卷，不需要重复提交\"}";
                    }
                    else
                    {
                        List<AnswerRecord> listAnswerRecode = new List<AnswerRecord>();
                        AnswerRecord objAnswerRecord = null;
                        foreach (string item in surveyArray)
                        {
                            objAnswerRecord = new AnswerRecord();
                            objAnswerRecord.Type = surveyType;
                            objAnswerRecord.UserId = UserId;
                            objAnswerRecord.ID = Guid.NewGuid();
                            if (!string.IsNullOrEmpty(sessionid))
                            {
                                objAnswerRecord.SessionId = Guid.Parse(sessionid.ToString());
                            }
                            string[] temp = item.Split('=');
                            objAnswerRecord.Question = temp[0];
                            objAnswerRecord.Answers = temp[1];
                            listAnswerRecode.Add(objAnswerRecord);
                        }
                        foreach (var item in listAnswerRecode)
                        {
                            if (!SaveQuestionAnswer(item))
                            {
                                result = "{\"Result\":\"0\",\"msg\":\"数据提交失败\"}";
                            }
                        }
                        result = string.IsNullOrEmpty(result) ? "{\"Result\":\"1\",\"msg\":\"\"}" : result;
                    }
                }
            }
            catch (Exception ex)
            {
                result = "{\"Result\":\"0\",\"msg\":\"提交失败，"+ex.Message+"\"}";
            }
            this.Context.Response.Write(result);
            this.Context.Response.End();
        }


        /// <summary>
        /// 保存问卷答案.
        /// </summary>
        /// <param name="record"></param>
        /// <returns></returns>
        public bool SaveQuestionAnswer(AnswerRecord record)
        {
            var result = false;
            //using (var connection = new SqlConnection(TuanDai.Config.BaseConfig.ActivityConnectionString))
            //{
            var commandText = @"insert into [20150705_XinXingFansMeetAndGreet_Answer] 
                                    (ID, UserId, SessionId, Type, Question, Answers, AddDate) values 
                                    (@ID, @UserId, @SessionId, @Type, @Question, @Answers, GETDATE())";
            var paras =new Dapper.DynamicParameters();
            paras.Add("@ID", record.ID);
            paras.Add("@UserId", record.UserId);
            paras.Add("@SessionId", record.SessionId);
            paras.Add("@Type", record.Type);
            paras.Add("@Question", record.Question);
            paras.Add("@Answers", record.Answers);
            result = TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBActivityWrite, commandText, ref paras) > 0;
            //    result = connection.Execute(commandText, record) > 0;

            //    connection.Close();
            //}

            return result;
        }
        

        /// <summary>
        /// 保存问卷调查结果.
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="type"></param>
        /// <param name="answers"></param>
        /// <returns></returns>
        public void SaveQuestionAnswers(Guid? sessionId, string type, string[] answers)
        {
            var userId = WebUserAuth.UserId.Value;
            var result = this.SaveQuestionAnswers(userId, sessionId, type, answers);
            this.Context.Response.Write("{\"result\":\"" + result.Success + "\",\"totalcount\":\"" + result.Message + "\"}");
        }

       

        


        /// <summary>
        /// 保存问卷答案.
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="sessionId"></param>
        /// <param name="type"></param>
        /// <param name="answers"></param>
        /// <returns></returns>
        public ProcessResult SaveQuestionAnswers(Guid? userId, Guid? sessionId, string type, string[] answers)
        {
            var result = new ProcessResult() { Success = true };

            var type1 = "问卷调查问卷";
            var type2 = "团长问卷答题";

            //校验问卷类型.
            if (type != type1 && type != type2)
            {
                result.Success = false;
                result.Message = "问卷有误！";
                return result;
            }

            //校验问卷调查问卷的用户标识是否有效.
            if (type == type1 && (userId == null || userId == Guid.Empty))
            {
                result.Success = false;
                result.Message = "用户标识有误！";
                return result;
            }

            //校验团长问卷答题的会话标识是否有效.
            if (type == type2 && (sessionId == null || sessionId == Guid.Empty))
            {
                result.Success = false;
                result.Message = "会话标识有误！";
                return result;
            }

            //校验提交的问题答案是否有效.
            if ((answers == null || answers.Length == 0) || !this.IsAnswersValid(answers) ||
                type == type1 && answers != null && answers.Length != 12 || /* 问卷调查问卷有12道题 */
                type == type2 && answers != null && answers.Length != 6)    /* 团长问卷答题有6道题  */
            {
                result.Success = false;
                result.Message = "问卷答案无效！";
                return result;
            }

            //检测是否重复答卷.
            if (type == type1 && this.IsAlreadySubmited(type1, 12, userId: userId) ||
                type == type2 && this.IsAlreadySubmited(type2, 6))
            {
                result.Success = false;
                result.Message = "您已经完成答卷，不需要重复回答！";
                return result;
            }

            //创建问题答案记录.
            var answerRecord = new AnswerRecord();
            answerRecord.Type = type;
            answerRecord.AddDate = DateTime.Now;

            if (type == type1) answerRecord.UserId = userId;
            if (type == type2) answerRecord.SessionId = sessionId;

            //保存问题的答案.
            foreach (var answer in answers)
            {
                answerRecord.ID = Guid.NewGuid();

                var index = answer.IndexOf('|');
                answerRecord.Question = answer.Substring(0, index).Trim();
                answerRecord.Answers = answer.Substring(index + 1).Trim();
                this.SaveQuestionAnswer(answerRecord);
            }

            result.Message = "保存成功！";

            return result;
        }

        

        /// <summary>
        /// 校验答案内容.
        /// </summary>
        /// <param name="answers"></param>
        /// <returns></returns>
        private bool IsAnswersValid(string[] answers)
        {
            foreach (var answer in answers)
            {
                if (answer.Length > 150) return false;
            }

            return true;
        }
        
        /// <summary>
        /// 检测某用户是否已经完成答卷.
        /// </summary>
        /// <param name="answersCount"></param>
        /// <param name="userId"></param>
        /// <param name="sessionId"></param>
        /// <returns></returns>
        public bool IsAlreadySubmited(string type, int answersCount, Guid? userId = null)
        {
            var result = false;
            //using (var connection = new SqlConnection(TuanDai.Config.BaseConfig.ActivityConnectionString))
            //{
                var builder = new StringBuilder();
                var parameters = new Dapper.DynamicParameters();

                builder.Append("select count(0) from [20150705_XinXingFansMeetAndGreet_Answer]");
                builder.Append(" where Type = @Type");
                parameters.Add("@Type", type);

                if (userId.HasValue && userId != Guid.Empty)
                {
                    builder.Append(" and UserId = @UserId");
                    parameters.Add("@UserId", userId);
                }
            result =
                TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBActivityWrite, builder.ToString(),
                    ref parameters) == answersCount;
            //    result = connection.Query<int>(builder.ToString(), parameters).FirstOrDefault() == answersCount;

            //    connection.Close();
            //}
            return result;
        }
        #endregion

    }
    /// <summary>
    /// 问卷答案记录.
    /// </summary>
    public class AnswerRecord
    {
        public Guid ID { get; set; }
        public Guid? UserId { get; set; }
        public Guid? SessionId { get; set; }
        public string Type { get; set; }
        public string Question { get; set; }
        public string Answers { get; set; }
        public DateTime? AddDate { get; set; }

        public override string ToString()
        {
            return this.Question;
        }
    }
}