const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const urlencodedParser = bodyParser.urlencoded({ extended: false })

const data = {
  "code": "SUCCESS",
  "message": "服务正常调用",
  "data": {
    "webUrlPrefix": "",
    "unReadCount": 5,
    "xiQueTotalCount": 20,
    "userDrawPrizeList": [
      {
        "boxType": "A",
        "boxStatus": 2,
        "prizeId": "2685",
        "prizeName": "58团币"
      },
      {
        "boxType": "B",
        "boxStatus": 2,
        "prizeId": "2695",
        "prizeName": "10元投资红包"
      }
    ],
    "userItemStatusList": {
      "item_1": 1,
      "item_2": 1,
      "item_3": 1,
      "item_4": 1,
      "item_5": 1
    },
    "logined": true
  }
}
app.get('/chinaValentineDay2018/indexInfo', (req, res) => {
    res.send(data)
})

app.get('/chinaValentineDay2018/getVaildCoin', (req, res) => {
  res.send({
    "code": "SUCCESS",
    "message": "服务正常调用",
    "data": 4614
  })
})

app.get('/chinaValentineDay2018/getFlag', (req, res) => {
  res.send({
    "code": "SUCCESS",
    "message": "服务正常调用",
    "data": 'SUCCESS'
  })
})

app.get('/chinaValentineDay2018/getShareTicket', (req, res) => {
  res.send({
    "code": "SUCCESS",
    "message": "服务正常调用",
    "data": "SUCCESS_ACQUIRE"
  })
})

app.get('/chinaValentineDay2018/getLuckTreasurePrize', (req, res) => {
    let param = req.query.drawFlag
    let data
    if(param == 'CHINAVALENTINEDAY2018_TREAS1_DRAW_FLAG'){
      data = {
        "userId":"08e09c58-d65d-44fa-81e4-215934a3936b",
        "prizeName":"18团币",
        "prizeId":2695,
        "prizeValue":10,
        "typeId":1,
        "leftTicketCount":10,
        "drawnRecId":104221
      }
    }
    else{
      data = {
        "userId":"08e09c58-d65d-44fa-81e4-215934a3936b",
        "prizeName":"20元投资红包",
        "prizeId":2695,
        "prizeValue":10,
        "typeId":1,
        "leftTicketCount":10,
        "drawnRecId":104221
      }
    }
    res.send({
      "code":"SUCCESS",
      "message":"服务正常调用",
      "data":data
  })
})

app.get('/chinaValentineDay2018/getTuanbiTicket', (req, res) => {
  res.send({
    "code": "SUCCESS",
    "message": "服务正常调用",
    "data": "SUCCESS"
  })
})

app.get('/chinaValentineDay2018/getInviteList', (req, res) => {
  res.send({
    "code": "SUCCESS",
    "message": "服务正常调用",
    "data": [
          {
              "flag": "E382A2226094DA11",
              "registerTime": "7-19",
              "phoneNum": "186****2012",
              "realName": "忘情",
              "invite": false,
              "send": false
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": false,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            },
            {
              "flag": "703EA213BF422864",
              "registerTime": "7-19",
              "phoneNum": "186****6666",
              "realName": "186****6666",
              "invite": true,
              "send": true
            }
      ]
  })
})

app.get('/chinaValentineDay2018/getDetailItem', (req, res) => {
  res.send({
    "code": "SUCCESS",
    "message": "服务正常调用",
    "data": {
      "status": 1,
      "xiQueDrawInfoList": [
        {
          "desc": "邀请好友投资",
          "drawDate": "08-03"
        },
        {
          "desc": "邀请好友注册",
          "drawDate": "08-03"
        },
        {
          "desc": "消耗200团币",
          "drawDate": "08-03"
        },
        {
          "desc": "单笔投资≥5000元",
          "drawDate": "08-03"
        },
        {
          "desc": "分享活动",
          "drawDate": "08-03"
        },
        {
          "desc": "分享活动",
          "drawDate": "08-03"
        },
        {
          "desc": "分享活动",
          "drawDate": "08-03"
        },
        {
          "desc": "分享活动",
          "drawDate": "08-03"
        }
      ]
    }
  })
})

app.post('/login', urlencodedParser,  (req, res) => {
    if (!req.body) return res.sendStatus(400)
    res.send('welcome, ' + req.body.username)
  })

app.listen(3000,() => {
    console.log('listening at 3000...')
})