import '../sass/pageCover.scss'

import $ from 'jquery'
import '../js/lib/alert'
import '../js/lib/share'
import {Login} from '../js/lib/bridge'
import Promise from 'promise-polyfill'

window.Promise = Promise

window.$ = window.Q = $

$('.link-btn').on('click',function(){
    location.href = `${window.location.origin}${window.webUrlPrefix}/thanksgivingAutumn/weRank/index`
})

$('.goToLogin').on('click',function(){
    $('#loginAlert').hide();
    Login()
})
