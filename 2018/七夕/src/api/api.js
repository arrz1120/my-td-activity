import axios from 'axios'

axios.defaults.timeout=20000
axios.defaults.baseURL= process.env.NODE_ENV === 'development'?'': window.webUrlPrefix
axios.defaults.withCredentials=true;

if(process.env.NODE_ENV === 'development') {
    // document.cookie = 'td_visitorId=3cbef711-1bff-2644-f763-7c91c889898d;td_exit_flag=1;'
    // document.cookie = 'Hm_lvt_6dff67da4e4ef03cccffced8222419de=1532596086,1533043993,1533106272,1533181564;'
    // document.cookie = 'TDLastLoginDate=2018-08-02yong22;'
    // document.cookie = 'TDNickName=yong22;'
    // document.cookie = 'TDWUserName=yong22;'
    // document.cookie = 'TDW_WapUserName=yong22;'
    // document.cookie = 'tuandaim=nguO%2B3EFBnQYMFjLkpT%2FHUPeWt8l6XH5;'
    // document.cookie = 'tuandaiw=bew6K1uOyNTm59BB7P4bnHrKYll9v61txuXJASFGHhfWmca4ArpC8%2B%2F5FvjiQ3CUmVyC7yqAo1ug2PYuRHqOuyCNpDG7x9jx;'
    // document.cookie = 'tuandaiwexin=bew6K1uOyNTm59BB7P4bnHrKYll9v61txuXJASFGHhewQdykpsROew%3D%3D;'
    // document.cookie = 'sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22yong22%22%2C%22%24device_id%22%3A%22164d5d84ba7343-0de814e495c0a4-2d604637-304500-164d5d84ba8379%22%2C%22props%22%3A%7B%22%24latest_traffic_source_type%22%3A%22%E7%9B%B4%E6%8E%A5%E6%B5%81%E9%87%8F%22%2C%22%24latest_referrer%22%3A%22%22%2C%22%24latest_referrer_host%22%3A%22%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC_%E7%9B%B4%E6%8E%A5%E6%89%93%E5%BC%80%22%2C%22PlatformType%22%3A%22TDW_WAP%22%7D%2C%22first_id%22%3A%22164d5d84ba7343-0de814e495c0a4-2d604637-304500-164d5d84ba8379%22%7D;'
    // document.cookie = 'td_half_sessionId=64de6fcd-1d69-a316-aca5-26aba3951772;'
    // document.cookie = 'Hm_lpvt_6dff67da4e4ef03cccffced8222419de=1533181677;'
    // document.cookie = '_td_st=1533181690228'
}


axios.interceptors.response.use(function (response) {
    if(response.status===200){
        return response.data;
    }
    return response;
  }, function (error) {
    return Promise.reject(error);
  });

function formatUrl(ip,api) {
    if(process.env.NODE_ENV === 'development'){
        return ip + api
    }else{
        return api
    }
}

export function getIndexInfo(){
    let url = formatUrl('/api',"/chinaValentineDay2018/indexInfo")
    return  axios({
        method:'get',
        url: url
    })
}

export function getLuckTreasurePrize(df) {
    let url = formatUrl('/api',"/chinaValentineDay2018/getLuckTreasurePrize")
    return  axios({
        method:'get',
        url: url,
        params: {
            drawFlag: df
        }
    })
}

export function postMsg(flag){
    let url = formatUrl('/zhengtengfei',"/chinaValentineDay2018/sendInviteMessage")
    return  axios({
        url: url,
        params: {
            flag: flag
        }
    })
}

export function getDetailItem(){
    let url = formatUrl('/api',"/chinaValentineDay2018/getDetailItem")
    return  axios({
        method:'get',
        url: url
    })
}

export function getInviteList(){
    let url = formatUrl('/api',"/chinaValentineDay2018/getInviteList")
    return  axios({
        method:'get',
        url: url
    })
}

export function getShareTicket(){
    let url = formatUrl('/api',"/chinaValentineDay2018/getShareTicket")
    return  axios({
        method:'get',
        url: url
    })
}

export function getVaildCoin(){
    let url = formatUrl('/api',"/chinaValentineDay2018/getVaildCoin")
    return  axios({
        method:'get',
        url: url
    })
}

export function getTuanbiTicket(){
    let url = formatUrl('/api',"/chinaValentineDay2018/getTuanbiTicket")
    return  axios({
        method:'get',
        url: url
    })
}

export function getFlag(){
    let url = formatUrl('/api',"/chinaValentineDay2018/getFlag")
    return  axios({
        method:'get',
        url: url
    })
}
