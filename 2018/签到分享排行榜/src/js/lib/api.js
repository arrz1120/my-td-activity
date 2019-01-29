const axios = require('axios')
var iHost=''
// var webUrlPrefix = iHost+"/userActivity"
var webUrlPrefix = "/api"

function getUserIndexInfo() {
    $.ajax({
        async: false,
        type: 'get',
        url: 'https://www.baidu.com',
        dataType: "json",
        // headers: {
        //     referer: 'https://at.tuandai.com/userActivity/sczdLottery/draw',
        //     host: 'at.tuandai.com'
        // },
        success: function (returnJsonData) {
            console.log(returnJsonData)
        },
        error: function () {
            toast.show("人数火爆，稍后再试！");
        }
    })
}

// getUserIndexInfo()

// var url = 'https://at.tuandai.com/userActivity/sczdLottery/draw'
// axios.get(url, {
//     headers: {
//         referer: 'https://at.tuandai.com/userActivity/sczdLottery/draw',
//         host: 'at.tuandai.com'
//     }
// }).then((response) => {
//     console.log(response.data)
// }).catch((e) => {
//     console.log(e)
// })