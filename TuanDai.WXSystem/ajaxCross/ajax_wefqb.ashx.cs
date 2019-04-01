﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Tool;
using System.Text;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using System.Data;
using TuanDai.WXSystem.Core;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using TuanDai.InfoSystem.Model;
using BusinessDll;
using Newtonsoft.Json;
using TuanDai.DB;
using TuanDai.PortalSystem.ExtServiceDAL;
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// ajax_wefqb 的摘要说明
    /// </summary>
    public class ajax_wefqb : SafeHandlerBase
    {

        #region We计划分期宝 申请赎回
        /// <summary>
        /// We计划分期宝申请赎回
        /// </summary>
        public void ApplyWeFqbTransfer()
        {
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                PrintJson("-99", "登陆超时");
            }
            TuanDai.PortalSystem.BLL.UserBLL userbll = new TuanDai.PortalSystem.BLL.UserBLL();
            TuanDai.PortalSystem.Model.UserBasicInfoInfo model = userbll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-98", "用户不存在");
            }
            if ((model.uStatus ?? 0) != 1)
            {
                PrintJson("-10", "用户已被冻结");
            }
            Guid weOrderId = WEBRequest.GetFormGuid("WeOrderId");
            if (weOrderId == Guid.Empty)
            {
                PrintJson("-9", "We订单不存在");
            }
            if (GlobalUtils.IsOpenCGT)
            {
                var reqMode = new CgtCallbackUrl.Model.ModelRequest.ApplyWeFQBTransferRequest
                {
                    WeOrderId = weOrderId
                };

                string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.WeFqbPreExit);
                PrintJson("8888", url);
            }
            else
            {
                //验证交易密码 
                var bll = new UserSettingBLL();
                var usersetting = bll.GetUserSettingInfo(userid);
                if (usersetting != null)
                {
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
                    string PayPwd = Tool.Encryption.MD5(Context.Request["TranPwd"]);
                    if (PayPwd != model.PayPwd)
                    {
                        //记录登录错误次数
                        if (usersetting.PayPwdErrorCount == null)
                        {
                            usersetting.PayPwdErrorCount = 0;
                        }
                        usersetting.PayPwdErrorCount += 1;
                        usersetting.PayPwdErrorDate = DateTime.Now;
                        //db.SaveChanges();
                        bll.UpdateUserSettingInfo(usersetting);
                        if (usersetting.PayPwdErrorCount == 5)
                        {
                            PrintJson("-151", "交易密码已错误5次，请24小时后再进行此操作");
                        }
                        else
                        {
                            PrintJson("-15", "交易密码错误，您还剩下" + (5 - usersetting.PayPwdErrorCount).ToString() + "次机会");
                        }
                    }
                    else
                    {
                        //清除错误记录
                        usersetting.PayPwdErrorCount = 0;
                        usersetting.PayPwdErrorDate = null;
                        //db.SaveChanges();
                        bll.UpdateUserSettingInfo(usersetting);
                    }
                }
                int status = 0;
                TuanDai.PortalSystem.BLL.WeOrderBLL webll = new TuanDai.PortalSystem.BLL.WeOrderBLL();
                webll.ApplyWeFqbRansom(weOrderId, out status);
                if (status == 1)
                {
                    PrintJson("1", "申请转让成功");
                }
                else
                {
                    string errMsg = "";
                    switch (status)
                    {
                        case 0:
                            errMsg = "系统异常";
                            break;
                        case 2:
                            errMsg = "不是We计划分期宝";
                            break;
                        case 3:
                            errMsg = "回款中状态不允许赎回";
                            break;
                        case 4:
                            errMsg = "持有时间必须超过3个月";
                            break;
                        case 5:
                            errMsg = "只有投标中的We计划才能转让";
                            break;
                    }
                    PrintJson("0", errMsg);
                }
            }
        }

        /// <summary>
        /// We计划分期宝取消赎回
        /// </summary>
        public void CancleWeFqbTransfer()
        {
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                PrintJson("-99", "登陆超时");
            }
            TuanDai.PortalSystem.BLL.UserBLL userbll = new TuanDai.PortalSystem.BLL.UserBLL();
            TuanDai.PortalSystem.Model.UserBasicInfoInfo model = userbll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-98", "用户不存在");
            }
            Guid weOrderId = WEBRequest.GetFormGuid("WeOrderId");
            if (weOrderId == Guid.Empty)
            {
                PrintJson("-9", "We订单不存在");
            }
            int status = 0;
            TuanDai.PortalSystem.BLL.WeOrderBLL webll = new TuanDai.PortalSystem.BLL.WeOrderBLL();
            webll.RevokeWeFqbRansom(weOrderId, out status);
            if (status == 1)
            {
                PrintJson("1", "撤销转让成功");
            }
            else
            {
                string errMsg = "";
                switch (status)
                {
                    case 0:
                        errMsg = "系统异常";
                        break;
                    case 2:
                        errMsg = "不在赎回状态";
                        break;
                    case 3:
                        errMsg = "不是We计划分期宝";
                        break;
                    case 4:
                        errMsg = "债权已有人承接,不能撤销";
                        break;
                }
                PrintJson("0", errMsg);
            }
        }
        /// <summary>
        /// 判断转让的债权是否有承接
        /// </summary>
        public void CheckTransferHasJoin()
        {
            Guid weOrderId = WEBRequest.GetFormGuid("WeOrderId");
            if (weOrderId == Guid.Empty)
            {
                PrintJson("-9", "We订单不存在");
            }
            string strSQL = "SELECT COUNT(1) AS cnt from  dbo.Subscribe with(nolock)  WHERE WeOrderId=@WeOrderId AND TransferedShares>0";
            Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@WeOrderId", weOrderId);
            int count = TuanDai.DB.TuanDaiDB.Query<int>(TdConfig.DBRead, strSQL, ref dyParams).FirstOrDefault();
            if (count <= 0)
                PrintJson("1", "未承接");
            else
                PrintJson("0", "已被承接");
        }
        #endregion

        /// <summary>
        /// 获取We计划分期宝的投资列表
        /// </summary>
        public void GetWeFQBProjectList()
        {
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid userid = WebUserAuth.UserId.Value;
            Guid weOrderId = WEBRequest.GetFormGuid("WeOrderId");
            StringBuilder sb = new StringBuilder();
            WeOrderBLL webll = new WeOrderBLL();
            int totalCount = 0;
            int pagesize = 10;
            List<SubMyInvestWeDetail_Info> dataList = webll.GetMyInvestWeFQBList(userid, weOrderId, pageindex, pagesize, out totalCount);
            int pageCount = GetPageCount(totalCount, pagesize);
            if (dataList.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
                foreach (SubMyInvestWeDetail_Info model in dataList)
                {
                    string Title = model.Title.Length > 20 ? model.Title.Substring(0, 20) + "..." : model.Title;

                    sb.Append("{\"Title\":\"" + Title + "\",\"Amount\":\"" + ToolStatus.ConvertLowerMoney(model.Amount)
                        + "\",\"SubscribeId\":\"" + model.InvestId
                        + "\",\"Type\":\"" + model.Type
                        + "\",\"ProjectId\":\"" + model.ProjectId
                        + "\",\"StatusDesc\":\"" + GetWeProjectStatusDesc(model)
                        + "\",\"TotalRecord\":\"" + model.TotalRecord
                        + "\",\"AddDate\":\"" + model.AddDate.ToString("yyyy-MM-dd HH:mm")
                        + "\",\"RemarkMode\":\"" + GetRemarkMode(model.TenderMode, model.IsFromTran ? 1 : 0)
                        + (index == dataList.Count() ? "\"}]}" : "\"},"));
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
        private string GetWeProjectStatusDesc(SubMyInvestWeDetail_Info model)
        {
            string cycleDate = model.FirstDate.ToString("yyyy-MM-dd") == "1900-01-01" ? "暂无" : model.FirstDate.ToString("yyyy-MM-dd");
            if (model.Status == 1 || model.Status == 2)
                return "等待满标";
            else if (model.Status == 3)
            {

                return cycleDate + " 回款(" + model.RefundedMonths + "/" + model.TotalRefundMonths + ")";
            }
            else if (model.Status == 4)
            {
                return cycleDate + " 已流标";
            }
            else if (model.Status == 5)
            {
                return " 已逾期";
            }
            else if (model.Status == 6)
            {
                return cycleDate + " 已完成";
            }
            return "";
        }
        protected string GetRemarkMode(object oTenderMode, object oIsFromTran)
        {
            string tenderMode = "";

            if (oTenderMode.ToText() == "5")
            {
                tenderMode = "自动投标";
            }
            if (oIsFromTran.ToText() == "1")
            {
                tenderMode = "承接债权";
            }
            return tenderMode;
        }


        #region 复投宝  申请赎回
        public void ApplyFTBTransfer()
        {
            Guid userid = WebUserAuth.UserId.Value;
            if (userid == Guid.Empty)
            {
                PrintJson("-99", "登陆超时");
            }
            TuanDai.PortalSystem.BLL.UserBLL userbll = new TuanDai.PortalSystem.BLL.UserBLL();
            TuanDai.PortalSystem.Model.UserBasicInfoInfo model = userbll.GetUserBasicInfoModelById(userid);
            if (model == null)
            {
                PrintJson("-98", "用户不存在");
            }
            if ((model.uStatus ?? 0) != 1)
            {
                PrintJson("-10", "用户已被冻结");
            }
            Guid weOrderId = WEBRequest.GetFormGuid("WeOrderId");
            if (weOrderId == Guid.Empty)
            {
                PrintJson("-9", "We订单不存在");
            }
            decimal applyAmount = WEBRequest.GetFormString("ApplyAmount").ToDecimal(0);
            if (applyAmount <= 0)
            {
                PrintJson("-1", "申请的退出本金必须大于0");
            }
            if (applyAmount % 1 != 0)
            {
                PrintJson("-1", "请输入大于0的整数金额");
            }

            if (GlobalUtils.IsOpenCGT)
            {
                var reqMode = new CgtCallbackUrl.Model.ModelRequest.ApplyFTBTransferRequest
                {
                    WeOrderId = weOrderId,
                    TransferAmount = applyAmount
                };

                string url = CgtCallBackConfig.GetCgtTradePwdUrl(reqMode, CgtCallBackConfig.CgtCallBackType.FTBPreExit);
                PrintJson("8888", url);
            }
            else
            {
                //验证交易密码 
                var bll = new UserSettingBLL();
                var usersetting = bll.GetUserSettingInfo(userid);
                if (usersetting != null)
                {
                    #region
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
                    string PayPwd = Tool.Encryption.MD5(Context.Request["TranPwd"]);
                    if (PayPwd != model.PayPwd)
                    {
                        //记录登录错误次数
                        if (usersetting.PayPwdErrorCount == null)
                        {
                            usersetting.PayPwdErrorCount = 0;
                        }
                        usersetting.PayPwdErrorCount += 1;
                        usersetting.PayPwdErrorDate = DateTime.Now;
                        //db.SaveChanges();
                        bll.UpdateUserSettingInfo(usersetting);
                        if (usersetting.PayPwdErrorCount == 5)
                        {
                            PrintJson("-151", "交易密码已错误5次，请24小时后再进行此操作");
                        }
                        else
                        {
                            PrintJson("-15", "交易密码错误，您还剩下" + (5 - usersetting.PayPwdErrorCount).ToString() + "次机会");
                        }
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

                int status = 0;
                string strError = "";
                TuanDai.PortalSystem.BLL.WeFTBBLL webll = new TuanDai.PortalSystem.BLL.WeFTBBLL();
                webll.ApplyFTBRansom(weOrderId, applyAmount, out status, out strError);
                PrintJson(status.ToString(), strError);
            }
        }
        #endregion

        #region 获取复投宝债权信息
        /// <summary>
        /// 获取复投宝债仅信息
        /// </summary>
        public void GetWeFtbObligatoryList()
        {
            Guid? productId = SafeConvert.ToGuid(WEBRequest.GetFormString("projectid"));
            int pageSize, pageIndex, totalCount;
            pageSize = 15;
            int.TryParse(Context.Request["pageIndex"], out pageIndex);
            WeFTBBLL weFtBll = new WeFTBBLL();

            List<FTBInvestProjectInfo> ftbInvestProjectInfoList = weFtBll.GetFTBObligatoryList(productId.Value, pageSize, pageIndex, out totalCount);
            List<FTBInvestProjectInfo> newList = new List<FTBInvestProjectInfo>();
            for (int i = 0; i < ftbInvestProjectInfoList.Count; i++)
            {
                var borrowerName = ftbInvestProjectInfoList[i].BorrowerName;
                var phone = ftbInvestProjectInfoList[i].TelNo;
                var IdentityCard = ftbInvestProjectInfoList[i].IdentityCard;
                var address = ftbInvestProjectInfoList[i].Address.ToText();
                if (borrowerName.Length > 0)
                {
                    borrowerName = borrowerName.Substring(0, 1) + "**";
                }
                if (!phone.IsEmpty())
                {
                    if (phone.Length > 11)
                        phone = phone.Left(11);
                    phone = StringHandler.MaskTelNo(phone);
                }

                if (!string.IsNullOrWhiteSpace(IdentityCard))
                {
                    if (IdentityCard.Length > 18)
                        IdentityCard = IdentityCard.Left(18);
                    IdentityCard = StringHandler.MaskCardNo(IdentityCard);
                }

                if (address.Length > 5)
                {
                    address = address.Substring(0, 6) + "...";
                }
                FTBInvestProjectInfo tempModel = new FTBInvestProjectInfo();
                tempModel.Address = address;
                tempModel.Amount = ftbInvestProjectInfoList[i].Amount;
                tempModel.BorrowerName = borrowerName;
                tempModel.Id = ftbInvestProjectInfoList[i].Id;
                tempModel.InvestDate = ftbInvestProjectInfoList[i].InvestDate;
                tempModel.ProductName = ftbInvestProjectInfoList[i].ProductName;
                tempModel.ProjectTitle = ftbInvestProjectInfoList[i].ProjectTitle;
                tempModel.ProjectId = ftbInvestProjectInfoList[i].ProjectId;
                tempModel.TelNo = phone;
                tempModel.IdentityCard = IdentityCard;
                newList.Add(tempModel);
            }
            this.Context.Response.Write(JsonConvert.SerializeObject(
                new
                {
                    result = totalCount > 0 ? 1 : 0,
                    totalcount = totalCount,
                    msg = newList
                }));

            this.Context.Response.End();
        }
        #endregion

        #region 获取我的复投宝投资列表

        public void GetMyFtbInvestList()
        {
            Guid? weOrderId = SafeConvert.ToGuid(WEBRequest.GetFormString("weOrderId"));
            int pageIndex;
            int.TryParse(Context.Request["pageIndex"], out pageIndex);
            int totalCount = 0;
            List<WeFTBWxInvestInfo> dataList = null;
            if (GlobalUtils.IsOpenSubscribeApi)//走CDC查询服务
            {
                string err = "";
                string resp = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName,
                    GlobalUtils.SubApiUrl + "/app/appGetMyFTBClaimDetail?weOrderId="+weOrderId+"&userId="+WebUserAuth.UserId.Value+"&pagesize=15&pageindex="+pageIndex, "", out err);
                if (!string.IsNullOrEmpty(resp))
                {
                    var pub = JsonConvert.DeserializeObject <
                              ResponsePublicModel<ResponseGeWeFTBWxInvestInfo>>(resp);
                    if (pub != null)
                    {
                        dataList = pub.data.dataList;
                        totalCount = pub.data.totalCount;
                    }
                }
                
                //dataList = service.GetDataPager<WeFTBWxInvestInfo>("/app/APPGetMyFTBClaimDetail", param,
                //    out totalCount);

                
            }
            else
            {
                string strSQL = @"SELECT * FROM (
                                    select SUM(1) OVER() as TotalCount, s.Id as SubscribeId,s.ContractNo,p.[Type],
                                    case when isnull(s.TotalShares,0)=0 and isnull(s.TransferedShares,0)=0 then s.Amount when  isnull(s.TransferedShares,0)>0 and (s.TotalShares=0 or s.TotalShares=s.TransferedShares)  then ISNULL(s.TranedAmount,0) else  s.Amount+isnull(s.TranedAmount,0) end Amount,p.Title,u.RealName as UserName,isnull(s.TranDate,s.AddDate) as AddDate,
                                    isnull(s.IsFromTran,0) as IsFromTran, s.TranId,
                                    ROW_NUMBER() OVER(order by s.AddDate desc) rownumber 
                                    from Subscribe s with(nolock)
                                    left join Project p with(nolock) on s.ProjectId=p.Id   
                                    left join UserBasicInfo u with(nolock) on p.UserId=u.Id
                                    where s.SubscribeUserId=@userId  AND s.WeOrderId=@weOrderId and s.ContractNo not like '%[_]%'
                                )M  WHERE M.rownumber> @pagesize*(@pageindex-1) and  M.rownumber<=@pagesize*@pageindex ";

                Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@weOrderId", weOrderId);
                dyParams.Add("@userId", WebUserAuth.UserId.Value);
                dyParams.Add("@pagesize", 15);
                dyParams.Add("@pageindex", pageIndex);

                dataList = TuanDai.DB.TuanDaiDB.Query<WeFTBWxInvestInfo>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
                if (dataList != null && dataList.Count > 0)
                {
                    totalCount = dataList[0].TotalCount;
                    foreach (var item in dataList)
                    {
                        if (item.UserName != null)
                        {
                            if (item.UserName.Length > 1)
                            {
                                item.UserName = item.UserName.Substring(0, 1) + "**";
                            }
                        }
                    }
                }
            }


            if (dataList != null && dataList.Count > 0)
            {
                WebSettingInfo ftzqSet = new WebSettingBLL().GetWebSettingInfo("BA8B8D06-A510-436C-B996-3D66D43FDF40");
                
                foreach (var item in dataList)
                {
                    item.IsFromTran = item.IsFromTran && item.AddDate > DateTime.Parse(ftzqSet.Param2Value);

                    if (GlobalUtils.IsOpenSubscribeApi)
                    {
                        item.ContractUrl = GetContractViewUrl(item.TypeId, item.IsFromTran, item.ContractUrl,
                            item.SubscribeId);
                        item.Title = item.ProjectTitle;
                        var borrowerModel = new UserBLL().GetUserBasicInfoModelById(item.BorrowerId);
                        if(borrowerModel == null)
                            borrowerModel = new UserBasicInfoInfo();
                        var relName = borrowerModel.RealName;
                        if (!string.IsNullOrEmpty(relName))
                            item.UserName = relName.Substring(0, 1) + "**";
                    }
                    else
                    {
                        item.ContractUrl = GetContractViewUrl(item.Type, item.IsFromTran, item.ContractNo,
                            item.SubscribeId);
                    }
                }
                if (ftzqSet.Param1Value == "1")
                {
                    DateTime checkDate = DateTime.Parse(ftzqSet.Param2Value.Trim());
                    //查询是否有承接记录
                    List<string> subIdList = dataList.Select(p => p.SubscribeId.ToString()).ToList();
                    if (subIdList != null && subIdList.Any())
                    {
                        //加开关控制
                        dataList.ForEach(p => p.IsFromTran = p.AddDate > checkDate && p.IsFromTran);
                        //string strSQL = "select UsedShares,SubscribeId, AddDate from dbo.ProjectFQBExTransfer where SubscribeId in(" + StrObj.StrToInSQL(subIdList) + ")";
                        //var dyParams = new Dapper.DynamicParameters();
                        //List<ProjectFQBExTransferInfo> fqbTranList = TuanDai.DB.TuanDaiDB.Query<ProjectFQBExTransferInfo>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
                        //if (fqbTranList == null || fqbTranList.Count == 0 || fqbTranList.Count < dataList.Count)
                        //{
                        //    //查询历史库
                        //    List<ProjectFQBExTransferInfo> fqbTranList2 = TuanDai.DB.TuanDaiDB.Query<ProjectFQBExTransferInfo>(TdConfig.ApplicationName, TdConfig.DBWePlanRead, strSQL, ref dyParams);
                        //    if (fqbTranList2 != null)
                        //    {
                        //        if (fqbTranList == null)
                        //            fqbTranList = new List<ProjectFQBExTransferInfo>();
                        //        fqbTranList.AddRange(fqbTranList2);
                        //    }
                        //}
                        string subids = "";
                        if (subIdList != null && subIdList.Count > 0)
                        {
                            foreach (var subid in subIdList)
                            {
                                if (string.IsNullOrEmpty(subids))
                                {
                                    subids = subid.ToUpper();
                                }
                                else
                                {
                                    subids += "," + subid.ToUpper();
                                }
                            }
                        }
                        List<ProjectFQBExTransferInfo> fqbTranList = GetTranList(subids);
                        
                        if (fqbTranList != null && fqbTranList.Any())
                        {
                            foreach (var item in dataList)
                            {
                                ProjectFQBExTransferInfo findObj = fqbTranList.Where(p => p.SubscribeId == item.SubscribeId).FirstOrDefault();
                                if (findObj != null)
                                {
                                    //加开关控制
                                    item.IsHaveTranList = findObj.AddDate > checkDate && findObj.UsedShares > 0;
                                }
                            }
                        }
                    }
                }
            }

            this.Context.Response.Write(JsonConvert.SerializeObject(
                new
                {
                    result = totalCount > 0 ? 1 : 0,
                    totalcount = totalCount,
                    msg = dataList
                }));

            this.Context.Response.End();
        }
        #endregion
        /// <summary>
        /// 通过大数据获取List ProjectFQBExTransfer 
        /// </summary>
        /// <param name="subId"></param>
        /// <returns></returns>
        private List<ProjectFQBExTransferInfo> GetTranList(string subId)
        {
            List<ProjectFQBExTransferInfo> fqbTranList = new List<ProjectFQBExTransferInfo>();
            string err = "";
            string resp = HttpClient.HttpUtil.HttpGet(TdConfig.ApplicationName, ConfigHelper.getConfigString("GetFtbTranListServerUrl") + "/we/FTBInvestList?SubscribeId=" + subId, "", out err);
            if (!string.IsNullOrEmpty(resp))
            {
                var rs = JsonConvert.DeserializeObject<ResponseFtbTransfer>(resp);
                if (rs != null && rs.list != null)
                    fqbTranList = rs.list;
            }
            else
            {
                TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "GetTranList", subId, "通过大数据获取List ProjectFQBExTransfer出错："+err);
            }
            return fqbTranList;
        } 
        /// <summary>
        /// 获取我的复投宝转让记录
        /// </summary>
        public void GetMyFtbTranList()
        {
            string subId = WEBRequest.GetFormString("SubId");
            int pageIndex;
            int.TryParse(Context.Request["pageIndex"], out pageIndex);
            int totalCount = 0;
            //string strSQL = @" select Id from dbo.ProjectFQBExTransfer where SubscribeId=@subId";
            //var dyParams = new Dapper.DynamicParameters();
            //dyParams.Add("@subId", subId);
            //Guid? tranId = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<Guid?>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
            Guid? tranId = GetTranList(subId.ToUpper()).FirstOrDefault().Id;
            List<FTBChengJieInfo> dataList = null;
            if (!tranId.HasValue)
            {
                totalCount = 0;
                dataList = new List<FTBChengJieInfo>();
            }
            else
            {
                var strSQL = @" select * from (select  ROW_NUMBER() OVER(order by a.TranDate desc) rownumber, isnull(a.TranDate,a.AddDate) as InvestDate, 
                    a.Amount as InvestAmount,b.TelNo,a.ContractNo,a.Id  as SubscribeId,p.Type
                    from Subscribe  a with(nolock)
                    inner join Project p with(nolock) on a.ProjectId=p.id
                    left join UserBasicInfo b with(nolock) on b.Id=a.SubscribeUserId
                    where a.TranId=@tranId
                    )M  WHERE M.rownumber> @pagesize*(@pageindex-1) and  M.rownumber<=@pagesize*@pageindex ";
                var dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@tranId", tranId);
                dyParams.Add("@pagesize", 15);
                dyParams.Add("@pageindex", pageIndex);
                dataList = TuanDai.DB.TuanDaiDB.Query<FTBChengJieInfo>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
                if (dataList != null && dataList.Count > 0)
                {
                    foreach (var item in dataList)
                    {
                        item.ContractUrl = GetContractViewUrl(item.Type, true, item.ContractNo, item.SubscribeId);
                        if (!string.IsNullOrEmpty(item.TelNo))
                        {
                            item.TelNo = BusinessDll.StringHandler.MaskTelNo(item.TelNo);
                        }
                        item.InvestDateStr = item.InvestDate.ToShortDateString();
                    }
                }
                strSQL = "select count(1) from Subscribe where TranId=@tranId";
                dyParams = new Dapper.DynamicParameters();
                dyParams.Add("@tranId", tranId);
                totalCount = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBRead, strSQL, ref dyParams);
            }


            this.Context.Response.Write(JsonConvert.SerializeObject(
                new
                {
                    result = totalCount > 0 ? 1 : 0,
                    totalcount = totalCount,
                    msg = dataList
                }));

            this.Context.Response.End();
        }

        private string GetContractViewUrl(object oType, bool isFromTran, string oContractNo, Guid oSubscribeId)
        {
            int type = Convert.ToInt32(oType);
            string contractNo = oContractNo != null ? oContractNo.ToString() : "";
            if (type == 1 || type == 3)
            {
                return GlobalUtils.ContractViewUrl + "/P2P/WeiXin/contractType" + (isFromTran ? "_ft_" : "") + 1 + ".aspx?key=" + contractNo;
            }
            else if (type == 9 || type == 10 || type == 11)
            {
                return GlobalUtils.ContractViewUrl + "/P2P/WeiXin/contractType" + (isFromTran ? "_ft_" : "") + 11 + ".aspx?key=" + contractNo;
            }
            else
            {
                return GlobalUtils.ContractViewUrl + "/P2P/WeiXin/contractType" + (isFromTran ? "_ft_" : "") + type + ".aspx?key=" + contractNo;
            }
        }
    }
    public class ResponseGeWeFTBWxInvestInfo
    {
        public int pageNum { get; set; }

        public int pageSize { get; set; }

        public int totalCount { get; set; }

        public int totalPage { get; set; }

        public List<WeFTBWxInvestInfo> dataList { get; set; }

    }
    /// <summary>
    /// 复投宝投资记录
    /// </summary>
    public class WeFTBWxInvestInfo
    {
        public int TotalCount { get; set; }
        public Guid SubscribeId { get; set; }
        public string ContractNo { get; set; }

        public int? TypeId { get; set; }
        public int? Type { get; set; }
        public decimal? Amount { get; set; }
        public bool IsFromTran { get; set; }
        public Guid? TranId { get; set; }
        public string UserName { get; set; }
        public string ProjectTitle { get; set; }
        public string Title { get; set; }

        public string ContractUrl { get; set; }

        public DateTime AddDate { get; set; }

        public bool IsHaveTranList { get; set; }
        public Guid BorrowerId { get; set; }
    }
    public class FTBChengJieInfo
    {
        public Guid SubscribeId { get; set; }
        public DateTime InvestDate { get; set; }

        public string InvestDateStr { get; set; }
        public string TelNo { get; set; }
        public decimal InvestAmount { get; set; }
        public string ContractUrl { get; set; }
        public string ContractNo { get; set; }
        public int Type { get; set; }
    }

    public class ResponseFtbTransfer
    {
        public string status { get; set; }

        public string msg { get; set; }

        public List<ProjectFQBExTransferInfo> list { get; set; } 
    }
}