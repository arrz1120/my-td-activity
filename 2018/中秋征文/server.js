const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const urlencodedParser = bodyParser.urlencoded({
  extended: true
})

// app.use(bodyParse.json())

app.get('/midAutumnSolicitArticle/carousels', (req, res) => {
  let data = [{
    "type": 1,
    "name": "6",
    "prizeName": "38元投资红包"
  }, {
    "type": 1,
    "name": "6",
    "prizeName": "0.88元现金红包"
  }, {
    "type": 1,
    "name": "6",
    "prizeName": "0.88元现金红包"
  }, {
    "type": 1,
    "name": "6",
    "prizeName": "0.88元现金红包"
  }, {
    "type": 1,
    "name": "6",
    "prizeName": "0.88元现金红包"
  }, {
    "type": 1,
    "name": "6",
    "prizeName": "0.88元现金红包"
  }]
  // data = []
  res.send(data)
})

app.get('/midAutumnSolicitArticle/initStatus', (req, res) => {
  let data = {
    "loginFlag": false,
    "activityEndFlag": false,
    "pageUrlPrefix": "http://at.tuandai.com/midAutumnSolicitArticle/"
  }
  res.send(data)
})

app.get('/midAutumnSolicitArticle/articles', (req, res) => {
  let data = [{
    "nickName": "aaa",
    "headImage": "//js.tuandai.com/images/default/default.jpg?v=20151231",
    "title": "月圆中秋 寄相思",
    "content": "思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。",
    "praise": 1,
    "id": 2,
    "praiseFlag": true
  }
  // , {
  //   "nickName": "h1",
  //   "headImage": "",
  //   "title": "中秋往事",
  //   "content": "test content",
  //   "praise": 1,
  //   "id": 3,
  //   "praiseFlag": false
  // }, {
  //   "nickName": "h1",
  //   "headImage": "//js.tuandai.com/images/default/default.jpg?v=20151231",
  //   "title": "中秋往事",
  //   "content": "test content",
  //   "praise": 1,
  //   "id": 4,
  //   "praiseFlag": true
  // }, {
  //   "nickName": "h1",
  //   "headImage": "",
  //   "title": "中秋往事",
  //   "content": "test content",
  //   "praise": 0,
  //   "id": 5,
  //   "praiseFlag": false
  // }
]
  // data = []
  res.send(data)
})

app.post('/midAutumnSolicitArticle/praise', (req, res) => {
  if (!req.query.articleId) {
    res.status(400).send({
      code: 'BLANK_ARTICLE_ERROR',
      message: '文章不存在'
    })
  } else {
    res.send({
      "praiseNum": 1
    })
  }
})

let count = 0
app.post('/midAutumnSolicitArticle/lanternRiddle', (req, res) => {
  // console.log(req.query)
  // if (!req.query.question) {
  //   res.status(400).send({
  //     code: 'BLANK_ARTICLE_ERROR'
  //   })
  // } 
  // else if(!req.query.answer){
  //   res.status(400).send({
  //     code: 'BLANK_ARTICLE_ERROR'
  //   })
  // }
  // else {
  //   count += 1
  //   res.send({
  //     "type": 1,
  //     "prizeName": "10元红包",
  //     "submitCount": count
  //   })
  // }
  count += 1
    res.send({
      "type": 1,
      "prizeName": "10元红包",
      "submitCount": count
    })
})

// app.post('/midAutumnSolicitArticle/lanternRiddle', urlencodedParser,  (req, res) => {
//   console.log(req.query)
//   if (!req.body) return res.sendStatus(400)
//   res.send('welcome, ' + req.body.username)
// })

app.post('/midAutumnSolicitArticle/article', (req, res) => {
    res.send({"id":1})
})


app.listen(3000, () => {
  console.log('listening at 3000...')
})