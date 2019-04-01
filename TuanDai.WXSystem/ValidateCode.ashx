<%@ WebHandler Language="C#" Class="ValidateCode" %>

using System;
using System.Web;
using System.Drawing;
using System.Web.SessionState;
using NetDimension.Web;
using Tool;

public class ValidateCode : IHttpHandler , IRequiresSessionState{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = System.DateTime.Now.AddSeconds(-1);
        context.Response.Expires = 0;
        context.Response.CacheControl = "no-cache";
        context.Response.AppendHeader("Pragma", "No-Cache");

        #region 获取文字验证码
        int CodeCount = 4;
        string allChar = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,i,J,K,M,N,P,Q,R,S,T,U,W,X,Y,Z";
        string[] allCharArray = allChar.Split(',');
        string RandomCode = "";
        int temp = -1;

        Random rand = new Random();
        for (int i = 0; i < CodeCount; i++)
        {
            if (temp != -1)
            {
                rand = new Random(temp * i * ((int)DateTime.Now.Ticks));
            }

            int t = rand.Next(33);

            while (temp == t)
            {
                t = rand.Next(33);
            }

            temp = t;
            RandomCode += allCharArray[t];
        }
        string checkCode = RandomCode;
        #endregion
        context.Session["webcheckcode"] = checkCode;
        CookieHelper.WriteCookie("tuandai005", Encryption.MD5(checkCode.ToLower()));
        //Cookie cookie = new Cookie("webcheckcode", 5, TimeUnit.Minute);
        //cookie.Encrypt = true;
        //cookie["webcheckcode"] = checkCode;
        #region 输出验证码
        
        int iwidth = (int)(checkCode.Length * 14);
        System.Drawing.Bitmap image = new System.Drawing.Bitmap(iwidth, 20);
        Graphics g = Graphics.FromImage(image);
        Font f = new System.Drawing.Font("Arial ", 10);
        Brush b = new System.Drawing.SolidBrush(Color.Black);
        Brush r = new System.Drawing.SolidBrush(Color.FromArgb(166, 8, 8));

        g.Clear(System.Drawing.ColorTranslator.FromHtml("#99C1CB"));//背景色

        char[] ch = checkCode.ToCharArray();
        for (int i = 0; i < ch.Length; i++)
        {
            if (ch[i] >= '0' && ch[i] <= '9')
            {
                //数字用红色显示
                g.DrawString(ch[i].ToString(), f, r, 3 + (i * 12), 3);
            }
            else
            {   //字母用黑色显示
                g.DrawString(ch[i].ToString(), f, b, 3 + (i * 12), 3);
            }
        }
        System.IO.MemoryStream ms = new System.IO.MemoryStream();
        image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
        //history back 不重复 
        context.Response.Cache.SetNoStore();//这一句 		
        context.Response.ClearContent();
        context.Response.ContentType = "image/Jpeg";
        context.Response.BinaryWrite(ms.ToArray());
        g.Dispose();
        image.Dispose();
        
        #endregion
    }

   
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}