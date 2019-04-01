using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using BusinessDll;
using System.Data;
using Kamsoft.Data.Dapper; 

namespace TuanDai.WXApiWeb.Activity.ExpGold
{
    public partial class Investment : System.Web.UI.Page
    {
        protected List<ExperienceGoldInfo> list;
        protected int count = 0;
        protected bool IsValidRealName = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (WebUserAuth.UserId!=Guid.Empty)
            {
                //JunTeEntities db = new JunTeEntities();
                //UserBasicInfo model = db.UserBasicInfo.FirstOrDefault(p => p.Id == WebUserAuth.UserId);
                //if (model != null && !string.IsNullOrEmpty(model.RealName) && model.IsValidateIdentity)
                //{
                //    IsValidRealName = true;
                //}
                GetData();
            }
            else
            {
                Response.Redirect("register.aspx");
            }            
        }

        protected void GetData()
        {
            var param = new DynamicParameters();
            param.Add("@Count", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);

//            using (IDbConnection conn = CreateReadConnection())
//            {
//                string sqlText = @"SELECT top 20 UserName,AddDate FROM  dbo.ExperienceGoldLog;
//                                          SELECT @Count=Count(0) FROM  dbo.ExperienceGoldLog";
//                list = SqlMapper.Query<ExperienceGoldInfo>(conn, sqlText, param).ToList();
//                count = param.Get<int>("@Count");
//                conn.Close();
//                conn.Dispose();
//            }
        }

        #region CreateReadConnection

        //protected SqlConnection CreateReadConnection()
        //{
        //    string connectionString = TuanDai.Config.BaseConfig.CommonConnectionString;
        //    SqlConnection connection = new SqlConnection(connectionString);
        //    connection.Open();
        //    return connection;
        //}

        #endregion

        public class ExperienceGoldInfo
        {
            public string UserName { get; set; }
            public DateTime AddDate { get; set; }
            public DateTime? ReceiveDate { get; set; }
            public DateTime? RecExpirateDate { get; set; }
            public DateTime? UsedDate { get; set; }
            public DateTime? UseExpirateDate { get; set; }
        }
    }
}