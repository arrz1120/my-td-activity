import '../sass/jizong.scss'
import { h, render, Component } from 'preact'
import Rule from "../js/components/rule/rule"
import Footer from "../js/components/footer/footer"
import Share from "../js/components/appShare/appShare"
import Toast from '../js/components/toast/toast'


let state = {
}

let doms = {
  dhAlert: $('#dh-alert'),
}


let methods = {
  showAlert: function (obj) {
    let tit = obj.tit,
      type = obj.type,
      lBtn = obj.lBtn || null,
      rBtn = obj.rBtn || null,
      cBtn = obj.cBtn || null,
      rBtnDom = doms.dhAlert.find('.btn-right');
    this.hide = function () {
      doms.dhAlert.hide();
    };


    doms.dhAlert.find('.btn').hide().unbind('click');
    tit && doms.dhAlert.find('.tit').html(tit);
    type && doms.dhAlert.find('.alert-type-img').attr('class', 'alert-type-img ' + type);

    if (lBtn) {
      doms.dhAlert.find('.btn-left').html(lBtn.txt).show().on('click', (e) => {
        e.preventDefault();
        console.log(this);
        lBtn.cb && lBtn.cb.call(this);
      })
    }


    if (cBtn) {
      doms.dhAlert.find('.btn-center').html(cBtn.txt).show().on('click', (e) => {
        e.preventDefault();
        cBtn.cb && cBtn.cb.call(this);
      })

    }

    if (rBtn) {
      rBtnDom.html(rBtn.txt).show().on('click', (e) => {
        e.preventDefault();
        rBtn.cb && rBtn.cb.call(this);
      })
      if (rBtnDom.find('.small').length) {
        rBtnDom.addClass('btn-newline');
      }else{
        rBtnDom.removeClass('btn-newline');
      }
    }

    doms.dhAlert.show();


  }







}


$('#dh-alert').on('touchmove',function (e) {
  e.preventDefault();
});







window.method = methods;

render(
  <Footer index="1" />,
  document.body
)
render(
  <Rule index="1" />,
  document.body
)


render(
  <Share />,
  document.body
)


render(
  <Toast/>,
  document.body
)