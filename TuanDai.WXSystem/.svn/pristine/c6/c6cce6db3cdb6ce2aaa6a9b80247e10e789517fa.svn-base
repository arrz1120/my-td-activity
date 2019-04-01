using System;
using Newtonsoft.Json;
using Tool;
using TuanDai.CunGuanTong.Client;
using TuanDai.CunGuanTong.Model;
using TuanDai.WXSystem.Core;

namespace TuanDai.WXApiWeb.Member.cgt
{
    public partial class trade_pwd : UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Do();
            }
        }

        private void Do()
        {
            try
            {
                string returnUrl = Request["returnurl"];
                string type = Request["type"];
                string content = Request["content"];
                string time = Request["t"];//对请求时间加密

                if (string.IsNullOrEmpty(returnUrl))
                {
                    if (Request.UrlReferrer != null)
                        returnUrl = Request.UrlReferrer.ToString();
                    else
                        returnUrl = GlobalUtils.WebURL;
                }
                Guid? userid = WebUserAuth.UserId;
                if (!userid.HasValue || userid.Value == Guid.Empty)
                {
                    Response.Redirect(returnUrl);
                    return;
                }

                if (content == "")
                {
                    Response.Redirect(returnUrl);
                    return;
                }
                content = Tool.DESC.HexToString(content);
                if (string.IsNullOrEmpty(content))
                {
                    Response.Redirect(returnUrl);
                    return;
                }

                if (string.IsNullOrEmpty(time))
                {
                    Response.Redirect(returnUrl);
                    return;
                }
                time = Tool.DESC.Decrypt(Tool.DESC.HexToString(time));
                DateTime dtFrom;
                DateTime.TryParse(time, out dtFrom);
                if ((DateTime.Now - dtFrom).TotalSeconds > 10)
                {
                    Response.Redirect(returnUrl);
                    return;
                }

                CgtCallBackConfig.CgtCallBackType cgtType = (CgtCallBackConfig.CgtCallBackType) int.Parse(type);
                string cgturl = CheckPwd(userid.Value, content, cgtType);

                if (!string.IsNullOrEmpty(cgturl))
                {
                    Response.Redirect(cgturl);
                }
            }
            catch (Exception ex)
            {
            }
        }

        private string CheckPwd(Guid userid, string content, CgtCallBackConfig.CgtCallBackType type)
        {
            CHECK_PASSWORD_Request request = new CHECK_PASSWORD_Request();
            CHECK_PASSWORD_Req_Td reqTd = new CHECK_PASSWORD_Req_Td();

            //ProductId｜BuyQty｜RepeatInvestType
            request.callbackUrl = CgtCallBackConfig.GetCgtCallBackUrl(type);

            request.platformUserNo = userid.ToString();
            request.userDevice = userDevice.MOBILE;

            reqTd.applicationid = 3;
            reqTd.businessid = Guid.NewGuid();
            reqTd.content = content;
            reqTd.mCHECK_PASSWORD_Request = request;
            

            switch (type)
            {
                case CgtCallBackConfig.CgtCallBackType.WeInvest:
                    string productName = Request["pname"];
                    if (string.IsNullOrEmpty(productName)) productName = "WE计划";
                    request.bizTypeDescription = "您正在购买" + GetWePlanTitle(productName);
                    reqTd.typeid = 4;
                    break;
                case CgtCallBackConfig.CgtCallBackType.TransferInvest:
                    request.bizTypeDescription = "您正在购买债权转让";
                    reqTd.typeid = 2;
                    break;
                case CgtCallBackConfig.CgtCallBackType.ProjectInvest:
                    string projectTypeName = Request["ptype"];
                    int projectTypeId;
                    int.TryParse(projectTypeName, out projectTypeId);
                    projectTypeName = TypeIdToTitle(projectTypeId);
                    request.bizTypeDescription = "您正在购买" + projectTypeName;
                    reqTd.typeid = 2;
                    break;
                case CgtCallBackConfig.CgtCallBackType.WeFqbPreExit:
                    request.bizTypeDescription = "您正在进行提前退出申请";
                    reqTd.typeid = 6;
                    break;
                case CgtCallBackConfig.CgtCallBackType.EndProject:
                    request.bizTypeDescription = "您正在进行结束发标";
                    reqTd.typeid = 5;
                    break;
                case CgtCallBackConfig.CgtCallBackType.ApplyZqzr:
                    request.bizTypeDescription = "您正在进行债权转让申请";
                    reqTd.typeid = 10;
                    break;
                case CgtCallBackConfig.CgtCallBackType.Withdraw:
                    request.bizTypeDescription = "您正在进行提现申请";
                    reqTd.typeid = 8;
                    break;
                case CgtCallBackConfig.CgtCallBackType.ModifyTradePwdStatus:
                    bool isTenderNeedPayPassword = false;
                    if (!string.IsNullOrEmpty(content))
                    {
                        var req = JsonConvert.DeserializeObject<CgtCallbackUrl.Model.ModelRequest.UpdatePayPwdStatusRequest>(content);
                        isTenderNeedPayPassword = req.IsTenderNeedPayPassword;
                    }
                    request.bizTypeDescription = string.Format("您正在进行{0}交易密码",isTenderNeedPayPassword?"开启":"关闭");
                    reqTd.typeid = 7;
                    break;
                case CgtCallBackConfig.CgtCallBackType.Prepayment:
                    request.bizTypeDescription = "您正在进行提前还款申请";
                    reqTd.typeid = 3;
                    break;
                case CgtCallBackConfig.CgtCallBackType.FTBPreExit:
                    request.bizTypeDescription = "复投宝提前退出交易密码验证";
                    reqTd.typeid =11;
                    break;
            }

            string rtn = UserClient.CHECK_PASSWORD_Req_Td(reqTd);
            return rtn;
        }

        /// <summary>
        /// 标类型ID转换成对应的标类型
        /// </summary>
        /// <param name="typeId"></param>
        /// <returns></returns>
        string TypeIdToTitle(int typeId)
        {

            string title = string.Empty;

            switch (typeId)
            {
                case 1:
                case 3:
                    {
                        title = "小微企业";
                        break;
                    }
                case 6:
                    {
                        title = "资产标";
                        break;
                    }
                case 9:
                    {
                        title = "车贷";
                        break;
                    }
                case 11:
                    {
                        title = "房贷";
                        break;
                    }
                case 15:
                case 24:
                case 25:
                case 26:
                case 27:
                case 28:
                case 29:
                    {
                        title = "分期宝";
                        break;
                    }
                case 18:
                    {
                        title = "私募宝";
                        break;
                    }
                case 19:
                case 20:
                    {
                        title = "供应链";
                        break;
                    }
                case 22:
                case 23:
                    {
                        title = "项目宝";
                        break;

                    }
                case 99:
                    {
                        title = "债权转让";
                        break;
                    }
                default:
                    {
                        title = "其它";
                        break;

                    }
            }
            return title;
        }

        string GetWePlanTitle(string productName)
        {
            return productName.GetCharLeft("(");
        }
    }
}