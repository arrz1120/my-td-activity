using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using System.Data.SqlClient;
using Kamsoft.Data.Dapper;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity.ThreeYearCeleb
{
    /// <summary>
    /// 登录后自动领取奖品
    /// </summary>
    public partial class AwardPrize : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string code = WEBRequest.GetQueryString("code");
            if (!IsPostBack)
            {
                if (WebUserAuth.IsAuthenticated)
                {
                    AwardMyPrize(code);
                    //领奖完毕后，跳转到我的团宝箱
                    Response.Redirect("/Member/UserPrize/Index.aspx");
                }
                else
                {
                    Response.Redirect("/Activity/ThreeYearCeleb/AuthIndex.aspx");
                }
            }
        }

        //登录后自动领取奖品
        private bool AwardMyPrize(string code)
        {
            ThirdLoginSDK sdkApi = new ThirdLoginSDK();
            sdkApi.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
            string OpenId = sdkApi.GetCookieOpenId(code);

//            using (SqlConnection connection = CelebHelper.OpenConnection(2))
//            {
//                string strSQL = "select * from Activity_ThreeYearGame_Record where WXOpenId=@WXOpenId";
//                DynamicParameters dyParams = new DynamicParameters();
//                dyParams.Add("@WXOpenId", OpenId);
//                GameRecordInfo recordInfo = connection.Query<GameRecordInfo>(strSQL, dyParams).FirstOrDefault();
//                if (recordInfo == null)
//                    return false;
//                //此处先屏蔽掉。因为考滤到之前没有领取红包失败的数据
//                //if (recordInfo.UserId.ToText().IsNotEmpty())
//                //    return true;


//                //非过期时才改为当前用户Id
//                //if (recordInfo.ExpirationDate.HasValue && recordInfo.ExpirationDate > DateTime.Now)
//                //{
//                UserBLL userbll = new UserBLL();
//                UserBasicInfoInfo userInfo = userbll.GetUserBasicInfoModelById(WebUserAuth.UserId.Value);

//                //判断同一个用户ID是否有领取奖品 Allen 2015-07-14
//                strSQL = " SELECT count(1) as cnt FROM Activity_ThreeYearGame_Record  WHERE UserId=@UserId";
//                dyParams = new DynamicParameters();
//                dyParams.Add("@UserId", userInfo.Id);
//                int iCount = connection.Query<Int32>(strSQL, dyParams).Sum();
//                if (iCount > 2)
//                {
//                    return false;
//                }

//                strSQL = @"update Activity_ThreeYearGame_Record set 
//                                UserId=@UserId, UserName=@UserName, NickName=@NickName,
//                                ExpirationDate=@ExpirationDate, GetPrizeDate=@GetPrizeDate
//                                where WXOpenId=@WXOpenId";
//                dyParams = new DynamicParameters();
//                dyParams.Add("@WXOpenId", OpenId);
//                dyParams.Add("@UserId", userInfo.Id);
//                dyParams.Add("@UserName", userInfo.UserName);
//                dyParams.Add("@NickName", userInfo.NickName);
//                dyParams.Add("@ExpirationDate", null); //已获取奖品后这里清空
//                dyParams.Add("@GetPrizeDate", DateTime.Now); //领取时间

//                int iSuc = connection.Execute(strSQL, dyParams);

//                if (iSuc > 0)
//                {
//                    //判断团宝箱中有没发放过10元投资红包
//                    bool isSendRedPacket = CelebHelper.CheckInvestRedPrizeIsExists(WebUserAuth.UserId.Value);
//                    if (isSendRedPacket == false)
//                    {
//                        GamePrizeInfo prizeInfo = CelebHelper.GetPrizeInfor("RedPacket");
//                        if (prizeInfo != null)
//                        {
//                            //发送团宝箱
//                            CelebHelper.AddToMyPrize(prizeInfo, WebUserAuth.UserId.Value, false);
//                        }
//                    }
//                }

//                //修改已登录标识
//                strSQL = "update Activity_ThreeYearGame_Friend set IsLogin=1 where  FriendOpenId=@FriendOpenId";
//                dyParams = new DynamicParameters();
//                dyParams.Add("@FriendOpenId", OpenId);
//                connection.Execute(strSQL, dyParams);
//                // }
//            }
            return true;
        }
    }
}