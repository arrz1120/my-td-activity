//借款端神策js

/*
    数据上报地址：
    正式地址：https://sensordata.tdw.cn/segmentation/?project=tdwloan
    测试地址：https://sensordata.tdw.cn/segmentation/?project=tdwloantest

*/

import sa from 'sa-sdk-javascript'

window.sa = sa

const project = 'tdwloantest'

sa.init({
    //配置打通 App 与 H5 的参数
    use_app_track: true,
    //数据接收地址
    server_url: `https://sensorslog.tdw.cn/sa?project=${project}`,
})
sa.quick('autoTrack')