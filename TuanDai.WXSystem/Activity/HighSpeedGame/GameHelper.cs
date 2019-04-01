using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TuanDai.WXApiWeb.Activity
{
    /// <summary>
    /// 高铁游戏操作类
    /// Allen 2015-06-11
    /// </summary>
    public class GameHelper
    {
        #region 初始化
        private Dictionary<int, List<ExamSubjectInfor>> GameExamDict = null;
        private static GameHelper _Instance = null;
        private GameHelper() {
            GameExamDict = new Dictionary<int, List<ExamSubjectInfor>>();
            this.InitExam();
        }
        public static GameHelper Instance {
            get {
                if (_Instance == null) {
                    _Instance = new GameHelper();
                }
                return _Instance;
            }
        }
        #endregion

        private Random rand = new Random((int)DateTime.Now.Ticks);
        /// <summary>
        /// 随机产生一份题目
        /// </summary>
        /// <param name="subjectType"></param>
        /// <returns></returns>
        public ExamSubjectInfor RandomOneSubject(int subjectType)
        {
            int rIndex = rand.Next(4);
            if (rIndex < 1 || rIndex > 4)
                rIndex = 1;
            List<ExamSubjectInfor> dataList = GameExamDict[subjectType];
            return dataList[rIndex - 1];
        }
        /// <summary>
        /// 判断题目是否答对 -1:题目不存在 0:答错了 1:正确
        /// </summary>
        /// <param name="examId"></param>
        /// <param name="answer"></param>
        /// <returns></returns>
        public int CheckAnswerIsRight(int examId, string answer) {
            ExamSubjectInfor examObj = null;
            foreach (var Item in GameExamDict) {
                examObj = Item.Value.Where(p => p.ExamId == examId).FirstOrDefault();
                if (examObj != null) {
                    break;
                }
            }
            if (examObj == null) 
                return -1;
            return examObj.RightAnswer.ToUpper() == answer.ToUpper() ? 1 : 0;
        }
         
        #region 题目清单
        private void InitExam()
        {
            GameExamDict.Clear();
            //人物篇
            #region
            List<ExamSubjectInfor> personList = new List<ExamSubjectInfor>();
            personList.Add(new ExamSubjectInfor()
            {
                ExamId= 1001,
                Title = "/Activity/HighSpeedGame/imgs/tx1.png",
                AnswerA = "来自星星的他",
                AnswerB = "Jack Ma",
                AnswerC = "阿里巴巴创始人",
                AnswerD = "中国最慷慨的慈善家之一",
                RightAnswer = "A"
            });
            personList.Add(new ExamSubjectInfor()
            {
                ExamId = 1002,
                Title = "/Activity/HighSpeedGame/imgs/tx2.png",
                AnswerA = "85后青年创业者",
                AnswerB = "中国第一职业经理人",
                AnswerC = "团贷网创始人唐军",
                AnswerD = "以超200万天价拍下商界传奇人物的午餐3小时",
                RightAnswer = "B"
            });
            personList.Add(new ExamSubjectInfor()
            {
                ExamId = 1003,
                Title = "/Activity/HighSpeedGame/imgs/tx3.png",
                AnswerA = "CCTV中国经济年度人物",
                AnswerB = "巨人网络董事局主席史玉柱",
                AnswerC = "著名武打演员",
                AnswerD = "团贷网大咖团队战略指导师",
                RightAnswer = "C"
            });
            personList.Add(new ExamSubjectInfor()
            {
                ExamId = 1004,
                Title = "/Activity/HighSpeedGame/imgs/tx4.png",
                AnswerA = "知名栏目记者",
                AnswerB = "优米网创办人王利芬",
                AnswerC = "著名国画师",
                AnswerD = "团贷网高级专家顾问团成员",
                RightAnswer = "C"
            });

            GameExamDict.Add(1, personList);
            #endregion

            //算术篇
            #region
            List<ExamSubjectInfor>  arithList = new List<ExamSubjectInfor>();
            arithList.Add(new ExamSubjectInfor()
            {
                ExamId = 2001,
                Title = "小明（对，又是小明）投资8万元到一个项目标，年收益18%，投资期限1年，请问，他的心理阴影有多大？",
                AnswerA = "1.44万元",
                AnswerB = "1.22万元",
                AnswerC = "9999元",
                AnswerD = "你在逗我吗？",
                RightAnswer = "A"
            });
            arithList.Add(new ExamSubjectInfor()
            {
                ExamId = 2002,
                Title = "小红投资20万元到一个项目标，年收益18%，投资期限1年，请问，小红大约可以买下多少苹果6？",
                AnswerA = "2台",
                AnswerB = "7台",
                AnswerC = "买苹果不卖肾，我都不好意思说出来",
                AnswerD = "15台",
                RightAnswer = "B"
            });
            arithList.Add(new ExamSubjectInfor()
            {
                ExamId = 2003,
                Title = "小红投资5000元到一个项目标，年收益18%，投资期限1年，请问，小红预期收益有多少？",
                AnswerA = "500元",
                AnswerB = "900元",
                AnswerC = "你猜",
                AnswerD = "200元",
                RightAnswer = "B"
            });
            arithList.Add(new ExamSubjectInfor()
            {
                ExamId = 2004,
                Title = "小明投资2万元到一个项目标，年收益18%，投资期限1年，请问，小明预期收益有多少？",
                AnswerA = "1500元",
                AnswerB = "2500元",
                AnswerC = "3600元",
                AnswerD = "4500元",
                RightAnswer = "C"
            });
            GameExamDict.Add(2, arithList);
            #endregion

            //Logo篇
            #region
            List<ExamSubjectInfor> pictureList = new List<ExamSubjectInfor>();
            pictureList.Add(new ExamSubjectInfor()
            {
                ExamId = 3001,
                Title = "以下哪个logo姿势正确？",
                AnswerA = "/Activity/HighSpeedGame/imgs/logo1-a.png",
                AnswerB = "/Activity/HighSpeedGame/imgs/logo1-b.png",
                AnswerC = "/Activity/HighSpeedGame/imgs/logo1-c.png",
                AnswerD = "/Activity/HighSpeedGame/imgs/logo1-d.png",
                RightAnswer = "C"
            });
            pictureList.Add(new ExamSubjectInfor()
            {
                ExamId = 3002,
                Title = "以下哪个logo姿势正确？",
                AnswerA = "/Activity/HighSpeedGame/imgs/logo2-a.png",
                AnswerB = "/Activity/HighSpeedGame/imgs/logo2-b.png",
                AnswerC = "/Activity/HighSpeedGame/imgs/logo2-c.png",
                AnswerD = "/Activity/HighSpeedGame/imgs/logo2-d.png",
                RightAnswer = "D"
            });
            pictureList.Add(new ExamSubjectInfor()
            {
                ExamId = 3003,
                Title = "以下哪个logo姿势正确？",
                AnswerA = "/Activity/HighSpeedGame/imgs/logo3-a.png",
                AnswerB = "/Activity/HighSpeedGame/imgs/logo3-b.png",
                AnswerC = "/Activity/HighSpeedGame/imgs/logo3-c.png",
                AnswerD = "/Activity/HighSpeedGame/imgs/logo3-d.png",
                RightAnswer = "A"
            });
            pictureList.Add(new ExamSubjectInfor()
            {
                ExamId = 3004,
                Title = "以下哪个logo姿势正确？",
                AnswerA = "/Activity/HighSpeedGame/imgs/logo4-a.png",
                AnswerB = "/Activity/HighSpeedGame/imgs/logo4-b.png",
                AnswerC = "/Activity/HighSpeedGame/imgs/logo4-c.png",
                AnswerD = "/Activity/HighSpeedGame/imgs/logo4-d.png",
                RightAnswer = "B"
            });
            GameExamDict.Add(3, pictureList);
            #endregion
        }
        #endregion 
       

    }

    public class ExamSubjectInfor {
        /// <summary>
        /// 题目ID，用于计算答案
        /// </summary>
        public int ExamId { get; set; }
        /// <summary>
        /// 题目标题（或者图片URL）
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// 选项A
        /// </summary>
        public string AnswerA { get; set; }
        /// <summary>
        /// 选项B
        /// </summary>
        public string AnswerB { get; set; }
        /// <summary>
        /// 选项C
        /// </summary>
        public string AnswerC { get; set; }
        /// <summary>
        /// 选项D
        /// </summary>
        public string AnswerD { get; set; }

        //正确答案
        public string RightAnswer { get; set; }
    }


}