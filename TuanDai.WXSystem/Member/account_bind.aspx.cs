using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessDll;
using Dapper;
using NetDimension.Json;
using TuanDai.PortalSystem.BLL;
using TuanDai.PortalSystem.Model.Enums;
using Tuandai.ServiceStackRedis;
using TuanDai.WXSystem.Core;
using TuandaiCommnetTool.Extensions;
using Tool;

namespace TuanDai.WXApiWeb.Member
{
    public partial class account_bind : UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cmd = Request.QueryString["cmd"];
            if (cmd == "sendcode")
            {
                SendCode();
            }
            else if (cmd == "bind")
            {
                Bind();
            }
        }

        public void Bind()
        {
            string type = Context.Request.Form["type"];
            int result = 1;
            Guid userid = WebUserAuth.UserId.Value;
            if (string.IsNullOrEmpty(type))
            {
                string code = Context.Request.Form["code"];
                string mobilePhone = Context.Request.Form["mobilePhone"];
                if (!mobilePhone.IsPhone())
                {
                    Response.Write("{\"result\":\"-2\",\"msg\":\"手机号格式不对\"}");
                    Response.End();
                }
                CookieHelper.WriteCookie("shellben4tel", Tool.Common.Utils.StringHandler.MaskTelNo(mobilePhone));
                var model = new UserBLL().GetUserBasicInfoModelByTelNo(mobilePhone);
                if (model == null)
                {
                    Response.Write("{\"result\":\"-1\",\"msg\":\"手机号未在团贷网注册\"}");
                    Response.End();
                }
                result = new CodeRecordBLL().CheckCodeRecord(code, mobilePhone, MsCodeType.PhoneCode,
                    MsCodeType2.BindWeiXinOpenId, model.Id, true);
                userid = model.Id;
            }

            if (result == 1)
            {
                var posturl = GlobalUtils.MsgApiUrl;
                string err = "";
                string openId = GlobalUtils.OpenId;
                if (string.IsNullOrEmpty(openId))
                {
                    Response.Write("{\"result\":\"-4\",\"msg\":\"获取不到微信OpenId\"}");
                    Response.End();
                }
                //openId = "oUYJbuHDRnoxUw0UbTQUTO_nkUtQ";
                string resp = "";
                try
                {
                    var descStr =
                        TuanDai.WXSystem.Core.Common.MsgDesc.GetDescStr("{\"Data\":{\"WeiXinOpenId\":\"" + openId +
                                                                        "\",\"UserId\":\"" + userid + "\"}}");
                    resp = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName,
                        posturl + "/6/UpdateMsgSetInfoWeixinOpenId", descStr,
                        out err, null, 3);
                }
                catch (Exception ex)
                {
                    TuanDai.LogSystem.LogClient.LogClients.ErrorLog(TdConfig.ApplicationName, "用户团贷网账户绑定微信", userid.ToString(), ex.Message);
                }

                if (!string.IsNullOrEmpty(resp))
                {
                    var returnmsg =
                        JsonConvert.DeserializeObject<TuanDai.WXSystem.Core.Common.MsgApiResponseMessage<bool>>(
                            resp);
                    if (returnmsg != null && returnmsg.Data)
                    {
                        TuandaiCommnetTool.BaseCommon.TaskAsyncHelper.RunAsync(()=>
                        {
                            if (getCount(userid) <= 0 && InsertRecord(userid, openId) > 0) //插入成功说明是首次绑定
                            {
                                SendTuanBi(userid);
                            }
                            else
                            {
                                UpdateRecord(userid,openId);
                            }
                        });
                        Response.Write("{\"result\":\"1\",\"msg\":\"绑定成功\"}");
                        Response.End();
                    }
                }
                Response.Write("{\"result\":\"0\",\"msg\":\"绑定失败\"}");
                Response.End();
            }
            else
            {
                Response.Write("{\"result\":\"-3\",\"msg\":\"验证码错误\"}");
                Response.End();
            }
        }

        /// <summary>
        /// 发送团币
        /// </summary>
        public void SendTuanBi(Guid userId)
        {
            string url = ConfigHelper.getConfigString("CoinServerUrl", "http://172.16.0.193:9320") + "/coin/sendCoin";
            string postJson = "{\"coinNum\": 30,\"subType\": 609,\"targetId\": \""+Guid.NewGuid()+"\",\"userId\": \""+userId+"\"}";
            string err = "";
            string resp = HttpClient.HttpUtil.HttpPostJson(TdConfig.ApplicationName, url, postJson, out err);
            TuanDai.LogSystem.LogClient.LogClients.TraceLog(TdConfig.ApplicationName, "发送团币", "首次关注微信发送团币回调结果",resp);
        }

        public int getCount(Guid userId)
        {
            string sql = "select count(0) from WeiXinBindRecord with(nolock) where userId=@userId";
            Dapper.DynamicParameters para = new DynamicParameters();
            para.Add("@userId", userId);

            return TuanDai.DB.TuanDaiDB.QueryFirstOrDefault<int>(TdConfig.ApplicationName, TdConfig.DBActivityWrite, sql, ref para);
        }

        /// <summary>
        /// 插入微信绑定记录
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="openId"></param>
        /// <returns></returns>
        public int InsertRecord(Guid userId,string openId)
        {
            string sql = "insert into dbo.WeiXinBindRecord( userId ,openId ) values  ( @userId , @openId )";
            Dapper.DynamicParameters para = new DynamicParameters();
            para.Add("@userId",userId);
            para.Add("@openId",openId);

            return TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBActivityWrite, sql, ref para);
        }
        /// <summary>
        /// 更新微信绑定记录
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="openId"></param>
        /// <returns></returns>
        public void UpdateRecord(Guid userId,string openId)
        {
            string sql = "update dbo.WeiXinBindRecord set openId=@openId,updateDate=getdate()  where userId =@userId";
            Dapper.DynamicParameters para = new DynamicParameters();
            para.Add("@userId", userId);
            para.Add("@openId", openId);

            TuanDai.DB.TuanDaiDB.Execute(TdConfig.ApplicationName, TdConfig.DBActivityWrite, sql, ref para);
        }

        public void SendCode()
        {
            string mobilePhone = Context.Request.Form["mobilePhone"];
            if (!mobilePhone.IsPhone())
            {
                Response.Write("{\"result\":\"-2\",\"msg\":\"手机号格式不对\"}");
                Response.End();
            }
            var model = new UserBLL().GetUserBasicInfoModelByTelNo(mobilePhone);
            if (model == null)
            {
                Response.Write("{\"result\":\"-1\",\"msg\":\"手机号未在团贷网注册\"}");
                Response.End();
            }
            string err ="";
            var ulist = RedisServerStack.StringGet<List<account_manager.WeiXinUser>>(TdConfig.ApplicationName, "/redis/web",
                GlobalUtils.OpenId, ref err);
            if (ulist != null && ulist.Exists(o => o.UserId == model.Id))
            {
                Response.Write("{\"result\":\"-3\",\"msg\":\"账号已在微信绑定列表中\"}");
                Response.End();
            }
            var result = new CodeRecordBLL().IsCanSendNewCodeRecord(mobilePhone, MsCodeType.PhoneCode, MsCodeType2.BindWeiXinOpenId, model.Id);
            if (!result.Success)
            {
                Response.Write("{\"result\":\"" + result.Code.ToString() + "\",\"msg\":\"" + result.Message + "\"}");
                Response.End();
            }
            var code = new CodeRecordBLL().CreateCodeRecordInfo(model.Id, "", MsCodeType.PhoneCode, MsCodeType2.BindWeiXinOpenId, mobilePhone);
            if (code != null)
            {
                var parameters = new Dictionary<string, object>();
                parameters.Add("ValidateCode", code.Code);
                var msgSender = new BusinessDll.MessageSend();
                msgSender.SendMessage2(option: SendOption.Sms, eventCode: MessageTemplates.ValidateCode, parameters: parameters, mobile: mobilePhone);
                Response.Write("{\"result\":\"1\",\"msg\":\"已发送，3分钟后可重新获取。\"}");
                Response.End();
            }
            else
            {
                Response.Write("{\"result\":\"0\",\"msg\":\"验证码发送失败，请重试。\"}");
                Response.End();
            }
        }
    }
}