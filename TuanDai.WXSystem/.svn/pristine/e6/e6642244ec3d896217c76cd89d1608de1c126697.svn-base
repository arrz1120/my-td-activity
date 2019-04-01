using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Data.SqlClient;
using System.Data;  
using BusinessDll;
using Dapper; 


namespace TuanDai.WXApiWeb.pages.App
{
    public partial class Smb_detailed : System.Web.UI.Page
    {
        private string ProductId { get; set; }
        public SuperProjectDetailInfo Model { get; set; }
        public string AppContent { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.ProductId = Request.QueryString["Id"];
                GetProductInfo();
            }
        }

        public void GetProductInfo()
        {
            if(string.IsNullOrEmpty(ProductId))
            {
                Model= new SuperProjectDetailInfo();
                return;
            }

            var superDetail = new SuperProjectDetailInfo();

            #region 修改时间：2015-11-30 刘诗根
//                string sql = @" declare @HasItems int
//                            declare @HasAlsoItems int
//                            declare @InstallmentsOverdue int
//                            declare @Total int
//                            declare @AlsoPrincipalInterest int
//                            declare @ProjectType int
//                            declare @Amount decimal(18,4)
//                            declare @userId uniqueidentifier
//                           select @userId=UserId,@ProjectType=[Type],@Amount=Amount from Project where id=@ProjectId;
//                           select @HasItems=COUNT(0) from Project(nolock) where UserId=@userId and ([Status] in(2,3,6));
//                           select @HasAlsoItems=COUNT(0) from Project(nolock) where UserId=@userId and [Status]=6;
//                           SELECT @InstallmentsOverdue=COUNT(0) FROM (SELECT  ProjectId,periods FROM dbo.OverDueRecord(nolock) WHERE PublisherUserId=@userId GROUP BY ProjectId,periods)t;
//                           --select @Total=isnull(SUM((CastedShares+BuybackShares)*LowerUnit),0) from Project(nolock) where UserId=@userId and (([Status] in (2,3,6,7) and [Type] not in (15,17))or ([Status] in (3,6) and [Type] in (15,17)));
//                           select @Total=CASE WHEN ISNULL(SUM(TotalShares*LowerUnit),0)>isnull(SUM((CastedShares+BuybackShares)*LowerUnit),0) THEN isnull(SUM((CastedShares+BuybackShares)*LowerUnit),0) ELSE ISNULL(SUM(TotalShares*LowerUnit),0) END from Project(nolock) where UserId=@userId and (([Status] in (2,3,6,7) and [Type] not in (15,17))or ([Status] in (3,6) and [Type] in (15,17)));
//                           WITH oa AS(
//                            SELECT Id FROM dbo.Project(NOLOCK) WHERE UserId=@userId
//                            ),
//                            ob AS(
//                            SELECT RealAmount,RealInterestAmout,ProjectId,Periods FROM dbo.SubscribeDetailHistory(NOLOCK)a
//                            INNER JOIN oa
//                            ON oa.Id = a.ProjectId
//                            ),
//                            oc AS(
//                            SELECT ProjectId,periods FROM dbo.OverDueRecord(NOLOCK) WHERE PublisherUserId=@userId AND IsBorrow=0
//                            UNION ALL
//                            SELECT m_ProjectId AS ProjectId, m_Period AS periods FROM dbo.t_AdvanceDetail(NOLOCK) WHERE m_BorrowUserid=@userId AND m_IsRefund=0
//                            )
//                            SELECT @AlsoPrincipalInterest=CAST((ISNULL(SUM(RealAmount),0)+ISNULL(SUM(RealInterestAmout),0)) AS NUMERIC(18,2)) FROM ob WHERE NOT EXISTS(SELECT 1 FROM oc WHERE ob.ProjectId=oc.ProjectId AND ob.Periods=oc.periods)
//
//                            select @HasItems as HasItems,@HasAlsoItems as HasAlsoItems,@InstallmentsOverdue as InstallmentsOverdue,convert(varchar(100),@Total) as Total,@AlsoPrincipalInterest as AlsoPrincipalInterest,@ProjectType as ProjectType,@Amount as Amount,@userId as userId";

            #endregion
        
            //SqlParameter[] parameter = { new SqlParameter("@ProjectId",this.ProductId),new SqlParameter("@HasItems",0), new SqlParameter("@HasAlsoItems",0),
            //                        new SqlParameter("@InstallmentsOverdue",0),new SqlParameter("@Total",0),new SqlParameter("@AlsoPrincipalInterest",0)};

            //parameter[1].Direction = ParameterDirection.Output;
            //parameter[2].Direction = ParameterDirection.Output;
            //parameter[3].Direction = ParameterDirection.Output;
            //parameter[4].Direction = ParameterDirection.Output;
            //parameter[5].Direction = ParameterDirection.Output;
            //db.ExecuteStoreCommand(sql, parameter);

          
            //paramters.Add("@HasItems");
            //paramters.Add("@HasAlsoItems");
            //paramters.Add("@InstallmentsOverdue");
            //paramters.Add("@Total");
            //paramters.Add("@AlsoPrincipalInterest");
            //paramters.Add("@ProjectType");
            //paramters.Add("@Amount");
            //paramters.Add("@userId");

            DynamicParameters paramters = new DynamicParameters();
            paramters.Add("@ProjectId", ProductId);
            string sql = "select UserId,[Type] as ProjectType,ISNULL(Amount,0) as Amount from Project(nolock) where id=@ProjectId";
            var _superDetail= QueryDataBySql(sql,paramters);

           
            var userId=_superDetail.UserId;

            ////用户信息
            var userBll = new UserBLL();
            UserBasicInfoInfo userBasicEntity = userBll.GetUserBasicInfoModelById(userId.Value); 
              

            decimal a = 0;
            decimal tborrowerAmount = 0;
            var projectType=_superDetail.ProjectType;
            if (projectType == 6)
            { 
                 Users.GetUserJingAmount(userBasicEntity, out tborrowerAmount, out a);
            }
            else if (projectType == 7)
            {
                tborrowerAmount = userBasicEntity.CreditGrantingAmount.Value;
            }
            else
            {
                tborrowerAmount = _superDetail.Amount??0;
            }
            superDetail.LineCredit = tborrowerAmount.ToString("0.00"); 

            Model= superDetail;

            var smbCommandText = @"select AppDescription from project_sm where projectId=@ProjectId";

            AppContent = PublicConn.QuerySingle<string>(smbCommandText, ref paramters);
                
        }

        private SuperProjectDetailInfo QueryDataBySql(string querySql, DynamicParameters dynamicParameters)
        {
            SuperProjectDetailInfo list = null; 
            list = PublicConn.QuerySingle<SuperProjectDetailInfo>(querySql, ref dynamicParameters);
            return list;
        }
    }

    public class SuperProjectDetailInfo
    {
        public decimal? Amount { get; set; }
        public Guid? UserId { get; set; }
        public int? ProjectType { get; set; }
       





        private string rating = string.Empty;
        /// <summary>
        /// 风险评估
        /// </summary>
        public string Rating
        {
            get { return rating = string.IsNullOrEmpty(rating) ? string.Empty : rating; }
            set { rating = value; }
        }

        #region 4.2.0版本新增字段

        private string lineCredit = string.Empty;
        /// <summary>
        /// 授信额度
        /// </summary>
        public string LineCredit
        {
            get { return lineCredit; }
            set { lineCredit = value; }
        }


        private string projectIntroduction;
        /// <summary>
        /// 项目介绍
        /// </summary>
        public string ProjectIntroduction
        {
            get { return projectIntroduction; }
            set { projectIntroduction = value; }
        }
        #endregion
    }
}