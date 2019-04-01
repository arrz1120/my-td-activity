﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using Newtonsoft.Json;
using TuanDai.BuyWePlan.Client;
using TuanDai.CunGuanTong.Client;
using TuanDai.Enums;
using TuanDai.Enums.Sms;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.DAL;
using TuanDai.PortalSystem.Model;
using System.Text;
using Tool;
using System.Data.SqlClient;
using System.Data;
using System.Data.Objects;
using Dapper;
using TuanDai.ServerContract;
using TuanDai.SMS.Client;
using TuanDai.Subscribe.Client;
using TuanDai.UserPrize.Client;
using TuanDai.UserPrize.Model.RequestModel;
using TuanDai.WXApiWeb.Member.Bank;
using TuanDai.WXSystem.Core;
using TuanDai.InfoSystem.Model;
using BusinessDll;
using TuanDai.PortalSystem.Model.Enums;
using TuanDai.DProject.Client;
using System.Configuration;
using TuanDai.CgtCallbackUrl.Model.ModelRequest;
using TuanDai.WXApiWeb.pages.invest.WE; 
using TuanDai.PortalSystem.Redis;
using Newtonsoft.Json.Converters;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// 投资项目Ajax处理
    /// Allen 2015-05-16
    /// </summary>
    public class InvestAjax : SafeHandlerBase
    {

        public void updateprojectstatus()
        {
            Guid projecId = Guid.Parse(Context.Request.Form["ProjectId"]);
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                PrintJson("-99", "登录已失效");
            }
            if (projecId == Guid.Empty)
            {
                PrintJson("-1", "此标的不存在");
            }
            ProjectDetailInfo pModel = new ProjectBLL().GetProjectDetailInfo(projecId);
            int? oldType = pModel.Status;
            if (pModel.Status != 2)
            {
                PrintJson("-4", "此标的不支持结束发标");
            }
            if (pModel.Type != 6 && pModel.Type != 7)
            {
                PrintJson("-3", "只支持结束资产标");
            }

            if (GlobalUtils.IsOpenCGT)
            {
                var reqMode = new StopProjectRequest
                {
                    Channel = "MOBILE",
                    ProjectId = projecId,
                    Status = "7",
                    UserId = userid.ToString(),
                    Version = GlobalUtils.Version
                };

                string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.EndProject);
                PrintJson("8888", url);
            }
            else
            {
                //验证交易密码
                var bll = new UserSettingBLL();
                var usersetting = bll.GetUserSettingInfo(userid);
                var model = new UserBLL().GetUserBasicInfoModelById(userid);
                if (usersetting != null)
                {
                    #region 验证交易密码

                    if (usersetting.PayPwdErrorDate.HasValue)
                    {
                        DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
                        DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
                        if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
                        {
                            PrintJson("-151", "交易密码已错误5次，请24小时后再进行此操作");
                        }
                        if (date1 != date2 && usersetting.PayPwdErrorCount > 1)
                        {
                            usersetting.PayPwdErrorCount = 0;
                            usersetting.PayPwdErrorDate = null;
                        }
                    }
                    string PayPwd = Tool.Encryption.MD5(Context.Request["tranPwd"]);
                    if (PayPwd != model.PayPwd)
                    {
                        //记录登录错误次数
                        if (usersetting.PayPwdErrorCount == null)
                        {
                            usersetting.PayPwdErrorCount = 0;
                        }
                        usersetting.PayPwdErrorCount += 1;
                        usersetting.PayPwdErrorDate = DateTime.Now;
                        bll.UpdateUserSettingInfo(usersetting);
                        PrintJson("-15", "交易密码错误还剩下：" + (5 - usersetting.PayPwdErrorCount).ToString() + "次");
                    }
                    else
                    {
                        //清除错误记录
                        usersetting.PayPwdErrorCount = 0;
                        usersetting.PayPwdErrorDate = null;
                        bll.UpdateUserSettingInfo(usersetting);
                    }

                    #endregion
                }


                var result = new ProjectBLL().WXUpdateProjectStatus(projecId);
                if (result)
                {
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.BusinessId = pModel.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                    log.Id = Guid.NewGuid().ToString();
                    log.HandlerTypeId = (int)ConstString.LogType.ProjectStatus;
                    string ssss = WebUserAuth.UserName;
                    log.UserId = WebUserAuth.UserId.Value.ToString();
                    log.UserTypeId = (int)ConstString.LogUserType.ManagerUser;
                    log.Content1 = "将标 " + pModel.Title + " 中的项目状态由 " +
                                   Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.ProjectStatus),
                                       oldType) + " 修改为：" +
                                   Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.ProjectStatus),
                                       pModel.Status.Value) + "。";
                    WebLogInfo.WriteLoginHandler(log);
                    PrintJson("1", "结束发标成功");
                }
                else
                {
                    PrintJson("-2", "结束发标失败");
                }
            }
        }
        /// <summary>
        /// 获取还款记录
        /// </summary>
        public void GetSubscribeDetailList()
        {
            int pagesize = Tool.SafeConvert.ToInt32(Context.Request.Form["pagesize"], 15);
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageindex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid projectid = Tool.SafeConvert.ToGuid(Context.Request.Form["projectid"]) ?? Guid.Empty;
            if (projectid == Guid.Empty)
            {
                this.PrintJson("-1", "项目编号有误");
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                int totalcount = 0;

                IList<PortalSystem.Model.SubscribeDetailInfo> list = new SubscribeDetailBLL().GetSubscribeDetailList(projectid, pageindex, pagesize, out totalcount);
                //处理逾期信息
                string sql = @"select PenaltyAmount,OverDueInterest,SubscribeId,periods,SubscribeUserId from OverDueRecord with(nolock) where ProjectId=@ProjectId";
                Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@ProjectId", projectid);
                IList<OverDueRecordInfo> overDueList = TuanDai.DB.TuanDaiDB.Query<OverDueRecordInfo>(TdConfig.DBRead, sql, ref dyParams);

                if (list != null && list.Count() > 0)
                {
                    int index = 1;
                    sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                    decimal totalAmount = 0;
                    foreach (PortalSystem.Model.SubscribeDetailInfo temp in list)
                    {
                        
                        totalAmount = Convert.ToDecimal(temp.RealAmount) + Convert.ToDecimal(temp.RealInterestAmout);
                        int dueDays = (DateTime.Now.Date - temp.CycDate.Value.Date).Days;
                        //逾期利息
                        Decimal? OverDueInterest = 0;
                        //滞纳金
                        Decimal PenaltyAmount = 0;
                        if (dueDays > 0 && overDueList != null)
                        {
                            OverDueRecordInfo overDueRecordInfo = overDueList.SingleOrDefault(o => o.periods == temp.Periods && o.SubscribeUserId == temp.UserId && o.SubscribeId == temp.SubscribeId);
                            if (overDueRecordInfo != null)
                            {
                                OverDueInterest = overDueRecordInfo.OverDueInterest;
                                PenaltyAmount = overDueRecordInfo.PenaltyAmount;

                            }
                        }

                        if (index == list.Count())
                        {
                            sb.Append("{\"TotalAmount\":\"" + ToolStatus.ConvertDetailWanMoney(totalAmount) + "\",\"OverDueInterest\":\"" + ToolStatus.ConvertDetailWanMoney(OverDueInterest) + "\",\"PenaltyAmount\":\"" + ToolStatus.ConvertDetailWanMoney(PenaltyAmount) + "\",\"DueDay\":\"" + (DateTime.Now.Date - temp.CycDate.Value.Date).Days + "\",\"CycDate\":\"" + temp.CycDate.Value.ToString("yyyy-MM-dd") + "\",\"Status\":\"" + temp.Status + "\",\"StrStatus\":\"" + temp.StrStatus
                                + "\",\"Amount\":\"0\",\"AmountInterest\":\"" + ToolStatus.ConvertDetailWanMoney(temp.RealAmount) + "\",\"RealInterestAmount\":\"" + ToolStatus.ConvertDetailWanMoney(temp.RealInterestAmout) + "\"}]}");
                        }
                        else
                        {
                            sb.Append("{\"TotalAmount\":\"" + ToolStatus.ConvertDetailWanMoney(totalAmount) + "\",\"OverDueInterest\":\"" + ToolStatus.ConvertDetailWanMoney(OverDueInterest) + "\",\"PenaltyAmount\":\"" + ToolStatus.ConvertDetailWanMoney(PenaltyAmount) + "\",\"DueDay\":\"" + (DateTime.Now.Date - temp.CycDate.Value.Date).Days + "\",\"CycDate\":\"" + temp.CycDate.Value.ToString("yyyy-MM-dd") + "\",\"Status\":\"" + temp.Status + "\",\"StrStatus\":\"" + temp.StrStatus
                                + "\",\"Amount\":\"0\",\"AmountInterest\":\"" + ToolStatus.ConvertDetailWanMoney(temp.RealAmount) + "\",\"RealInterestAmount\":\"" + ToolStatus.ConvertDetailWanMoney(temp.RealInterestAmout) + "\"},");
                        }
                        index++;
                    }
                }
                else
                {
                    sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
                }
                this.Context.Response.Write(sb.ToString());
                this.Context.Response.End();
            }
        }

        #region 获取投资项目列表
        /// <summary>
        /// 获取投资项目列表
        /// </summary>
        public void GetProjectShowList()
        {
            int pagesize = GlobalUtils.PageSize;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            string queryType = Tool.WEBRequest.GetString("queryType");
            int orderByDesc = Tool.SafeConvert.ToInt32(Context.Request.Form["orderByDesc"], 1);
            int orderByType = queryType.IsIn("filter", "queryByDefault") ? 0 : (queryType == "queryByRate" ? 1 : 2);
            int projectType = Tool.SafeConvert.ToInt32(Context.Request.Form["projectType"], 0);
            int startYearRate = Tool.WEBRequest.GetFormInt("startYearRate", 0);
            int endYearRate = Tool.WEBRequest.GetFormInt("endYearRate", 0);
            int startDeadline = Tool.WEBRequest.GetFormInt("startDeadline", 0);
            int endDeadline = Tool.WEBRequest.GetFormInt("endDeadline", 0);
            int startDeadType = Tool.WEBRequest.GetFormInt("startDeadType", 1);
            int endDeadType = Tool.WEBRequest.GetFormInt("endDeadType", 1);

            if (pageindex < 1)
            {
                pageindex = 1;
            }
            int orderByYearRate = 0, orderByDeadline = 0;
            if (orderByType == 0)
            {
                orderByYearRate = 0;
                orderByDeadline = 0;
            }
            else if (orderByType == 1)
            {
                //按利率
                orderByYearRate = orderByDesc;
                orderByDeadline = 0;
            }
            else
            {
                //利期限
                orderByYearRate = 0;
                orderByDeadline = orderByDesc;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            ProjectListRequest projectRequest = new ProjectListRequest();
            projectRequest.RequestSource = 2;
            projectRequest.ProjectType = projectType;
            projectRequest.PageSize = pagesize;
            projectRequest.PageIndex = pageindex;
            projectRequest.OrderByDeadline = orderByDeadline;
            projectRequest.OrderByYearRate = orderByYearRate;
            projectRequest.StartYearRate = startYearRate;
            projectRequest.EndYearRate = endYearRate;
            projectRequest.StartDeadline = startDeadline;
            projectRequest.EndDeadline = endDeadline;
            projectRequest.StartDeadType = startDeadType;
            projectRequest.EndDeadType = endDeadType;

            List<WXProjectListInfo> list = bll.WXGetProjectShowList(projectRequest, out totalcount);

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                double divide = totalcount / pagesize;
                double floor = System.Math.Floor(divide);
                if (totalcount % pagesize != 0)
                    floor++;
                int pageCount = Convert.ToInt32(floor);//总页数 

                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXProjectListInfo temp in list)
                {
                    string newHandPlusRate = "";
                    if (temp.IsNewHand)
                    {
                        newHandPlusRate = ToolStatus.DeleteZero(temp.NewHandRate);
                    }
                    sb.Append("{\"TypeName\":\"" + invest_list.GetTypeName(temp.TypeId, temp.SubTypeId) + "\",\"Title\":\"" + invest_list.FilterProjectName(temp.TypeId, temp.Title) + "\",\"YearRate\":\"" + invest_list.GetProjectYearRate(temp)
                          + "\",\"DeadType\":\"" + temp.DeadType + "\",\"Deadline\":\"" + invest_list.GetProjectShowDeadline(temp) + "\",\"SurplusAmount\":\"" + GetProjectSurplusMoney(temp)
                          + "\",\"Progress\":\"" + temp.Progress + "\",\"PrincipalStr\":\"" + temp.PrincipalInterestSecured + "\",\"ProfitTypeId\":\"" + temp.ProfitTypeId
                          + "\",\"CastInterest\":\"" + temp.CastInterest + "\",\"LinkUrl\":\"" + invest_list.GetClickUrl(temp.TypeId, temp.SubTypeId, temp.Id)
                          + "\",\"TuandaiRate\":\"" + temp.TuandaiRate
                          + "\",\"RepaymentTypeString\":\"" + TuanDai.WXApiWeb.CommUtils.GetRepaymentTypeString(temp.RepaymentType)
                          + "\",\"NewHandRate\":\"" + newHandPlusRate
                          + "\",\"TypeId\":\"" + temp.TypeId);
                    if (index == list.Count())
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
                sb.Append("{\"result\":\"0\", \"totalcount\":\"" + totalcount + "\",\"pagecount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        /// <summary>
        /// 获取债权转让投资项目列表
        /// </summary>
        public void GetZQZRProjectShowList()
        {
            int pagesize = GlobalUtils.PageSize;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            string queryType = Tool.WEBRequest.GetString("queryType");
            int orderByDesc = Tool.SafeConvert.ToInt32(Context.Request.Form["orderByDesc"], 1);
            int orderByType = queryType.IsIn("filter", "queryByDefault") ? 0 : (queryType == "queryByRate" ? 1 : 2);
            int projectType = Tool.SafeConvert.ToInt32(Context.Request.Form["projectType"], 0);
            int startYearRate = Tool.WEBRequest.GetFormInt("startYearRate", 0);
            int endYearRate = Tool.WEBRequest.GetFormInt("endYearRate", 0);
            int startDeadline = Tool.WEBRequest.GetFormInt("startDeadline", 0);
            int endDeadline = Tool.WEBRequest.GetFormInt("endDeadline", 0);
            int startDeadType = Tool.WEBRequest.GetFormInt("startDeadType", 1);
            int endDeadType = Tool.WEBRequest.GetFormInt("endDeadType", 1);

            if (pageindex < 1)
            {
                pageindex = 1;
            }
            int orderByYearRate = 0, orderByDeadline = 0;
            if (orderByType == 0)
            {
                orderByYearRate = 0;
                orderByDeadline = 0;
            }
            else if (orderByType == 1)
            {
                //按利率
                orderByYearRate = orderByDesc;
                orderByDeadline = 0;
            }
            else
            {
                //利期限
                orderByYearRate = 0;
                orderByDeadline = orderByDesc;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            ProjectListRequest projectRequest = new ProjectListRequest();
            projectRequest.RequestSource = 2;
            projectRequest.ProjectType = projectType;
            projectRequest.PageSize = pagesize;
            projectRequest.PageIndex = pageindex;
            projectRequest.OrderByDeadline = orderByDeadline;
            projectRequest.OrderByYearRate = orderByYearRate;
            projectRequest.StartYearRate = startYearRate;
            projectRequest.EndYearRate = endYearRate;
            projectRequest.StartDeadline = startDeadline;
            projectRequest.EndDeadline = endDeadline;
            projectRequest.StartDeadType = startDeadType;
            projectRequest.EndDeadType = endDeadType;

            List<WXProjectListInfo> list = bll.WXGetZQZRProjectShowList(projectRequest, out totalcount);

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                double divide = totalcount / pagesize;
                double floor = System.Math.Floor(divide);
                if (totalcount % pagesize != 0)
                    floor++;
                int pageCount = Convert.ToInt32(floor);//总页数 

                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"pagecount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXProjectListInfo temp in list)
                {
                    string newHandPlusRate = "";
                    if (temp.IsNewHand)
                    {
                        newHandPlusRate = ToolStatus.DeleteZero(temp.NewHandRate);
                    }
                    sb.Append("{\"TypeName\":\"" + invest_list.GetTypeName(temp.TypeId, temp.SubTypeId) + "\",\"Title\":\"" + invest_list.FilterProjectName(temp.TypeId, temp.Title) + "\",\"YearRate\":\"" + invest_list.GetProjectYearRate(temp)
                          + "\",\"DeadType\":\"" + temp.DeadType + "\",\"Deadline\":\"" + invest_list.GetProjectShowDeadline(temp) + "\",\"SurplusAmount\":\"" + GetProjectSurplusMoney(temp)
                          + "\",\"Progress\":\"" + temp.Progress + "\",\"PrincipalStr\":\"" + temp.PrincipalInterestSecured + "\",\"ProfitTypeId\":\"" + temp.ProfitTypeId
                          + "\",\"CastInterest\":\"" + temp.CastInterest + "\",\"LinkUrl\":\"" + invest_list.GetClickUrl(temp.TypeId, temp.SubTypeId, temp.Id)
                          + "\",\"TuandaiRate\":\"" + temp.TuandaiRate
                          + "\",\"RepaymentTypeString\":\"" + TuanDai.WXApiWeb.CommUtils.GetRepaymentTypeString(temp.RepaymentType)
                          + "\",\"NewHandRate\":\"" + newHandPlusRate
                          + "\",\"TypeId\":\"" + temp.TypeId);
                    if (index == list.Count())
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
                sb.Append("{\"result\":\"0\", \"totalcount\":\"" + totalcount + "\",\"pagecount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        protected string GetProjectSurplusMoney(WXProjectListInfo itemInfo)
        {
            decimal amount = ((itemInfo.TotalShares ?? 0) - (itemInfo.CastedShares ?? 0)) * itemInfo.LowerUnit;
            return string.Format("<span>{0}</span>{1}", (amount >= 10000) ? ToolStatus.ConvertWanMoney(amount) : ToolStatus.ConvertLowerMoney(amount), (amount >= 10000) ? "万" : "元");
        }
        #endregion

        #region 获取用户投资时金额
        /// <summary>
        /// 获取用户投资时金额
        /// </summary>
        public void GetUserInvestMoney()
        {
            string strProjectId = WEBRequest.GetString("projectId");
            if (strProjectId.ToText().IsEmpty())
            {
                PrintJson("0", "参数传入异常");
                return;
            }
            Guid ProjectId = SafeConvert.ToGuid(strProjectId).Value;
            Guid userId = TuanDai.WXApiWeb.WebUserAuth.UserId.Value;
            ProjectBLL projectbll = new ProjectBLL();
            ProjectDetailInfo project = projectbll.GetProjectDetailInfo(ProjectId);
            if (project == null)
            {
                //PrintJson("0", "该笔数据已不存在");
                GetZQZRSubscribe();
                return;
            }
            decimal aviMoney = 0;
            int level = 0;
            InvestMoneyInfo moneyInfo = new InvestMoneyInfo();
            moneyInfo.IsLogin = WebUserAuth.IsAuthenticated ? 1 : 0;
            moneyInfo.IsNewHandProject = (project.IsNewHand && (project.TuandaiRate ?? 0) > 0) ? 1 : 0;//标记是否新手标

            if (moneyInfo.IsLogin == 1)
            {
                var fundAccount = new UserBLL().WXGetUserBill(userId);
                var model = new UserBLL().GetUserBasicInfoModelById(userId);
                moneyInfo.AviMoney = fundAccount.AviMoney;
                aviMoney = fundAccount.AviMoney;
                level = model.Level.Value;
                var rInfo = new UserRiskEvaluationBLL().GetAssassTimeThisYear(userId, TdConfig.ApplicationName);
                if (rInfo == null)
                {
                    moneyInfo.IsRisk = false;
                }
                else
                {
                    moneyInfo.IsRisk = true;
                }
            }

            int maxUnit = 0, nowUnit = 1;
            double PublisherRate = 0, TuandaiRate = 0;
            decimal expected = 0, LowerUnit = 0, RewardAmount = 0, perAmout = 0;
            int shares = project.TotalShares.Value - (project.CastedShares ?? 0);
            decimal amount = project.LowerUnit.Value * shares;

            LowerUnit = project.LowerUnit.Value;
            if (aviMoney > amount)
            {
                maxUnit = (int)(amount / project.LowerUnit.Value);
            }
            else
            {
                maxUnit = (int)(aviMoney / project.LowerUnit.Value);
            }
            PublisherRate = project.PublisherRate ?? 0;
            TuandaiRate = moneyInfo.IsNewHandProject == 1 ? 0 : (project.TuandaiRate ?? 0); //新手标时这里为0
            moneyInfo.MaxUnit = maxUnit;//最大出借份数

            if (project.Type == 17)
            {
                perAmout = LowerUnit * project.InterestRate.Value / 100 * project.Deadline.Value / 365;
                expected = (project.LowerUnit.Value * nowUnit) * project.InterestRate.Value / 100 * project.Deadline.Value / 365;
            }

            int deadLine = 12;
            if (project.DeadType == 2)
            {
                deadLine = 365;
            }

            RewardAmount = (Convert.ToDecimal(PublisherRate) * nowUnit * LowerUnit * project.Deadline.Value / 100) / deadLine +
                           (Convert.ToDecimal(TuandaiRate) * nowUnit * LowerUnit * project.Deadline.Value / 100) / deadLine;

            //计算佣金
            //Guid wsId = Guid.Parse("b7acf6d5-001b-4012-941a-71633f6a9244");
            //WebSetting ws = db.WebSetting.FirstOrDefault(p => p.Id == wsId);
            var ws = new WebSettingBLL().GetWebSettingInfo("b7acf6d5-001b-4012-941a-71633f6a9244");
            string investcommissionrate1 = ws.Param1Value;//收取普通用户投资人佣金税率
            string investcommissionrate2 = ws.Param2Value;//收取特权用户投资人佣金税率

            if ((int)ConstString.UserType.VipUser == level || project.Type == 6 || project.Type == 7)
            {
                moneyInfo.CommissionMoney = "0";
            }
            else
            {
                moneyInfo.CommissionMoney = ((decimal)((double)expected * double.Parse(investcommissionrate1) / 100)).ToString();
            }
            //预期收益
            moneyInfo.ExpectedMoney = expected;
            moneyInfo.LowerUnit = LowerUnit;

            moneyInfo.PublisherRate = PublisherRate;
            moneyInfo.TuandaiRate = TuandaiRate;
            moneyInfo.perAmout = perAmout;
            moneyInfo.RewardAmount = RewardAmount;
            moneyInfo.RepaymentType = project.RepaymentType ?? 0;
            moneyInfo.RepaymentTypeDesc = ToolStatus.ConvertRepaymentType(moneyInfo.RepaymentType);
            moneyInfo.Deadline = project.Deadline ?? 0;
            moneyInfo.DeadType = project.DeadType ?? 1;
            moneyInfo.InterestRate = project.InterestRate ?? 0;
            moneyInfo.ProjectType = project.Type ?? 0;
            moneyInfo.IsNeedPayPwd = IsShowTranPwd() ? 1 : 0;
            moneyInfo.NewHandRate = 0;
            moneyInfo.TotalShares = project.TotalShares ?? 0;
            moneyInfo.ComplateShares = project.CastedShares ?? 0;
            moneyInfo.IsZQZR = 0;
            moneyInfo.EndDate = CommUtils.GetInvestEndDay(project);

            if (project.Type == 15)
            {
                string sql = @"select u.OrgTypeId,u.OrgId,ISNULL(o.SubTypeId,0) AS SubTypeId from fq_UserApply u with(nolock) 
                       INNER JOIN fq_Organization o with(nolock) ON u.OrgId=o.OrgId
                       where u.ProjectId=@ProjectId";
                Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@ProjectId", ProjectId);
                var mOrgInfo =
                    TuanDai.DB.TuanDaiDB.Query<OrgInfo>(TdConfig.DBRead, sql, ref dyParams)
                        .FirstOrDefault();
                if (mOrgInfo != null)
                    moneyInfo.orgInfo = mOrgInfo;
            }

            if (project.Type == 18)//私募宝
            {
                var projectSm = projectbll.GetProjectSMInfo(project.Id);
                moneyInfo.ProfitType = projectSm.ProfitTypeId.HasValue ? projectSm.ProfitTypeId.Value : 0;
                moneyInfo.PreProfitRate_S = projectSm.PreProfitRate_S.HasValue ? projectSm.PreProfitRate_S.Value : 0;
                moneyInfo.PreProfitRate_E = projectSm.PreProfitRate_E.HasValue ? projectSm.PreProfitRate_E.Value : 0;
            }
            if (project.Type == 22 || project.Type == 23)
            {
                var projectXm = projectbll.GetProjectXMBInfo(project.Id);
                moneyInfo.XmbMinInterestRate = projectXm.MinInterestRate.HasValue ? projectXm.MinInterestRate.Value : 0;
                moneyInfo.XmbMaxInterestRate = projectXm.MaxInterestRate.HasValue ? projectXm.MaxInterestRate.Value : 0;
            }

            //获取新手投资加息利率
            if (moneyInfo.IsLogin == 1 && moneyInfo.IsNewHandProject == 1 && project.TuandaiRate > 0)
            {
                //判断是否投资新手 
              
                string cmdText = "select count(1) from Subscribe with(nolock) where SubscribeUserId=@UserId and status >= 2";
                var para = new Dapper.DynamicParameters();
                para.Add("@UserId", userId);
                bool isNewHand = TuanDai.DB.TuanDaiDB.Query<int>(TdConfig.DBRead, cmdText, ref para).Sum() == 0;
                moneyInfo.NewHandRate = isNewHand ? decimal.Parse((project.TuandaiRate ?? 0).ToString()) : 0;
            }
            #region 获取用户红包列表
            moneyInfo.RedPacketListStr = "";
            MyNewUserPrizeInfo prizeModel = new MyNewUserPrizeBLL().GetUserValidPrizeList(userId, ProjectId, false);
            if (prizeModel != null)
            {
                var iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy.MM.dd HH:mm:ss";
                moneyInfo.RedPacketListStr = JsonConvert.SerializeObject(prizeModel, iso);
            }
            #endregion
            string jsonStr = this.ToJson(moneyInfo);
            PrintJson("1", jsonStr);
        }
        /// <summary>
        /// 债权转让申购弹出层
        /// </summary>
        public void GetZQZRSubscribe()
        {
            Guid projectId = Tool.SafeConvert.ToGuid(Context.Request.Form["projectId"]) ?? Guid.Empty;
            if (projectId == Guid.Empty)
            {
                this.PrintJson("-1", "项目ID错误");
            }
            Guid userId = WebUserAuth.UserId.Value;
            int nowUnit = Tool.SafeConvert.ToInt32(Context.Request.Form["unit"], 1);
            decimal aviMoney = 0;
            int level = 0;
            if (userId != null && userId != Guid.Empty)
            {
                var fundAccount = new UserBLL().WXGetUserBill(userId);
                var model = new UserBLL().GetUserBasicInfoModelById(userId);
                aviMoney = fundAccount.AviMoney;
                level = model.Level.Value;
            }

            string sql = @"select C.m_Id as Id,
                           A.Type,--项目类型
                           isnull(C.m_TotalAmount,0)+dbo.f_TransferPriceCal(B.Id,isnull(C.m_TotalShares,0)) as Amount,
                           --isnull(C.m_TotalAmount,0) as Amount,--总金额
                           isnull(C.m_TotalShares,0) as TotalShares,--总份数
                           isnull(C.m_ComplateShares,0) as ComplateShares,--完成份数
                           isnull(C.m_AviShares,0) as AviShares,--剩余份数
                           isnull(A.RepaymentType,0) as RepaymentType ,--还款方式
                           (isnull(C.m_TotalAmount,0)+dbo.f_TransferPriceCal(B.Id,isnull(C.m_TotalShares,0)))/isnull(C.m_TotalShares,0) as LowerUnit,
                           --isnull(C.m_UnitAmount,0) as LowerUnit,--出借份数
                           C.m_Status as Status,--状态
                           --(case C.m_status when 1 then isnull(DATEDIFF(day,getdate(),(select max(CycDate) from SubscribeDetail sd where sd.subscribeId=B.Id)),0) else 0 end )as Deadline,--还款期限
                           --isnull(dbo.f_TransferProjectRate(C.m_Id),0) as  InterestRate,-- 利率
                           (case c.m_status when 1 then isnull(DATEDIFF(day,getdate(),dbo.f_GetMaxRepayment_Date(B.AddDate,A.Deadline,A.RepaymentType)),0) else isnull(c.m_FullRemainDay,0) end )as Deadline,	
                           isnull(dbo.f_TransferProjectRate(C.m_Id),0) as  InterestRate,
                           isnull(A.PublisherRate,0) as PublisherRate,
                           isnull(A.TuandaiRate,0) as TuandaiRate,
                           isnull(A.Deadline,0) as ProjectDeadline,
                           case c.m_Status when 1 then isnull((b.TotalRefundMonths-isnull(b.RefundedMonths,0)),0)else isnull(c.m_FullRemainMonth,0) end as ResidueDeadline--剩余期数
                    from Project(nolock) as A 
                         inner join Subscribe as B  with(nolock) on B.ProjectId=A.Id  
                         inner join t_SubScribeTransfer as C with(nolock) on C.m_FromSubscribeId=B.id
                    where C.m_Id=@Id";
            //var whereParams = new SqlParameter[] { new SqlParameter("@Id", projectId) };
            //var zqzrProjectEntity = db.ExecuteStoreQuery<ZQZRProjectInfo>(sql, whereParams).FirstOrDefault();
            var para = new Dapper.DynamicParameters();
            para.Add("@Id", projectId);
            var zqzrProjectEntity = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<ZQZRProjectInfo>(TdConfig.DBRead, sql,
                ref para);
            if (zqzrProjectEntity == null)
            {
                this.PrintJson("-3", "不存在申购的项目");
            }

            string ProjectAmount = "转让总额：";//BusinessDll.Invest.Title_Amount(zqzrProjectEntity.Type) + "：";//借款金额

            string Rate = "年化利率：";//利率
            decimal LowerUnit = zqzrProjectEntity.LowerUnit;
            string Unit = "转让单位：";//BusinessDll.Invest.Title_Unit(zqzrProjectEntity.Type) + "：";//出借单位
            double PublisherRate = 0, TuandaiRate = 0;
            PublisherRate = 0;//zqzrProjectEntity.PublisherRate ?? 0;
            TuandaiRate = 0;//zqzrProjectEntity.TuandaiRate ?? 0;
            int maxUnit = 0;
            decimal expected = 0, commission = 0, RewardAmount = 0, perAmout = 0;
            int shares = zqzrProjectEntity.AviShares;
            decimal amount = zqzrProjectEntity.LowerUnit * shares;

            if (aviMoney > amount)
            {
                maxUnit = (int)(amount / zqzrProjectEntity.LowerUnit);
            }
            else
            {
                maxUnit = (int)(aviMoney / zqzrProjectEntity.LowerUnit);
            }

            if (zqzrProjectEntity.Type == 17)
            {
                perAmout = LowerUnit * zqzrProjectEntity.InterestRate / 100 * zqzrProjectEntity.Deadline / 360;
                expected = (zqzrProjectEntity.LowerUnit * nowUnit) * zqzrProjectEntity.InterestRate / 100 * zqzrProjectEntity.Deadline / 360;
            }
            RewardAmount = Convert.ToDecimal(PublisherRate) * nowUnit * LowerUnit / 100 + Convert.ToDecimal(TuandaiRate) * nowUnit * LowerUnit / 100;

            //Guid wsId = Guid.Parse("b7acf6d5-001b-4012-941a-71633f6a9244");
            //WebSetting ws = db.WebSetting.FirstOrDefault(p => p.Id == wsId);
            var ws = new WebSettingBLL().GetWebSettingInfo("b7acf6d5-001b-4012-941a-71633f6a9244");
            string investcommissionrate1 = ws.Param1Value;//收取普通用户投资人佣金税率
            string investcommissionrate2 = ws.Param2Value;//收取特权用户投资人佣金税率

            if ((int)ConstString.UserType.VipUser == level || zqzrProjectEntity.Type == 6 || zqzrProjectEntity.Type == 7)
            {
                commission = 0;
            }
            else
            {
                commission = (decimal)((double)expected * double.Parse(investcommissionrate1) / 100);
            }

            string MaxUnit = maxUnit.ToString();//最大申购份数


            InvestMoneyInfo moneyInfo = new InvestMoneyInfo();
            moneyInfo.IsLogin = WebUserAuth.IsAuthenticated ? 1 : 0;
            moneyInfo.AviMoney = aviMoney;
            moneyInfo.MaxUnit = int.Parse(MaxUnit);
            moneyInfo.CommissionMoney = commission.ToString();
            moneyInfo.ExpectedMoney = expected;
            moneyInfo.LowerUnit = decimal.Parse(ToolStatus.ConvertLowerMoney(LowerUnit));

            moneyInfo.PublisherRate = PublisherRate;
            moneyInfo.TuandaiRate = TuandaiRate;
            moneyInfo.perAmout = perAmout;
            moneyInfo.RewardAmount = RewardAmount;
            moneyInfo.RepaymentType = zqzrProjectEntity.RepaymentType;
            moneyInfo.RepaymentTypeDesc = ToolStatus.ConvertRepaymentType(moneyInfo.RepaymentType);
            moneyInfo.Deadline = zqzrProjectEntity.Deadline;
            moneyInfo.DeadType = 2;
            moneyInfo.InterestRate = zqzrProjectEntity.InterestRate;
            moneyInfo.ProjectType = 99; //默认为99,方便前台计算收益   //zqzrProjectEntity.Type;
            moneyInfo.IsNeedPayPwd = IsShowTranPwd() ? 1 : 0;
            moneyInfo.NewHandRate = 0;
            moneyInfo.TotalShares = zqzrProjectEntity.TotalShares;
            moneyInfo.ComplateShares = zqzrProjectEntity.ComplateShares;
            moneyInfo.IsZQZR = 1;
            if (moneyInfo.DeadType == 1)
            {
                moneyInfo.EndDate = DateTime.Now.AddMonths(moneyInfo.Deadline).ToShortDateString();
            }
            else
            {
                moneyInfo.EndDate = DateTime.Now.AddDays(moneyInfo.Deadline).ToShortDateString();
            }
            if (userId != null && userId != Guid.Empty)
            {
                var rInfo = new UserRiskEvaluationBLL().GetAssassTimeThisYear(userId, TdConfig.ApplicationName);
                if (rInfo == null)
                {
                    moneyInfo.IsRisk = false;
                }
                else
                {
                    moneyInfo.IsRisk = true;
                }
            }

            #region 获取用户红包列表
            moneyInfo.RedPacketListStr = "";
            MyNewUserPrizeInfo prizeModel = new MyNewUserPrizeBLL().GetUserValidPrizeList(userId, projectId, false);
            if (prizeModel != null)
            {
                var iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy.MM.dd HH:mm:ss";
                moneyInfo.RedPacketListStr = JsonConvert.SerializeObject(prizeModel, iso);
            }
            #endregion

            string jsonStr = this.ToJson(moneyInfo);
            PrintJson("1", jsonStr);
        }

        private bool IsShowTranPwd()
        {
            Guid userId = WebUserAuth.UserId.Value;
            //UserSetting model = db.UserSettings.FirstOrDefault(p => p.UserId == userId);
            var model = new UserSettingBLL().GetUserSettingInfo(userId);
            if (model != null)
            {
                if (model.IsTenderNeedPayPassword == true)//需要输入交易密码
                {
                    return true;
                }
            }
            return false;
        }

        //检测是否新手
        public void CheckIsNewHandUser()
        {
            Guid? userId = WebUserAuth.UserId;
            if (userId == Guid.Empty)
            {
                PrintJson("0", "您还未登录！");
                return;
            }

            WebSettingBLL websetbll=new WebSettingBLL();
            WebSettingInfo NewHandSetInfo = websetbll.GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1");
            WebSettingInfo NewHandExtSet = websetbll.GetWebSettingInfo("20B98405-633B-4559-95C9-C0E96DD3BD2C");
            //取新手标最大限额
            int NewHandMax = Tool.SafeConvert.ToInt32(NewHandSetInfo.Param1Value);
            int NewHandLimitNum = NewHandSetInfo.Param4Value.ToInt(3);
            bool IsNewHandNewRule = NewHandSetInfo.Param5Value == "1";
            int limitRegDay = NewHandExtSet.Param1Value.ToInt(30); //限制注册XX天内可投

            if (IsNewHandNewRule == false)
            {
                #region 旧规则
                string cmdText = "select count(1) from Subscribe with(nolock) where SubscribeUserId=@UserId"; 
                var para = new Dapper.DynamicParameters();
                para.Add("@UserId", userId);
                bool IsNewHand = TuanDai.DB.TuanDaiDB.Query<int>(TdConfig.DBRead, cmdText, ref para).Sum() == 0;
                if (IsNewHand)
                {
                    PrintJson("1", "未投资过！");
                }
                else
                {
                    PrintJson("0", "有投资过！");
                }
                #endregion
            }
            else
            {
                #region 新规则检测
                UserBasicInfoInfo userBasicInfo = new UserBLL().GetUserBasicInfoModelById(userId.Value);
                if (userBasicInfo.AddDate.Value.Date.AddDays(limitRegDay) < DateTime.Today)
                {
                    PrintJson("0", "您注册团贷网已超过30天！");
                    return;
                }
                else
                {
                    SubscribeBLL _SubscribeBll = new SubscribeBLL();
                    int BuyNewHandNum = _SubscribeBll.GetUserBuyWeNewHandCount(userId.Value);
                    if (BuyNewHandNum >= NewHandLimitNum)
                    {
                        PrintJson("0", "您投资新手标次数已达上限！");
                        return;
                    }
                    else
                    {
                        decimal buyedAmount = _SubscribeBll.GetUserBuyWeNewHandAmount(userId.Value);
                        if (buyedAmount >= Convert.ToDecimal(NewHandMax))
                        {
                            string maxAmountChinese = NewHandMax >= 10000 ? ((decimal)NewHandMax / 10000) + "万" : ((decimal)NewHandMax / 1000) + "千";
                            PrintJson("0", "您投资新手标金额已达" + maxAmountChinese + "限额！");
                            return;
                        }
                        else
                        {
                            PrintJson("1", "");
                            return;
                        }
                    }
                }
                #endregion
            }
        }
        #endregion

        #region 获取We计划项目列表
        public void GetWePlanShowList()
        {
            int pagesize = GlobalUtils.PageSize;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL projectBll = new ProjectBLL();
            IList<WeProductDetailInfo> WeList = projectBll.WXGetWePlanShowList(pagesize, pageindex, out totalcount);
            if (WeList != null && WeList.Count() > 0)
            {
                var SetModel = new WebSettingBLL().GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
                var SetModel1 = new WebSettingBLL().GetWebSettingInfo("06A6344D-E1FB-4AAA-890A-E39351D5E7A3");
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (WeProductDetailInfo temp in WeList)
                {
                    decimal JxRate = 0;
                    var IsWeQPR = false;
                    if ((temp.TypeWord.ToLower().Contains("q") || temp.TypeWord.ToLower().Contains("p") ||
                        temp.TypeWord.ToLower().Contains("r")) && temp.StartDate >= DateTime.Parse(SetModel.Param1Value) && temp.StartDate < DateTime.Parse(SetModel.Param2Value))
                    {
                        IsWeQPR = true;
                        JxRate = decimal.Parse(SetModel.Param3Value);
                    }
                    var IsWe4ZxJx = false;//4周年专享加息时间内
                    if (temp.StartDate >= DateTime.Parse(SetModel1.Param1Value) && temp.StartDate < DateTime.Parse(SetModel1.Param2Value))
                    {
                        IsWe4ZxJx = true;
                        JxRate = decimal.Parse(SetModel1.Param3Value);
                    }
                    if (temp.TuandaiRedRate.HasValue && temp.TuandaiRedRate > 0)
                    {
                        JxRate = temp.TuandaiRedRate.Value;
                    }
                    string linkBtnHtml = "";
                    if (temp.StartDate > DateTime.Now && temp.StatusId == 1)
                    {
                        linkBtnHtml = "<a href=\"javascript:void(0);\" class=\"toBuy\">即将开始</a>";
                    }
                    else if (temp.StartDate < DateTime.Now && temp.OrderQty != temp.TotalQty)
                    {
                        linkBtnHtml = string.Format("<a href=\"{0}\" class=\"toBuy\">抢购</a>", GetWeDetailUrl(temp));
                    }
                    else if (((temp.OrderQty == temp.TotalQty && temp.InvestCompleteDate.HasValue) || temp.OrderCompleteDate.HasValue && temp.OrderCompleteDate.Value.AddDays(5) <= DateTime.Now) && !temp.IsWeFQB)
                    {
                        linkBtnHtml = "<a href=\"javascript:void(0);\" class=\"toBuy finished\">结束</a>";
                    }
                    else
                    {
                        linkBtnHtml = "<a href=\"javascript:void(0);\" class=\"toBuy finished\">售罄</a>";
                    }

                    sb.Append("{\"Title\":\"" + temp.ProductName
                          + "\",\"YearRate\":\"" + this.GetWePlanYearRate(temp)
                          + "\",\"Deadline\":\"" + (temp.Deadline ?? 0)
                          + "\",\"SurplusMoney\":\"" + WE_list.GetWePlanSurplusMoney(temp)
                          + "\",\"ProductName\":\"" + WE_list.GetWePlanTitle(temp.ProductName, 1)
                          + "\",\"IsWeFQB\":\"" + (temp.IsWeFQB ? 1 : 0)
                          + "\",\"ProductId\":\"" + temp.ProductId
                          + "\",\"JoinButton\":\"" + linkBtnHtml
                          + "\",\"IsWeQPR\":\"" + IsWeQPR
                          + "\",\"IsWe4ZxJx\":\"" + IsWe4ZxJx
                          + "\",\"JxRate\":\"" + JxRate
                          );

                    if (index == WeList.Count())
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
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        protected string GetWePlanYearRate(WeProductDetailInfo item)
        {
            string formatStr = "{0}<span>{1}%</span>";
            string yearRate = ToolStatus.DeleteZero(item.YearRate);
            string addRateStr = "";
           
            return string.Format(formatStr, CommUtils.GetFloatDivideStr(decimal.Parse(yearRate), 1), CommUtils.GetFloatDivideStr(decimal.Parse(yearRate), 2) + addRateStr);
        }
        protected string GetWeDetailUrl(WeProductDetailInfo item)
        {
            if (item.IsWeFQB)
                return "/pages/invest/WE/WeFqb_detail.aspx?id=" + item.ProductId;
            else if (item.IsFTB)
                return "/pages/invest/WE/WeFtb_detail.aspx?id=" + item.ProductId;
            else
                return "/pages/invest/WE/WE_detail.aspx?id=" + item.ProductId;
        }
        #endregion

        #region 获取We计划投资时金额
        public void GetUserWePlanMoney()
        {
            decimal YearRate = 0;
            Guid projectId = WEBRequest.GetFormGuid("projectId");
            if (projectId == Guid.Empty)
            {
                PrintJson("0", "参数传入异常");
                return;
            }
            WeProductDetailInfo product = null;
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                string err = string.Empty;
                var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(projectId, out err,
                    TdConfig.ApplicationName);
                if (weRedisInfo != null)
                    product = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                if (product == null || !string.IsNullOrEmpty(err))
                    product = new WeProductBLL().GetWeProductInfo(projectId);
            }
            else
            {
                product = new WeProductBLL().GetWeProductInfo(projectId);
            }

            if (product == null)
            {
                PrintJson("0", "该笔数据已不存在");
                return;
            }
            Guid userId = Guid.Empty;
            decimal Amount = 0;
            InvestMoneyInfo moneyInfo = new InvestMoneyInfo();
            if (WebUserAuth.IsAuthenticated)
            {
                userId = TuanDai.WXApiWeb.WebUserAuth.UserId.Value;
                Amount = new UserBLL().GetUserAviMoney(userId);
                var rInfo = new UserRiskEvaluationBLL().GetAssassTimeThisYear(userId, TdConfig.ApplicationName);
                if (rInfo == null)
                {
                    moneyInfo.IsRisk = false;
                }
                else
                {
                    moneyInfo.IsRisk = true;
                }
            }

            int maxUnit = 0, nowUnit = 1;

            moneyInfo.IsLogin = WebUserAuth.IsAuthenticated ? 1 : 0;
            moneyInfo.AviMoney = Amount;
            moneyInfo.LowerUnit = product.UnitAmount ?? 0;


            int shares = product.TotalQty.Value - product.OrderQty.Value;
            decimal amount = product.UnitAmount.Value * shares;
            if (Amount > amount)
            {
                maxUnit = shares;
            }
            else
            {
                maxUnit = (int)(Amount / product.UnitAmount.Value);
            }
            YearRate = product.YearRate ?? 0;
            WebSettingBLL webSettingBll = new WebSettingBLL();
            var setModel = webSettingBll.GetWebSettingInfo("06A6344D-E1FB-4AAA-890A-E39351D5E7A3");
            if (product.StartDate >= DateTime.Parse(setModel.Param1Value) &&
                product.StartDate < DateTime.Parse(setModel.Param2Value))//4周年庆全场加息
            {
                YearRate += decimal.Parse(setModel.Param3Value);
                product.MaxYearRate2 += decimal.Parse(setModel.Param3Value);
            }

            var setModel1 = webSettingBll.GetWebSettingInfo("5E08DFE3-6CED-4E71-8CF9-2A2E3BAC9036");
            if ((product.TypeWord.ToLower().Contains("p") || product.TypeWord.ToLower().Contains("r") || product.TypeWord.ToLower().Contains("q")) && product.StartDate >= DateTime.Parse(setModel1.Param1Value) && product.StartDate < DateTime.Parse(setModel1.Param2Value))
            {
                YearRate += decimal.Parse(setModel1.Param3Value);
                product.MaxYearRate2 += decimal.Parse(setModel1.Param3Value);
            }
            if (product.TuandaiRedRate.HasValue && product.TuandaiRedRate > 0)
            {
                YearRate += product.TuandaiRedRate.Value;
                product.MaxYearRate2 += decimal.Parse(setModel1.Param3Value); ;
            }
            moneyInfo.WeQAmount = 0;

            moneyInfo.ExpectedMoney = (product.UnitAmount.Value * nowUnit) * YearRate / 100 * product.Deadline.Value / 12;
            moneyInfo.MaxUnit = maxUnit;
            moneyInfo.IsNeedPayPwd = IsShowTranPwd() ? 1 : 0;
            moneyInfo.InterestRate = YearRate;
            moneyInfo.Deadline = product.Deadline ?? 0;
            moneyInfo.MaxYearRate2 = product.MaxYearRate2 ?? 0;
            moneyInfo.TotalShares = product.TotalQty.Value;
            moneyInfo.ComplateShares = product.OrderQty.Value;
            moneyInfo.IsWeFQB = product.IsWeFQB ? 1 : 0;
            moneyInfo.IsFTB = product.IsFTB ? 1 : 0;
            moneyInfo.IsNewHandProject = product.IsNewHand ? 1 : 0;
            moneyInfo.FTBSubType = product.FTBSubType.HasValue?product.FTBSubType.Value:0;

            //WE计划按月处理
            moneyInfo.DeadType = 1;
            moneyInfo.EndDate = CalcWeInvestEndDate(product).ToString("yyyy.MM.dd");
            if (product.IsWeFQB)
            {
                moneyInfo.EndDate = DateTime.Today.AddDays(6).AddMonths(moneyInfo.Deadline).AddSeconds(1 * 24 * 60 * 60 - 1).ToString("yyyy.MM.dd");
            }
            else if (product.IsFTB)
            {
                if (product.IsNewHand)
                    moneyInfo.EndDate = DateTime.Now.AddDays(moneyInfo.Deadline).ToString("yyyy.MM.dd");
                else
                    moneyInfo.EndDate = DateTime.Today.AddDays(6).AddMonths(moneyInfo.Deadline).AddSeconds(1 * 24 * 60 * 60 - 1).ToString("yyyy.MM.dd");
            }
            else
            {
                if (moneyInfo.DeadType == 1)
                {
                    moneyInfo.EndDate = DateTime.Now.AddMonths(moneyInfo.Deadline).ToString("yyyy.MM.dd");
                }
                else
                {
                    moneyInfo.EndDate = DateTime.Now.AddDays(moneyInfo.Deadline).ToString("yyyy.MM.dd");
                }
            }
            WebSettingInfo NewHandSetInfo = null;
            decimal NewHandMax = 0;  //取新手标最大限额
            bool IsNewHandNewRule = false;
            if (product.IsNewHand)
            {
                moneyInfo.DeadType = product.DeadType.Value;
                NewHandSetInfo = webSettingBll.GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1");
                NewHandMax = Tool.SafeConvert.ToInt32(NewHandSetInfo.Param1Value);
                IsNewHandNewRule = NewHandSetInfo.Param5Value == "1";
                if ((maxUnit * product.UnitAmount.Value) > NewHandMax) //修改最高限额
                    maxUnit = (int)(NewHandMax / product.UnitAmount.Value);
            }

            if (product.IsNewHand && moneyInfo.IsLogin == 1 && !userId.ToText().ToUpper().IsIn("341C0108-FF9F-4598-8289-3312B34ED936", "E7CCC442-4CCB-47B3-9DD5-89ECABE5BEB9", "4332A90D-5855-4A38-9174-AA3684521A55"))
            {
                if (!IsNewHandNewRule)
                {
                    #region 旧规则
                    //新手专享复投宝
                    if (moneyInfo.IsLogin == 1 && product.IsNewHand)
                    {
                        SubscribeBLL _SubscribeBll = new SubscribeBLL();
                        //判断是否投资新手首次 
                        bool isNewHandFirst = _SubscribeBll.GetUserBuyProjectCount(userId) == 0;
                        bool hasBuyNewHand = _SubscribeBll.GetUserBuyWeNewHandCount(userId) == 0;
                        if (isNewHandFirst && hasBuyNewHand)
                        {
                            if ((maxUnit * product.UnitAmount.Value) > NewHandMax) //修改最高限额
                                maxUnit = (int)(NewHandMax / product.UnitAmount.Value);
                        }
                        else
                        {
                            moneyInfo.IsInvested = 1;
                            moneyInfo.NewHandMsg = "新手标仅限未成功投资过的用户！";
                            maxUnit = 0;
                        }
                        moneyInfo.MaxUnit = maxUnit;
                    }
                    #endregion
                }
                else
                {
                    #region 新规则
                    WebSettingInfo NewHandExtSet = webSettingBll.GetWebSettingInfo("20B98405-633B-4559-95C9-C0E96DD3BD2C");
                    int limitRegDay = NewHandExtSet.Param1Value.ToInt(30);
                    //新手专享复投宝
                    if (moneyInfo.IsLogin == 1 && product.IsNewHand)
                    {
                        UserBasicInfoInfo userBasicInfo = new UserBLL().GetUserBasicInfoModelById(userId);
                        if (userBasicInfo.AddDate.Value.Date.AddDays(limitRegDay) < DateTime.Today)
                        {
                            maxUnit = 0;
                            moneyInfo.IsInvested = 1;
                            moneyInfo.NewHandMsg = "您注册团贷已超过30天，无法购买新手标";
                        }
                        else
                        {
                            SubscribeBLL _SubscribeBll = new SubscribeBLL();
                            int BuyNewHandNum = _SubscribeBll.GetUserBuyWeNewHandCount(userId);
                            int NewHandLimitNum = Int32.Parse(NewHandSetInfo.Param4Value);
                            if (BuyNewHandNum >= NewHandLimitNum)
                            {
                                maxUnit = 0;
                                moneyInfo.IsInvested = 1;
                                moneyInfo.NewHandMsg = "您投资新手标次数已达上限，无法购买新手标";
                            }
                            else
                            {
                                decimal buyedAmount = _SubscribeBll.GetUserBuyWeNewHandAmount(userId);
                                if (buyedAmount >= Convert.ToDecimal(NewHandMax))
                                {
                                    maxUnit = 0;
                                    moneyInfo.IsInvested = 1;
                                    string maxAmountChinese = NewHandMax >= 10000 ? ((decimal)NewHandMax / 10000) + "万" : ((decimal)NewHandMax / 1000) + "千";
                                    moneyInfo.NewHandMsg = "您投资新手标金额已达" + maxAmountChinese + "限额，无法购买新手标";
                                }
                                else
                                {
                                    if ((maxUnit * product.UnitAmount.Value + buyedAmount) > NewHandMax) //修改最高限额
                                    {
                                        maxUnit = (int)((NewHandMax - buyedAmount) / product.UnitAmount.Value);
                                    }
                                }
                            }
                        }
                        moneyInfo.MaxUnit = maxUnit;
                    }
                    #endregion
                }
            }
            #region 获取用户红包列表
            moneyInfo.RedPacketListStr = "";
            MyNewUserPrizeInfo prizeModel = new MyNewUserPrizeBLL().GetUserValidPrizeList(userId, projectId, true);
            if (prizeModel != null)
            {
                var iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy.MM.dd HH:mm:ss";
                moneyInfo.RedPacketListStr = JsonConvert.SerializeObject(prizeModel, iso);
            }
            #endregion

            string jsonStr = this.ToJson(moneyInfo);
            PrintJson("1", jsonStr);
        }
        #endregion

        #region 获取投资完成页中信息
        private DateTime CalcWeInvestEndDate(WeProductDetailInfo product)
        {
            DateTime EndDate = DateTime.Today;
            if (product.IsWeFQB || product.IsFTB)
            {
                if (product.IsNewHand)
                {
                    if (product.DeadType == 1)
                    {
                        EndDate = DateTime.Now.AddMonths(product.Deadline.Value).AddDays(3);
                    }
                    else
                    {
                        EndDate = DateTime.Now.AddDays(product.Deadline.Value).AddDays(3);
                    }
                }
                else if(product.FTBSubType == 3)
                    EndDate = DateTime.Today.AddDays(1).AddMonths(product.Deadline.Value);
                else
                    EndDate = DateTime.Today.AddDays(6).AddMonths(product.Deadline.Value).AddSeconds(1 * 24 * 60 * 60 - 1);
            }
            else
            {
                if (product.DeadType == 1)
                {
                    EndDate = DateTime.Now.AddMonths(product.Deadline.Value);
                }
                else
                {
                    EndDate = DateTime.Now.AddDays(product.Deadline.Value);
                }
            }
            return EndDate;
        }
        public void GetInvestFinishInfo()
        {
            Guid projectId = WEBRequest.GetFormGuid("projectId");
            if (projectId == Guid.Empty)
            {
                PrintJson("0", "参数传入异常");
                return;
            }
            // 投资类型 project:投资普通标   weplan:投资we计划   
            string InvestType = WEBRequest.GetFormString("investtype").ToLower();
            InvestMoneyInfo moneyInfo = new InvestMoneyInfo();
            if (InvestType == "weplan")
            {
                WeProductDetailInfo product = null;
                if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
                {
                    string err = string.Empty;
                    var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(projectId,
                    out err, TdConfig.ApplicationName);
                    if (weRedisInfo != null)
                        product = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                    if(product == null || !string.IsNullOrEmpty(err))
                        product = new WeProductBLL().GetWeProductInfo(projectId);
                }
                else
                {
                    product = new WeProductBLL().GetWeProductInfo(projectId);
                }
                
                moneyInfo.EndDate = CalcWeInvestEndDate(product).ToString("yyyy.MM.dd");
            }
            else if (InvestType == "project")
            {
                ProjectBLL projectbll = new ProjectBLL();
                ProjectDetailInfo project = projectbll.GetProjectDetailInfo(projectId);
                if (project == null) //处理债权转让
                {
                    var pModel = new TuanDai.PortalSystem.BLL.SubScriberansferBLL().GetSubScriberansfer(projectId);
                    project = projectbll.GetProjectDetailInfo(pModel.ProjectId);
                }
                moneyInfo.EndDate = CommUtils.GetInvestEndDay(project);
                moneyInfo.RepaymentTypeDesc = ToolStatus.ConvertRepaymentType(project.RepaymentType.Value);
                
                
            }
            string jsonStr = this.ToJson(moneyInfo);
            PrintJson("1", jsonStr);
        }
        #endregion
        
        /// <summary>
        /// 获取we计划周年庆当前用户当天已加入金额 及 已加入次数
        /// </summary>
        public void GetWeZnqCurrDayJoinMoney()
        {
            string sql = @"select isnull(sum(Amount),0) as CurrDayJoinMoney,count(0) as CurrDayJoinCount from We_Order  with(nolock) 
                            where (ProductName like '%p%' or ProductName like '%q%' or ProductName like '%r%') 
                            and UserId =@UserId and OrderDate > CONVERT(varchar(100), GETDATE(), 23)";
            var para = new Dapper.DynamicParameters();
            para.Add("@UserId", WebUserAuth.UserId.Value);
            WeQMoney joinMoney = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<WeQMoney>(TdConfig.DBRead, sql, ref para);
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(joinMoney)); ;
        }
        
        #region 申请项目
        /// <summary>
        /// 申购
        /// </summary>
        public void addloan()
        {
            Guid userid = WebUserAuth.UserId.Value;
            UserBLL userBll = new UserBLL();
            UserBasicInfoInfo model = userBll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-99", "登陆超时");
            }
            if ((model.uStatus ?? 0) != 1)
            {
                PrintJson("-10", "用户已被冻结");
            }
            Guid projectid = Guid.Empty;
            Guid.TryParse(Context.Request["bid"], out projectid);
            ProjectBLL projectBll = new ProjectBLL();
            ProjectDetailInfo pModel = projectBll.GetProjectDetailInfo(projectid);
            #region 债权转让申购验证码验证
            string isOpenMobileCode = "false";
            var webSet = new WebSettingBLL().GetWebSettingInfo("C7FC6726-A36D-4035-A36C-957D43F5EF96");
            if (webSet == null) webSet = new WebSettingInfo();
            if (webSet.Param1Value == "1")
                isOpenMobileCode = "true";
            if (pModel == null && !TuanDai.PortalSystem.Redis.mRedis.GetZqzrInvestCodePass(projectid, userid)&&isOpenMobileCode=="true")
            {
                string code = Context.Request["code"];
                int result = new CodeRecordBLL().CheckCodeRecord(code, model.TelNo, MsCodeType.PhoneCode, MsCodeType2.SubScribeTransferCode, model.Id, true, 1);
                if (result == -1)
                {
                    PrintJson("-111", "验证码有误，请重新输入");
                }
                else if (result == -3 || result == -2)
                {
                    PrintJson("-111", "验证码已使用或已过期");
                }
                else if (result == 1) //验证通过
                {
                    TuanDai.PortalSystem.Redis.mRedis.GetZqzrInvestCodePass(projectid, userid, true);
                }
                else
                {
                    PrintJson("-111", "验证码有误,请重新输入");
                }
            }
            #endregion
            //验证交易密码
            //UserSetting usersetting = db.UserSettings.FirstOrDefault(p => p.UserId == userid);
            var bll = new UserSettingBLL();
            var usersetting = bll.GetUserSettingInfo(userid);
            bool isTenderNeedPayPassword = usersetting != null && usersetting.IsTenderNeedPayPassword;
            #region 验证交易密码
            //if (!GlobalUtils.IsOpenCGT)
            //{
            //    if (usersetting != null)
            //    {
            

            //        if (usersetting.IsTenderNeedPayPassword == true)
            //        {
            //            if (usersetting.PayPwdErrorDate.HasValue)
            //            {
            //                DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
            //                DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
            //                if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
            //                {
            //                    PrintJson("-151", "交易密码已错误5次，请24小时后再进行此操作");
            //                }
            //                if (date1 != date2 && usersetting.PayPwdErrorCount > 1)
            //                {
            //                    usersetting.PayPwdErrorCount = 0;
            //                    usersetting.PayPwdErrorDate = null;
            //                }
            //            }
            //            string PayPwd = Tool.Encryption.MD5(Context.Request["TranPwd"]);
            //            if (PayPwd != model.PayPwd)
            //            {
            //                //记录登录错误次数
            //                if (usersetting.PayPwdErrorCount == null)
            //                {
            //                    usersetting.PayPwdErrorCount = 0;
            //                }
            //                usersetting.PayPwdErrorCount += 1;
            //                usersetting.PayPwdErrorDate = DateTime.Now;
            //                //db.SaveChanges();
            //                bll.UpdateUserSettingInfo(usersetting);
            //                PrintJson("-15", "交易密码错误还剩下：" + (5 - usersetting.PayPwdErrorCount).ToString() + "次");
            //            }
            //            else
            //            {
            //                //清除错误记录
            //                usersetting.PayPwdErrorCount = 0;
            //                usersetting.PayPwdErrorDate = null;
            //                //db.SaveChanges();
            //                bll.UpdateUserSettingInfo(usersetting);
            //            }
            //        }

            //        
            //    }
            //}
                    #endregion
            if (model.IsValidateIdentity == false || model.IsValidateMobile == false)
            {
                PrintJson("-11", "为保证您的合法权益,请完成所有信息验证之后进行投标！");
            }

            decimal tendAmount = 0;
            decimal.TryParse(Context.Request["tendAmount"], out tendAmount);
            if (tendAmount <= 0)
            {
                PrintJson("-16", "因为申购金额有误");
            }
            if (tendAmount > userBll.GetUserAviMoney(userid))
            {
                PrintJson("-16", "可用余额不足");
            }

            int unit = 0;
            int.TryParse(Context.Request["unit"], out unit);
            if (unit <= 0)
            {
                PrintJson("-16", "因为申购份数有误");
            }

            int deviceType = GetTenderType();
            string IsNewProjectFrame = ConfigurationManager.AppSettings["IsNewProjectFrame"];
            string IsNewSubscribeFrame = ConfigurationManager.AppSettings["IsNewSubscribeFrame"];
            string isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
            Guid? PrizeId = null;
            if (WEBRequest.GetFormString("prizeid") != "")
                PrizeId = WEBRequest.GetFormGuid("prizeid"); 

            string msg = string.Empty;
            bool isBuy = new CgtCheckBLL().GetUserCgtIsOper(userid, "", ref msg);
            if (!isBuy)
            {
                PrintJson("-199", msg + "，不能进行申购");
                return;
            }

            if (isTenderNeedPayPassword)
            {
                var reqMode = new CgtCallbackUrl.Model.ModelRequest.SubscribeRequest();
                reqMode.Channel = "MOBILE";
                reqMode.Number = unit.ToString();
                reqMode.ProjectId = projectid;
                reqMode.UserId = userid.ToString();
                reqMode.tendAmount = tendAmount;
                reqMode.isNewHandProject = false;
                reqMode.IsNewProjectFrame = IsNewProjectFrame;
                reqMode.IsNewSubscribeFrame = IsNewSubscribeFrame;
                reqMode.buyQty = unit;
                reqMode.Version = GlobalUtils.Version;
                reqMode.PrizeId = PrizeId;
                if (GlobalUtils.IsOpenCgtSub && pModel != null)
                {
                    string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.ProjectInvest, "ptype=" + pModel.Type);
                    PrintJson("8888", url);
                }
                else if (GlobalUtils.IsOpenCgtTrans && pModel == null)
                {
                    string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.TransferInvest, "");
                    PrintJson("8888", url);
                }
            }
            else
            {
                InvestReturnMsg irm = new InvestReturnMsg();
                irm = new TuanDai.WXSystem.Core.SubscribeInvest().ProjectInvest(tendAmount, unit, projectid, pModel,
                          model, deviceType, PrizeId, IsNewProjectFrame, IsNewSubscribeFrame, isNewSmsRequest);
                PrintJson(irm.outStatus, irm.remark);
            }
        }
        private void SubscribeEnd(Guid projectid, int outStatus, int completeStatus, ProjectDetailInfo pModel, UserBasicInfoInfo UserModel, decimal tendAmount, string msg, string newmsg, int deviceType)
        {
            if (completeStatus == 1 && outStatus == 1)
            {
                SubscribePushApp(pModel);
            }
            if (outStatus.ToString() == "1")
            {
                //调用第三方渠道
                try
                {
                    TuanDai.PortalSystem.BLL.ThirdPartyChannel.SubscribeCallBack(null, UserModel.Id, projectid);
                }
                catch (Exception ex)
                {
                    new TuanDai.LogSystem.LogClient.LogClients().WriteErrorLog(
                        "TuanDai.PortalSystem.BLL.ThirdPartyChannel.SubscribeCallBack",
                        "", "", ex.Message);
                }
                #region 投资成功后
                string title = "恭喜您成功购买了" + tendAmount + "元标";
                //string content2 = title + "【<a href='" + GlobalUtils.TuanDaiURL + "/pages/invest/detail.aspx?id=" + projectid + "' target='_bank' style='color:red;'>" + pModel.Title + "</a>】。";

                try
                {
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.UserId = UserModel.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.addloan;
                    log.Content1 = "恭喜您成功购买了" + tendAmount + "元标! 标的ID：" + projectid.ToString();
                    log.Id = Guid.NewGuid().ToString();
                    WebLogInfo.WriteLoginHandler(log);

                    //投标成功不发短信了 2016-8-22
                    //MessageSend send = new MessageSend();
                    //var parmeters = new Dictionary<string, object>();
                    //parmeters.Add("UserId", UserModel.Id);
                    //parmeters.Add("UserName", UserModel.RealName);
                    //parmeters.Add("CurrentDate", DateTime.Now);
                    //parmeters.Add("InvestAmount", ToolStatus.ConvertLowerMoney(tendAmount));
                    //parmeters.Add("ProjectDeadline", string.Format("{0}{1}", pModel.Deadline, pModel.DeadType == 2 ? "天" : "个月"));
                    //parmeters.Add("ProjectRate", ToolStatus.DeleteZero(pModel.InterestRate));
                    //parmeters.Add("ProjectType", ToolStatus.ConvertProjectType((int)pModel.Type));
                    //parmeters.Add("ProjectNO", string.Format("<a href=\"http://www.tuandai.com/pages/invest/detail.aspx?id={0} \" target=\"_blank\">{1}</a>", pModel.Id, pModel.Grade));
                    //parmeters.Add("ProjectModel", pModel);
                    //send.SendMessage2(eventCode: MessageTemplates.InterestProjectSuccess, parameters: parmeters, mobile: UserModel.TelNo, email: UserModel.Email, userId: UserModel.Id);
                    if (deviceType == 9)
                    {
                        //服务号首次投资加团币
                        VipGetTuanBiTaskBLL.FirstInvestByServiceAccount(UserModel.Id);
                    }
                }
                catch (Exception ex)
                {
                    WebLog log = new WebLog();
                    log.AddDate = DateTime.Now;
                    log.UserId = UserModel.Id.ToString();
                    log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                    log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                    log.HandlerTypeId = (int)ConstString.LogType.addloan;
                    log.Content1 = "标的ID：" + projectid.ToString() + ";申购信息错误:" + UserModel.Id.ToString() + ";" + ex.Message + ":" + ex.InnerException + ":" + ex.StackTrace;
                    log.Id = Guid.NewGuid().ToString();
                    BusinessDll.WebLogInfo.WriteLoginHandler(log);
                }
                #endregion
            }
            else
            {
                #region 投资失败
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.UserId = UserModel.Id.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Add;
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.addloan;
                log.Content1 = "申购失败_标的ID：" + projectid.ToString() + ";申购的状态:" + UserModel.Id.ToString() + ";" + outStatus.ToString() + ";申购失败信息" + msg;
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);
                #endregion
            }
        }

        /// <summary>
        /// 获取标异步申购后的结果
        /// </summary>
        public void GetSubscribeStatus()
        {
            Guid userid = WebUserAuth.UserId.Value;
            UserBLL userBll = new UserBLL();
            UserBasicInfoInfo model = userBll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-99", "登陆超时");
            }
            if ((model.uStatus ?? 0) != 1)
            {
                PrintJson("-10", "用户已被冻结");
            }
            string msg = string.Empty;
            int outStatus = 0;
            Guid subscribeId;
            Guid.TryParse(Context.Request["subscribeId"], out subscribeId);
            if (subscribeId == Guid.Empty)
            {
                PrintJson("-1", "申购ID不能为空");
            }
            TuanDai.Subscribe.Client.SubscribeClient subscribeClient = new TuanDai.Subscribe.Client.SubscribeClient();
            string result = subscribeClient.SubscribeStatus(subscribeId.ToString(), ref msg);
            if (!string.IsNullOrEmpty(msg))
            {
                TuanDai.LogSystem.LogClient.LogClients logclient = new TuanDai.LogSystem.LogClient.LogClients();
                logclient.WriteErrorLog("WXTenderReuest", "申购查询结果异常", "", msg);
            }
            SetSubscribeStatus(ref outStatus, ref msg, result);
            PrintJson(outStatus.ToString(), msg);
        }
        /// <summary>
        /// 设置申购状态
        /// </summary>
        /// <param name="outStatus"></param>
        /// <param name="msg"></param>
        /// <param name="result"></param>
        private void SetSubscribeStatus(ref int outStatus, ref string msg, string result)
        {
            if (string.IsNullOrEmpty(result))
            {
                result = "-998";
            }
            outStatus = Tool.SafeConvert.ToInt32(result);
            //申购失败,返回失败
            switch (result)
            {
                case "-998":
                    msg = "申购中";
                    break;
                case "-1":
                    msg = "购买失败(错误编码:001)";
                    //msg = "方式不对";
                    break;
                case "-2":
                    msg = "份数不能少于1份";
                    break;
                case "-3":
                    msg = "购买失败(错误编码:003)";
                    //msg = "项目不存在";
                    break;
                case "-4":
                    msg = "购买失败(错误编码:004)";
                    //msg = "份数不够";
                    break;
                case "-5":
                    msg = "购买失败(错误编码:005";
                    //msg = "用户不存在";
                    break;
                case "-6":
                    msg = "未实名";
                    break;
                case "-7":
                    msg = "购买失败(错误编码:007)";
                    //msg = "状态不对";
                    break;
                case "-8":
                    msg = "不能购买自己的标";
                    //msg = "用户类型不对";
                    break;
                case "-9":
                    msg = "购买失败(错误编码:009)";
                    //msg = "发送申购项目份数队列失败";
                    break;
                case "-10":
                    msg = "购买失败(错误编码:010)";
                    //msg = "修改申购状态失败或者已经处理(发送资金处理请求)";
                    break;
                case "-11":
                    outStatus = -14;//旧的返回状态有11，需要转换
                    msg = "购买失败(错误编码:011)";
                    //msg = "发送付款请求失败";
                    break;
                case "-12":
                    msg = "可用金额不足 ";
                    break;
                case "-13":
                    msg = "购买失败(错误编码:013)";
                    //msg = "扣款异常";
                    break;
                //case "14":14已用
                //    break;
                case "-15":
                    outStatus = -17;//旧的状态返回有15，需要转换
                    msg = "交易密码已错误5次，请24小时后再进行此操作";
                    break;
                case "-16":
                    outStatus = -18;//旧的状态返回有-16,需要转换
                    msg = "";
                    break;
                case "-50":
                    msg = "新手标仅限未成功投资过的用户";
                    break;
                case "-51":
                    msg = "新手标每位用户仅有一次机会，最高限投30000元";
                    break;
            }
        }
        #endregion

        #region 申购债权转让 
        public int BuySubScriberansfer(Guid subscribeId, Guid buyUserId, int buyShares, int tenderMode)
        {
            //SqlParameter[] parms = {
            //                        SqlHelper.MakeInParam("m_Id",SqlDbType.UniqueIdentifier,subscribeId),
            //                        SqlHelper.MakeInParam("buyUserId",SqlDbType.UniqueIdentifier,buyUserId),
            //                        SqlHelper.MakeInParam("BuyShares",SqlDbType.Int, buyShares),
            //                        SqlHelper.MakeInParam("TenderMode",SqlDbType.Int, tenderMode),
            //                        SqlHelper.MakeOutParam("OutPutStatus",SqlDbType.Int,0)};
            var paras = new Dapper.DynamicParameters();
            paras.Add("@m_Id", subscribeId);
            paras.Add("@buyUserId", buyUserId);
            paras.Add("@BuyShares", buyShares);
            paras.Add("@TenderMode", tenderMode);
            paras.Add("@OutPutStatus", 0, DbType.Int32, ParameterDirection.Output);
            TuanDai.DB.TuanDaiDB.Execute(TdConfig.DBSubscribeWrite, "p_TransferSubscribe", ref paras, CommandType.StoredProcedure);
            //SqlHelper.ExecuteNonQuery(TuanDai.Config.BaseConfig.ConnectionString, CommandType.StoredProcedure,
            //    "p_TransferSubscribe", parms);
            //return Tool.SafeConvert.ToInt32(parms[4].Value);
            return Tool.SafeConvert.ToInt32(paras.Get<int>("@OutPutStatus"));
        }
        #endregion


        #region 申购类型 与 We计划类型
        //获取申购类型
        private int GetTenderType()
        {
            try
            {
                int deviceType = 6;
                if (GlobalUtils.IsWeiXinBrowser)
                    deviceType = 9;
                return deviceType;
            }
            catch
            {
                return 6;
            }
        }
        //买We计划类型
        private int GetWeTenderType()
        {
            try
            {
                int deviceType = 4;
                if (GlobalUtils.IsWeiXinBrowser)
                    deviceType = 5;
                return deviceType;
            }
            catch
            {
                return 4;
            }
        }

        #endregion

        #region 发送手机推送
        //发送手机推送
        private void SubscribePushApp(ProjectDetailInfo projectEntity)
        {
            //推送借款人
            //Dictionary<string, string> customizedValues = new Dictionary<string, string>();
            //List<Guid> userIds = new List<Guid>();
            //customizedValues.Add("Url", "ToMyLoanList");
            //customizedValues.Add("UserId", Tool.AppDESC.UseridEncry(projectEntity.UserId.ToString()));
            //userIds.Add(projectEntity.UserId ?? Guid.Empty);
            //string content = string.Format(Tool.Common.AppMsmPushConst.BorrowingSuccess, 1);
            //new BusinessDll.MessageSend().AsyncSendAppPushMsgHandler(Tool.Common.AppMsmPushSettingCodeEnum.personel.ToString(), userIds, (int)Tool.Common.AppMsmPushTypeEnum.MsmPushType15, "团贷网通知", content, customizedValues); 
            var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
            if (isNewSmsRequest == "0")
            {


                BusinessDll.MessageSend mSend = new BusinessDll.MessageSend();
                var borrowerParameters = new Dictionary<string, object>();
                //微信推送给借款人
                //除电话语音外，其他发送途径均需要从模板中取发送内容.
                var fulltemplate = mSend.GetMsgTemplateInfoByCode(MessageTemplates.BorrowerBorrowSuccess, borrowerParameters);
                if (fulltemplate != null)
                {
                    //发送微信上推送消息
                    if ((fulltemplate.IsWeiXinPush ?? false) == true && !fulltemplate.WeiXinPush.ToText().IsEmpty())
                    {
                        //满标发短信通知借款人 
                        SubscribeFull.ProjectBorrowerInfo projectInfo = SubscribeFull.GetProjectBorrowerInfo(projectEntity.Id);
                        borrowerParameters.Add("UserId", projectInfo.UserId);
                        borrowerParameters.Add("UserName", projectInfo.RealName);
                        borrowerParameters.Add("ProjectAmount", projectInfo.Amount);
                        borrowerParameters.Add("ProjectDeadline", string.Format("{0}{1}", projectInfo.Deadline, projectInfo.Type == 17 ? "天" : "个月"));
                        borrowerParameters.Add("Rate", ToolStatus.DeleteZero(projectInfo.InterestRate));
                        borrowerParameters.Add("RepaymentType", ToolStatus.ConvertRepaymentType(int.Parse(projectInfo.RepaymentType.ToString())));
                        borrowerParameters.Add("AddDate", projectInfo.AddDate.Value);
                        borrowerParameters.Add("ProjectTitle", projectInfo.Title);
                        borrowerParameters.Add("CurrentDate", DateTime.Now);
                        borrowerParameters.Add("ProjectId", projectInfo.ProjectId);
                        WXTemplateMessage.SendWeiXinAlert(MessageTemplates.BorrowerBorrowSuccess, borrowerParameters, projectEntity.UserId, fulltemplate.WeiXinPush);
                    }
                }


                //推送借款人
                Dictionary<string, string> customizedValues = new Dictionary<string, string>();
                List<Guid> userIds = new List<Guid>();
                customizedValues.Add("Url", "ToMyLoanList");
                customizedValues.Add("UserId", Tool.AppDESC.UseridEncry(projectEntity.UserId.ToString()));
                userIds.Add(projectEntity.UserId ?? Guid.Empty);

                var par = new Dictionary<string, object>();
                par.Add("Count", 1);
                var template = mSend.GetMsgTemplateInfoByCode(MessageTemplates.FQBBorrowerBorrowSuccess, par);

                string content = template != null && !string.IsNullOrEmpty(template.PushContent) ? template.PushContent : string.Empty;
                string title = template != null && !string.IsNullOrEmpty(template.PushTitle) ? template.PushTitle : string.Empty;
                if (string.IsNullOrEmpty(content))
                    return;
                new BusinessDll.MessageSend().AsyncSendAppPushMsgHandler(Tool.Common.AppMsmPushSettingCodeEnum.personel.ToString(), userIds, (int)Tool.Common.AppMsmPushTypeEnum.MsmPushType15, title, content, customizedValues);
            }
            else
            {

                //在服务端处理发送通知给借款人,投资人 2016-8-22
                TuanDai.SMS.Client.SmsRequest projectFullSmsRequest = new TuanDai.SMS.Client.SmsRequest();
                projectFullSmsRequest.EventCode = TuanDai.Enums.Sms.MsgTemplatesType.ProjectFullNote;
                projectFullSmsRequest.PlatformSource = TuanDai.Enums.PlatformSource.WeiXin;
                projectFullSmsRequest.Parameters = new Dictionary<string, object>();
                projectFullSmsRequest.Parameters.Add("ProjectId", projectEntity.Id);
                projectFullSmsRequest.IsWithoutTemplates = true;//服务端处理
                string errorString = string.Empty;
                TuanDai.SMS.Client.SmsClient.SendMessage(projectFullSmsRequest, ref errorString);
                if (!string.IsNullOrEmpty(errorString))
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "项目满标消息推送", JsonConvert.SerializeObject(projectFullSmsRequest), errorString);
                }
            }
        }
        #endregion


        #region 申请We计划
        public void BuyWePlan()
        {
            Guid? productId = Tool.SafeConvert.ToGuid(Context.Request.Form["ProductId"]);
            int buyQty = Tool.SafeConvert.ToInt32(Context.Request.Form["BuyQty"]);
            Guid userid = WebUserAuth.UserId.Value;
            if (productId == Guid.Empty)
            {
                PrintJson("-1", "产品Id错误!");
            }

            UserBLL userBll = new UserBLL();
            UserBasicInfoInfo model = userBll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-99", "登陆超时");
            }

            //验证交易密码
            var bll = new UserSettingBLL();
            var usersetting = bll.GetUserSettingInfo(userid);
            bool isTenderNeedPayPassword = usersetting != null && usersetting.IsTenderNeedPayPassword;

            #region 验证交易密码
            //if (!GlobalUtils.IsOpenCGT)
            //{
            //    //UserSetting usersetting = db.UserSettings.FirstOrDefault(p => p.UserId == userid);
            //    if (usersetting != null)
            //    {
                    
            //        if (usersetting.IsTenderNeedPayPassword == true)
            //        {
            //            isTenderNeedPayPassword = true;
            //            if (usersetting.PayPwdErrorDate.HasValue)
            //            {
            //                DateTime date1 = Convert.ToDateTime(usersetting.PayPwdErrorDate.Value.ToString("yyyy/MM/dd"));
            //                DateTime date2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd"));
            //                if (date1 == date2 && usersetting.PayPwdErrorCount >= 5)
            //                {
            //                    PrintJson("-151", "交易密码已错误5次，请24小时后再进行此操作");
            //                }
            //                if (date1 != date2 && usersetting.PayPwdErrorCount > 1)
            //                {
            //                    usersetting.PayPwdErrorCount = 0;
            //                    usersetting.PayPwdErrorDate = null;
            //                }
            //            }
            //            string PayPwd = Tool.Encryption.MD5(Context.Request["TranPwd"]);
            //            if (PayPwd != model.PayPwd)
            //            {
            //                //记录登录错误次数
            //                if (usersetting.PayPwdErrorCount == null)
            //                {
            //                    usersetting.PayPwdErrorCount = 0;
            //                }
            //                usersetting.PayPwdErrorCount += 1;
            //                usersetting.PayPwdErrorDate = DateTime.Now;
            //                //db.SaveChanges();
            //                bll.UpdateUserSettingInfo(usersetting);
            //                PrintJson("-15", "交易密码错误还剩下：" + (5 - usersetting.PayPwdErrorCount).ToString() + "次");
            //            }
            //            else
            //            {
            //                //清除错误记录
            //                usersetting.PayPwdErrorCount = 0;
            //                usersetting.PayPwdErrorDate = null;
            //                //db.SaveChanges();
            //                bll.UpdateUserSettingInfo(usersetting);
            //            }
            //        }
                   
            //    }
            //} 
            #endregion


            int repeatInvestType = Tool.SafeConvert.ToInt32(Context.Request.Form["RepeatInvestType"], 0);
            int deviceType = GetWeTenderType();

            WeProductDetailInfo product = null;
            if (GlobalUtils.IsRedis && GlobalUtils.IsWePlanRedis)
            {
                string err = string.Empty;
                var weRedisInfo = TuanDai.RedisApi.Client.WePlanRedis.GetWePlanRedisByProductIdJson(productId.Value,
                    out err, TdConfig.ApplicationName);
                if (weRedisInfo != null)
                    product = JsonConvert.DeserializeObject<WeProductDetailInfo>(weRedisInfo);
                if (product == null || !string.IsNullOrEmpty(err))
                    product = new WeProductBLL().GetWeProductInfo(productId.Value);
            }
            else
            {
                product = new WeProductBLL().GetWeProductInfo(productId.Value);
            }

            int surplusQty = product.TotalQty ?? 0 - product.OrderQty ?? 0;
            if (surplusQty <= 0 || buyQty > surplusQty)
            {
                PrintJson("-3", "申购份数不够，不能购买！");
            }
            if ((product.UnitAmount ?? 0) * buyQty > userBll.GetUserAviMoney(userid))
            {
                PrintJson("-3", "可用余额不足！");
            }

            string IsNewProjectFrame = ConfigHelper.getConfigString("IsNewProjectFrame");
            Guid? PrizeId = null;
            if (WEBRequest.GetFormString("PrizeId") != "")
                PrizeId = WEBRequest.GetFormGuid("PrizeId");

            //存管通
            if (GlobalUtils.IsOpenCGT)
            {
                string msg = string.Empty;
                bool isBuy = new CgtCheckBLL().GetUserCgtIsOper(userid, "", ref msg);
                if (!isBuy)
                {
                    PrintJson("-199", msg + "，不能进行申购");
                    return;
                }
                if (GlobalUtils.IsOpenCgtSubWe && isTenderNeedPayPassword)
                {
                    //进入存管前判断是否有超过新手标限制
                    if (product.IsFTB && product.IsNewHand)
                    {
                        WebSettingInfo NewHandSetInfo = null;
                        WebSettingBLL webSettingBll = new WebSettingBLL();
                        decimal NewHandMax = 0;  //取新手标最大限额
                        bool IsNewHandNewRule = false;
                        if (product.IsNewHand)
                        {
                            NewHandSetInfo = webSettingBll.GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1");
                            NewHandMax = Tool.SafeConvert.ToInt32(NewHandSetInfo.Param1Value);
                            IsNewHandNewRule = NewHandSetInfo.Param5Value == "1";
                        }

                        if (product.IsNewHand && !userid.ToText().ToUpper().IsIn("341C0108-FF9F-4598-8289-3312B34ED936", "E7CCC442-4CCB-47B3-9DD5-89ECABE5BEB9", "4332A90D-5855-4A38-9174-AA3684521A55"))
                        {
                            if (IsNewHandNewRule)
                            {

                                #region 新规则
                                WebSettingInfo NewHandExtSet = webSettingBll.GetWebSettingInfo("20B98405-633B-4559-95C9-C0E96DD3BD2C");
                                int limitRegDay = NewHandExtSet.Param1Value.ToInt(30);
                                //新手专享复投宝

                                UserBasicInfoInfo userBasicInfo = new UserBLL().GetUserBasicInfoModelById(userid);
                                if (userBasicInfo.AddDate.Value.Date.AddDays(limitRegDay) < DateTime.Today)
                                {
                                    PrintJson("-3", "您注册团贷已超过30天，无法购买新手标！");
                                }
                                else
                                {
                                    SubscribeBLL _SubscribeBll = new SubscribeBLL();
                                    int BuyNewHandNum = _SubscribeBll.GetUserBuyWeNewHandCount(userid);
                                    int NewHandLimitNum = Int32.Parse(NewHandSetInfo.Param4Value);
                                    if (BuyNewHandNum >= NewHandLimitNum)
                                    {
                                        PrintJson("-3", "您投资新手标次数已达上限，无法购买新手标");
                                    }
                                    else
                                    {
                                        decimal buyedAmount = _SubscribeBll.GetUserBuyWeNewHandAmount(userid);
                                        string maxAmountChinese = NewHandMax >= 10000 ? ((decimal)NewHandMax / 10000) + "万" : ((decimal)NewHandMax / 1000) + "千";
                                        if (buyedAmount >= Convert.ToDecimal(NewHandMax))
                                        {
                                            PrintJson("-3", "您投资新手标金额已达" + maxAmountChinese + "限额，无法购买新手标");
                                        }
                                        else
                                        {
                                            if ((buyQty * product.UnitAmount.Value + buyedAmount) > NewHandMax) //修改最高限额
                                            {
                                                decimal newHandMaxVal2 = Tool.SafeConvert.ToDecimal(new TuanDai.PortalSystem.BLL.WebSettingBLL().GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1").Param1Value);

                                                PrintJson("-3", "您已超出新手标累计投资" + maxAmountChinese + "限额，本次只能再投资" + (newHandMaxVal2 - buyedAmount).ToString("F1") + "元！");
                                            }
                                        }
                                    }
                                }
                                #endregion
                            }
                        }
                    }

                    var reqMode = new CgtCallbackUrl.Model.ModelRequest.WeplanSubmitRequest
                    {
                        Channel = "MOBILE",
                        JoinCopies = buyQty,
                        Level = null,
                        ProductId = productId.Value,
                        RepeatInvestType = repeatInvestType,
                        UserId = userid.ToString(),
                        UserName = model.UserName,
                        Version = GlobalUtils.Version,
                        PrizeId = PrizeId
                    };
                    string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.WeInvest, "pname=" + product.ProductName);
                    PrintJson("8888", url);
                }
                else
                {
                    var si = new TuanDai.WXSystem.Core.SubscribeInvest();
                    InvestReturnMsg irm = si.WePlanInvest(product, buyQty, model, repeatInvestType,
                        deviceType, PrizeId, GlobalUtils.IsRedis, GlobalUtils.IsWePlanRedis, IsNewProjectFrame);

                    PrintJson(irm.outStatus, irm.remark);
                }
            }
        }

        /// <summary>
        /// 获取we计划购合并一个存储过程后的错误信息
        /// </summary>
        /// <param name="outStatus">返回给前端的状态</param>
        /// <param name="errorString">错误信息</param>
        /// <param name="result">数据库返回的状态</param>
        /// <param name="step">步数</param>
        private void SetBuyWePlanStatus2(ref int outStatus, ref string errorString, string result, string step)
        {
            if (string.IsNullOrEmpty(result))
            {
                result = "-998";
                return;
            }
            outStatus = Tool.SafeConvert.ToInt32(result);
            if (outStatus == 1 && step == "7")
            {
                //状态等于1，而且七步都走完了才真的购买成功
                return;
            }
            //申购失败,返回失败
            switch (step)
            {
                case "0":
                    switch (result)
                    {
                        case "-3":
                            errorString = "系统出错了！";
                            break;
                        case "-6":
                            outStatus = -6;
                            errorString = "未通过实名认证";
                            break;
                        case "-7":
                            outStatus = -7;
                            errorString = "用户账户已冻结";
                            break;
                        case "-8":
                            outStatus = -8;
                            errorString = "中介，担保机构，借款人不允许投标";
                            break;
                        case "-12":
                            outStatus = -12;
                            errorString = "请先验证手机号码";
                            break;
                        case "-129":
                            outStatus = -129;//前端直接提示信息
                            errorString = "分期乐机构不能购买We计划";
                            break;
                        case "-130":
                            outStatus = -130;//资金不足
                            errorString = "资金不足";
                            break;
                        case "-131":
                            outStatus = -131;//资金不足
                            errorString = "We计划还未开始";
                            break;
                        case "-132":
                            outStatus = -132;
                            errorString = "新手标仅限未成功投资过的用户";
                            break;
                        case "-133":
                            //取最大限额
                            int newHandMaxVal = Tool.SafeConvert.ToInt32(new TuanDai.PortalSystem.BLL.WebSettingBLL().GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1").Param1Value);
                            outStatus = -133;
                            errorString = "新手标每位用户仅有一次机会，最高限投" + newHandMaxVal + "元";
                            break;
                        case "-134":
                            outStatus = -134;
                            errorString = "您已购买过新手标,不可再购买!";
                            break;

                        case "-232":
                            outStatus = -3;
                            errorString = "您注册团贷已超过30天，无法购买新手标！";
                            break;
                        case "-233":
                            outStatus = -3;
                            errorString = "您投资新手标次数已达上限，无法购买新手标！";
                            break;
                        case "-234":
                            //取最大限额
                             newHandMaxVal = Tool.SafeConvert.ToInt32(new TuanDai.PortalSystem.BLL.WebSettingBLL().GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1").Param1Value);
                            string maxAmountChinese = newHandMaxVal >= 10000 ? ((decimal)newHandMaxVal / 10000) + "万" : ((decimal)newHandMaxVal / 1000) + "千";
                            outStatus = -3;
                            errorString = "您投资新手标金额已达" + maxAmountChinese + "限额，无法购买新手标！";
                            break;
                        case "-235":
                            Guid userId = WebUserAuth.UserId.Value;
                            SubscribeBLL _SubscribeBll = new SubscribeBLL();
                            decimal newHandMaxVal2 = Tool.SafeConvert.ToDecimal(new TuanDai.PortalSystem.BLL.WebSettingBLL().GetWebSettingInfo("28ED2C47-C151-47AA-9D58-63277C0483C1").Param1Value);
                            maxAmountChinese = newHandMaxVal2 >= 10000 ? ((decimal)newHandMaxVal2 / 10000) + "万" : ((decimal)newHandMaxVal2 / 1000) + "千";
                            decimal buyedAmount = _SubscribeBll.GetUserBuyWeNewHandAmount(userId); 
                            errorString = "您已超出新手标累计投资" + maxAmountChinese + "限额，本次只能再投资" + (newHandMaxVal2 - buyedAmount).ToString("F1") + "元！";
                            outStatus = -3;
                            break;


                    }
                    break;
                case "1":
                    switch (result)
                    {
                        case "-1":
                            outStatus = -3;
                            errorString = "份数错误";
                            break;
                        case "2":
                            outStatus = -3;
                            errorString = "购买失败";//购买份数失败
                            break;
                        case "4":
                            outStatus = -3;
                            errorString = "复投方式不正确";
                            break;
                    }
                    break;
                case "2":
                    switch (result)
                    {
                        case "0":
                            outStatus = -3;
                            errorString = "购买失败";//扣款失败
                            break;
                        case "3":
                            outStatus = -11;
                            errorString = "可用资金不足";
                            break;
                    }
                    break;
                case "3":
                    switch (result)
                    {
                        case "-1":
                            outStatus = -3;
                            errorString = "购买失败";//已处理过
                            break;
                        case "0":
                            outStatus = -3;
                            errorString = "程序异常";
                            break;
                        case "1":
                            outStatus = -11;
                            errorString = "可用资金不足";//已处理过
                            break; 
                    }
                    break;
                case "4":
                    switch (result)
                    {
                        case "-1":
                            outStatus = -3;
                            errorString = "购买失败";//订单已处理过
                            break;
                        case "-2":
                            outStatus = -3;
                            errorString = "购买失败";//金额不正确
                            break;
                        case "0":
                            outStatus = -3;
                            errorString = "购买失败";//处理异常
                            break;
                    }
                    break;
                case "5":
                    switch (result)
                    {
                        case "-1":
                            outStatus = -3;
                            errorString = "购买失败";//已处理过
                            break;
                        case "-2":
                            outStatus = -3;
                            errorString = "购买失败";//不存在订单
                            break;
                    }
                    break;
                case "6":
                    switch (result)
                    {
                        case "0":
                            outStatus = -3;
                            errorString = "购买失败";//失败
                            break;
                    }
                    break;
                case "7":
                    switch (result)
                    {
                        case "-3":
                            outStatus = -3;
                            errorString = "购买失败";//不在事务里面
                            break;
                        case "-2":
                            outStatus = -3;
                            errorString = "购买失败";//用户奖品个数
                            break;
                        case "-1":
                            outStatus = -3;
                            errorString = "购买失败";
                            break;
                        case "0":
                            outStatus = -3;
                            errorString = "购买失败";
                            break;
                    }
                    break;
            }
        }

        /// <summary>
        /// 获取购买we计划结果
        /// </summary>
        public void GetBuyWeplanStatus()
        {
            Guid userid = WebUserAuth.UserId.Value;
            UserBasicInfoInfo model = new UserBLL().GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-99", "登陆超时");
            }
            if ((model.uStatus ?? 0) != 1)
            {
                PrintJson("-10", "用户已被冻结");
            }
            string msg = string.Empty;
            int outStatus = 0;
            Guid weOrderId;
            Guid.TryParse(Context.Request["weOrderId"], out weOrderId);
            if (weOrderId == Guid.Empty)
            {
                PrintJson("-1", "weOrderID不能为空");
            }
            int checkCount = int.Parse(Context.Request["checkCount"].ToString());
            TuanDai.RedisApi.Model.WeOrderBuyStatus backmodel = new WeProductBLL().GetWeOrderBuyStatusByRedis(
                weOrderId, out msg,checkCount, TdConfig.ApplicationName);
            if (!string.IsNullOrEmpty(msg))
            {
                TuanDai.LogSystem.LogClient.LogClients logclient = new TuanDai.LogSystem.LogClient.LogClients();
                logclient.WriteErrorLog("WXGetBuyWeplanStatusTenderReuest", "查询购买we计划结果异常", "UserId:" + userid + " WeOrderId:" + weOrderId, msg);
            }
            var result = "";
            if (backmodel != null)
                result = backmodel.Status.ToString();
            msg = string.Empty;
            SetBuyWePlanStatus(ref outStatus, ref msg, result);
            PrintJson(outStatus.ToString(), msg);
        }
        /// <summary>
        /// 设置购买we计划状态
        /// </summary>
        /// <param name="outStatus"></param>
        /// <param name="msg"></param>
        /// <param name="result"></param>
        private void SetBuyWePlanStatus(ref int outStatus, ref string msg, string result)
        {
            if (string.IsNullOrEmpty(result))
            {
                result = "-998";
            }
            outStatus = Tool.SafeConvert.ToInt32(result);
            //申购失败,返回失败
            switch (result)
            {
                case "-998":
                    msg = "申购中";
                    break;
                case "-1":
                    outStatus = -11;
                    msg = "申购失败(错误编码:001)";
                    //msg="份数不够";
                    break;
                case "-2":
                    msg = "申购失败(错误编码:002)";
                    //msg = "客户端异常";
                    break;
                case "-3":
                    msg = "申购失败(错误编码:003)";
                    //msg = "还没有到时间";
                    break;
                case "-4":
                    msg = "申购失败(错误编码:004)";
                    //msg = "份数不够";
                    break;
                case "-5":
                    msg = "申购失败(错误编码:005)";
                    //msg = "用户不存在";
                    break;
                case "-6":
                    outStatus = -7;
                    msg = "没有实名";
                    break;
                case "-7":
                    outStatus = -3;
                    msg = "申购失败(错误编码:007)";
                    //msg = "状态不对";
                    break;
                case "-8":
                    outStatus = -3;
                    msg = "申购失败(错误编码:008)";
                    //msg = "用户类型不对";
                    break;
                case "-9":
                    msg = "申购失败(错误编码:009)";
                    //msg = "资金客户端异常";
                    break;
                case "-10":
                    outStatus = -12;
                    msg = "申购失败(错误编码:012)";
                    // msg = "产品不存在";
                    break;
                case "-11":
                    msg = "申购失败(错误编码:011)";
                    //msg = "投资人扣款服务端异常";
                    break;
                case "-12":
                    msg = "未通过手机认证";
                    //msg = "投资人扣款服务端异常";
                    break;
                case "-13":
                    outStatus = -3;
                    msg = "分期乐机构不能购买We计划";
                    //msg = "投资人扣款服务端异常";
                    break;
                case "0":
                    msg = "申购失败(错误编码:000)";
                    //msg = "存储过程异常";
                    break;
                case "1":
                    msg = "成功";
                    break;
                case "2":
                    msg = "申购失败(错误编码:013)";
                    //msg = "购买份数失败";
                    break;
                case "3":
                    msg = "申购失败(错误编码:013)";
                    //msg = "投资人金额不够";
                    break;
                case "4":
                    msg = "申购失败(错误编码:014)";
                    //msg = "复投类型不对";
                    break;
            }
        }
        #endregion

        #region 是否注册
        public void IsReg()//根据手机号码判断是否注册
        {
            string tel = Context.Request.Form["tel"];
            UserBLL bll = new UserBLL();
            var userInfo = bll.GetUserBasicInfoModelByTelNo(tel);
            if (userInfo == null)
                this.PrintJson("0", "未注册");

            this.PrintJson("1", "已注册");
        }
        #endregion


        #region 发送通知与消息
        public class SubscribeFull
        {
            #region 证劵宝
            private delegate void SubscribeFullHandler(Guid ProjectId);

            public static void AsyncGPPZSubscribeFull(Guid ProjectId)
            {
                SubscribeFullHandler handler = new SubscribeFullHandler(SubscribeFullAction);
                handler.BeginInvoke(ProjectId, null, null);
            }
            private static void SubscribeFullAction(Guid ProjectId)
            {
                ProjectBorrowerInfo projectInfo = GetProjectBorrowerInfo(ProjectId);
                if (projectInfo != null)
                {
                    var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                    if (isNewSmsRequest == "0")
                    {
                        var projectType = projectInfo.Title.Replace("【", "“").Replace("】", "”");

                        //满标发短信通知借款人
                        var borrowerParameters = new Dictionary<string, object>();
                        borrowerParameters.Add("UserId", projectInfo.UserId);
                        borrowerParameters.Add("UserName", projectInfo.RealName);
                        borrowerParameters.Add("ProjectAmount", projectInfo.Amount);
                        borrowerParameters.Add("ProjectDeadline", string.Format("{0}{1}", projectInfo.Deadline, projectInfo.Type == 17 ? "天" : "个月"));
                        borrowerParameters.Add("Rate", ToolStatus.DeleteZero(projectInfo.InterestRate));
                        borrowerParameters.Add("RepaymentType", ToolStatus.ConvertRepaymentType(int.Parse(projectInfo.RepaymentType.ToString())));
                        borrowerParameters.Add("AddDate", projectInfo.AddDate.Value);
                        borrowerParameters.Add("ProjectTitle", projectType);
                        borrowerParameters.Add("CurrentDate", DateTime.Now);

                        var msgSender = new MessageSend();
                        msgSender.SendMessage2(eventCode: MessageTemplates.BorrowerBorrowSuccess, parameters: borrowerParameters,
                            mobile: projectInfo.TelNo, email: projectInfo.Email, userId: projectInfo.UserId);

                        //满标发短信通知投资人
                        List<Subscribeinfo> list = GetSubscribeinfoList(ProjectId);
                        if (list != null && list.Count > 0)
                        {
                            var inveresterParameters = new Dictionary<string, object>();
                            foreach (Subscribeinfo item in list)
                            {
                                inveresterParameters.Clear();
                                inveresterParameters.Add("UserId", item.UserId);
                                inveresterParameters.Add("UserName", item.RealName);
                                inveresterParameters.Add("AddDate", item.AddDate);
                                inveresterParameters.Add("ProjectTitle", projectType);
                                inveresterParameters.Add("CurrentDate", DateTime.Now);
                                msgSender.SendMessage2(eventCode: MessageTemplates.InvestorBorrowSuccess, parameters: inveresterParameters,
                                    mobile: item.TelNo, email: item.Email, userId: item.UserId);
                            }
                        }
                    }
                    else
                    {
                        //在服务端处理发送通知给借款人,投资人(满标)
                        TuanDai.SMS.Client.SmsRequest projectFullSmsRequest = new TuanDai.SMS.Client.SmsRequest();
                        projectFullSmsRequest.EventCode = TuanDai.Enums.Sms.MsgTemplatesType.ProjectFullNote;
                        projectFullSmsRequest.PlatformSource = TuanDai.Enums.PlatformSource.WeiXin;
                        projectFullSmsRequest.Parameters = new Dictionary<string, object>();
                        projectFullSmsRequest.Parameters.Add("ProjectId", ProjectId);
                        string errorString = string.Empty;
                        TuanDai.SMS.Client.SmsClient.SendMessage(projectFullSmsRequest, ref errorString);
                        if (!string.IsNullOrEmpty(errorString))
                        {
                            TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "项目满标消息推送", JsonConvert.SerializeObject(projectFullSmsRequest), errorString);
                        }
                    }
                }
            }
            #endregion


            #region 分期宝
            private delegate void FQSubscribeInitFullHandler(Guid ProjectId, int OrgTypeId);

            public static void AsyncFQSubscribeEnd(Guid ProjectId, int OrgTypeId)
            {
                Action action = new Action(delegate()
                {
                    SubscribeFQFullAction(ProjectId, OrgTypeId);
                });
                action.BeginInvoke(null, null);

            }
            public static void SubscribeFQFullAction(Guid ProjectId, int OrgTypeId)
            {
                ProjectBorrowerInfo projectInfo = GetProjectBorrowerInfo(ProjectId);
                if (projectInfo != null)
                {
                    var isNewSmsRequest = ConfigHelper.getConfigString("IsNewSmsRequest", "0");
                    if (isNewSmsRequest == "0")
                    {
                        Organization model = GetOrganizationName(ProjectId);
                        var msgSender = new MessageSend();

                        var borrowerParameters = new Dictionary<string, object>();
                        borrowerParameters.Add("ProjectId", ProjectId);
                        borrowerParameters.Add("OrgTypeId", OrgTypeId);
                        borrowerParameters.Add("OrganizationName", model.RealName);
                        borrowerParameters.Add("CurrentDate", DateTime.Now);
                        borrowerParameters.Add("AddDate", projectInfo.AddDate);

                        if (OrgTypeId == 5)
                        { //分期乐
                            msgSender.SendMessage2(eventCode: MessageTemplates.FQLBorrowerBorrowSuccess,
                                                    parameters: borrowerParameters,
                                                    mobile: projectInfo.TelNo,
                                                    email: projectInfo.Email);
                            msgSender.SendMessage2(eventCode: MessageTemplates.FQLBorrowerBorrowSuccess,
                                                   parameters: borrowerParameters, userId: projectInfo.UserId);
                        }
                        else
                        {
                            msgSender.SendMessage2(eventCode: MessageTemplates.FQBBorrowerBorrowSuccess,
                                                     parameters: borrowerParameters,
                                                     mobile: projectInfo.TelNo,
                                                     email: projectInfo.Email);
                            msgSender.SendMessage2(eventCode: MessageTemplates.FQBBorrowerBorrowSuccess,
                                                    parameters: borrowerParameters, userId: projectInfo.UserId);
                        }

                        //满标发短信通知投资人
                        List<FqbSubscribeinfo> list = GetFQSubscribeinfoList(ProjectId);
                        if (list != null && list.Count > 0)
                        {
                            foreach (FqbSubscribeinfo item in list)
                            {
                                var investorParameters = new Dictionary<string, object>();
                                investorParameters.Add("ProjectId", ProjectId);
                                investorParameters.Add("OrgTypeId", OrgTypeId);
                                investorParameters.Add("UserName", item.RealName);
                                investorParameters.Add("CurrentDate", DateTime.Now);
                                investorParameters.Add("AddDate", item.AddDate);
                                investorParameters.Add("InvestAmount", item.InvestAmount);
                                investorParameters.Add("SubscribeId", item.SubscribeId);

                                if (OrgTypeId == 5)
                                {
                                    msgSender.SendMessage2(eventCode: MessageTemplates.FQLInvestorBorrowSuccess,
                                                          parameters: investorParameters,
                                                          mobile: item.TelNo,
                                                          email: item.Email,
                                                          userId: item.UserId);
                                }
                                else
                                {
                                    msgSender.SendMessage2(eventCode: MessageTemplates.FQBInvestorBorrowSuccess,
                                                          parameters: investorParameters,
                                                          mobile: item.TelNo,
                                                          email: item.Email,
                                                          userId: item.UserId);
                                }
                            }
                        }
                    }
                    else { 
                    //在服务端处理发送通知给借款人,投资人(满标)
                    TuanDai.SMS.Client.SmsRequest projectFullSmsRequest = new TuanDai.SMS.Client.SmsRequest();
                    projectFullSmsRequest.EventCode = TuanDai.Enums.Sms.MsgTemplatesType.ProjectFullNote;
                    projectFullSmsRequest.PlatformSource = TuanDai.Enums.PlatformSource.WeiXin;
                    projectFullSmsRequest.Parameters = new Dictionary<string, object>();
                    projectFullSmsRequest.Parameters.Add("ProjectId", ProjectId);
                    string errorString = string.Empty;
                    TuanDai.SMS.Client.SmsClient.SendMessage(projectFullSmsRequest, ref errorString);
                    if (!string.IsNullOrEmpty(errorString))
                    {
                        TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "项目满标消息推送", JsonConvert.SerializeObject

        (projectFullSmsRequest), errorString);
                    }
                    }
                    

                }
            }

            #endregion

            public static ProjectBorrowerInfo GetProjectBorrowerInfo(Guid id)
            {
                ProjectBorrowerInfo model;
                //using (IDbConnection conn = CreateReadConnection())
                //{
                string cmdText = @"select p.Id as ProjectId,p.AddDate,p.Title,u.Id as UserId,u.TelNo,u.Email from Project p inner join UserBasicInfo u on p.UserId=u.Id where p.Id=@Id";
                var para = new Dapper.DynamicParameters();
                para.Add("@Id", id);
                model = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<ProjectBorrowerInfo>(TdConfig.DBRead, cmdText, ref para);
                //    var para = new { Id = id };
                //    model = Kamsoft.Data.Dapper.SqlMapper.Query<ProjectBorrowerInfo>(conn, cmdText, para).FirstOrDefault();
                //    conn.Close();
                //    conn.Dispose();
                //}
                return model;
            }

            public static List<Subscribeinfo> GetSubscribeinfoList(Guid projectid)
            {
                List<Subscribeinfo> list;
                //using (IDbConnection conn = CreateReadConnection())
                //{
                string cmdText = @"select distinct u.Id as UserId,u.TelNo,u.Email from UserBasicInfo u inner join Subscribe s on u.Id=s.SubscribeUserId where ProjectId=@ProjectId";
                var para = new Dapper.DynamicParameters();
                para.Add("@ProjectId", projectid);
                list = TuanDai.DB.TuanDaiDB.Query<Subscribeinfo>(TdConfig.DBRead, cmdText, ref para);
                //    var para = new { ProjectId = projectid };
                //    list = Kamsoft.Data.Dapper.SqlMapper.Query<Subscribeinfo>(conn, cmdText, para).ToList();
                //    conn.Close();
                //    conn.Dispose();
                //}
                return list;
            }


            public static List<FqbSubscribeinfo> GetFQSubscribeinfoList(Guid projectid)
            {
                List<FqbSubscribeinfo> list;
                string cmdText = @"select s.SubscribeUserId as UserId, u.TelNo,u.Email,u.RealName, max(s.AddDate) as AddDate, 
                                    sum(s.Amount) as InvestAmount, max(cast(s.Id as varchar(40))) as SubscribeId
                                    from UserBasicInfo u with(nolock)
                                    left join Subscribe s with(nolock) on u.Id=s.SubscribeUserId 
                                    where s.ProjectId=@ProjectId
                                    group by s.SubscribeUserId, u.TelNo,u.Email,u.RealName ";
                var para = new Dapper.DynamicParameters();
                para.Add("@ProjectId", projectid);
                list = TuanDai.DB.TuanDaiDB.Query<FqbSubscribeinfo>(TdConfig.ApplicationName, TdConfig.DBRead, cmdText, ref para);
                return list;
            }
            /// <summary>
            /// 根据项目Id获取所属机构名称
            /// </summary>
            /// <param name="projectid"></param>
            /// <returns></returns>
            public static Organization GetOrganizationName(Guid projectid)
            {
                Organization model;
                string cmdText = @"SELECT b.RealName  FROM dbo.fq_UserApply u INNER JOIN dbo.UserBasicInfo b ON u.OrgId=b.Id WHERE u.ProjectId=@ProjectId";
                var para = new Dapper.DynamicParameters();
                para.Add("@ProjectId", projectid);
                model = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<Organization>(TdConfig.ApplicationName, TdConfig.DBRead, cmdText, ref para);

                return model;
            }

            //public static SqlConnection CreateReadConnection()
            //{
            //    string connectionString = TuanDai.Config.BaseConfig.CommonConnectionString;
            //    SqlConnection connection = new SqlConnection(connectionString);
            //    connection.Open();
            //    return connection;
            //}
            public class FqbSubscribeinfo
            {
                public Guid UserId { get; set; }
                public string RealName { get; set; }
                public string TelNo { get; set; }
                public string Email { get; set; }
                public DateTime AddDate { get; set; }
                public decimal InvestAmount { get; set; }
                public Guid SubscribeId { get; set; }
            }

            /// <summary>
            /// 申购信息
            /// </summary>
            public class Subscribeinfo
            {
                public Guid UserId { get; set; }
                public string TelNo { get; set; }
                public string Email { get; set; }
                public DateTime AddDate { get; set; }
                public string RealName { get; set; }
            }

            public class ProjectBorrowerInfo
            {
                /// <summary>
                /// 用户Id
                /// </summary>
                public Guid UserId { get; set; }
                /// <summary>
                /// 用户真名
                /// </summary>
                public string RealName { get; set; }
                /// <summary>
                /// 项目Id
                /// </summary>
                public Guid ProjectId { get; set; }
                /// <summary>
                /// 类型
                /// </summary>
                public int Type { get; set; }
                /// <summary>
                /// 期限
                /// </summary>
                public int Deadline { get; set; }
                /// <summary>
                /// 金额
                /// </summary>
                public decimal Amount { get; set; }
                /// <summary>
                /// 利率
                /// </summary>
                public decimal InterestRate { get; set; }
                /// <summary>
                /// 还款方式
                /// </summary>
                public int RepaymentType { get; set; }

                /// <summary>
                /// 手机号
                /// </summary>
                public string TelNo { get; set; }
                /// <summary>
                /// 邮箱
                /// </summary>
                public string Email { get; set; }
                /// <summary>
                /// 发标时间
                /// </summary>
                public DateTime? AddDate { get; set; }
                /// <summary>
                /// 项目名称
                /// </summary>
                public string Title { get; set; }
            }

            public class Organization
            {
                /// <summary>
                /// 机构名称
                /// </summary>
                public string RealName { get; set; }
            }
        }
        #endregion

        #region 获取we计划分期宝交易记录
        public void GetWeFQBTradeDetailShowList()
        {
            int pagesize = 8;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            var weOrderId = HttpContext.Current.Request.Form["weOrderId"];
            if (pageindex < 1)
                pageindex = 1;

            int totalcount = 0;
            StringBuilder sb = new StringBuilder();
//            List<WeFundDetailInfo> list = new List<WeFundDetailInfo>();
//            string strSQL = @"SELECT * FROM (
//                                    SELECT  ROW_NUMBER() OVER (ORDER BY a.AddDate desc) AS rownumber,SUM(1) OVER() TotalCount,
//                                    A.Amount, A.InAmount, A.OutAmount,A.FundType, A.Describe, A.AddDate,P.Id AS ProjectId,p.Grade
//                                    FROM We_FundDetail  A WITH(NOLOCK)
//                                    INNER JOIN We_Order  B WITH(nolock) ON B.Id=A.WeOrderId
//                                    LEFT JOIN Subscribe C WITH(nolock) ON c.Id=A.FundProjectID
//                                    left join Project P  WITH(nolock) on C.ProjectId=p.Id
//                                    WHERE A.FundType in(1,2,3,4,5,6,7,8,9,10,11) AND A.WeOrderId=@weOrderId AND A.UserID=@userId 
//                                )M  WHERE M.rownumber> @pagesize*(@pageindex-1) and  M.rownumber<=@pagesize*@pageindex ";

//            var dyParams = new Dapper.DynamicParameters();
//            dyParams.Add("@weOrderId", weOrderId);
//            dyParams.Add("@userId", WebUserAuth.UserId.Value);
//            dyParams.Add("@pagesize", pagesize);
//            dyParams.Add("@pageindex", pageindex);
//            dyParams.Add("@total", 0, DbType.Int32, ParameterDirection.Output, 0);
//            list = TuanDai.DB.TuanDaiDB.Query<WeFundDetailInfo>(TdConfig.DBRead, strSQL, ref dyParams);
//            totalcount = list != null && list.Any() ? list[0].TotalCount : 0;
            WeFundDetailHistoryClient Client = new WeFundDetailHistoryClient();
            var reqModel = new TuanDai.UserPrize.Model.RequestModel.GetFoundDetailListJosnModelRequest();
            reqModel.UserId = WebUserAuth.UserId.Value;
            reqModel.WeOrderId = Guid.Parse(weOrderId); 
            reqModel.PageIndex = pageindex;
            reqModel.PageSize = pagesize;
            string errorInfo = string.Empty;

            var result = Client.GetFoundDetailListJosn(reqModel, ref errorInfo);
            if (!errorInfo.IsEmpty())
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "FTB-GetFoundDetailListJosn出错", WebUserAuth.UserId.ToText(), errorInfo);
            }
            if (result == null)
            {
                return;
            }
            totalcount = result.TotalRecord;


            List<WeFundDetailInfo> list = new List<WeFundDetailInfo>();
            if (result.items.Any())
            {
                result.items.ForEach(p =>
                {
                    list.Add(new WeFundDetailInfo()
                    {
                        WeOrderId = Guid.Parse(p.WeOrderId),
                        Amount = p.Amount.ToDecimal(0),
                        InAmount = p.InAmount.ToDecimal(0),
                        OutAmount = p.OutAmount.ToDecimal(0),
                        FundType = p.FundType,
                        Describe = p.Describe,
                        AddDate = p.AddDate,
                        //ProjectId=p.FundProjectID
                        //Grade=p.g
                        FundProjectID = p.FundProjectID,
                    });
                });
            }
            List<string> fundIdList = list.Select(p => p.FundProjectID).Distinct().ToList();
            if (fundIdList.Any())
            {
                string strSQL = @"select P.Id AS ProjectId,p.Grade, Cast(isnull(a.Id,'')  as varchar(255)) AS  FundProjectID from Subscribe   a WITH(nolock)
                                          left join Project P  WITH(nolock) on a.ProjectId=P.id
                                          where  a.id in(" + StrObj.StrToInSQL(fundIdList) + ")";
                Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                List<WeFundDetailInfo> subscribeList = TuanDai.DB.TuanDaiDB.Query<WeFundDetailInfo>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
                if (subscribeList != null)
                {
                    foreach (var item in subscribeList)
                    {
                        List<WeFundDetailInfo> tmpList = list.Where(p => p.FundProjectID == item.FundProjectID && p.FundType.ToText().IsIn("2", "3", "4")).ToList();
                        if (tmpList != null && tmpList.Any())
                        {
                            foreach (var subitem in tmpList)
                            {
                                subitem.ProjectId = item.ProjectId;
                                subitem.Grade = item.Grade;
                            }
                        }
                    }
                }
            } 

            int pageCount = GetPageCount(totalcount, pagesize);
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (WeFundDetailInfo temp in list)
                {
                    string linkUrl = "";
                    sb.Append("{\"FundType\":\"" + temp.FundType + "\",\"AddDate\":\"" + (temp.AddDate.ToString("yyyy-MM-dd HH:mm")) +
                                 "\",\"InAmount\":\"" + temp.InAmount.ToString("N2") + "\",\"OutAmount\":\"" + temp.OutAmount.ToString("N2") +
                                 "\",\"ActionStr\":\"" + GetActionStr(temp.FundType, temp.Grade, temp.ProjectId, temp.Describe, out linkUrl) +
                                  "\",\"LinkUrl\":\"" + linkUrl);

                    if (index == list.Count())
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
                sb.Append("{\"result\":\"0\",\"pageCount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        protected string GetActionStr(object fundType, object grade, object projectId, object describe, out string linkUrl)
        {
            int iFundType = fundType.ToInt(0);
            string actionName = "未知";
            linkUrl = "";
            switch (iFundType)
            {
                case 1:
                    actionName = "加入计划";
                    break;
                case 2:
                    actionName = "投资 标号" + grade;
                    linkUrl = string.Format("/pages/invest/detail.aspx?id={0}", projectId);
                    break;
                case 3:
                    if (describe.ToText().IndexOf("提前还款") != -1)
                        actionName = "提前回款 标号" + grade;
                    else
                        actionName = "回款 标号" + grade;
                    linkUrl = string.Format("/pages/invest/detail.aspx?id={0}", projectId);
                    break;
                case 4:
                    actionName = "复投 标号" + grade;
                    linkUrl = string.Format("/pages/invest/detail.aspx?id={0}", projectId);
                    break;
                case 5:
                    actionName = "提前赎回";
                    break;
                case 6:
                    actionName = "退出计划";
                    break;
                case 7:
                    actionName = "提取收益";
                    break;
                case 8:
                    if (iFundType == 8 && describe.ToText().IndexOf("流标退还") != -1)
                        actionName = "流标退款";
                    else
                        actionName = "退款";
                    break;
                case 9:
                    actionName = "奖励";
                    break;
                case 10:
                    actionName = "债权转让";
                    break;
                case 11:
                    actionName = "管理费";
                    break;
            }
            return actionName;
        }
        
        #endregion

        #region 获取We计划复投宝交易记录
        public void GetWeFTBTradeDetailShowList()
        {
            int pagesize = 8;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            var weOrderId = HttpContext.Current.Request.Form["weOrderId"];
            if (pageindex < 1)
                pageindex = 1;

            int totalcount = 0;
            StringBuilder sb = new StringBuilder();

            List<WeFundDetailInfo> list = new List<WeFundDetailInfo>();
            if (ConfigHelper.getConfigString("IsHadoop") == "1")//开启大数据，交易记录从大数据取
            {
                WeFundDetailHistoryClient Client = new WeFundDetailHistoryClient();
                var reqModel = new TuanDai.UserPrize.Model.RequestModel.GetFoundDetailListJosnModelRequest();
                reqModel.UserId = WebUserAuth.UserId.Value;
                reqModel.WeOrderId = Guid.Parse(weOrderId);
                reqModel.PageIndex = pageindex;
                reqModel.PageSize = pagesize;
                string errorInfo = string.Empty;

                var result = Client.GetFoundDetailListJosn(reqModel, ref errorInfo);
                if (!errorInfo.IsEmpty())
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName,
                        "FTB-GetFoundDetailListJosn出错", WebUserAuth.UserId.ToText(), errorInfo);
                }
                if (result == null)
                {
                    return;
                }
                totalcount = result.TotalRecord;

                if (result.items.Any())
                {
                    result.items.ForEach(p =>
                    {
                        list.Add(new WeFundDetailInfo()
                        {
                            WeOrderId = Guid.Parse(p.WeOrderId),
                            Amount = p.Amount.ToDecimal(0),
                            InAmount = p.InAmount.ToDecimal(0),
                            OutAmount = p.OutAmount.ToDecimal(0),
                            FundType = p.FundType,
                            Describe = p.Describe,
                            AddDate = p.AddDate,
                            FundProjectID = p.FundProjectID,
                        });
                    });
                }
                List<string> fundIdList = list.Select(p => p.FundProjectID).Distinct().ToList();
                if (fundIdList.Any())
                {
                    string strSQL = @"select P.Id AS ProjectId,p.Grade, Cast(isnull(a.Id,'')  as varchar(255)) AS  FundProjectID from Subscribe   a WITH(nolock)
                                          left join Project P  WITH(nolock) on a.ProjectId=P.id
                                          where  a.id in(" + StrObj.StrToInSQL(fundIdList) + ")";
                    Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                    List<WeFundDetailInfo> subscribeList =
                        TuanDai.DB.TuanDaiDB.Query<WeFundDetailInfo>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL,
                            ref dyParams);
                    if (subscribeList != null)
                    {
                        foreach (var item in subscribeList)
                        {
                            List<WeFundDetailInfo> tmpList =
                                list.Where(
                                    p =>
                                        p.FundProjectID == item.FundProjectID && p.FundType.ToText().IsIn("2", "3", "4"))
                                    .ToList();
                            if (tmpList != null && tmpList.Any())
                            {
                                foreach (var subitem in tmpList)
                                {
                                    subitem.ProjectId = item.ProjectId;
                                    subitem.Grade = item.Grade;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                string strSQL = @"SELECT * FROM (
                                                    SELECT  ROW_NUMBER() OVER (ORDER BY a.AddDate desc) AS rownumber,SUM(1) OVER() TotalCount,
                                                    A.Amount, A.InAmount, A.OutAmount,A.FundType, A.Describe, A.AddDate,P.Id AS ProjectId,p.Grade,b.IsNewHand
                                                    FROM We_FundDetail  A WITH(NOLOCK)
                                                    INNER JOIN We_Order  B WITH(nolock) ON B.Id=A.WeOrderId
                                                    LEFT JOIN Subscribe C WITH(nolock) ON c.Id=A.FundProjectID
                                                    left join Project P  WITH(nolock) on C.ProjectId=p.Id
                                                    WHERE A.FundType in(1,2,3,4,5,6,7,8,9,10,11) AND A.WeOrderId=@weOrderId AND A.UserID=@userId 
                                                )M  WHERE M.rownumber> @pagesize*(@pageindex-1) and  M.rownumber<=@pagesize*@pageindex ";

                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@weOrderId", weOrderId);
                dyParams.Add("@userId", WebUserAuth.UserId.Value);
                dyParams.Add("@pagesize", pagesize);
                dyParams.Add("@pageindex", pageindex);
                dyParams.Add("@total", 0, DbType.Int32, ParameterDirection.Output, 0);
                list = TuanDai.DB.TuanDaiDB.Query<WeFundDetailInfo>(TdConfig.DBRead, strSQL, ref dyParams);
                totalcount = list != null && list.Any() ? list[0].TotalCount : 0;
            }
            

            int pageCount = GetPageCount(totalcount, pagesize);
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (WeFundDetailInfo temp in list)
                {
                    string linkUrl = "";
                    sb.Append("{\"FundType\":\"" + temp.FundType + "\",\"AddDate\":\"" + (temp.AddDate.ToString("yyyy-MM-dd HH:mm")) +
                                 "\",\"InAmount\":\"" + temp.InAmount.ToString("N2") + "\",\"OutAmount\":\"" + temp.OutAmount.ToString("N2") +
                                 "\",\"ActionStr\":\"" + GetFTBActionStr(temp.FundType, temp.Grade, temp.ProjectId, temp.Describe,temp.IsNewHand, out linkUrl) +
                                  "\",\"LinkUrl\":\"" + linkUrl);

                    if (index == list.Count())
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
                sb.Append("{\"result\":\"0\",\"pageCount\":\"" + pageCount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }


        protected string GetFTBActionStr(object fundType, object grade, object projectId, object describe,bool isNewHand, out string linkUrl)
        {
            int iFundType = fundType.ToInt(0);
            string actionName = "未知";
            linkUrl = "";
            switch (iFundType)
            {
                case 1:
                    actionName = isNewHand ? "加入新手专享复投宝" : "加入计划";
                    break;
                case 2:
                    actionName = "投资 标号" + grade;
                    linkUrl = string.Format("/pages/invest/detail.aspx?id={0}", projectId);
                    break;
                case 3:
                    actionName = "回款 标号" + grade;
                    linkUrl = string.Format("/pages/invest/detail.aspx?id={0}", projectId);
                    break;
                case 4:
                    actionName = "复投 标号" + grade;
                    linkUrl = string.Format("/pages/invest/detail.aspx?id={0}", projectId);
                    break;
                case 5:
                    actionName = "结束服务，回款解冻，提取至可用余额";
                    break;
                case 6:
                    actionName = isNewHand ? "结束服务，回款解冻" : "结束服务，回款解冻，提取至可用余额";
                    break;
                case 7:
                    actionName = "提取收益";
                    break;
                case 8:
                    if (iFundType == 8 && describe.ToText().IndexOf("流标退还") != -1)
                        actionName = "流标退款";
                    else
                        actionName = "退款";
                    break;
                case 9:
                    {
                        if (describe.ToText().IsEmpty())
                            actionName = "奖励收益";
                        else if (describe.ToText() == "加息奖励")
                            actionName = "加息奖励";
                        else
                            actionName = "发放现金奖励";
                        break;
                    }
                case 10:
                    actionName = "债权退出回款冻结";
                    break;
                case 11:
                    actionName = "扣除服务费";
                    break;
            }
            return actionName;
        }
        #endregion 

    }


    #region 内部类

    public class UserAddInterest
    {
        public Guid? UserId { get; set; }
        public decimal? RedRate { get; set; }

        public int? StartDeadline { get; set; }
        public int? EndDeadline { get; set; }

        public DateTime? StartDate { get; set; }

        public DateTime? EndDate { get; set; }
    }

    public class ReturnMessage
    {
        public string status { get; set; }

        public string msg { get; set; }
    }
    public class WeQMoney
    {
        public decimal CurrDayJoinMoney { get; set; }
        public decimal CurrDayJoinCount { get; set; }
    }

    public class ZQZRProjectInfo
    {
        public Guid Id { get; set; }

        public int Type { get; set; }

        public decimal Amount { get; set; }

        public int TotalShares { get; set; }

        public int ComplateShares { get; set; }

        public int AviShares { get; set; }

        public int RepaymentType { get; set; }

        public decimal LowerUnit { get; set; }

        public int Status { get; set; }

        public decimal InterestRate { get; set; }

        public double? PublisherRate { get; set; }

        public double? TuandaiRate { get; set; }

        public int Deadline { get; set; }

        public int ResidueDeadline { get; set; }

        public int ProjectDeadline { get; set; }

    }

    [Serializable]
    public class InvestMoneyInfo
    {
        /// <summary>
        /// 判断用户是否有登陆
        /// </summary>
        public int IsLogin { get; set; }
        /// <summary>
        /// 可用余额
        /// </summary>
        public decimal AviMoney { get; set; }

        /// <summary>
        /// 最小单位,即每份多少钱
        /// </summary>
        public decimal LowerUnit { get; set; }
        /// <summary>
        /// 佣金
        /// </summary>
        public string CommissionMoney { get; set; }

        //最大出借份数
        public int MaxUnit { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal ExpectedMoney { get; set; }
        /// <summary>
        /// 发标人投标奖励
        /// </summary>
        public double PublisherRate { get; set; }
        /// <summary>
        /// 团贷网投标奖励
        /// </summary>
        public double TuandaiRate { get; set; }
        public decimal perAmout { get; set; }
        public decimal RewardAmount { get; set; }
        /// <summary>
        /// 付款方式
        /// </summary>
        public int RepaymentType { get; set; }
        /// <summary>
        /// 付款方式描述
        /// </summary>
        public string RepaymentTypeDesc { get; set; }
        public int Deadline { get; set; }
        public decimal InterestRate { get; set; }
        public int ProjectType { get; set; }
        //是否需要录入交易密码
        public int IsNeedPayPwd { get; set; }
        /// <summary>
        /// 还款期限类型  1:按月 2:按天
        /// </summary>
        public int DeadType { get; set; }

        #region 私募宝
        /// <summary>
        /// 私募宝收益计算方式1:浮动收益2:固定收益
        /// </summary>
        public int ProfitType { get; set; }
        /// <summary>
        /// 私募宝特有预期收益
        /// </summary>
        public decimal PreProfitRate_S { get; set; }
        /// <summary>
        /// 私募宝特有，预期收益
        /// </summary>
        public decimal PreProfitRate_E { get; set; }
        #endregion
        /// <summary>
        /// 新手加息奖励
        /// </summary>
        public decimal NewHandRate { get; set; }

        /// <summary>
        /// 项目宝最新小利率
        /// </summary>
        public decimal XmbMinInterestRate { get; set; }
        /// <summary>
        /// 项目宝最大利率
        /// </summary>
        public decimal XmbMaxInterestRate { get; set; }
        /// <summary>
        /// 是否1218当天
        /// </summary>
        public int IsDay1218 { get; set; }
        /// <summary>
        /// 1218活动网址
        /// </summary>
        public string Activity1218Url { get; set; }
        //We计划本金复投最大利率
        public decimal MaxYearRate2 { get; set; }
        /// <summary>
        /// 总份数
        /// </summary>
        public int TotalShares { get; set; }
        /// <summary>
        /// 已完成份数
        /// </summary>
        public int ComplateShares { get; set; }
        /// <summary>
        /// 标的到期时间
        /// </summary>
        public string EndDate { get; set; }
        /// <summary>
        /// 是否债权转让标
        /// </summary>
        public int IsZQZR { get; set; }
        /// <summary>
        /// 机构信息
        /// </summary>
        public OrgInfo orgInfo { get; set; }
        /// <summary>
        /// 是否新手标
        /// </summary>
        public int IsNewHandProject { get; set; }
        /// <summary>
        /// we计划Q购买金额
        /// </summary>
        public decimal WeQAmount { get; set; }
        public int IsWeFQB { get; set; }
        public int IsFTB { get; set; }
        public int FTBSubType { get; set; }
        /// <summary>
        /// 是否有投资过
        /// </summary>
        public int IsInvested { get; set; }
        /// <summary>
        /// 新手标申购时提示
        /// </summary>
        public string NewHandMsg { get; set; }
        /// <summary>
        /// 是否完成风险评测
        /// </summary>
        public bool IsRisk { get; set; }
        /// <summary>
        /// 可使用红包列表
        /// </summary>
        public string RedPacketListStr { get; set; }
    }
    /// <summary>
    /// 机构信息
    /// </summary>
    public class OrgInfo
    {
        /// <summary>
        /// 机构ID
        /// </summary>
        public Guid OrgId { get; set; }
        /// <summary>
        /// 机构类型
        /// </summary>
        public int OrgTypeId { get; set; }
        /// <summary>
        /// 机构子类
        /// </summary>
        public int SubTypeId { get; set; }
    }
    /// <summary>
    /// We资金流水
    /// </summary>
    public class WeFundDetailInfo
    {
        public int TotalCount { get; set; }
        public Guid WeOrderId { get; set; }
        public decimal Amount { get; set; }
        public decimal InAmount { get; set; }
        public decimal OutAmount { get; set; }
        public int FundType { get; set; }

        public string Describe { get; set; }

        public DateTime AddDate { get; set; }
        public Guid? ProjectId { get; set; }
        /// <summary>
        /// 标号
        /// </summary>
        public string Grade { get; set; }
        public string FundProjectID { get; set; }
        public bool IsNewHand { get; set; }
    }
    #endregion
}