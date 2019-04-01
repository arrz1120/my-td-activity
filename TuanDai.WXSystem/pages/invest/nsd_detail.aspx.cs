﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using Tool;
using TuanDai.DB;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.invest
{
    public partial class nsd_detail : BasePage
    {
        protected Guid? projectId = Guid.Empty;
        protected ProjectDetailInfo model = null;
        private ProjectBLL bll = null;
        protected UserBasicInfoInfo borrowerUserInfo = null;
        protected string finishProcess = "0%";

        protected int SubscribeUserCount = 0;//投资人数 
        protected decimal PreInterestRate = 0; //投资1W的预期收益
        protected int EbaoMultiple = 0;//余额宝的倍数,余额宝按2.5%计算
        protected decimal EbaoInterest = 0;//余额宝收益
        protected List<PreSubscribeDetailInfo> preSubscribeList;//预回款信息
        //项目展示图
        protected List<ProjectImageInfo> imageList;

        protected int oneMonthSuccess = 0;//成功出让最近一个月
        protected int sixMonthSuccess = 0;
        protected int twelveMonthSuccess = 0;
        protected int oneMonthCys = 0;//成功回购最近一个月
        protected int sixMonthCys = 0;
        protected int twelveMonthCys = 0;
        protected int oneMonthOver = 0;//逾期违约最近一个月
        protected int sixMonthOver = 0;
        protected int twelveMonthOver = 0;
        protected string oneMonthBadrate = "0";//逾期还款率最近一个月
        protected string sixMonthBadrate = "0";
        protected string twelveMonthBadrate = "0";
        protected WebSettingInfo regulaSet = new WebSettingInfo();
        protected int InterestModel = 1;//起息方式


        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow", true);
            this.projectId = WEBRequest.GetGuid("projectid");
            if (!IsPostBack)
            {
                bll = new ProjectBLL();
                if (this.projectId != Guid.Empty)
                {

                    if (!this.GetData())
                        return;
                    //信用档案
                    
                    imageList = CommUtils.GetProjectImages(this.projectId.Value);
                }
                else
                {
                    Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                }
            }
        }
        

        protected bool GetData()
        {
            //获取项目信息
            model = bll.GetProjectDetailInfo(projectId.Value);
            if (model == null)
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }
            if (model.Type.Value != 36)
            {
                Response.Redirect(GlobalUtils.WebURL + "/Member/my_account.aspx");
                return false;
            }
            HistoryItems();
            
            GetBorrowUserInfo();

            finishProcess = CommUtils.GetProjectProcess(model);

            SubscribeUserCount = CommUtils.GetSubscribeUserCount(this.projectId.Value);
            //计算预期收益
            PreInterestRate = CommUtils.CalcInvestInterest(model, 10000);
            EbaoMultiple = int.Parse(Math.Ceiling(model.InterestRate.Value / decimal.Parse("2.5")).ToString());
            EbaoInterest = CommUtils.GetEbaoMultipleInterest(model, 10000);
            preSubscribeList = CommUtils.GetPreSubscribeDetail(model, 10000);

            regulaSet = new WebSettingBLL().GetWebSettingInfo("293A1C07-1D90-4D22-ADD4-39E6735DAC06");
            InterestModel = TuanDai.PortalSystem.Redis.ProjectRedis.GetProjectInterestMode(model.Type.Value, model.RepaymentType.Value);
            //截标时间为NULL时候取审核时间  +5 天
            if (model.TenderDate == null)
            {
                model.TenderDate = Convert.ToDateTime(model.AuditDate == null ? model.AddDate : model.AuditDate).AddDays(5);
            }
            else
            {
                model.TenderDate = model.TenderDate;
            }

            if (model.AuditDate == null)
            {
                model.TenderStartDate = model.AddDate;
            }
            else
            {
                model.TenderStartDate = model.AuditDate;
            }  
			
            return true;
        }

        //获取借款人信息
        protected void GetBorrowUserInfo()
        {
            string sqlbow = "select RealName,TelNo,Address as BankCity from dbo.project_NSD with(nolock) where ProjectId=@ProjectId";
            Dapper.DynamicParameters parm = new Dapper.DynamicParameters();
            parm.Add("@ProjectId", model.Id);
            
            this.borrowerUserInfo = TuanDaiDB.QueryFirstOrDefault<UserBasicInfoInfo>(TdConfig.ApplicationName, TdConfig.DBRead, sqlbow, ref parm);
            
        }


        /// <summary>
        /// 计算逾期还款率
        /// </summary>
        /// <param name="successcount">成功记录数</param>
        /// <param name="badcount">逾期记录数</param>
        /// <returns></returns>
        public string calcrate(int successcount, int badcount)
        {
            if (successcount != 0)
            {
                return ((double)(badcount) / (double)(successcount) * 100).ToString("0.00");
            }
            else
            {
                return "0";
            }
        }
        #region 出让历史记录 HistoryItems

        /// <summary>
        /// 出让历史记录
        /// </summary>
        private void HistoryItems()
        {
            var p = new Dapper.DynamicParameters();
            p.Add("@projectid", projectId.Value);
            ProjectStatistics Statisticsmodel = TuanDaiDB.Query<ProjectStatistics>(TdConfig.ApplicationName, TdConfig.DBRead, "exec p_v_ProjectStatistics @projectid", ref p).First();
            oneMonthSuccess = Statisticsmodel.oneMonthSuccess;
            sixMonthSuccess = Statisticsmodel.sixMonthSuccess;
            twelveMonthSuccess = Statisticsmodel.twelveMonthSuccess;
            oneMonthCys = Statisticsmodel.oneMonthCys;
            sixMonthCys = Statisticsmodel.sixMonthCys;
            twelveMonthCys = Statisticsmodel.twelveMonthCys;
            oneMonthOver = Statisticsmodel.oneMonthOver;
            sixMonthOver = Statisticsmodel.sixMonthOver;
            twelveMonthOver = Statisticsmodel.twelveMonthOver;
            oneMonthBadrate = calcrate(oneMonthSuccess, oneMonthOver);
            sixMonthBadrate = calcrate(sixMonthSuccess, sixMonthOver);
            twelveMonthBadrate = calcrate(twelveMonthSuccess, twelveMonthOver);
        }

        #endregion

        
    }
    public class ProjectStatistics
    {
        public int oneMonthSuccess { get; set; }
        public int sixMonthSuccess { get; set; }
        public int twelveMonthSuccess { get; set; }
        public int oneMonthCys { get; set; }
        public int sixMonthCys { get; set; }
        public int twelveMonthCys { get; set; }
        public int oneMonthOver { get; set; }
        public int sixMonthOver { get; set; }
        public int twelveMonthOver { get; set; }
    }
}