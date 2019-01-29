import '../sass/caidan.scss'
import "../js/lib/winScroller.min.js"
import {h,render} from 'preact';
import Toast from "../js/components/toast/toast";
import Textarea from "../js/lib/textarea";

new Textarea(50);

function updateList(dataM) {

  var allMsg = '';


  for (var i=0;i<dataM.length;i++) {

    // console.log(dataM[key].imgUrl);

    var tmpLi = `<li>
                  <div class="user">
                      <img src=${dataM[i].imgUrl} alt="" class="user-img">
                      <p class="name">${dataM[i].name}</p>
                  </div>
                  <p class="time">${dataM[i].time}投稿</p>
                  <p class="word">${dataM[i].word}</p>
                </li>`;

                allMsg +=tmpLi;

    }
    // console.log(allMsg);
    $('#msgList').append(allMsg);
}

window.updateList = updateList;

render(
  <Toast />,
  document.body
);

$(".alert-bg").on("touchmove", function (e) {
  e.preventDefault();
}).on("click", function () {
  $(this).parent().hide();
})
$(".close").on("click", function () {
  $(this).parent().parent().hide(); 
})

$(".alert-banmove").on("touchmove", function (e) {
  e.preventDefault();
})



