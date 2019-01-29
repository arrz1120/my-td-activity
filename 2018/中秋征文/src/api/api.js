import axios from 'axios'
import '../js/lib/toast'

axios.defaults.baseURL=__DEV__?'/mock/midAutumnSolicitArticle': window.webUrlPrefix + '/midAutumnSolicitArticle'
axios.defaults.timeout=8000
axios.interceptors.response.use(function (res) {
  if(res.status===200){
    return res.data
  }
  return res
}, function (error) {
  return Promise.reject(error)
})

function showErr(err) {
  let msg = ''
  if (err.response) {
    let code = err.response.data.code
    if(code) {
      if(code === 'ACTIVITY_NOT_START') msg = '活动未开始'
      if(code === 'ACTIVITY_FINISHED') msg = '活动已结束'
      if(code === 'TOO_MANY_OPERATE_ERROR') msg = '未登录'
      if(code === 'BLANK_TITLE') msg = '标题为空'
      if(code === 'BLANK_NICK_NAME') msg = '昵称为空'
      if(code === 'BLANK_CONTENT') msg = '内容为空'
      if(code === 'TOOLONG_TITLE') msg = '标题过长'
      if(code === 'TOOLONG_NICK_NAME') msg = '昵称过长'
      if(code === 'TOOLONG_CONTENT') msg = '正文字数超过1000'
      if(code === 'BLANK_ARTICLE_ERROR') msg = '文章不存在'
      if(code === 'BLANK_QUESTION') msg = '谜语为空'
      if(code === 'BLANK_ANSWER') msg = '谜底为空'
      if(code === 'TOOLONG_QUESTION') msg = '谜语过长'
      if(code === 'TOOLONG_ANSWER') msg = '谜底过长'
    }else{
      msg = '网络开小差喔，请稍后再试~'
    }
  } 
  toast.show(msg,2000,() => {
    // window.location.reload()
  })
}

module.exports={
  getArticleData(){
    return new Promise((resolve,reject) => {
      axios.get('/articles')
      .then(res => {
        resolve(res)
      })
      .catch(err => {
        if(err.response){
          if(err.response.data.code === 'NETWORK_EXCEPTION_ERROR'){
            reject(err.response.data)
          } else {
            showErr(err)
          }
        }else{
          reject(err)
        }
      })
    })
  },

  awardListData(){
    return new Promise((resolve,reject) => {
      axios.get('/carousels')
      .then(res => {
        resolve(res)
      })
      .catch(err => {
        if(err.response){
          if(err.response.data.code === 'NETWORK_EXCEPTION_ERROR'){
            reject(err.response.data)
          } else {
            showErr(err)
          }
        }else{
          reject(err)
        }
      })
    })
  },

  getInitStatus() {
    return new Promise((resolve,reject) => {
      axios.get('/initStatus')
      .then(res => {
        resolve(res)
      })
      .catch(err => {
        if(err.response){
          if(err.response.data.code === 'NETWORK_EXCEPTION_ERROR'){
            reject(err.response.data)
          } else {
            showErr(err)
          }
        }else{
          reject(err)
        }
      })
    })
  },

  praise(id) {
    return new Promise((resolve,reject) => {
      axios({
        method: 'post',
        url: '/praise',
        params: {
          articleId: id,
        }
      })
      .then(res => {
        resolve(res)
      })
      .catch(err => {
        if(err.response){
          if(err.response.data.code === 'NETWORK_EXCEPTION_ERROR'){
            reject(err.response.data)
          } else {
            showErr(err)
          }
        }else{
          reject(err)
        }
      })
    })
  },

  lanternRiddle(question,answer) {
    return new Promise((resolve,reject) => {
      axios.post('/lanternRiddle', {
        question: question,
        answer: answer
      })
      .then(res => {
        resolve(res)
      })
      .catch(err => {
        if(err.response){
          if(err.response.data.code === 'NETWORK_EXCEPTION_ERROR'){
            reject(err.response.data)
          } else {
            showErr(err)
          }
        }else{
          reject(err)
        }
      })
    })
  },

  sendArticle(param) {
    let {nickName,title,article} = param
    return new Promise((resolve,reject) => {
      axios.post('/article', {
        nickName: nickName,
        title: title,
        content: article
      })
      .then(res => {
        resolve(res)
      })
      .catch(err => {
        if(err.response){
          if(err.response.data.code === 'NETWORK_EXCEPTION_ERROR'){
            reject(err.response.data)
          } else {
            showErr(err)
          }
        }else{
          reject(err)
        }
      })
    })
  }
}

