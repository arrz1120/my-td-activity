using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Kamsoft.Data.Dapper;
using Tool;

namespace TuanDai.WXApiWeb.Activity._20150901Vote
{
    /// <summary>
    /// VoteAjaxHandler 的摘要说明
    /// </summary>
    public class VoteAjaxHandler : SafeHandlerBase
    {
        public void GetVoteTop20List()
        {
            const string querySql = @"select top 20 Id ParticipantId,Name,Records,OrderNo,BigImageUrl,ThumbnailsUrl 
                                    from [dbo].[20150901_MountaineeringPhotos]  order by Records desc";

            var dataList = QueryList<OrderListViewMode>(querySql, null);
            if (dataList.Any())
            {
                var responseObj = new { Success = true, Message = "加载数据成功", list = dataList, pagecount = dataList.Count };
                PrintJson(responseObj);
            }
            else
            {
                var responseObj = new { Success = false, Message = "没有找到数据!" };
                PrintJson(responseObj);
            }
        }

        /// <summary>
        /// 获取参数者列表
        /// </summary>
  
        public void GetParticpantsList()
        {
            string keyword = WEBRequest.GetFormString("keyword");
            int pageIndex = string.IsNullOrEmpty(WEBRequest.GetFormString("pageIndex")) == true ? 1 : int.Parse(WEBRequest.GetFormString("pageIndex"));
            var beginRowNumber = (pageIndex - 1) * 20 + 1;
            var endRowNumber = pageIndex * 20;

            const string querySql = @"select @Total=count(1) from [dbo].[20150901_MountaineeringPhotos] where Name like '%'+@keyword+'%' or OrderNo like '%'+@keyword+'%';
            with t1 as( select ROW_NUMBER() over(order by t.OrderNo asc) as RowNumber,[Id] ParticipantId,OrderNo,[Name],[ThumbnailsUrl],[BigImageUrl],Records
            from [dbo].[20150901_MountaineeringPhotos] t where t.Name like '%'+@keyword+'%' or t.OrderNo like '%'+@keyword+'%')
            select * from t1 where t1.RowNumber between @beginRow and @endRow";

            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Total", ParameterDirection.Output);
            parameters.Add("@beginRow", beginRowNumber);
            parameters.Add("@endRow", endRowNumber);
            parameters.Add("@keyword", keyword); 

            var dataList =QueryList<OrderListViewMode>(querySql, parameters); 
            if (dataList.Any())
            {
                var responseObj = new { Success = true, Message = "", list = dataList, pagecount = dataList.Count };
                PrintJson(responseObj);
            }
            else
            {
                var responseObj = new { Success = false, Message = "没有找到数据!" };
                PrintJson(responseObj);
            }
        }
         

        /// <summary>
        /// 根据语句查询列表
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="querySql"></param>
        /// <param name="dynimanParameters"></param>
        /// <returns></returns>
        private IList<T> QueryList<T>(string querySql, object dynimanParameters)
        {
            IList<T> returnList = new List<T>();
            //using (SqlConnection connection = new SqlConnection(BaseConfig.ActivityConnectionString))
            //{
            //    returnList = connection.Query<T>(querySql, dynimanParameters).ToList();
            //    connection.Close();
            //    connection.Dispose();
            //}

            return returnList;
        }

        public void Vote()
        {
            try
            {
                int status = 0;
                string code = WEBRequest.GetFormString("code");
                string participantId = WEBRequest.GetFormString("participantId");

                if (string.IsNullOrEmpty(code) || string.IsNullOrEmpty(participantId))
                {
                    PrintJson(new { Status = -4 });
                    return;

                }

                var param = new DynamicParameters();
                param.Add("@openId", code);
                param.Add("@participantId", new Guid(participantId));
                param.Add("@outStatus", 0, System.Data.DbType.Int32, System.Data.ParameterDirection.Output);

                //using (SqlConnection connection = new SqlConnection(BaseConfig.ActivityConnectionString))
                //{
                //    connection.Execute("p_20150901photoVote", param, null, null,
                //        CommandType.StoredProcedure);
                //    status = param.Get<int>("@outStatus");
                //    connection.Close();
                //    connection.Dispose();
                //}

                PrintJson(new { Status = status });
            }
            catch (Exception exception)
            {
                BusinessDll.NetLog.WriteLoginHandler("应用系统错误:" + exception.TargetSite.Name, Tool.ExceptionHelper.GetExceptionMessage(exception), "触屏版_20150901Vote");
                var responseObj = new { Status = 0 };
                PrintJson(responseObj);
            }
        }
    }


    public class OrderListViewMode
    {
        /// <summary>
        /// 参数者ID
        /// </summary>
        public Guid ParticipantId { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 票数
        /// </summary>
        public int Records { get; set; }
        /// <summary>
        /// 编号
        /// </summary>
        public int OrderNo { get; set; }
        public string BigImageUrl { get; set; }
        public string ThumbnailsUrl { get; set; }
    }
}