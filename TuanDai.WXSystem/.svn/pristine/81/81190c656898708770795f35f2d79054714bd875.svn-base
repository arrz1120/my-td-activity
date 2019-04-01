using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using System.Data;
using System.Data.SqlClient;    
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.pages.App
{
	public partial class Xmb_introduct : System.Web.UI.Page
    {
       
        public string AmountUsedDesc = string.Empty;      //资金用途
        public string ProjectDescription = string.Empty;  //项目简介
        public string InvestRange = string.Empty;          //投资范围
        public string InvestHighlight = string.Empty;     //投资亮点
        public string ProjectProspect = string.Empty;     //项目前景
        public string RepaymentSecurity = string.Empty;   //还款保障
        public string ProfitBudget = string.Empty;   //盈利预测
        public string ProductId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.ProductId = Request.QueryString["Id"];
            if (!IsPostBack)
            {
               BindProjectXMB();
            }
        }

        private void BindProjectXMB()
        {
           string sqlText =
               @"SELECT ProjectId,AmountUsedDesc,ProjectDescription,InvestRange,InvestHighlight,ProjectProspect,ProfitBudget,RepaymentSecurity
                 from Project_XMB where  ProjectId=@ProjectId";
            var para = new Dapper.DynamicParameters();
            para.Add("@ProjectId", ProductId);//"5A234E16-B321-D324-AAAA-11111FF82344"
           Project_XMB xmbinfo =  PublicConn.QuerySingle<Project_XMB>(sqlText, ref para);
            if (xmbinfo != null)
            {
                AmountUsedDesc = xmbinfo.AmountUsedDesc;
                ProjectDescription = xmbinfo.ProjectDescription;
                InvestRange = xmbinfo.InvestRange;
                ProjectProspect = xmbinfo.ProjectProspect;
                RepaymentSecurity = xmbinfo.RepaymentSecurity;
                ProfitBudget = xmbinfo.ProfitBudget;
                InvestHighlight = xmbinfo.InvestHighlight;
            }  
        }
	}

    public class Project_XMB 
    {
        public Guid ProjectId { get; set; }
        public string AmountUsedDesc { get; set; }
        public string ProjectDescription { get; set; }

        public string InvestRange { get; set; }
        public string ProjectProspect { get; set; }
        public string RepaymentSecurity { get; set; }
        public string InvestHighlight { get; set; }
        public string ProfitBudget { get; set; }
    }

   
}