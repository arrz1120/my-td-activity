export function setAxiosDefaultConfig(axios){
    axios.defaults.baseURL=__DEV__?'/mock':''
    axios.defaults.timeout=8000
    axios.interceptors.response.use(function (res) {
    if(res.status===200){
        return res.data
    }
    return res
    }, function (error) {
    return Promise.reject(error)
    })
}

export const pageHost = 'https://at.tuandai.com'

export const apiPrefix = `${window.webUrlPrefix}/newYearsRaiseInterest/`