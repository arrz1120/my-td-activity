﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;
using Tool;
using Dapper;

namespace TuanDai.WXApiWeb
{
    /// <summary>
    /// 我的投资记录
    /// Allen 2015-05-14
    /// </summary>
    public partial class invest_list : AppActivityBasePage
    {
        protected List<WXProjectListInfo> projectList=new List<WXProjectListInfo>();
        protected int RecordCount = 0;
        protected int pageCount = 0; 
        protected decimal GylPlusRate = 0;
        protected decimal Day15PlusRate = 0;
        protected string pageType = "";
        //protected string theBackUrl = TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser ? "/WeiXinIndex.aspx" : "/Index.aspx";

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("//m.tuandai.com/pages/downOpenApp.aspx", true);
            return;
            //if (GoBackUrl.ToText() != "")
            //    theBackUrl = GoBackUrl; 
            string appActivityToken = Tool.WEBRequest.GetString("t"); 
            if (appActivityToken.IsNotEmpty())
            {
                pageType = "18";
            }
            else {
                pageType = WEBRequest.GetQueryString("type");
            }

            if (!IsPostBack)
            {
                this.IsShowRightBar = GlobalUtils.IsWeiXinBrowser ? false : true;
                ProjectBLL bll = new ProjectBLL();
                //if (bll.WXGetCanInvestProjectCount() == 0)
                //{
                //    Response.Redirect("/pages/invest/invest_list_empty.aspx");
                //    return;
                //}
                //从App跳转过来这里不用加载数据
                if (pageType.IsEmpty())
                    GetProjectList(bll);
            }
        }

        //获取投资项目列表
        protected void GetProjectList(ProjectBLL bll)
        {
            ProjectListRequest projectRequest = new ProjectListRequest();
            projectRequest.RequestSource = 2;
            projectRequest.ProjectType = 0;
            projectRequest.PageSize = GlobalUtils.PageSize;
            projectRequest.PageIndex = 1;
            projectRequest.OrderByDeadline = 0;
            projectRequest.OrderByYearRate = 0;

            projectList = bll.WXGetProjectShowList(projectRequest, out RecordCount);
            
            double divide = RecordCount / GlobalUtils.PageSize;
            double floor = System.Math.Floor(divide);
            if (RecordCount % GlobalUtils.PageSize != 0)
                floor++;
            pageCount = Convert.ToInt32(floor);//总页数
            //新手加息判断
            WebSettingInfo GylSetInfo = new  WebSettingBLL().GetWebSettingInfo("5AC96A83-B678-4191-BADB-C39C02DFEBB5");
            if (GylSetInfo != null)
            {
                GylPlusRate = Tool.StrObj.StrToDecimalDef(GylSetInfo.Param3Value, 0);
                Day15PlusRate = Tool.StrObj.StrToDecimalDef(GylSetInfo.Param4Value, 0);
            }
        }

        public static string GetTypeName(int typeId,int subTypeId)
        {
            switch (typeId)
            {
                case 1:
                    return "商友贷";
                case 3:
                    return "零售贷";
                case 6:
                    return "资产标";
                case 7:
                    return "资产标";
                case 9:
                case 39:
                case 40:
                case 41:
                case 43:
                    return "车贷";
                case 10:
                    return "消贷";
                case 11:
                case 34:
                case 200:
                    return "房贷";
                case 15:
                    if (subTypeId == 1)
                        return "分期宝";
                    else
                        return "分期乐";
                case 17:
                    return "股票配资";
                case 18:
                    return "私募宝";
                case 19:
                case 20:
                    return "供应链";
                case 22:
                    return "项目宝B";
                case 23:
                    return "项目宝A";
                case 24: 
                case 25:
                case 26:
                case 27: 
                case 28:
                case 29:
                case 30:
                case 31:
                case 33:
                case 42:
                case 44:
                case 45:
                case 46:
                case 47:
                    return "分期宝";
                case 32:
                    return "共借标";
                case 35:
                    return "小派钱包";
                case 36:
                    return "农饲贷";
                case 37:
                case 38:
                    return "智享计划";
                case 48:
                    return "扶贫贷";
                case 99:
                    return "债权转让";
            }
            return "分期宝";
        }
        //过滤掉标题中特殊字符
        public static string FilterProjectName(int pTypeId, string title)
        {
            if (title.IndexOf("【") != -1)
            {
                if (pTypeId == 17)
                {
                    //股票配资【GPPZ-201505311454441363】
                    title = title.Replace("股票配资【", "").Replace("】", "");
                }
                //else
                //{
                //    List<string> macroList = Tool.StrObj.GetMacroList(title, "【", "】");
                //    foreach (string macro in macroList)
                //    {
                //        title = title.Replace(macro, "");
                //    }
                //}
            }
            return StrObj.CutString(title, 20);
        }
        //获取投标详情点击时URL
        public static string GetClickUrl(int TypeId, int SubTypeId, Guid projectId)
        {
            //1:商友贷 3:零售贷 6:净值标 7:股权抵押标 9:车贷 11:房贷 15:分期宝 17:股票配资
            switch (TypeId)
            {
                case 1:
                case 3:
                    return "/pages/invest/invest_detail.aspx?projectid=" + projectId.ToText();
                case 6://净股标
                case 7:
                    return "/pages/invest/jing_detail.aspx?projectid=" + projectId.ToText();
                case 10: //消费贷 
                case 9:
                case 11:
                    return "/pages/invest/mini_detail.aspx?projectid=" + projectId.ToText();
                case 15:
                    if (SubTypeId == 1)
                        return "/pages/invest/fqbao_detail.aspx?projectid=" + projectId.ToText();
                    else
                        return "/pages/invest/fqle_detail.aspx?projectid=" + projectId.ToText();
                case 17:
                    return "/pages/invest/bond_detail.aspx?projectid=" + projectId.ToText();
                case 18:
                    return "/pages/invest/simubao_detail.aspx?projectid=" + projectId.ToText();
                case 19: //电商供应链标
                    return "/pages/invest/gylds_detail.aspx?projectid=" + projectId.ToText();
                case 20: //供应链标
                    return "/pages/invest/gyl_detail.aspx?projectid=" + projectId.ToText();
                case 22: //项目宝
                case 23:
                    return "/pages/invest/xmb_detail.aspx?projectid=" + projectId.ToText();
                case 24://普惠分期宝
                case 25:
                    return "/pages/invest/puhui_detail.aspx?projectid=" + projectId.ToText();
                case 27://话费分期
                    return "/pages/invest/huafei_detail.aspx?projectid=" + projectId.ToText();
                case 28:
                    return "/pages/invest/kuailaidai_detail.aspx?projectid=" + projectId.ToText();
                case 29:
                    return "/pages/invest/mjn_detail.aspx?projectid=" + projectId.ToText();
                case 99: //债权转让标
                    return "/pages/invest/zqzr_detail.aspx?projectid=" + projectId.ToText();
            }
            return "#";
        }

        public static string GetDeadlineStr(WXProjectListInfo project)
        {
            string strTemplate = "<b class='{2} c-212121'>{0}</b> {1}";
            if (project.TypeId == 17 || (project.TypeId == 6 && project.DeadType == 2) || project.TypeId==99)
            {
                return string.Format(strTemplate, project.Deadline, "天", "f20px");
            }
            else
            {
                if (project.TypeId == 23)
                {
                    return string.Format(strTemplate, project.MinDeadLine + "-" + project.MaxDeadLine, "个月", "f18px");
                }
                else
                {
                    return string.Format(strTemplate, project.Deadline, project.DeadType.Value == 1 ? "个月" : "天", "f20px");
                }
            }
        }
        //获取利率
        public static string GetProjectYearRate(WXProjectListInfo temp)
        {
            string strFormat = "{0}<span>{1}%</span>"; 
            if (temp.TypeId == 18|| temp.TypeId==23)
            {
                if (temp.ProfitTypeId == 1)
                    return string.Format(strFormat,  ToolStatus.DeleteZero(temp.PreProfitRate_S) + "~" + ToolStatus.DeleteZero(temp.PreProfitRate_E) , "", "f21px");
                else
                    return string.Format(strFormat,  ToolStatus.DeleteZero(temp.PreProfitRate_S) , "", "f27px");
            }
            else
            {
                return string.Format(strFormat, CommUtils.GetFloatDivideStr(temp.YearRate ?? 0, 1), CommUtils.GetFloatDivideStr(temp.YearRate ?? 0, 2), "f27px");
            }
        }


        #region 新方法 
        public static string GetProjectSurplusMoney(WXProjectListInfo project)
        {
            decimal num = ((project.TotalShares ?? 0) - (project.CastedShares ?? 0)) * project.LowerUnit;
            return string.Format("<span>{0}</span>{1}", (num >= 10000) ? ToolStatus.ConvertWanMoney(num) : ToolStatus.ConvertLowerMoney(num), (num >= 10000) ? "万" : "元");
        }
         
        public static string GetProjectShowDeadline(WXProjectListInfo project)
        {
            string strTemplate = "{0}{1}";
            if (project.TypeId == 17 || (project.TypeId == 6 && project.DeadType == 2) || project.TypeId == 99)
            {
                return string.Format(strTemplate, project.Deadline, "天");
            }
            else
            {
                if (project.TypeId == 23)
                {
                    return string.Format(strTemplate, project.MinDeadLine + "-" + project.MaxDeadLine, "个月");
                }
                else
                {
                    return string.Format(strTemplate, project.Deadline, project.DeadType.Value==1?"个月":"天");
                }
            }
        }
        #endregion

    } 
}