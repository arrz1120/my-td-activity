const express = require('express')
const axios = require('axios')

const app = express()
const apiRoutes = express.Router()

// apiRoutes.get('/getDiscList', function (req, res) {
//     var url = 'https://c.y.qq.com/splcloud/fcgi-bin/fcg_get_diss_by_tag.fcg'
// })
var url = 'https://at.tuandai.com/userActivity/signIncrIncRank/indexInfo'
axios.get(url, {
    headers: {
        referer: 'https://at.tuandai.com/userActivity/signIncrIncRank/index',
        host: 'at.tuandai.com'
    }
}).then((response) => {
    console.log(response.data)
}).catch((e) => {
    console.log(e)
})