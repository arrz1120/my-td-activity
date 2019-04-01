using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using Newtonsoft.Json;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.SMS.Client;
using TuanDai.WXApiWeb.Member.Repayment;
using Tool;
using TuanDai.WXSystem.Core;
using TuanDai.ZXSystem.BLL;
using TuanDai.ZXSystem.Model;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// BorrowAjax 的摘要说明
    /// </summary>
    public class BorrowAjax : SafeHandlerBase
    {
        protected int pagesize = 15;
        private Guid userid = WebUserAuth.UserId.Value;
        private int totalItemCount = 0;
        /// <summary>
        /// 智享发起记录
        /// </summary>
        public void GetMyBorrowRecord()
        {
            string statusStr = Tool.SafeConvert.ToString(Context.Request.Form["status"]);
            int status = 1;
            if (statusStr == "Finished")
            {
                status = 2;
            }
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            int total = 0;
            JsonDemo1 jd = new JsonDemo1();
            var list = new ZXWXSelectBLL().GetZXWxBorrowList(userid, pageindex, pagesize, status, out total);
            totalItemCount = total;
            jd.borrowList = list;
            jd.pageCount = GetPageCount(total,pagesize);

            PrintJson("1", JsonConvert.SerializeObject(jd));
        }
        /// <summary>
        /// 智享 获得回款还款明细 按天汇总列表  （页面上点击月份事件）
        /// </summary>
        public void GetZxReturnAndPayDetail()
        {
            int year = Tool.SafeConvert.ToInt32(Context.Request.Form["year"], 2016);
            int month = Tool.SafeConvert.ToInt32(Context.Request.Form["month"], 8);
            DateTime startTime;
            DateTime endTime;
            if (year == DateTime.Now.Year && month == DateTime.Now.Month)
            {
                startTime = DateTime.Parse(DateTime.Now.AddDays(1).ToShortDateString());
                endTime = new DateTime(startTime.AddMonths(1).Year, startTime.AddMonths(1).Month, 1); ;
            }
            else
            {
                startTime = new DateTime(year, month, 1);
                endTime = startTime.AddMonths(1);
            }
            List<MyReturnAndPayInfo> list = new List<MyReturnAndPayInfo>();
            List<ZXWxDueAmountMonth> zxList = new ZXWXSelectBLL().GetZxWxDueAmountMonths(userid, startTime, endTime, 2);
            if (zxList != null && zxList.Count > 0)
            {
                foreach (var item in zxList)
                {
                    MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                    info.myDate = item.cycDate;
                    info.myMonth = item.cycDate;
                    info.payMoney = item.dueOutTotalAmount;
                    info.returnMoney = item.dueInTotalAmount;
                    list.Add(info);
                }
            }
            string resultStr = JsonHelper.ToJson(list);
            PrintJson(resultStr);
        }
        /// <summary>
        /// 智享 获取某一天的回款 还款项目列表 (点击天数)
        /// </summary>
        public void GetZxReturnAndPayByDay()
        {
            string dt = Context.Request.Form["Date"];
            if (dt.Contains("-"))
            {
                dt = DateTime.Parse(Context.Request.Form["Date"]).ToString("yyyyMMdd");
            }
            List<ReturnAndPayProjectDetail> list = new List<ReturnAndPayProjectDetail>();
            List<ZXWxReturnAndPayProjectDetail> returnAndPayProjectDetails =
                new ZXWXSelectBLL().GetReturnAndPayProjectDetails(userid, dt);
            if (returnAndPayProjectDetails != null && returnAndPayProjectDetails.Count > 0)
            {
                list =
                    JsonConvert.DeserializeObject<List<ReturnAndPayProjectDetail>>(
                        JsonConvert.SerializeObject(returnAndPayProjectDetails));
            }
            string resultStr = JsonHelper.ToJson(list);
            PrintJson(resultStr);
        }
        /// <summary>
        /// 获得智享计划回款还款 按月汇总列表
        /// </summary>
        public void GetZxReturnAndPayMonths()
        {
            var startDate = int.Parse(WEBRequest.GetString("startDate"));
            DateTime sTime;
            DateTime eTime;
            if (startDate == 1)
            {
                sTime = DateTime.Parse(DateTime.Now.AddDays(1).ToShortDateString());
                eTime =
                    new DateTime(DateTime.Now.AddMonths(3).Year, DateTime.Now.AddMonths(3).Month, 1).AddMilliseconds(-1);
            }
            else
            {
                sTime = new DateTime(DateTime.Now.AddMonths(3 * (startDate - 1)).Year,
                    DateTime.Now.AddMonths(3 * (startDate - 1)).Month, 1);
                eTime =
                    new DateTime(DateTime.Now.AddMonths(3 * (startDate)).Year, DateTime.Now.AddMonths(3 * (startDate)).Month,
                        1).AddMilliseconds(-1);
            }


            MyReturnAndPayList myList = new MyReturnAndPayList();
            List<MyReturnAndPayInfo> list = new List<MyReturnAndPayInfo>();
            List<ZXWxDueAmountMonth> zxList = new ZXWXSelectBLL().GetZxWxDueAmountMonths(userid, sTime, eTime, 1);
            if (zxList != null && zxList.Count > 0)
            {
                foreach (var item in zxList)
                {
                    MyReturnAndPayInfo info = new MyReturnAndPayInfo();
                    info.myDate = item.cycDate;
                    info.myMonth = item.cycDate;
                    info.payMoney = item.dueOutTotalAmount;
                    info.returnMoney = item.dueInTotalAmount;
                    list.Add(info);
                }
            }
            myList.list = list;
            string resultStr = JsonHelper.ToJson(myList);
            PrintJson(resultStr);
        }
        #region 我的借款记录
        /// <summary>
        /// 获取我的借款记录列表
        /// </summary>
        public void GetMyLoanShowList()
        {
            int pagesize = GlobalUtils.PageSize;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            int status = Tool.SafeConvert.ToInt32(Context.Request.Form["statusStr"], 0);
            string userId = Tool.SafeConvert.ToString(Context.Request.Form["userId"]);
            Guid uId = WebUserAuth.UserId.Value;
            if (uId == Guid.Empty)
            {
                if (string.IsNullOrEmpty(userId))
                    uId = Guid.NewGuid();
                else
                    uId = Guid.Parse(userId);
            }
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            WXMyLoanList_Info myLoanModel = bll.WXGetMyLoanList(uId, status, pageindex, pagesize, out totalcount);

            if (myLoanModel != null && myLoanModel.List.Count() > 0)
            {
                int index = 1;
                int pageCount = GetPageCount(totalcount, pagesize);//总页数

                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXSubMyLoanList_Info temp in myLoanModel.List)
                {
                    sb.Append("{\"Id\":\"" + temp.ProjectId + "\",\"Title\":\"" + temp.Title + "\",\"ProjectType\":\"" + ToolStatus.ConvertProjectType(temp.Type)
                           + "\",\"Amount\":\"" + Tool.MoneyHelper.ConvertDetailWanMoney(temp.Amount) + "\",\"HaveBorrowedAmount\":\"" + Tool.MoneyHelper.ConvertDetailWanMoney(temp.HaveBorrowedAmount)
                           + "\",\"ProcessStr\":\"" + borrowLog.GetProcessStr(temp) + "\",\"MonthsStr\":\"" + borrowLog.GetMonthsStr(temp)
                           + "\",\"PrincipalInterest\":\"" + Tool.MoneyHelper.ConvertDetailWanMoney(myLoanModel.PrincipalInterest)
                           + "\",\"LinkUrl\":\"" + borrowLog.GetLinkUrl(temp)
                           + "\",\"CircleCss\":\"" + borrowLog.GetCircleCss(temp)
                           + "\",\"AddDate\":\"" + Convert.ToDateTime(temp.AddDate).ToString("yyyy-MM-dd")
                           + "\",\"DeadlineStr\":\"" + borrowLog.GetDeadlineStr(temp)
                           + "\",\"InterestRate\":\"" + ToolStatus.DeleteZero(temp.InterestRate));

                    if (index == myLoanModel.List.Count())
                    {
                        sb.Append("\"}]}");
                    }
                    else
                    {
                        sb.Append("\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        #endregion

        #region 我的账单
        /// <summary>
        /// 获取我的账单记录
        /// </summary>
        public void GetMyBillsShowList()
        {
            int pagesize = 10;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            TuanDai.PortalSystem.Model.WebSettingInfo webset = new WebSettingBLL().GetWebSettingInfo("42E7BF6F-74F0-4375-A614-00AD81A4638E");
            if (webset == null)
            {
                webset = new TuanDai.PortalSystem.Model.WebSettingInfo();
                webset.Param1Value = "6";
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            WXMyBillsInfo myBillModel =new my_bills().WXGetMyBills(WebUserAuth.UserId.Value, pageindex, GlobalUtils.PageSize,DateTime.Now.AddDays(-int.Parse(webset.Param1Value)).ToDateString());
            if (myBillModel == null)
            {
                myBillModel = new WXMyBillsInfo();
            }

            if (myBillModel != null)
            {
                //思路：先从主库取数据，再从大数据取数据衔接
                totalcount = myBillModel.TotalCount;
                int index = 1;
                int pageCount = GetPageCount(totalcount, pagesize);//总页数  主库数据页数
                int firstPageSize = 10;
                int newPageIndex = 0;
                if (pageindex >= pageCount)
                {
                    newPageIndex = pageindex - pageCount + 1;
                    firstPageSize = 10 - (totalcount % pagesize);
                }

                var bigModel = new my_bills().WXGetMyBillsFromBigData(WebUserAuth.UserId.Value, DateTime.Now.AddMonths(-2), DateTime.Now.AddDays(-int.Parse(webset.Param1Value)), newPageIndex, 10, firstPageSize);
                if (bigModel == null)
                {
                    bigModel =new WXMyBillsInfo();
                }
                if (pageindex >= pageCount && bigModel.List != null)
                {
                    myBillModel.List.AddRange(bigModel.List);
                }

                totalcount += bigModel.TotalCount;  //加上大数据的近两个月总条数
                pageCount = GetPageCount(totalcount, pagesize);//加上大数据的近两个月总页数

                if (myBillModel.List != null && myBillModel.List.Count > 0)
                {
                    sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"" + pageCount +
                              "\",\"list\":[");
                    foreach (WXMyBillDetialInfo temp in myBillModel.List)
                    {
                        if (index == myBillModel.List.Count())
                        {
                            sb.Append("{\"Title\":\"" + my_bills.GetBillTitle(temp) + "\",\"BillDate\":\"" +
                                      Convert.ToDateTime(temp.BillDate).ToString("yyyyMM") + "\",\"OperateStr\":\"" +
                                      (temp.PayOutAmount > 0 ? "-" : "+")
                                      + "\",\"Amount\":\"" +
                                      Tool.MoneyHelper.ConvertDetailWanMoney((temp.PayOutAmount ?? 0) > 0
                                          ? temp.PayOutAmount
                                          : (temp.InAmount ?? 0))
                                      + "\",\"BillType\":\"" + my_bills.GetBillType(temp)
                                      + "\",\"Day\":\"" + temp.BillDate.ToString("MM-dd")
                                      + "\",\"Hour\":\"" + temp.BillDate.ToString("HH:mm:ss")
                                      + "\",\"Year\":\"" + temp.BillDate.ToString("yyyy")
                                      + "\",\"Month\":\"" + temp.BillDate.ToString("MM")
                                      + "\",\"Id\":\"" + temp.Id
                                      + "\"}]}");
                        }
                        else
                        {
                            sb.Append("{\"Title\":\"" + my_bills.GetBillTitle(temp) + "\",\"BillDate\":\"" +
                                      Convert.ToDateTime(temp.BillDate).ToString("yyyyMM") + "\",\"OperateStr\":\"" +
                                      (temp.PayOutAmount > 0 ? "-" : "+")
                                      + "\",\"Amount\":\"" +
                                      Tool.MoneyHelper.ConvertDetailWanMoney((temp.PayOutAmount ?? 0) > 0
                                          ? temp.PayOutAmount
                                          : (temp.InAmount ?? 0))
                                      + "\",\"BillType\":\"" + my_bills.GetBillType(temp)
                                      + "\",\"Day\":\"" + temp.BillDate.ToString("MM-dd")
                                      + "\",\"Hour\":\"" + temp.BillDate.ToString("HH:mm:ss")
                                      + "\",\"Year\":\"" + temp.BillDate.ToString("yyyy")
                                      + "\",\"Month\":\"" + temp.BillDate.ToString("MM")
                                      + "\",\"Id\":\"" + temp.Id
                                      + "\"},");
                        }
                        index++;
                    }
                }
                else
                {
                    sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"0\"}");
                }
                
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        /// <summary>
        /// 获取投资记录
        /// </summary>
        public void GetInvestmentsRecordsList()
        {

        }
        /// <summary>
        /// 获取借款记录
        /// </summary>
        public void LoadBorrowingRecordsList()
        {
        }
        /// <summary>
        /// 获取充值记录
        /// </summary>
        public void LoadRechargeRecordsList()
        {
        }
        /// <summary>
        /// 获取提现记录
        /// </summary>
        public void LoadWithdrawRecordsList()
        {
        }

        #endregion

        #region 股票配资--补仓
        public void AddGPMargin()
        {
            Guid projectId = WEBRequest.GetFormGuid("ProjectId");
            decimal amount = Decimal.Parse(WEBRequest.GetFormString("Amount"));
            string payPwd = WEBRequest.GetFormString("PayPwd");
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == null)
            {
                this.PrintJson("-3", "对不起，您还未登录!");
                return;
            }
            ProjectBLL bll = new ProjectBLL();
            string strResult = bll.WXGPAddMargin(userId, projectId, payPwd, amount);
            if (strResult.ToText() == "")
            {
                this.PrintJson("1", "补仓成功!");
                return;
            }
            else
            {
                this.PrintJson("0", strResult);
            }
        }
        #endregion

        #region 提前还款
        public void PrepaymentSubmit()
        {
            Guid projectId = WEBRequest.GetFormGuid("ProjectId");
            string payPwd = WEBRequest.GetFormString("TranPwd");
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == null || userId == Guid.Empty)
            {
                this.PrintJson("-3", "对不起，您还未登录!");
                return;
            }

            if (GlobalUtils.IsOpenCGT)
            {
                TuanDai.CgtCallbackUrl.Model.ModelRequest.PreReturnMoney reqMode = new TuanDai.CgtCallbackUrl.Model.ModelRequest.PreReturnMoney();
                reqMode.UserId = userId.ToString();
                List<Guid> listProject = new List<Guid>();
                listProject.Add(projectId);
                reqMode.ProjectIds = listProject;
                string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.Prepayment);
                PrintJson("8888", url);
            }
            else
            {
                ProjectBLL bll = new ProjectBLL();
                string errorMsg = bll.PrepaymentSubmit(projectId, userId, payPwd);
                if (errorMsg != "")
                {
                    this.PrintJson("-2", errorMsg);
                    return;
                }

                //TuanDai.WXApiWeb.Common.SubscribeMsgHelper msghelper = new Common.SubscribeMsgHelper();
                //推送提前还款信息到App
                //msghelper.AsyncSubscribeUserToMsg(projectId);

                //向所有投资者发送短信通知用户提前还款
                //msghelper.SyncSendPhoneMsgToSubcribeUsers(projectId);
                SyncSendPhoneMsgToSubcribeUsers(projectId);

                SysLogHelper.WriteTraceLog("提前还款", "用户Id:" + userId.ToText() + " ProjectId:" + projectId.ToText());

                this.PrintJson("1", "");
                return;
            }
            
        }
        private delegate void SubscribeFullHandler(Guid projectId);
        /// <summary>
        /// 异步向所有投资者发送短信通知用户提前还款
        /// </summary>
        /// <param name="projectId"></param>
        public void SyncSendPhoneMsgToSubcribeUsers(Guid projectId)
        {
            SubscribeFullHandler handler = new SubscribeFullHandler(DoSyncSendPhoneMsgToSubcribeUsers);
            handler.BeginInvoke(projectId, null, null);
        }
        /// <summary>
        /// 异步向所有投资者发送短信通知用户提前还款
        /// </summary>
        /// <param name="projectId"></param>
        private void DoSyncSendPhoneMsgToSubcribeUsers(Guid projectId)
        {
            var smsRequestPrepaymentRemind = new SmsRequest();
            smsRequestPrepaymentRemind.EventCode = MsgTemplatesType.PrepaymentRemind;
            smsRequestPrepaymentRemind.PlatformSource = PlatformSource.WeiXin;
            smsRequestPrepaymentRemind.Parameters = new Dictionary<string, object>();
            smsRequestPrepaymentRemind.Parameters.Add("ProjectId", projectId.ToString());
            string errorString = string.Empty;
            SmsClient.SendMessage(smsRequestPrepaymentRemind, ref errorString);

            if (!string.IsNullOrEmpty(errorString))
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName,
                    "WXInvest/DoSyncSendPhoneMsgToSubcribeUsers",
                    JsonConvert.SerializeObject(smsRequestPrepaymentRemind), errorString);
            }
        }

        #endregion

        #region 私有方法
        private int GetPageCount(int totalcount, int pageSize)
        {
            double divide = totalcount / pageSize;
            double floor = System.Math.Floor(divide);
            if (totalcount % pageSize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数
            return pageCount;
        }
        #endregion

        public class JsonDemo1
        {
            public int totalCount;
            public List<ZXWxInvestRecord> list;
            public List<ZXWxBorrowList> borrowList;
            public int pageCount;
        }

    }
}