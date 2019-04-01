using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using ThoughtWorks.QRCode.Codec;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Text;
using Dapper;
using Tool;


namespace TuanDai.WXApiWeb.pages
{
    public partial class APPCreateImage : System.Web.UI.Page
    {
        int functionType = Tool.SafeConvert.ToInt32(Tool.WEBRequest.GetString("functionType"));
        string tdfrom = Tool.WEBRequest.GetString("tdfrom");
        string extendkey = Tool.WEBRequest.GetString("extendkey");
        public string headImage = "/imgs/users/avatar/bav_head.gif";
        public bool isEnable = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect(GlobalUtils.WebURL + "/pages/APPCreateImage.aspx?functionType=" + functionType + "&tdfrom=" + tdfrom + "&extendkey="+extendkey);
            if (functionType != 0)
            {
                string strSQL = "SELECT [ShareUrl] FROM dbo.SharedSetting(nolock) WHERE IsEnabled=1 AND functionType=@functionType and ShareToolType=7 order by SEQUENCE";
                string shareUrl = string.Empty;
                DynamicParameters whereParams = new DynamicParameters();
                whereParams.Add("@functionType", functionType);

                shareUrl = PublicConn.QueryActivitySingle<string>(strSQL, ref whereParams);
                shareUrl = shareUrl.ToText();

                shareUrl = shareUrl + (string.IsNullOrEmpty(tdfrom) ? "" : string.Format("?tdfrom={0}", tdfrom));
                shareUrl += string.IsNullOrEmpty(extendkey) ? "" : (string.IsNullOrEmpty(tdfrom) ? "?" : "&") + string.Format("extendkey={0}", extendkey);
                shareUrl = shareUrl + "&type=mobileapp";
                string imageShareUrl = APPCreateImageBase64Str(shareUrl);
                Image2.ImageUrl = imageShareUrl;
                Image2.Visible = string.IsNullOrEmpty(imageShareUrl) ? false : true;

                if (!string.IsNullOrEmpty(imageShareUrl))
                {
                    isEnable = true;
                    string strHeadImageSQL = "SELECT HeadImage FROM UserBasicInfo(nolock)  WHERE  ExtendKey=@ExtendKey";
                    DynamicParameters HeadImageParams = new DynamicParameters();
                    HeadImageParams.Add("@ExtendKey", extendkey);
                    string headImageUrl = string.Empty;

                    headImageUrl = PublicConn.QuerySingle<string>(strHeadImageSQL, ref HeadImageParams);

                    headImage = !string.IsNullOrEmpty(headImageUrl) ? headImageUrl : headImage;
                }
            }
            else
            {
                Image2.Visible = false;
            }
            
        }

        /// <summary>
        /// add by linhelin
        /// 生成二维码
        /// 2016-06-18
        /// </summary>
        /// <param name="url">活动地址</param>
        /// <returns>二维码Base64</returns>
        public string APPCreateImageBase64Str(string url)
        {
            QRCodeEncoder qrCodeEncoder = new QRCodeEncoder();
            qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
            qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
            qrCodeEncoder.QRCodeVersion = 0;
            qrCodeEncoder.QRCodeScale = 4;
            //将字符串生成二维码图片
            Bitmap image = qrCodeEncoder.Encode(url, Encoding.Default);

            //保存为PNG到内存流  
            MemoryStream ms = new MemoryStream();
            image.Save(ms, ImageFormat.Png);

            byte[] arr = new byte[ms.Length];
            ms.Position = 0;
            ms.Read(arr, 0, (int)ms.Length);
            ms.Close();
            string strbaser64 = Convert.ToBase64String(arr);
            return "data:image/png;base64," + strbaser64;
        }
    }
}