class Textarea{

    constructor(maxLength){
        this.isCnInput = false;
        this.txtLen = 0;
        this.ta = $("#textarea");
        this.holder = $(".holder");
        this.ticker = $(".ticker").find('span');
        this.toastDom = $('.msg-toast');
        this.holderEvent();
        this.showLength(maxLength);
    }

    androidFoucs(){
        if(mobileUtils.isAndroid && Jsbridge.isApp()) $('.alert-con').css('transform', 'translateY(-5rem)');
    }

    androidBlur(){
        if(mobileUtils.isAndroid && Jsbridge.isApp()) $('.alert-con').css('transform', 'translateY(0)');
    }

    holderEvent(){
        this.holder.on('click',()=>{
            this.ta.focus();
        })
    }

    showLength(maxLength){
        this.ta.on('compositionstart', ()=> {
            this.isCnInput = true;
        }).on('compositionend', ()=>{
            this.isCnInput = false;
            this.setLength(maxLength);
        }).on('input', (e)=> {
            if(this.isCnInput) return;
            this.setLength(maxLength);
        }).on('focus',()=>{
            this.androidFoucs();
            if(this.ta.val()==""){
                this.holder.fadeOut();
            }
        }).on('blur',()=>{
            this.androidBlur();
            if(this.ta.val()==""){
                this.holder.fadeIn();
            }
        })
    }

    formatVal(val){
        if(val == 0){
            return 0
        }else{
            return val<10 ? "0" + val : val;
        }
    }

    setLength(maxLength){
        this.txtLen = this.ta.val().length;
        if(this.txtLen > maxLength) {
            this.txtLen = maxLength;
        }
        this.ticker.html(this.formatVal(this.txtLen));
    }

}

export default Textarea;