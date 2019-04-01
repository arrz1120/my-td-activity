/**
 * 
 * @param {String||domNode} el:锁定节点
 * @return {
 *  lock():锁定滚动条
 *  unloack():解锁滚动条
 * }  
 */
let fixedScroll=function(el){
  let scrollTop;
  el=typeof el ==='string'?document.querySelector(el):el;
  let {cssText}=el.style;
  return{
    lock(){
      scrollTop=window.scrollY;
      el.style.cssText=`position:fixed;top:0;left:0;bottom:0;right:0;transform:translateY(-${scrollTop}px);-webkit-transform:translateY(-${scrollTop}px);${cssText}`;
    },
    unlock(){
      el.style.cssText=cssText;
      window.scrollTo(0,scrollTop) ;
    }
  }
};
if(typeof module==="object"&&typeof module.exports==="object"){
  module.exports=fixedScroll;
}else{
  window.fixedScroll=fixedScroll;
}
