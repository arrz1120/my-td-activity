using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using System.Configuration;

namespace TuanDai.WXApiWeb.pages.invest
{
    /// <summary>
    /// 标详情跳转页面
    /// Allen 2015-08-03
    /// </summary>
    public partial class detail : BasePage
    {
        protected Guid? projectId = Guid.Empty;
        protected string backUrl = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/Member/Repayment/my_return_list.aspx?typeTab=Disperse&tab=CompletedAndFlow",true);
            this.projectId = WEBRequest.GetGuid("id");
            backUrl = WEBRequest.GetQueryString("backurl");
            if (this.projectId != Guid.Empty)
            {
                string tdfrom = Request.QueryString["tdfrom"];
                string DOMAINNAME = ConfigurationManager.AppSettings["CookieDomain"];
                //第三方跳投标地址记录来源信
                if (!string.IsNullOrEmpty(tdfrom))
                {
                    if (!string.IsNullOrEmpty(CookieHelper.GetCookie("tdfrom")))
                    {
                        Tool.CookieHelper.ClearCookie("tdfrom");
                    }
                    Tool.CookieHelper.WriteCookie(DOMAINNAME, "tdfrom", tdfrom, 24 * 60 * 7);//保存7天
                }
                string url="";
                ProjectBLL bll = new ProjectBLL();
                ProjectDetailInfo projectInfo = bll.GetProjectDetailInfo(projectId.Value);
                if (projectInfo != null)
                {

                    #region
                    switch (projectInfo.Type)
                    {
                        //项目借款
                        case 1:
                        case 3:
                            {
                                url = string.Format("/pages/invest/invest_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        //净股
                        case 6:
                        case 7:
                            {
                                url = string.Format("/pages/invest/jing_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        //微团贷
                        case 9:
                        case 10:
                        case 11:
                        case 34://新房贷
                        case 200:
                        case 26:
                        case 40://一点车贷
                            {
                                url = string.Format("/pages/invest/mini_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        //团贷宝
                        case 5:
                            {
                                url = string.Format("/pages/invest/bao_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        case 12:
                            {
                                url = string.Format("/pages/invest/fangbaobao_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        case 15:
                            {
                                //当为分期宝时
                                WXFQUserApplyInfo FQUserApplyInfo = null;
                                if (projectInfo != null && (projectInfo.Type ?? 0) == 15)
                                    FQUserApplyInfo = bll.WXGetFQUserApplyInfo(projectId.Value.ToString());

                                if (FQUserApplyInfo.OrgTypeId != null && FQUserApplyInfo.OrgTypeId != 5)
                                    url = string.Format("/pages/invest/fqbao_detail.aspx?projectid={0}", this.projectId);
                                else
                                    url = string.Format("/pages/invest/fqle_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        case 16:
                        case 17:
                            {
                                url = string.Format("/pages/invest/bond_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        case 18:
                        {
                            url = string.Format("/pages/invest/simubao_detail.aspx?projectid={0}", this.projectId);
                            break;
                        }
                        case 19:
                        {
                            url = string.Format("/pages/invest/gylds_detail.aspx?projectid={0}", this.projectId);
                            break;
                        }
                        case 20: //供应链标
                            {
                                url = string.Format("/pages/invest/gyl_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        case 22:
                        case 23:
                            {
                                url = string.Format("/pages/invest/xmb_detail.aspx?projectid={0}", this.projectId);
                                break;
                            }
                        case 24://消费金融
                        case 25://正合小贷业务
                        case 42:
                            url = string.Format("/pages/invest/puhui_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 27://你我金融----话费分期
                            url = string.Format("/pages/invest/huafei_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 28://快来贷
                            url = string.Format("/pages/invest/kuailaidai_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 29://沐金农
                            url = string.Format("/pages/invest/mjn_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 30://极速借
                            url = string.Format("/pages/invest/jisujie_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 32://有信贷
                            url = string.Format("/pages/invest/youxindai_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 36://农饲贷
                            url = string.Format("/pages/invest/nsd_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 39://车全
                            url = string.Format("/pages/invest/chequan_detail.aspx?projectid={0}", this.projectId);
                            break; 
                        case 41://二手车商
                            url = string.Format("/pages/invest/twocar_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 48://扶贫贷
                            url = string.Format("/pages/invest/fupin_detail.aspx?projectid={0}", this.projectId);
                            break;
                        case 31: //拿下分期标
                        case 46://
                        case 45://
                        case 44:
                        case 43:
                        case 35:
                        case 33:
                            url = "/pages/invest/invest_list.aspx?v=20171216";
                            break;
                        default:
                            url = string.Format("/pages/invest/invest_detail.aspx?projectid={0}", this.projectId);
                            break;
                    }
                    #endregion
                }
                else
                {
                    //债权转证
                    ProjectZQZRDetailInfo model = new SubScriberansferBLL().GetSubScriberansfer(projectId.Value);
                    if (model != null)
                        url = string.Format("/pages/invest/zqzr_detail.aspx?projectid={0}", this.projectId);
                }
                if (url != "")
                    url += "&backurl=" + backUrl.Replace(" ", "+");
                Response.Redirect(GlobalUtils.MTuanDaiURL + url);
            }
            else
            {
                Response.Redirect(GlobalUtils.WebURL);
            }
        }
    }
}