const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const urlencodedParser = bodyParser.urlencoded({ extended: false })

app.get('/midAutumn/getUserDrawCount', (req, res) => {
    let data = {
      userDrawCount: 0,
      shared: true,
      usedCount: false
    }
    res.send(data)
})

app.get('/midAutumn/getFuDaiList', (req, res) => {
    let data = [
      {"prizeDesc":"150元投资红包","name":"173****0315"},
      {"prizeDesc":"2.0%加息券","name":"173****0315"}
      
      ]
    // data.data = []
    res.send(data)
})

app.get('/midAutumn/getUserFuDaiList', (req, res) => {
    let data = [
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"100元投资红包","drawDate":"09-10 18:30"},
      {"prizeDesc":"50元投资红包","drawDate":"09-10 18:30"}
      ]
    data = []
    res.send(data)
})

app.get('/midAutumn/weRank/getAwardList', (req, res) => {
    let data = {
      "code": "SUCCESS",
      "data": [{
        "activityCode": "midAutumn_WE_Rank",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-27",  // 上榜日期
        "rankIndex": 1, // 排名
        "activityPrizeId": 12223,
        "prizeName": "1888现金红包", // 获取奖品
       },
       {
        "activityCode": "midAutumn_WE_Rank",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-27",
        "rankIndex": 2,
        "activityPrizeId": 12223,
        "prizeName": "1888现金红包",
       },
       {
        "activityCode": "midAutumn_WE_Rank",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-28",
        "rankIndex": 3,
        "activityPrizeId": 12224,
        "prizeName": "888现金红包",
       },
       {
        "activityCode": "midAutumn_WE_Rank",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-28",
        "rankIndex": 4,
        "activityPrizeId": 12224,
        "prizeName": "888现金红包",
       },
       {
        "activityCode": "midAutumn_WE_Rank",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-28",
        "rankIndex": 5,
        "activityPrizeId": 12224,
        "prizeName": "888现金红包",
       }
      ],
      "message": "服务正常调用"
    }
    // data.data = []
    // data = {
    //   "code": "FAIL",
    //   "data": null,
    //   "message": "网络异常, 请关闭页面后，重新打开"
    // }
    res.send(data)
})

app.post('/midAutumn/toFuDaiDraw', (req, res) => {
  // console.log(req)
  // if (req.query.type === 0) {
  //   res.send({
  //     "prizeName": "2.0%加息券",
  //     "prizeUrl": "2.png",
  //     "typeId": 1,
  //     "leftDrawCount": 0
  //   })
  // } 
  // else if (req.query.type === 1) {
  //   res.send({
  //     "prizeName": "100元投资红包",
  //     "prizeUrl": "2.png",
  //     "typeId": 1,
  //     "leftDrawCount": 0
  //   })
  // }
  // let data = {
  //   code: 'FUDAI_DRAW_COUNT_SHARED'
  // }
  // res.status(609).send(data)
  res.send({
    "prizeName": "100元投资红包",
    "prizeUrl": "2.png",
    "typeId": 1,
    "leftDrawCount": 0,
    "usedCount":true

  })
})


app.post('/login', urlencodedParser,  (req, res) => {
    if (!req.body) return res.sendStatus(400)
    res.send('welcome, ' + req.body.username)
})

app.listen(3000,() => {
    console.log('listening at 3000...')
})