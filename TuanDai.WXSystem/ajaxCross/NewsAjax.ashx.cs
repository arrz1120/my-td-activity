﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using BusinessDll;
using NetDimension.Json;
using TuanDai.Enums;
using TuanDai.InfoSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXApiWeb.pages.news;
using TuanDai.PortalSystem.Model;
using TuanDai.WXApiWeb.Member.withdrawal;
using Kamsoft.Data.Dapper;
using Tool;
using TuanDai.DB;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    /// NewsAjax 的摘要说明
    /// </summary>
    public class NewsAjax : SafeHandlerBase
    {
        #region 团贷热点
        /// <summary>
        /// 获取团贷热点列表
        /// </summary>
        public void GetNewsShowList()
        {
            int pagesize = GlobalUtils.PageSize;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1); 
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            NewsBLL bll = new NewsBLL();
            IList<WXNewsVideoInfo> list = bll.GetNewsVideoList(pagesize, pageindex, out totalcount);

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (WXNewsVideoInfo temp in list)
                {
                    if (index == list.Count())
                    {
                        sb.Append("{\"NewsId\":\"" + temp.Id + "\",\"Title\":\"" + Tool.StrObj.CutString(temp.Title, 20) + "\",\"HeadImg\":\"" + newslist.GetShownNewsImg(temp.HeadImg) +
                                  "\",\"AddDate\":\"" + (temp.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd") +
                                  "\",\"InfoType\":\"" + temp.InfoType + "\"}]}");
                    }
                    else
                    {
                        sb.Append("{\"NewsId\":\"" + temp.Id + "\",\"Title\":\"" + Tool.StrObj.CutString(temp.Title, 20) + "\",\"HeadImg\":\"" + newslist.GetShownNewsImg(temp.HeadImg) +
                                   "\",\"AddDate\":\"" + (temp.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd") +
                                   "\",\"InfoType\":\"" + temp.InfoType + "\"},");
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
        #endregion


        #region 提现，充值记录
        //获取提现记录分页数据
        public void GetWithDrawalShowList()
        {
            int pagesize = 15;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            int status = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["status"], -1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            IList<WXAppWithdrewFund> list = bll.WXGetUserWithdrewFund(WebUserAuth.UserId.Value, pagesize, pageindex,status, out totalcount);

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (WXAppWithdrewFund temp in list)
                {
                    sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount ?? 0) + "\",\"AppDate\":\"" + (temp.AppDate.Value.ToString("yyyy-MM-dd HH:mm")) +
                                 "\",\"StatusStr\":\"" + this.GetWithdrawStatusIcon(temp.Status ?? 0));
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
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        //获取充值记录分页数据
        public void GetRechageShowList() {
            int pagesize = 15;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == null || userId == Guid.Empty) {
                PrintJson("0","还未登录"); 
                return;
            }

            int status = Tool.WEBRequest.GetFormInt("status",0);
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            ProjectBLL bll = new ProjectBLL();
            IList<WXAccountRechare> list = bll.WXGetUserAccountRechare(status, userId, pagesize, pageindex, out totalcount);
            double divide = totalcount / pagesize;
            double floor = System.Math.Floor(divide);
            if (totalcount % pagesize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor);//总页数  
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"pagecount\":\"" + pageCount + "\",\"list\":[");
                foreach (WXAccountRechare temp in list)
                {
                    sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount) + "\",\"AddDate\":\"" + (temp.AddDate.ToString("yyyy-MM-dd HH:mm")) +
                               "\",\"StatusStr\":\"" + TuanDai.WXApiWeb.Member.Bank.Rechagehistory.GetStatusIcon(temp.Status) + 
                               "\",\"DeviceType\":\"" + TuanDai.WXApiWeb.Member.Bank.Rechagehistory.GetDeviceType(temp.From??1) );

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
                sb.Append("{\"result\":\"0\",\"pagecount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        protected  string GetWithdrawStatusIcon(object o)
        {
            int status = int.Parse(o.ToString());
            string str = "";
            switch (status)
            {
                case 0:
                    str = "<i class='ico-inline ico-state03'></i>提现处理中";
                    break;
                case 1:
                    str = "<i class='ico-inline ico-state02'></i>提现失败";
                    break;
                case 2:
                    str = "<i class='ico-inline ico-state01'></i>提现成功";
                    break;
                case 12:
                    str = "<i class='ico-inline ico-state03'></i>未验密";
                    break;
                case 3:
                    str = "<i class='ico-inline ico-state03'></i>正在审核";
                    break;
                case 4:
                case 8:
                case 9:
                case 10:
                case 13:
                    str = "<i class='ico-inline ico-state02'></i>审核失败";
                    break;
                case 6:
                    str = "<i class='ico-inline ico-state02'></i>取消提现";
                    break;
                case 7:
                    str = "<i class='ico-inline ico-state04'></i>审核成功";
                    break;
                case 11:
                    str = "<i class='ico-inline ico-state02'></i>暂不审核";
                    break;
                default:
                    str = "<i class='ico-inline ico-state02'></i>提现失败";
                    break;
            }
            return str;
        }
        #endregion


        #region 团贷公告
        public void GetNoticeShowList() {
            int pagesize = GlobalUtils.PageSize;
            int pageindex = Tool.SafeConvert.ToInt32(Context.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }

            StringBuilder sb = new StringBuilder();
            int totalcount = 0;
            NewsBLL bll = new NewsBLL();
            List<NewsInfo> list = bll.GetNewsList(69, pagesize, pageindex, out totalcount);

            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                foreach (NewsInfo temp in list)
                {
                    if (index == list.Count())
                    {
                        sb.Append("{\"NewsId\":\"" + temp.Id + "\",\"Title\":\"" + Tool.StrObj.CutString(temp.Title, 20) +
                                  "\",\"AddDate\":\"" + (temp.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd") + "\"}]}");
                    }
                    else
                    {
                        sb.Append("{\"NewsId\":\"" + temp.Id + "\",\"Title\":\"" + Tool.StrObj.CutString(temp.Title, 20) + 
                                   "\",\"AddDate\":\"" + (temp.AddDate ?? DateTime.Today).ToString("yyyy-MM-dd") + "\"},");
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
        #endregion
        public int GetOrderCount(Guid productid)
        {
            int result = 0;
            var args = new Dapper.DynamicParameters();
            args.Add("@productId", productid);
            string sqlText = "select Count(0) from We_Order with(nolock) where statusid in (0,1,2,4) and ProductId=@productId";
            result = TuanDaiDB.ExecuteScalar<int>(TdConfig.ApplicationName, TdConfig.DBRead, sqlText, ref args);
            return result;
        }
        /// <summary>
        /// 获取订单记录 GetOrderList
        /// </summary>
        /// <param name="productid">产品Id</param>
        /// <param name="pageIndex">当前页数</param>
        /// <param name="pageSize">页大小</param>
        /// <returns>返回订单列表</returns>
        public List<WeOrderInfo> GetOrderList(Guid productid, int pageIndex, int pageSize)
        {
            var args = new Dapper.DynamicParameters();
            args.Add("@productId", productid);
            args.Add("@pageIndex", pageIndex);
            args.Add("@pageSize", pageSize);
            string sqlText = @"select UserName,NickName,TelNo,Amount,OrderDate,RepeatInvestType,DeviceType from (
                        select u.UserName,u.NickName,u.TelNo,o.Amount,o.OrderDate,ROW_NUMBER() over(order by o.OrderDate desc) as rownum,
                        isnull(RepeatInvestType,0) as RepeatInvestType,o.DeviceType,o.statusid
                        from We_Order o with(nolock) 
                        left join UserBasicInfo u with(nolock) on o.UserId=u.Id  where  o.productId=@productId) t 
                        where t.statusid in (0,1,2,4) and t.rownum>(@pageIndex-1)*@pageSize  and t.rownum<=@pageIndex*@pageSize";
            List<WeOrderInfo> list = TuanDaiDB.Query<WeOrderInfo>(TdConfig.ApplicationName, TdConfig.DBRead, sqlText, ref args);
            return list;
        }
        #region 申购记录
        //获取提现记录分页数据
        public void GetSubscribeUserList()
        {
            int pagesize = 15;
            int pageindex = Tool.SafeConvert.ToInt32(HttpContext.Current.Request.Form["pageIndex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid projectId = Tool.SafeHttpWebRequest.GetFormGuid("projectid", Guid.Empty);
            string projecttype = Tool.WEBRequest.GetString("projecttype");
            StringBuilder sb = new StringBuilder();
            int totalcount = 0;

            WeOrderBLL webll = new WeOrderBLL();
            List<TuanDai.WXApiWeb.Common.WXSubscribeRecord_Bak> subList = null;
            //当为We计划时
            if (projecttype.ToLower() == "weplan")
            {
                totalcount = GetOrderCount(projectId);
            }
            else if (projecttype.ToLower() == "zqzr")
            {
                //债权转让 
                totalcount = GetZQZRSubscribeListCount(projectId);
            }
            else
            {
                subList = TuanDai.WXApiWeb.Common.WXInvest.WXGetSubscribeList(projectId, pagesize, pageindex, out totalcount);
            }


            if (totalcount > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + totalcount + "\",\"list\":[");
                if (projecttype.ToLower() == "weplan")
                {
                    #region We计划处理
                    List<WeOrderInfo> welist = GetOrderList(projectId, pageindex, pagesize);
                    foreach (WeOrderInfo temp in welist)
                    {
                        string tenderMode = TuanDai.WXApiWeb.pages.invest.SubscribeUser.GetWeTenderName(temp.DeviceType); 
                        if (index == welist.Count())
                        {
                            sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount ?? 0) + "\",\"AddDate\":\"" + (temp.OrderDate.Value.ToString("yyyy-MM-dd HH:mm:ss")) +
                                      "\",\"NickName\":\"" + (temp.TelNo == null ? TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringName(temp.UserName) : TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringTelNo(temp.TelNo)) +
                                      "\",\"OrderType\":\"" + tenderMode + "\",\"IsAuto\":\"False\"}]}");
                        }
                        else
                        {

                            sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount ?? 0) + "\",\"AddDate\":\"" + (temp.OrderDate.Value.ToString("yyyy-MM-dd HH:mm:ss")) +
                                      "\",\"NickName\":\"" + (temp.TelNo == null ? TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringName(temp.UserName) : TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringTelNo(temp.TelNo)) +
                                      "\",\"OrderType\":\"" + tenderMode + "\",\"IsAuto\":\"False\"},");
                        }
                        index++;
                    }
                    #endregion
                }
                else if (projecttype.ToLower() == "zqzr")
                {
                    #region
                    List<SubscribeUserInfo> zqSubList = GetZQZRSubscribelist(projectId, pagesize, pageindex);
                    foreach (SubscribeUserInfo temp in zqSubList)
                    {
                        sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount) + "\",\"AddDate\":\"" + (temp.OrderDate.Value.ToString("yyyy-MM-dd HH:mm:ss")) +
                                    "\",\"NickName\":\"" + (temp.NickName == null ? TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringName(temp.UserName) : TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringTelNo(temp.NickName)) +
                                    "\",\"OrderType\":\"" + temp.OrderType + "\",\"IsAuto\":\""+temp.IsAuto);
                        if (index == zqSubList.Count())
                        {
                            sb.Append("\"}]}");
                        }
                        else
                        {

                            sb.Append("\"},");
                        }
                        index++;
                    }
                    #endregion
                }
                else
                {
                    #region
                    //一般的标
                    foreach (TuanDai.WXApiWeb.Common.WXSubscribeRecord_Bak temp in subList)
                    {
                        string orderType = TuanDai.WXApiWeb.pages.invest.SubscribeUser.GetProjectTenderName(temp.TenderMode);
                        sb.Append("{\"Amount\":\"" + ToolStatus.ConvertLowerMoney(temp.Amount ?? 0) + "\",\"AddDate\":\"" + (temp.AddDate.Value.ToString("yyyy-MM-dd HH:mm:ss")) +
                                      "\",\"NickName\":\"" + (temp.NickName == null ? TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringName(temp.UserName) : TuanDai.WXApiWeb.pages.invest.SubscribeUser.SubStringTelNo(temp.NickName)) +
                                      "\",\"OrderType\":\"" + orderType + "\",\"IsAuto\":\"" + temp.IsAuto);
                        if (index == subList.Count())
                        {
                            sb.Append("\"}]}");
                        }
                        else
                        {

                            sb.Append("\"},");
                        }
                        index++;
                    }
                    #endregion
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\",\"totalcount\":\"" + totalcount + "\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }

        //债权转让申购记录
        protected List<SubscribeUserInfo> GetZQZRSubscribelist(Guid projectId,int pageSize,int pageIndex)
        {
            List<SubscribeUserInfo> dataList = new List<SubscribeUserInfo>();

            var commandText = @"select UserName,NickName,Amount,TenderMode as OrderType,SubscribeShares,TotalShares,LowerUnit,InterestRate,AddDate as OrderDate
								from
								(
								select ROW_NUMBER() over(order by S.AddDate desc) as num_,C.UserName,C.TelNo as NickName,isnull(S.ReceiveAmount,0)+isnull(s.ReceiveInterest,0) as Amount,S.TenderMode,S.TranDate as AddDate
								,S.SubscribeShares,S.TotalShares,(isnull(D.m_TotalAmount,0)+dbo.f_TransferPriceCal(S.Id,isnull(D.m_TotalShares,0)))/isnull(D.m_TotalShares,0) as LowerUnit,
								isnull(dbo.f_TransferProjectRate(D.m_Id),0) as  InterestRate,isnull(s.IsAuto,0) as IsAuto
								from 
								dbo.Subscribe S with(nolock)
								inner join UserBasicInfo C 
								on S.SubscribeUserId=C.Id
								inner join t_SubScribeTransfer as D 
								on D.m_id=S.TranId
								where s.tranid=@ProjectId
								) T where T.num_>@PageSize*(@PageIndex-1) and T.num_<=@PageSize*@PageIndex";
            //using (System.Data.SqlClient.SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateReadConnection())
            //{
            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@ProjectId", projectId);
            dyParams.Add("@PageIndex", pageIndex);
            dyParams.Add("@PageSize", pageSize);
            //dataList = connection.Query<SubscribeUserInfo>(commandText, dyParams).ToList();
            dataList = TuanDai.DB.TuanDaiDB.Query<SubscribeUserInfo>(TdConfig.DBRead, commandText, ref dyParams);
            if(dataList != null && dataList.Count >0)
                dataList.ForEach(o => o.OrderType = TuanDai.WXApiWeb.pages.invest.SubscribeUser.GetProjectTenderName(o.OrderType.ToInt(1)));

            //    connection.Close();
            //    connection.Dispose(); 
            //}
            return dataList;
        }
        protected int GetZQZRSubscribeListCount(Guid projectId)
        {
            //using (System.Data.SqlClient.SqlConnection connection = TuanDai.PortalSystem.DAL.PubConstant.CrateReadConnection())
            //{
            var commandTotalText = @"select COUNT(0)
								from dbo.Subscribe S with(nolock)
								--inner join dbo.Project P with(nolock) on S.ProjectId=P.Id
								inner join UserBasicInfo C with(nolock) on S.SubscribeUserId=C.Id 
								inner join t_SubScribeTransfer as D  with(nolock)
								on D.m_id=S.TranId
								where s.tranid=@ProjectId";

            var dyParams = new Dapper.DynamicParameters();
            dyParams.Add("@ProjectId", projectId);
            int recordCount = TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.DBRead, commandTotalText,
                ref dyParams);
            //    int recordCount = connection.Query<int>(commandTotalText, dyParams).FirstOrDefault();
            //    connection.Close();
            //    connection.Dispose(); 
            //    return recordCount;
            //}
            return recordCount;
        }
        #endregion

        #region 消息设置
        public void GetMessageSetInfo()
        {
            Guid userId = WebUserAuth.UserId.Value;
            if (userId == Guid.Empty)
            {
                PrintJson("-99","登录已失效");
            }
            string msg = string.Empty;
            var list = TuanDai.SMS.Client.MessageSetClient.GetMsgSetInfoListByUserId(WebUserAuth.UserId.Value, ref msg);
            TuanDai.SMS.Client.MsgSetInfo item = null;
            if(list != null && list.Count >0 )
                 item = list.FirstOrDefault();
            
            if(item == null)
                PrintJson("0","无设置数据");
            PrintJson("1",JsonConvert.SerializeObject(item));
        }
        //保存设置信息
        public void SaveMessageSetInfo()
        {
            string msg = string.Empty;
            var list = TuanDai.SMS.Client.MessageSetClient.GetMsgSetInfoListByUserId(WebUserAuth.UserId.Value, ref msg);
            TuanDai.SMS.Client.MsgSetInfo item = null;
            if(list != null && list.Count >0 )
                 item = list.FirstOrDefault();

            string notices = Tool.WEBRequest.GetString("notices");
            
            string preMessage = item!= null ? item.CategoryNotices :"";
            if (!string.IsNullOrEmpty(preMessage)&&preMessage.Contains("chk4_6"))
            {
                notices += ",chk4_6";
            }
            var isUpdate = TuanDai.SMS.Client.MessageSetClient.UpdateMsgSetInfoCategoryNotices(WebUserAuth.UserId.Value, notices,
                PlatformSource.WeiXin, ref msg);
            if (isUpdate)
            {
                WebLog log = new WebLog();
                log.AddDate = DateTime.Now;
                log.BusinessId = WebUserAuth.UserId.ToString();
                log.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
                log.UserId = WebUserAuth.UserId.ToString();
                log.UserTypeId = (int)ConstString.LogUserType.WebUser;
                log.HandlerTypeId = (int)ConstString.LogType.InformSetting;
                log.Content1 = "信息设置，修改之前：" + preMessage + ";修改之后：" + notices;
                log.Id = Guid.NewGuid().ToString();
                WebLogInfo.WriteLoginHandler(log);

                PrintJson("1", "设置成功");
            }
                
            else
                PrintJson("0", "设置失败"+msg);
        }
        #endregion

        #region 新版帮助中心
        public void SearchWXHelpTitle() {
            string strKey = WEBRequest.GetFormString("KeyWord");
            TuanDai.News.Contract.BaseRequest request = new TuanDai.News.Contract.BaseRequest();
            request.PageIndex = 1;
            request.PageSize = 30;
            request.StrKey1 = "0";
            request.StrKey2 = strKey;

            int count = 0;
            List<TuanDai.News.Contract.WXHelpDetialInfo> datalist = TuanDai.News.Client.WXHelpService.GetDetailDataByPager(request, ref  count);
            StringBuilder sb = new StringBuilder();
            if (datalist != null && datalist.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"totalcount\":\"" + count + "\",\"list\":[");
                foreach (TuanDai.News.Contract.WXHelpDetialInfo temp in datalist)
                {
                    sb.Append("{\"NewsId\":\"" + temp.Id + "\",\"Title\":\"" + Tool.StrObj.CutString(temp.Title, 20));

                    if (index == datalist.Count())
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
                sb.Append("{\"result\":\"0\",\"totalcount\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        #endregion

        #region 内部Model
        public class SubscribeUserInfo
        {
            /// <summary>
            /// 用户名
            /// </summary>
            public string UserName { get; set; }
            /// <summary>
            /// 用户昵称
            /// </summary>
            public string NickName { get; set; }
            /// <summary>
            /// 订购金额
            /// </summary>
            public decimal Amount { get; set; }
            /// <summary>
            /// 订单时间
            /// </summary>
            public DateTime? OrderDate { get; set; }
            /// <summary>
            /// 申购类型  1、手动 2、自动 3、WE计划
            /// </summary>
            public string OrderType { get; set; }

            public bool IsAuto { get; set; }
        }
        #endregion
    }
}