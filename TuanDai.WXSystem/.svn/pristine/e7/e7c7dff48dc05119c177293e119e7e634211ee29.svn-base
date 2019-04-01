using System;
using System.Collections.Generic;
using System.Linq;
using System.Web; 
using TuanDai.PortalSystem.DAL;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using Dapper;

namespace TuanDai.WXApiWeb.Activity._20150626_GZGold
{
    /// <summary>
    ///广州金交会抽奖
    /// </summary>
    public class ajax_activity : SafeHandlerBase
    {
        /// <summary>
        /// 抽奖
        /// </summary>
        public void GetPrize()
        {
            Guid? userId = WebUserAuth.UserId;
            if (userId == Guid.Empty)
            {
                this.PrintJson("2", "对不起，你未登录，请先登录。");
            }

            var param = new DynamicParameters();
            param.Add("@userId", userId);
            param.Add("@outStatus", 0, DbType.Int32, ParameterDirection.Output);
            param.Add("@PrizeName", "", DbType.String, ParameterDirection.Output);

            int status = 0;
            string prizeName = string.Empty;
            PublicConn.ExecuteActivity("p_Activity_Guangzhou_Gold", ref param, CommandType.StoredProcedure);
            status = param.Get<int>("@outStatus");
            prizeName = param.Get<string>("@PrizeName");

            this.PrintJson(status.ToString(), prizeName);
        }
        /// <summary>
        /// 中奖纪录
        /// </summary>
        public void GetRecord()
        {
            IList<RecordInfo> list;
            DynamicParameters dyParams = new DynamicParameters();
                string sqlText = "SELECT TOP 60 UserName,PrizeName FROM dbo.Activity_Guangzhou_Record WITH(NOLOCK) ORDER BY AddDate DESC";
                list = PublicConn.QueryBySql<RecordInfo>(sqlText, ref dyParams);
               
            StringBuilder sb = new StringBuilder();
            if (list != null && list.Count() > 0)
            {
                int index = 1;
                sb.Append("{\"result\":\"1\",\"list\":[");
                foreach (RecordInfo temp in list)
                {
                    if (index == list.Count())
                    {
                        sb.Append("{\"PrizeName\":\"" + temp.PrizeName + "\",\"UserName\":\"" + BusinessDll.StringHandler.MaskTelNo(temp.UserName) + "\"}]}");
                    }
                    else
                    {
                        sb.Append("{\"PrizeName\":\"" + temp.PrizeName + "\",\"UserName\":\"" + BusinessDll.StringHandler.MaskTelNo(temp.UserName) + "\"},");
                    }
                    index++;
                }
            }
            else
            {
                sb.Append("{\"result\":\"0\"}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();
        }
        /// <summary>
        /// 我的奖品
        /// </summary>
        public void GetRecordByUserId()
        {
            Guid? userId = WebUserAuth.UserId;
            if (userId == Guid.Empty)
            {
                this.PrintJson("2", "对不起，你未登录，请先登录。");
            }
            var param = new DynamicParameters();
            param.Add("@UserId", userId);

            RecordInfo recordInfo;

            string sqlText = "SELECT UserName,PrizeName FROM dbo.Activity_Guangzhou_Record WITH(NOLOCK) WHERE UserId=@UserId";
            recordInfo = PublicConn.QuerySingle<RecordInfo>(sqlText, ref param); 

            if (recordInfo != null)
                this.PrintJson("1", recordInfo.PrizeName);
            else
                this.PrintJson("0", recordInfo.PrizeName);
        }
        /// <summary>
        /// 中奖实体
        /// </summary>
        public class RecordInfo
        {
            public string UserName { get; set; }
            public string PrizeName { get; set; }
        }
    }
}