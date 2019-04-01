using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TuanDai.WXApiWeb.Common;
using System.Data.SqlClient;
using Tool;
using Kamsoft.Data.Dapper;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model;

namespace TuanDai.WXApiWeb.Activity.GodWealth
{
    /// <summary>
    /// 财神爷活动--领取红包页面
    /// </summary>
    public partial class GetPrize : UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strType = Tool.WEBRequest.GetQueryString("type");
            if (!IsPostBack)
            {
                if (WebUserAuth.IsAuthenticated)
                {
                    AwardToGetPrize();
                    //根据传回来参数判断领取完后跳转页面：团宝箱，投资列表
                    if (strType.ToLower() == "redpacket")
                        Response.Redirect("/Member/UserPrize/Index.aspx");
                    else
                        Response.Redirect("/pages/invest/invest_list.aspx");
                }
                else
                {
                    Response.Redirect("/Activity/GodWealth/Index.aspx");
                }
            }
        }
        //领取红包
        private void AwardToGetPrize()
        {
            try
            {
                ThirdLoginSDK sdkApi = new ThirdLoginSDK();
                sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                string OpenId = sdkApi.GetCookieOpenId("");
                Guid userId = WebUserAuth.UserId.Value;
                //判断为空时不可领取
                if (userId == Guid.Empty || OpenId.ToText().IsEmpty())
                    return;

//                using (SqlConnection connection = WealthPage.OpenConnection(2))
//                {
//                    //判断是否有领取过
//                    string strSQL = "SELECT COUNT(1) AS cnt  FROM Activity_GodWealth_Record   WHERE  IsGetPrize=1 AND (WXOpenId=@WXOpenId OR UserId=@UserId)";
//                    DynamicParameters dyParams = new DynamicParameters();
//                    dyParams.Add("@WXOpenId", OpenId);
//                    dyParams.Add("@UserId", userId);
//                    int iCount = connection.Query<Int32>(strSQL, dyParams).FirstOrDefault();
//                    if (iCount > 0)
//                        return;
//                    //判断奖品是否已发送完毕
//                    WealthPage.ActivityConfigInfo configInfo = WealthPage.GetActivityConfig();
//                    if (configInfo == null || configInfo.UsePrizeNum >= configInfo.TotalPrizeNum)
//                        return;

//                    WealthPage.GodWealthRecordInfo recordInfo = WealthPage.GetUserGodWealthInfo(OpenId);
//                    //非过期时才可领取红包
//                    if (recordInfo.ExpirationDate.HasValue && recordInfo.ExpirationDate > DateTime.Now)
//                    {
//                        UserBLL userbll = new UserBLL();
//                        UserBasicInfoInfo userInfo = userbll.GetUserBasicInfoModelById(userId);
//                        strSQL = @" update Activity_GodWealth_Record set 
//                                UserId=@UserId, UserName=@UserName,
//                                ExpirationDate=@ExpirationDate,
//                                GetPrizeDate=@GetPrizeDate, IsGetPrize=@IsGetPrize
//                                where WXOpenId=@WXOpenId";
//                        dyParams = new DynamicParameters();
//                        dyParams.Add("@WXOpenId", OpenId);
//                        dyParams.Add("@UserId", userInfo.Id);
//                        dyParams.Add("@UserName", userInfo.UserName);
//                        dyParams.Add("@ExpirationDate", null); //已获取奖品后这里清空
//                        dyParams.Add("@GetPrizeDate", DateTime.Now); //领取时间
//                        dyParams.Add("@IsGetPrize", 1); //标记已领取

//                        int iSuc = connection.Execute(strSQL, dyParams);
//                        if (iSuc > 0)
//                        {
//                            int outStatus = 0;
//                            SendUserPrizeInfo prizeInfo = new SendUserPrizeInfo();
//                            prizeInfo.UserId = userId;
//                            prizeInfo.PrizeName = "10元投资红包";
//                            prizeInfo.PrizeValue = 10;
//                            //规则： 新用户要投资500元才能使用10元，老用户投资1000元才能使用
//                            if (userInfo.AddDate >= configInfo.ActivityStartDate)
//                            {
//                                prizeInfo.RuleId = Guid.Parse("9dd159c3-712a-4bee-8857-640de08b9a9e");
//                                prizeInfo.Description = "团贷网&财神爷派红包活动-单笔投资满500元即可使用10元,过期时间为:" + DateTime.Today.AddMonths(1).AddDays(-1).ToString("yyyy/MM/dd");
//                            }
//                            else
//                            {
//                                prizeInfo.RuleId = Guid.Parse("918f88a9-f3f7-4687-b239-8db70c4e483b");//规则Id 
//                                prizeInfo.Description = "团贷网&财神爷派红包活动-单笔投资满1000元即可使用10元,过期时间为:" + DateTime.Today.AddMonths(1).AddDays(-1).ToString("yyyy/MM/dd");
//                            }                           
//                            userbll.SendUserPrizeNew(prizeInfo, out  outStatus);
//                            //更新奖品数量
//                            if (outStatus == 1)
//                                WealthPage.UpdateUsedPrizeNum();
//                        }
//                    }
//                }
            }
            catch (Exception ex) {
                BusinessDll.NetLog.WriteLoginHandler("财神爷派红包活动领取奖品失败", ExceptionHelper.GetExceptionMessage(ex), "触屏版");
            }
        }


    }
}