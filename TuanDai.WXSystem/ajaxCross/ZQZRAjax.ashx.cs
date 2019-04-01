﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web; 
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using System.Text;
using Tool; 
using System.Data.SqlClient;
using System.Data;
using Kamsoft.Data.Dapper;
using TuanDai.WXSystem.Core;
using TuanDai.InfoSystem.Model;
using BusinessDll;
using TuanDai.DProject.Client;
using System.Configuration;
using System.Web.Configuration;
using Kamsoft.Data;
using Newtonsoft.Json;
using MessageTemplates = TuanDai.PortalSystem.Model.Enums.MessageTemplates;
using TuanDai.PortalSystem.Model.Enums;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ZQZRAjax 的摘要说明
    /// </summary>
    public class ZQZRAjax : SafeHandlerBase
    {

        #region  转让列表及详情
        //获取债权转让列表
        public void GetZQZRCanTransferList()
        {
            int pageSize = GlobalUtils.PageSize;
            int pageIndex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            string pStatus = WEBRequest.GetFormString("status");
            if (pageIndex < 1)
            {
                pageIndex = 1;
            }
            Guid userid = WebUserAuth.UserId.HasValue ? WebUserAuth.UserId.Value : Guid.Empty;
            if (userid == Guid.Empty)
            {
                PrintJson("0", "您还未登录!");
                return;
            }
           
            int outputStatus = 0;
            if (pStatus == "CanTran")
            {
                #region 可转让标
                int count = 0;
                List<NegotiableInfo> list = new TuanDai.PortalSystem.BLL.SubScriberansferBLL().GetNegotiableList(userid, 3, pageIndex, pageSize, out outputStatus, out count);
                List<NegotiableInfoExt> dataList = new List<NegotiableInfoExt>();

                if (outputStatus == -1)
                {
                    PrintJson("0", "有发净股标或者逾期垫付未还");
                }
                else
                {
                    foreach (NegotiableInfo item in list)
                    {
                        NegotiableInfoExt extItem = new NegotiableInfoExt();
                        extItem.ProjectId = item.ProjectId;
                        extItem.Id = item.Id;
                        extItem.Title = item.Title;
                        extItem.TotalRefundMonths = item.TotalRefundMonths;
                        extItem.RefundedMonths = item.RefundedMonths;
                        extItem.TypeName = ToolStatus.ConvertProjectType(item.Type);
                        extItem.DueInAmount = ToolStatus.ConvertLowerMoney(item.Amount + item.InterestAmout);
                        extItem.PreCycDateStr = item.PreCycDate.ToString("yyyy-MM-dd");
                        extItem.TenderModeName = GetTenderMode(item.TenderMode);
                        extItem.InterestRate = ToolStatus.DeleteZero(item.InterestRate);
                        extItem.RepaymentType = ToolStatus.ConvertRepaymentType(item.RepaymentType);
                        dataList.Add(extItem);
                    }
                }
                if (count == 0)
                {
                    PrintJson("0","没有找到数据");
                    return;
                }
                int pageCount = GetPageCount(count, pageSize);
                var objData = new { result = "1", msg = "", pageCount = pageCount, list = dataList };
                PrintJson(objData);
                #endregion
            }
            else if (pStatus == "Traning")
            {
                #region 转让中
                int transferCount = 0; 
                  List<SubScribeTransferInfo> tempList  = new TuanDai.PortalSystem.BLL.SubScriberansferBLL().GetSubScribeTransferList(userid, 1, pageSize, pageIndex, out transferCount);
                  if (transferCount == 0)
                  {
                      PrintJson("0", "没有找到数据");
                      return;
                  }
                  int pageCount = GetPageCount(transferCount, pageSize);
                   List<SubScribeTransferInfoExt> dataList = new List<SubScribeTransferInfoExt>();
                   foreach (SubScribeTransferInfo item in tempList)
                   {
                       SubScribeTransferInfoExt extItem = new SubScribeTransferInfoExt();
                       extItem.ProjectId = item.ProjectId;
                       extItem.Id = item.Id;
                       extItem.Title = item.Title;
                       extItem.SumTransferAmount = ToolStatus.ConvertLowerMoney(item.sumTransferAmount);
                       extItem.ProgressStr = Convert.ToDouble(item.Progress).ToString("f1");
                       extItem.LastTimeStr = item.remainTime;
                       extItem.AddDate = item.AddDate;
                       extItem.TotalAmountStr = ToolStatus.ConvertLowerMoney(item.TotalAmount);
                       DateTime EndTransferDate = DateTime.Parse(item.AddDate.ToString("yyyy-MM-dd") + " 23:59:59");
                       if (DateTime.Now > EndTransferDate)
                           extItem.LastSecond = 0;
                       else {
                           extItem.LastSecond = Convert.ToInt32((EndTransferDate - DateTime.Now).TotalSeconds);
                       } 
                       dataList.Add(extItem);
                   }
                   var objData = new { result = "1", msg = "", pageCount = pageCount, list = dataList };
                PrintJson(objData);
                #endregion
            }
            else {             
                #region 已完成
                int transferCount = 0;
                List<SubScribeTransferInfo> tempList = new TuanDai.PortalSystem.BLL.SubScriberansferBLL().GetSubScribeTransferList(userid, 2, pageSize, pageIndex, out transferCount);
                if (transferCount == 0)
                {
                    PrintJson("0", "没有找到数据");
                    return;
                }
                int pageCount = GetPageCount(transferCount, pageSize);
                List<SubScribeTransferInfoExt> dataList = new List<SubScribeTransferInfoExt>();
                foreach (SubScribeTransferInfo item in tempList)
                {
                    SubScribeTransferInfoExt extItem = new SubScribeTransferInfoExt();
                    extItem.ProjectId = item.ProjectId;
                    extItem.Id = item.Id;
                    extItem.Title = item.Title;
                    extItem.SumTransferAmount = ToolStatus.ConvertLowerMoney(item.sumTransferAmount);
                    extItem.ProgressStr = Convert.ToDouble(item.Progress).ToString("f1"); 
                    dataList.Add(extItem);
                }
                var objData = new { result = "1", msg = "", pageCount = pageCount, list = dataList };
                PrintJson(objData);
                #endregion
            }
        }

        //获取转让详情数据
        public void GetZQZRTransferRecord()
        {
            int pageSize = 8;
            int pageIndex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            Guid transferId = WEBRequest.GetFormGuid("transferId");
            Guid userid = WebUserAuth.UserId.HasValue ? WebUserAuth.UserId.Value : Guid.Empty;
            if (userid == Guid.Empty)
            {
                PrintJson("0", "您还未登录!");
                return;
            }
            SubscribeBLL bll = new SubscribeBLL();
            int recordCount = 0;
            int index = 1;
            TransferRecord mTransferRecord = bll.GetTransferRecord(transferId, pageIndex, pageSize, out recordCount);
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"result\":\"1\",\"list\":[");
            foreach (var temp in mTransferRecord.listTranster)
            {
                sb.Append("{\"NickName\":\"" + BusinessDll.StringHandler.MaskStartPre(temp.UserName, 1) + "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount) +
                            "\",\"TotalShares\":\"" + temp.TotalShares+
                            "\",\"ContractNo\":\"" + temp.ContractNo
                            );
                if (index == mTransferRecord.listTranster.Count())
                {
                    sb.Append("\"}]}");
                }
                else
                {

                    sb.Append("\"},");
                }
                index++;
            } 
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        #endregion


        #region  中止债权转让
        //获取中止转让验证码
        public void GetStopTranCode() {
            Guid userid = WebUserAuth.UserId.Value;
            UserBLL userbll = new UserBLL();
            UserBasicInfoInfo model = userbll.GetUserBasicInfoModelById(userid); 
            if (model == null)
            {
                PrintJson("-1","用户不存在"); 
            }

            //string random = StringUtilily.GetRandomString(6); 
            string telNo = model.TelNo;
            string strIP = Tool.WebFormHandler.GetIP();

            //TuanDB.CodeRecord codeRecord = new TuanDB.CodeRecord();
            //codeRecord.Id = Guid.NewGuid();
            //codeRecord.UserId = userid;
            //codeRecord.Code = random;
            //codeRecord.AddDate = DateTime.Now;
            //codeRecord.Status = 0;
            //codeRecord.Type = 2;
            //codeRecord.Type2 = 20;
            //codeRecord.token = token;
            //codeRecord.TypeValue = telNo;
            //db.CodeRecord.AddObject(codeRecord);
            //if (db.SaveChanges() > 0)
            var canSend = new CodeRecordBLL().IsCanSendNewCodeRecord(telNo, MsCodeType.PhoneCode, MsCodeType2.PCStopTransferCode, null, 1, strIP);
            if (!canSend.Success)
            {
                PrintJson("-1", canSend.Message);
            }
            var code = new CodeRecordBLL().CreateCodeRecordInfo(userid, "", MsCodeType.PhoneCode,  MsCodeType2.PCStopTransferCode, telNo);
            if(code != null)
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

        //中止债权转让
        public void StopTransfer() {
            Guid userId = WebUserAuth.UserId.Value;
            Guid transferId = Guid.Empty;
            Guid.TryParse(Context.Request["transferid"], out transferId);
            string code = Context.Request["code"];
            UserBLL bll = new UserBLL();
            UserBasicInfoInfo  userModel = bll.GetUserBasicInfoModelById(userId);
            if (userModel != null && !string.IsNullOrEmpty(userModel.TelNo))
            {
                int msgCode = new TuanDai.PortalSystem.BLL.CodeRecordBLL().CheckCodeRecord(code, userModel.TelNo, MsCodeType.PhoneCode, MsCodeType2.PCStopTransferCode, userId, true);
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
                int result = new TuanDai.PortalSystem.BLL.SubScriberansferBLL().StopTransfer(userId, transferId);
                if (result != 1)
                {
                    PrintJson(result.ToString(), "终止转让失败");
                    return;
                }
                PrintJson(result.ToString(), "终止转让成功");
            }
        }
        #endregion

        #region 申请转让债权
        //加载转让信息
        public void InitApplicationTransfer()
        {
            //TuanDB.JunTeEntities dbRead = TuanDB.JunTeEntities.Read();
            Guid subscribeId = Guid.Empty;
            Guid.TryParse(Context.Request["id"], out subscribeId);
            Guid userId = WebUserAuth.UserId.Value;

            //TuanDB.Subscribe subscribeEntity = dbRead.Subscribe.FirstOrDefault(p => p.Id == subscribeId && p.SubscribeUserId == userId);

            var subscribeEntity = new SubscribeBLL().GetSubscribeById(subscribeId);
            if (subscribeEntity == null)
            {
                PrintJson("0", "数据异常");
                return;
            }
            ProjectBLL bll = new ProjectBLL();
            ProjectDetailInfo projectEntity = bll.GetProjectDetailInfo(subscribeEntity.ProjectId.Value);
            //Project projectEntity = dbRead.Project.FirstOrDefault(p => p.Id == subscribeEntity.ProjectId);
            if (projectEntity == null)
            {
                PrintJson("0", "数据异常");
                return;
            }

            InitApplicationtransferInfo initApplicationtransferEntity = new InitApplicationtransferInfo();
            initApplicationtransferEntity.Title = projectEntity.Title;
            initApplicationtransferEntity.TypeName = ToolStatus.ConvertProjectType(projectEntity.Type ?? 0);
            initApplicationtransferEntity.InterestRate = projectEntity.InterestRate ?? 0;
            initApplicationtransferEntity.RepaymentTypeName = ToolStatus.ConvertRepaymentType(projectEntity.RepaymentType ?? 0);
            initApplicationtransferEntity.Deadline = projectEntity.Deadline ?? 0;
            initApplicationtransferEntity.LowerUnit = projectEntity.LowerUnit ?? 0;
            initApplicationtransferEntity.SubscribeShares = subscribeEntity.SubscribeShares ?? 0;
            initApplicationtransferEntity.Amount = "0";
            initApplicationtransferEntity.InterestAmount = "0";
            //var subscribeDetailList = dbRead.SubscribeDetail.Where(p => p.SubscribeId == subscribeId);
            var subscribeDetailList = new SubscribeDetailBLL().GetSubscribeDetailListBySubscribeId(subscribeId);
            if (subscribeDetailList.Count() > 0)
            {
                initApplicationtransferEntity.Amount = ToolStatus.ConvertLowerMoney(subscribeDetailList.Sum(p => p.Amount));
                initApplicationtransferEntity.InterestAmount = ToolStatus.ConvertLowerMoney(subscribeDetailList.Sum(p => p.InterestAmout.Value));
            }
            initApplicationtransferEntity.RefundedMonths = subscribeEntity.RefundedMonths ?? 0;
            initApplicationtransferEntity.TotalRefundMonths = subscribeEntity.TotalRefundMonths ?? 0;
            initApplicationtransferEntity.PreCycDate = subscribeEntity.PreCycDate.HasValue ? subscribeEntity.PreCycDate.Value.ToString("yyyy-MM-dd") : "";

            string sql = string.Empty;
            if (projectEntity.RepaymentType == 1)//到期还本息
            {
                sql = "SELECT dateDiff(day,@BeginDate,getdate())-1";
            }
            else
            {
                sql = "SELECT dateDiff(day,dbo.f_GetRepaymentAdvance_Date(@BeginDate,@Month),getdate())";
            }
            var para = new Dapper.DynamicParameters();
            para.Add("@BeginDate", subscribeEntity.AddDate);
            para.Add("@Month", subscribeEntity.RefundedMonths);
            initApplicationtransferEntity.Days = PublicConn.QuerySingle<int>(sql, ref para);
            //using (SqlConnection connection = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
            //{
            //    connection.Open();
            //     int day = connection.Query<int>(sql, new { BeginDate = subscribeEntity.AddDate, Month = subscribeEntity.RefundedMonths }).First();
            //    connection.Close();
            //    connection.Dispose();
            //    initApplicationtransferEntity.Days = day;
            //}

            initApplicationtransferEntity.result = 1;
            PrintJson(initApplicationtransferEntity);
        }

        public void GetInterestPayable() { 
            Guid subscribeId = Guid.Empty;
            Guid.TryParse(Context.Request["sid"], out subscribeId);
            int shares = 0;
            int.TryParse(Context.Request["transfershares"], out shares);
            //using (System.Data.SqlClient.SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateReadConnection())
            //{
            string sql = "SELECT ISNULL(dbo.f_TransferPriceCal(@SubscribeId,@shares),0)";
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@SubscribeId", subscribeId);
            dyParams.Add("@shares", shares);
            decimal interestPaya = PublicConn.QueryBySql<decimal>(sql, ref dyParams).Sum();
            //   decimal interestPaya = connection.Query<decimal>(sql, dyParams).Sum();
            PrintJson("1", interestPaya.ToString("0.00")); 
            //} 
        }
        /// <summary>
        /// 计算承接人的年化利率
        /// </summary>
        /// <returns></returns>
        public void GetUndertakeYearRate()
        {
            Guid subscribeId = Guid.Empty;
            Guid.TryParse(Context.Request["subscribeid"], out subscribeId);
            int totalShares = 0;
            int.TryParse(Context.Request["totalshares"], out totalShares);

            decimal totalAmount = 0;
            decimal.TryParse(Context.Request["totalamount"], out totalAmount);

            string sql = "select isnull(dbo.f_GetCurTransferProjectRate(@SubscribeId,@TotalShares,@TotalAmount),0)";

            var whereParas = new Dapper.DynamicParameters();
            whereParas.Add("@SubscribeId", subscribeId);
            whereParas.Add("@TotalShares", totalShares);
            whereParas.Add("@TotalAmount", totalAmount);
            decimal yearRate = 0;
            try
            {
                //using (SqlConnection conn = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
                //{
                //    conn.Open();                    
                //    yearRate = conn.Query<decimal>(sql, whereParas).Sum();
                //    conn.Close();
                //    conn.Dispose();
                //}
                yearRate = PublicConn.QueryBySqlWrite<decimal>(sql, ref whereParas).Sum();
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("计算承接者利率异常", "申购Id:" + subscribeId + "异常:" + ex.Message);
            }
            finally
            {
                PrintJson(yearRate.ToString(), "");
            } 
        }

        //确认申请转让
        public void SubmitTransaction() { 
            Guid subscribeId = Guid.Empty;
            Guid.TryParse(Context.Request["sid"], out subscribeId);
            int transferShares = 0;
            int.TryParse(Context.Request["shares"], out transferShares);
            decimal transferPrice = 0;
            decimal.TryParse(Context.Request["price"], out transferPrice);
            Guid userId = WebUserAuth.UserId.Value;
         
            string payPwd = Context.Request["ppwd"];
            payPwd = Tool.Encryption.MD5(payPwd);
            UserBasicInfoInfo userBasicEntity = new UserBLL().GetUserBasicInfoModelById(userId); 
            if (userBasicEntity == null)
            {
                PrintJson("-31", "登录已过期或未登录");
                return;
            }
            if (!GlobalUtils.IsOpenCGT && !string.IsNullOrEmpty(payPwd) && userBasicEntity.PayPwd != payPwd)
            {
                PrintJson("-32", "交易密码错误");
                return;
            }
            if (string.IsNullOrEmpty(userBasicEntity.TelNo))
            {
                PrintJson("-33", "手机号码未认证");
                return;
            }

            string headImage = userBasicEntity.HeadImage;
            try
            {
                if (headImage.ToText().IsEmpty())
                {
                    //var whereParams = new Dapper.DynamicParameters();
                    Random rnd = new Random();
                    int rndNum = rnd.Next(1, 28);
                    string rndminNum = rndNum.ToString();
                    if (rndNum < 10)
                    {
                        rndminNum = "0" + rndminNum;
                    }
                    headImage = GlobalUtils.TuanDaiURL + "/img/avatar/tdface/tdface" + rndminNum + ".jpg";
                    new TuanDai.PortalSystem.BLL.UserBLL().UpdateUserHeadImage(headImage, userId);
                    //string strSQL = string.Format(@"update UserBasicInfo set HeadImage=@HeadImage where id=@userId");
                    //whereParams.Add("@HeadImage", headImageURL);
                    //whereParams.Add("@userId", userId);
                    ////using (SqlConnection conn = new SqlConnection(TuanDai.Config.BaseConfig.ConnectionString))
                    ////{
                    ////    conn.Open();
                    ////    conn.Execute(strSQL, whereParams);
                    ////    conn.Close();
                    ////    conn.Dispose();
                    ////}
                    //PublicConn.ExecuteTD(PublicConn.DBWriteType.UserWrite, strSQL, ref whereParams);
                }
            }
            catch (Exception ex)
            {
                SysLogHelper.WriteErrorLog("申请转让，更新头像异常", "用户:" + userId + "异常:" + ex.Message);
            }

            if (GlobalUtils.IsOpenCGT && GlobalUtils.IsOpenCgtTrans)
            {
                var reqMode = new TuanDai.CgtCallbackUrl.Model.ModelRequest.SanBiaoTransactionRequest
                {
                    Channel = "MOBILE",
                    UserId = userId.ToString(),
                    subscribeId = subscribeId,
                    transferPrice = transferPrice,
                    transferShares = transferShares,
                    headImageURL = headImage,
                    Version = GlobalUtils.Version
                };

                string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.ApplyZqzr);
                PrintJson("8888", url);
            }
            else
            {
                int outputStatus = 0;
                string msg = string.Empty;
                new TuanDai.PortalSystem.BLL.SubScriberansferBLL().ApplicationTransfer(subscribeId, string.Empty,
                    transferShares, transferPrice, userId, out outputStatus, out msg);

                if (outputStatus == 0)
                {
                    PrintJson("0", "申请转让失败");
                }
                else
                {
                    PrintJson(outputStatus.ToString(), msg);
                }
            }
        }
        #endregion


        #region 私有方法
        protected string GetTenderMode(object oTenderMode)
        {
            string tenderMode = "未知";

            if (oTenderMode != null)
            {
                switch (oTenderMode.ToString())
                {
                    case "1"://1手动投标（PC）
                        tenderMode = "网站投标";
                        break;
                    case "2"://手动投标（移动端）
                        tenderMode = "移动端";
                        break;
                    case "3"://手动投标（移动端）
                        tenderMode = "移动端";
                        break;
                    case "4"://自动投标
                        tenderMode = "自动投标";
                        break;
                    case "5"://We计划
                        tenderMode = "We计划";
                        break;
                    case "6"://触屏版
                    case "7"://手动投标（IOS）
                    case "8"://手动投标（Android）
                        tenderMode = "移动端";
                        break;
                    default:
                        tenderMode = "未知";
                        break;
                }
            }
            return tenderMode;
        }
        private int GetPageCount(int totalItemCount,int pageSize)
        {
            double divide = totalItemCount / pageSize;
            double floor = System.Math.Floor(divide);
            if (totalItemCount % pageSize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数
            return pageCount;
        }
        #endregion


        #region 内部Model
        public class NegotiableInfoExt : NegotiableInfo {
            public string TypeName { get; set; }
            /// <summary>
            /// 待收本息
            /// </summary>
            public string DueInAmount { get; set; }
            //下次回款日
            public string PreCycDateStr { get; set; }
            //投标方式
            public string TenderModeName { get; set; }
            /// <summary>
            /// 还款类型
            /// </summary>
            public string RepaymentType { get; set; }
            /// <summary>
            /// 利率
            /// </summary>
            public string InterestRate { get; set; }
        }
        public class SubScribeTransferInfoExt : SubScribeTransferInfo
        {
            /// <summary>
            /// 转让本金
            /// </summary>
            public string SumTransferAmount { get; set; }
            /// <summary>
            /// 转让价
            /// </summary>
            public string TotalAmountStr { get; set; }
            public string ProgressStr { get; set; }
            public string LastTimeStr { get; set; }
            //剩余秒数
            public long LastSecond { get; set; }
        }
        #endregion

    }
}