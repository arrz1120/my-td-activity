const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const urlencodedParser = bodyParser.urlencoded({ extended: false })

app.get('/zxRanking201808/getAwardList', (req, res) => {
    let data = {
      "code": "SUCCESS",
      "data": [{
        "activityCode": "WE_Promote_Invest_201808",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-27",  // 上榜日期
        "rankIndex": 1, // 排名
        "activityPrizeId": 12223,
        "prizeName": "微软Surface Go 二合一平板电脑", // 获取奖品
       },
       {
        "activityCode": "WE_Promote_Invest_201808",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-27",
        "rankIndex": 1,
        "activityPrizeId": 12223,
        "prizeName": "1888现金红包",
       },
       {
        "activityCode": "WE_Promote_Invest_201808",
        "userId": "EEE1AB3B-925D-4D6A-962D-B5AE1468F3D2",
        "rankDate": "2018-07-28",
        "rankIndex": 1,
        "activityPrizeId": 12224,
        "prizeName": "888现金红包",
       }
      ],
      "message": "服务正常调用"
    }
    // data.data = []
    res.send(data)
})

app.get('/zxRanking201808/getReturnMoneyList', (req, res) => {
    let data = {
      "code": "SUCCESS",
      "data": [{
        "amountStr": "￥153,168", // 投资金额
        "prizeDesc": "￥888", // 奖励金额
        "rankDate": "2018-07-28",  // 奖励日期
       },
       {
       "amountStr": "￥99,153,168", // 投资金额
        "prizeDesc": "￥1888", // 奖励金额
        "rankDate": "2018-07-27",  // 奖励日期
       },
       {
        "amountStr": "￥53,168", // 投资金额
        "prizeDesc": "￥588", // 奖励金额
        "rankDate": "2018-07-29",  // 奖励日期
       }
      ],
      "message": "服务正常调用"
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