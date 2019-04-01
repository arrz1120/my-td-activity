using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text; 
using Tool;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.ajaxCross
{
    /// <summary>
    ///     ajax_simubao 的摘要说明
    /// </summary>
    public class ajax_simubao : SafeHandlerBase
    {
        //private JunTeEntities dbread = JunTeEntities.Read();

        public void GetSMBJingZhiPageList()
        {
            int pagesize = SafeConvert.ToInt32(Context.Request.Form["pagesize"], 6);
            int pageindex = SafeConvert.ToInt32(Context.Request.Form["pageindex"], 1);
            if (pageindex < 1)
            {
                pageindex = 1;
            }
            Guid projectid = SafeConvert.ToGuid(Context.Request.Form["projectid"]) ?? Guid.Empty;
            if (projectid == Guid.Empty)
            {
                PrintJson("-1", "项目编号有误");
            }

            string sql = @"SELECT @Total=COUNT(1) FROM ProjectFundDetail_SM(NOLOCK) WHERE projectId=@projectId;
                    SELECT * FROM (
                    SELECT ROW_NUMBER() OVER(ORDER BY PriceDate DESC) AS RowNumber,* FROM ProjectFundDetail_SM(NOLOCK) 
                     WHERE projectId=@projectId
                    )T WHERE T.RowNumber BETWEEN (@pageIndex-1)*@pageSize+1 AND @pageIndex*@pageSize";

            //var whereParams = new[]
            //{
            //    new SqlParameter("@Total", 0), new SqlParameter("@projectId", projectid),
            //    new SqlParameter("@pageIndex", pageindex),
            //    new SqlParameter("@pageSize", pagesize)
            //};
            //whereParams[0].Direction = ParameterDirection.Output;
            var paras = new Dapper.DynamicParameters();
            paras.Add("@Total",0,DbType.Int32,ParameterDirection.Output);
            paras.Add("@pageIndex", pageindex);
            paras.Add("@pageSize", pagesize);
            paras.Add("@projectId",projectid);
            var list = new List<SMBProjectFundDetailInfo>();
            //list = dbread.ExecuteStoreQuery<SMBProjectFundDetailInfo>(sql, whereParams).ToList();
            list = TuanDai.DB.TuanDaiDB.Query<SMBProjectFundDetailInfo>(TdConfig.DBRead, sql, ref paras);
            int totalItemCount = paras.Get<int>("@Total");
            //int.TryParse(whereParams[0].Value.ToString(), out totalItemCount);
            var sb = new StringBuilder();
            int index = 1;

            double divide = totalItemCount / pagesize;
            double floor = Math.Floor(divide);
            if (totalItemCount % pagesize != 0)
                floor++;
            int pageCount = Convert.ToInt32(floor); //总页数

            sb.Append("{\"result\":\"1\",\"pageCount\":\"" + pageCount + "\",\"list\":[");
            foreach (SMBProjectFundDetailInfo item in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"PriceDate\":\"{0}\",", item.PriceDate.ToString("yyyy-MM-dd"));
                sb.AppendFormat("\"Price\":\"{0}\",", item.Price);
                sb.AppendFormat("\"TotalPrice\":\"{0}\"", item.TotalPrice);
                sb.Append("},");

                if (list.Count == index)
                {
                    sb.Length = sb.Length - 1;
                }
                index++;
            }
            sb.Append("]}");

            Context.Response.Write(sb.ToString());
            Context.Response.End();
        }

        //获得私募宝趋势走势图
        public void GetSMBProjectFundDetail()
        {
            //JunTeEntities dbread = JunTeEntities.Read();
            string sql =@"select top 6 cast(convert(varchar(10), PriceDate, 120) as date) as priceDate ,isnull(sum(Price), 0) as price
                    from dbo.[ProjectFundDetail_SM] where   ProjectId = @ProjectId
                    group by convert(varchar(10), priceDate, 120)
                    order by priceDate asc;";

            Guid projectid = Tool.SafeConvert.ToGuid(Context.Request.Form["projectid"]) ?? Guid.Empty;

            //var whereParams = new SqlParameter[] { new SqlParameter("@ProjectId", projectid) };
            var para = new Dapper.DynamicParameters();
            para.Add("@ProjectId",projectid);
            List<TuanDai.PortalSystem.Model.SMBProjectFundDetailInfo> list = new List<SMBProjectFundDetailInfo>();
            list = TuanDai.DB.TuanDaiDB.Query<SMBProjectFundDetailInfo>(TdConfig.DBRead, sql, ref para);
            //list =dbread.ExecuteStoreQuery<TuanDai.PortalSystem.Model.SMBProjectFundDetailInfo>(sql, whereParams).OrderBy(x=>x.PriceDate).ToList();
            StringBuilder sb = new StringBuilder();
            int index = 1;
            if (list.Count > 0)
            {
                sb.Append("{ \"result\":\"1\",\"list\":[");
                foreach (var item in list)
                {
                    sb.Append("{");
                    sb.AppendFormat("\"PriceDate\":\"{0}\",", item.PriceDate.ToString("yyyy-MM-dd"));
                    sb.AppendFormat("\"Price\":\"{0}\"", item.Price);
                    sb.Append("},");
                    if (list.Count == index)
                    {
                        sb.Length = sb.Length - 1;
                    }
                    index++;
                }

                sb.Append("]}");
            }
            else
            {
                sb.Append("{ \"result\":\"0\",\"list\":[]}");
            }
            this.Context.Response.Write(sb.ToString());
            this.Context.Response.End();


        }
    }
}