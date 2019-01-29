const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const urlencodedParser = bodyParser.urlencoded({ extended: false })

//登录接口
app.get('/activity/riddleGame/isLogin', (req, res) => {
  let data = {
    code: "0",
    data: true,
    msg: "string"
  }
  res.send(data)
})
//获取用户答题状态接口
app.get('/activity/riddleGame/getUserResult', (req, res) => {
    let data = {
      "data": {
          "score": 10, //答对题数
          "attendStatus": 0 //0：正常，-1：已答完所有，-2：答错暂停，-3：超时暂停
       },
      "code": 200
    }
    res.send(data)
})
//获取题目
//传入参数: userId
app.get('/activity/riddleGame/getQuestion', (req, res) => {
    let data = {
      "data": {
          "question": "降落伞",
          "tips": '打一三国人名',
          "time": 20
       },
      "code": 200
      }
    res.send(data)
})
//分享获得抽奖机会
//传入参数: userId
app.get('/activity/riddleGame/shareActivity', (req, res) => {
    let data = {
      "code": 200
      }
    res.send(data)
})
//获取用户答题状态接口
//传入参数: answer
app.post('/activity/riddleGame/submitAnswer', (req, res) => {
    let data = {
      "data": {
          "answer": "p2p",
          "correct": false,
          "drawn": false
       },
      "code": 200
      }
    res.send(data)
})
//用户抽奖接口
app.post('/activity/riddleGame/lotteryDraw', (req, res) => {
    let data = {
      "data": 3,
      "code": 200
      }
    res.send(data)
})
//获取答题排行榜接口
app.get('/activity/riddleGame/findRankList', (req, res) => {
    let data = {
      "data": [
            {
            "phone":'138****8000',
            "score":200
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            },
            {
            "phone":'138****8001',
            "score":100
            }
        ],
      "code": 200
      }
    res.send(data)
})
//查询是否活动期间接口
app.get('/activity/riddleGame/checkActivityDate', (req, res) => {
    let data = {
      "code": 200
      }
    res.send(data)
})
//获取中奖记录接口
app.get('/activity/riddleGame/getLotteryRecordList', (req, res) => {
    let data = {
      "code": 200,
      "data": [{
              "phone": "135****8785",
              "prizeName": "3元现金红包",
              "createTime": "09-19 11:10"
          },
          {
              "phone": "137****8782",
              "prizeName": "10元投资红包",
              "createTime": "09-19 10:14"
          },
          {
              "phone": "135****8711",
              "prizeName": "155元现金红包",
              "createTime": "09-19 10:14"
          },
          {
              "phone": "135****8710",
              "prizeName": "18元投资红包",
              "createTime": "09-19 10:13"
          },
          {
              "phone": "135****8783",
              "prizeName": "15元现金红包",
              "createTime": "09-19 10:12"
          },
          {
              "phone": "135****8781",
              "prizeName": "5元投资红包",
              "createTime": "09-19 10:10"
          },
          {
              "phone": "135****8712",
              "prizeName": "500元现金红包",
              "createTime": "09-19 09:10"
          },
          {
              "phone": "135****8786",
              "prizeName": "50团币",
              "createTime": "09-19 10:19"
          },
          {
              "phone": "135****8789",
              "prizeName": "300团币",
              "createTime": "09-19 10:15"
          },
          {
              "phone": "135****8788",
              "prizeName": "500团币",
              "createTime": "09-19 10:13"
          },
          {
              "phone": "135****8787",
              "prizeName": "100团币",
              "createTime": "09-19 10:11"
          }
      ]
  }
    res.send(data)
})

//获取初始状态接口
app.get('/activity/riddleGame/getInitStatus', (req, res) => {
    console.log(req)
    let data = {
        "data": {
            "login": true,
            "underway": true,
            "userResultDTO": {
                "score": 10, 
                "attendStatus": 0
            }
        },
        "code": 200
    }
    res.send(data)
})
//获取用户上一道答题信息接口
app.get('/activity/riddleGame/getLastRiddle', (req, res) => {
    let data = {
        "data": {"question": "高台对映月分明",
                 "tips": "打一字",
                 "answer": "昙"
                 },
        "code": 200
        }
    res.send(data)
})


app.post('/login', urlencodedParser,  (req, res) => {
    if (!req.body) return res.sendStatus(400)
    res.send('welcome, ' + req.body.username)
})

app.listen(3000,() => {
    console.log('listening at 3000...')
})