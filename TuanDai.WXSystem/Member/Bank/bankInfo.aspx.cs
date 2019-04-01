using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;
using TuanDai.PortalSystem.Model;
using TuanDai.PortalSystem.BLL;
using TuanDai.WXSystem.Core.Common;
using TuanDai.WXSystem.Core.models;

namespace TuanDai.WXApiWeb.Member.Bank
{
    public partial class bankInfo : UserPage
    {
        protected string bankName = string.Empty;
        protected string bankImg = string.Empty;
        protected string bankNo = string.Empty;
        protected string bankProvice = string.Empty;
        protected string bankCity = string.Empty;
        protected string openBankName = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            Guid userid = WebUserAuth.UserId.Value;
            GetBankInfo(userid);
        }

        private void GetBankInfo(Guid userid)
        {
            if (GlobalUtils.IsBankService)
            {
                var bankInfoFromJava = new BankFromJavaService().GetBankInfo(userid, ServiceType.TuoMin);
                if (bankInfoFromJava != null && bankInfoFromJava.respData != null)
                {
                    bankNo = bankInfoFromJava.respData.bankNo;
                    bankProvice = bankInfoFromJava.respData.bankProvice;
                    bankCity = bankInfoFromJava.respData.bankCity;
                    openBankName = bankInfoFromJava.respData.openBankName;
                    bankName = bankInfoFromJava.respData.bankName;
                    bankImg = bankInfoFromJava.respData.imgUrl;
                }
                else
                {
                    Response.Redirect("/Member/cgt/cgtBindCard.aspx");
                }
            }
            else
            {
                var basicInfo = new UserBLL().GetUserBasicInfoModelById(userid);
                if (basicInfo != null)
                {
                    bankNo = basicInfo.BankAccountNo;
                    bankProvice = basicInfo.BankProvice;
                    bankCity = basicInfo.BankCity;
                    openBankName = basicInfo.OpenBankName;
                    bankImg = GlobalUtils.GetBankImg(basicInfo.Id, out bankName);
                }
                else
                {
                    Response.Redirect("/Member/cgt/cgtBindCard.aspx");
                }
            }
            if (string.IsNullOrEmpty(bankNo))
            {
                Response.Redirect("/Member/cgt/cgtBindCard.aspx");
            }
        }
    }
}