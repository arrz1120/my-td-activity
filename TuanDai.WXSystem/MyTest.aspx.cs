using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text; 
using System.Data;
using Newtonsoft.Json; 
using System.Xml;
using System.Configuration;
using System.Security.Cryptography; 
using System.Web.UI.HtmlControls;  
using BusinessDll;
using Tool;
using TuanDai.InfoSystem.Model;
using System.Data.SqlClient; 
using TuanDai.PortalSystem.Model;
using Tuandai.Redis;
using TuanDai.ZKHelper;
using ZooKeeperNet;
using JunteSecurity.UserInfo;
using TuanDai.BalancedSystem.Client; 

namespace TuanDai.WXApiWeb
{
    public partial class MyTest : System.Web.UI.Page
    {

        protected string NickName = "";
        protected string StrUserName = "";
        private static string Path = "/redis/PCRedis";


        public static string GetZK(string path, ref string ErrorMessage)
        {
            string str = string.Empty;
            try
            {
                ZooKeeper zooKeeper = ZooKClient.GetZooKeeper(); 
                str = UserInfoSecurity.DBDecy(Encoding.UTF8.GetString(zooKeeper.GetData(path, null, null))); 
            }
            catch (Exception exception)
            {
                ErrorMessage = exception.Message + "|" + exception.StackTrace;
            }
            return str;
        }
        public static string CreateZK(string path, string connStr, ref string ErrorMessage) {
            try
            {
                ZooKeeper zooKeeper = ZooKClient.GetZooKeeper();                
                string strResult = zooKeeper.Create(path, connStr.GetBytes(), Ids.OPEN_ACL_UNSAFE, CreateMode.Persistent);
               return strResult;
            }
            catch (Exception exception)
            {
                ErrorMessage = exception.Message + "|" + exception.StackTrace;
            }
            return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string strMessage = "";
            string token = WEBRequest.GetQueryString("t");
             
             //TuanDai.LogSystem.LogClient.LogClients.ErrorLog("触屏版", "应用系统错误", "方法名", "测试写日志", true);

             //BalancedSystemClient client = new BalancedSystemClient();
             //string Url = "";
             //client.Vip_MQ(ref Url, ref strMessage);
             //NickName += "Url:" + Url + " message:" + strMessage;


          //  string strOpenId=WeiXinApi.GetUserWXOpenId(Guid.Parse("d12965c0-6856-4f68-878c-9d12e6c51bd1"));

            //NickName += "String:" + RedisServer.StringGet<string>(Path, token, ref strMessage);
            //StrUserName += " String:" + strMessage;
            //NickName += "Guid:" + RedisServer.StringGet<Guid>(Path, token, ref strMessage);

            //StrUserName += " String:" + strMessage;
            //NickName += "<br/>" + StrUserName;

            //BusinessDll.NetLog.WriteLoginHandler("测试写日志", "测试写日志222", "触屏版");

            string valueForZK = GetZK(token, ref strMessage);
            NickName += "ZK:" + valueForZK + " <br/>报错:" + strMessage;

          // string valueForZK = CreateZK("/BD/test3", "2222222222222asfasfafasafa", ref strMessage);
          // NickName += valueForZK + " <br/>报错:" + strMessage; 
          
            //Guid userId = Guid.Parse("3c90ae9a-d45e-447c-80af-3c2078ab5f48");
            //List<WebLog> loglist = new WebLogService().GetListWebLogInfo(UserId: userId.ToString());
            //NickName = loglist.Count.ToString();

            //WebLog logsm = new WebLog();
            //logsm.AddDate = DateTime.Now;
            //logsm.BusinessId = "3c90ae9a-d45e-447c-80af-3c2078ab5f48";
            //logsm.BusinessTypeId = (int)ConstString.LogBusinessType.Edit;
            //logsm.HandlerTypeId = (int)ConstString.LogType.EditIdentityCard;
            //logsm.UserId = "3c90ae9a-d45e-447c-80af-3c2078ab5f48";
            //logsm.UserTypeId = (int)ConstString.LogUserType.WebUser;
            //logsm.Content1 = "征信系统验证--测试" + DateTime.Now;
            //logsm.Content2 = "真实姓名：王爱玲 身份证号：43052519861228611X" + DateTime.Now;
            //logsm.Id = Guid.NewGuid().ToString();
            //WebLogInfo.WriteLoginHandler(logsm);

            //IPublicService service = new IPublicService();
            //NickName = service.ValidateRealName("王爱玲", "43052519861228611X");


            //WebLogService dbService = new WebLogService();
            //List<WebLog> loglist = dbService.GetListWebLogInfo(UserId: "3c90ae9a-d45e-447c-80af-3c2078ab5f48");
            //NickName = loglist.Count.ToString();
            //if (loglist != null && loglist.Count > 0)
            //{
            //    NickName = loglist[loglist.Count-1].Content2;
            //} 

            //BalancedSystemClient sClient = new BalancedSystemClient();
            //sClient.ClearCacheByClient(); 

            // var messageSender = new BusinessDll.MessageSend();
            // NickName= messageSender.SendNoteHandler("", Guid.Parse("3c90ae9a-d45e-447c-80af-3c2078ab5f48"), "13434019865", "团贷网测试短信");

            #region 速度测试
            //            DBBalanceClient dbClient = new DBBalanceClient();

            //            string errorMessage = string.Empty;
            //            NickName += "<br/>1.开始读取:" + DateTime.Now.ToString();
            //            string connStr = dbClient.TdProjectPCRead(ref errorMessage);
            //            NickName += "<br/>DBBalance:" + connStr;
            //            NickName += "<br/>1.结束读取:" + DateTime.Now.ToString();
            //            //Dapper.DynamicParameters dynamicParameters = new Dapper.DynamicParameters();
            //            //string querySql = "select NickName from dbo.UserBasicInfo where TelNo='13434019865'";
            //            //NickName = TuanDai.DB.TuanDaiDB.Query<string>(TuanDai.DB.ConnectionType.PCProjectRead, querySql, ref dynamicParameters).FirstOrDefault();

            //            NickName += "<br/>2.开始读取:" + DateTime.Now.ToString();
            //            string connectionString = TuanDai.Config.BaseConfig.CommonConnectionString;
            //            NickName += "<br/>2.结束读取:" + DateTime.Now.ToString();
            //            using (SqlConnection connection = new SqlConnection(connectionString))
            //            {
            //                NickName += "<br/>3.打开连接:" + DateTime.Now.ToString();
            //                connection.Open();
            //                NickName += "<br/>本地Conn:" + connection.ConnectionString;
            //                NickName += "<br/>3.结束连接:" + DateTime.Now.ToString();
            //                connection.Close();
            //            }


            //            using (SqlConnection conn = new SqlConnection(connectionString))
            //            {
            //                conn.Open();
            //                string strSQL = @" select top 3 * from (
            //	                        select ROW_NUMBER() over(PARTITION BY A.ProductTypeId ORDER BY A.Startdate DESC) as num, B.ProductId, A.ProductName, A.ProductNumber,
            //	                        A.ProductTypeId, A.PlanAmount,A.YearRate, A.UnitAmount, A.StatusId, A.Deadline, A.ProjectTypes,
            //	                        A.StartDate,A.EndDate,A.InvestCompleteDate,A.OrderCompleteDate,B.InvestCount
            //	                        ,B.OrderCount, B.OrderQty, B.TotalQty,A.IsWeFQB, C.TypeWord,C.SortOrder
            //                            from dbo.We_Product A with(nolock) 
            //	                        inner join dbo.We_ProductDetail  B with(nolock) on A.Id=B.ProductId  
            //                            inner join dbo.We_ProductType C  with(Nolock) on C.Id=A.ProductTypeId
            //                            WHERE ISNULL(C.IsWeFQB,0)=0    
            //                        UNION ALL
            //                            SELECT TOP 1 * FROM (
            //		                        select ROW_NUMBER() over(PARTITION BY A.ProductTypeId ORDER BY A.StatusId, A.Startdate DESC) as num, B.ProductId, A.ProductName, A.ProductNumber,
            //		                        A.ProductTypeId, A.PlanAmount,A.YearRate, A.UnitAmount, A.StatusId, A.Deadline, A.ProjectTypes,
            //		                        A.StartDate,A.EndDate,A.InvestCompleteDate,A.OrderCompleteDate,B.InvestCount
            //		                        ,B.OrderCount, B.OrderQty, B.TotalQty,A.IsWeFQB, C.TypeWord,C.SortOrder
            //		                        from dbo.We_Product A with(nolock) 
            //		                        inner join dbo.We_ProductDetail  B with(nolock) on A.Id=B.ProductId  
            //		                        inner join dbo.We_ProductType C  with(Nolock) on C.Id=A.ProductTypeId
            //		                        WHERE ISNULL(C.IsWeFQB,0)=1  and A.StatusId=1
            //                             ) WeData WHERE WeData.num=1   order by case when isnull(IsWeFQB,0)=1 then SortOrder else 999 end  
            //	                    ) T where T.num=1 order by case when isnull(IsWeFQB,0)=1 then SortOrder else 999 end, TypeWord";
            //                conn.Execute(strSQL, null);
            //                conn.Close();
            //                conn.Dispose();
            //                NickName += "<br/>4.结束查询:" + DateTime.Now.ToString();
            //            }
            #endregion

            //1.查询推送日志
            //using (SqlConnection conn = new SqlConnection("Data Source=192.168.2.22;Initial Catalog=TuanDai_Message;User ID=TuanDai_Message;Password=rM[~3mRhAQAA;MultipleActiveResultSets=True;Max Pool Size=1000; Min Pool Size=50;"))
            //{
            //    conn.Open();
            //    string strSQL = "select count(1) from WXPushMsg";
            //    NickName = conn.Query<int>(strSQL).FirstOrDefault().ToString(); 
            //}

            //1.消息推送
            //BusinessDll.WXTemplateMessage wxSend = new BusinessDll.WXTemplateMessage(WXTemplateMessage.PlatFormType.WeiXin, Guid.Parse("3c90ae9a-d45e-447c-80af-3c2078ab5f48"));
            //wxSend.TemplateId = "F6ijcbneJWO4ZQAO-EqkG6mVXTiquWnRKOlBN7pVeN0";
            ////WeiXinApi.ClearOpenIdFromCookie();//清除掉Cookie中OpenId 
            //NickName = wxSend.SendInviteFriendReg("夏日酷雪", "13434019865", DateTime.Now).ToString();

            //string strSQL = "update  dbo.MsgTemplate  set  IsWeiXinPush=1,Status=1,WeiXinPush='8j74Yi-4ZrFVVhpQ0ioTM8Q8JjZGouhC8wBuIWIOWiY',WeiXinTempateId='OPENTM206932412--还款日提醒' where code='RepaymentBalancesEnough' or code='RepaymentBalancesNoEnough'";
            //Dapper.DynamicParameters dyParams = new Dapper.DynamicParameters();
            //NickName = TuanDai.DB.TuanDaiDB.Execute(DB.ConnectionType.AllProjectWrite, strSQL, ref dyParams).ToString();

            //string sql = "select top 1 o.id from we_product p with(nolock) inner join we_order o with(nolock) on p.id=o.productid where p.id=@id and o.userid=@userid order by OrderDate desc";
            //Dapper.DynamicParameters para = new Dapper.DynamicParameters();
            //para.Add("@id", "a9a6a5f7-4bcc-46a4-b617-a7ca5dd0d745");
            //para.Add("@userid", WebUserAuth.UserId.Value);
            //var orderId = TuanDai.DB.TuanDaiDB.Query<Guid>(DB.ConnectionType.AllProjectWrite, sql, ref para).FirstOrDefault();
            //NickName = orderId.ToText();

        }
        

    } 

}

 