﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using TuanDai.DB;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;

namespace TuanDai.WXApiWeb.Member.Repayment
{
    /// <summary>
    /// 项目标、微团贷、净股标  借款详情界面
    /// Allen 2015-07-01
    /// </summary>
    public partial class borrowInvestShow : UserPage
    {
        protected WXMyLoanDetailInfo model = null;
        protected Guid? projectId = null;
        protected ProjectBLL bll = null;
        protected decimal actualAmount = 0;//待付本息
        //repayedAmount：已还金额；overdueAmount：待还本息；duerepayAmount：逾期；
        protected decimal repayedAmount = 0, overdueAmount = 0, duerepayAmount = 0;
        protected decimal yhAmount = 0;//已还本息

        protected decimal AviMoney = 0;//帐户余额     
        protected int subscribeCount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.projectId = WEBRequest.GetGuid("id");
            if (!IsPostBack)
            {
                CookieHelper.WriteCookie("mTDBeforeCgtUrl", Request.Url.AbsoluteUri,5);
                bll = new ProjectBLL();
                if (this.projectId != Guid.Empty)
                {
                    if (!this.GetData())
                    {
                        return;
                    }
                }
                else
                {
                    Response.Redirect(GlobalUtils.MTuanDaiURL + "/Member/Repayment/borrowLog.aspx");
                }
            }
        }

        private bool GetData()
        {
            UserBLL userbll = new UserBLL();
            //获取项目信息
            model = bll.WXGetMyLoanDetail(this.projectId.Value, WebUserAuth.UserId.Value);

            if (model == null)
            {
                Response.Redirect(GlobalUtils.MTuanDaiURL + "/Member/Repayment/borrowLog.aspx");
                return false;
            }
            //需提前还款时才做查询数据
            if (model.IsPrepayment)
            {
                WebSettingInfo set = new WebSettingBLL().GetWebSettingInfo("3F902315-6986-44FF-9F00-9D420C07FCDA");
                if (set != null && DateTime.Parse(set.Param4Value) >= model.AddDate)
                {
                    ProjectBLL projectbll = new ProjectBLL();
                    projectbll.WXGetPrepaymentActualAmountAndBalance(WebUserAuth.UserId.Value, this.projectId.Value,
                        ref actualAmount, ref AviMoney);
                }
                else
                {
                    var whereParams = new DynamicParameters();
                    whereParams.Add("@projectId", projectId);
                    whereParams.Add("@DueOutMoney", 0, DbType.Double, ParameterDirection.Output);

                    TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBRead, "p_ShowDueOutOfProject_ZC", ref whereParams, CommandType.StoredProcedure);
                    actualAmount = (decimal)whereParams.Get<double>("@DueOutMoney");
                }
                
                AviMoney = userbll.GetUserAviMoney(WebUserAuth.UserId.Value);
            }
            GetRepayedMsg(model.ProjectId);
            return true;
        }

        /// <summary>
        /// 标详情页，获取回款汇总信息
        /// </summary>
        public void GetRepayedMsg(Guid projId)
        {           
            List<SubscribeTotalInfo> repaylist = new SubscribeBLL().GetRepaymentInfo(projId);
            if (repaylist == null)
                repaylist = new List<SubscribeTotalInfo>();
            foreach (SubscribeTotalInfo item in repaylist)
            {
                switch (item.status)
                {
                    case 1:
                        repayedAmount = SafeConvert.ToDecimal(item.Amount) + SafeConvert.ToDecimal(item.InterestAmount);
                        break;
                    case 2:
                        overdueAmount = SafeConvert.ToDecimal(item.Amount) + SafeConvert.ToDecimal(item.InterestAmount);
                        break;
                    case 3:
                        duerepayAmount = SafeConvert.ToDecimal(item.Amount) + SafeConvert.ToDecimal(item.InterestAmount);
                        break;
                }
            }


            //PrintJson("1", string.Format("{0}|{1}|{2}", ToolStatus.ConvertDetailWanMoney(repayedAmount),
            //        ToolStatus.ConvertDetailWanMoney(overdueAmount), ToolStatus.ConvertDetailWanMoney(duerepayAmount)));
        }

 
    }
}