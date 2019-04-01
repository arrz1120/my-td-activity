using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using Newtonsoft.Json;
using Tool;
using TuanDai.PortalSystem.DAL;
using TuanDai.WXApiWeb.Common;

namespace TuanDai.WXApiWeb.Activity
{
    public partial class CreateQRPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCreateQR_Click(object sender, EventArgs e)
        {
            this.txtQRUrl.Text = string.Empty;
            this.ImageQR.ImageUrl = "";
            if (this.txtPassword.Text.Equals("createQRAdministrator"))
            {
                if (string.IsNullOrEmpty(this.txtSourceFrom.Text.Trim()) || this.txtSourceFrom.Text.Trim().Length > 59)
                {
                    JavaScript.Alert("推广渠道填写错误，最多60个字，不能空白");
                }
                #region 先判断以前有没有，有就直接返回
                const string querySql = "select * from [dbo].[WXQRInfos] where sourceFrom =@sourceFrom order by AddDate desc ";
                var param = new DynamicParameters();
                param.Add("@SourceFrom", this.txtSourceFrom.Text.Trim());

                var wxQrInfos =PublicConn.QueryActivityBySql<WXQRInfo>(querySql,ref param);
                if (wxQrInfos.Count >=1)
                {
                    this.txtQRUrl.Text = wxQrInfos.FirstOrDefault().QrUrl;
                    this.ImageQR.ImageUrl = "http://s.jiathis.com/qrcode.php?url=" + wxQrInfos.FirstOrDefault().QrUrl;
                    JavaScript.Alert("已经生成过这样的推广二维码了哦！");
                    return;
                }

                #endregion
                #region  调用接口获取
                ThirdLoginSDK sdk = new ThirdLoginSDK();
                sdk.InitSDK(ThirdLoginSDK.ThirdLoginType.WeiXin);
                var wxQr = sdk.GetWXQrInfoBy(this.txtSourceFrom.Text);
                if (wxQr != null)
                {
                    this.txtQRUrl.Text = wxQr.url;
                    const string insertSql = @"insert into [dbo].[WXQRInfos]([Id],[SourceFrom],[AddDate],[QrUrl],[Ticket])
                                                values (@Id,@SourceFrom,@AddDate,@QrUrl,@Ticket)";

                    var param2 = new DynamicParameters();
                    param2.Add("@Id", Guid.NewGuid());
                    param2.Add("@SourceFrom", this.txtSourceFrom.Text);
                    param2.Add("@AddDate", DateTime.Now);
                    param2.Add("@QrUrl", wxQr.url);
                    param2.Add("@Ticket", wxQr.ticket);

                    PublicConn.ExecuteActivity(insertSql,ref param2); 
                    this.ImageQR.ImageUrl = "http://s.jiathis.com/qrcode.php?url=" + wxQr.url;
                }
                #endregion
            }
            else
            {
                Jscript.Alert("请输入正确的管理员密码");
            }
        }

    }

    public class WXQRInfo
    {
        public Guid Id { get; set; }
        public string SourceFrom { get; set; }
        public DateTime AddDate { get; set; }
        public string QrUrl { get; set; }
        public string Ticket { get; set; }
    }

    public class TwoCode
    {
        public string[] code { get; set; }
        public string base64 { get; set; }
    }
}