class SinglePageJustify{
    constructor(dom,percent){
        this.ele = $(dom);
        this.per = percent;
        this.init();
    }
    init(){
        if(this.ele.length>1){
            this.ele.each((item)=>{
                this.render($(item));
            })
        }else{
            this.render(this.ele);
        }
    }
    render(item){
        let conHei= item.outerHeight();
        let per=winH * this.per/ conHei;
        if(per<1){
            item.css({
                webkitTransformOrigin: 'center top',
                transformOrigin: 'center top',
                webkitTransform:`scale(${per},${per})`,
                transform:`scale(${per},${per})`
            })
        }
    }
}

export default SinglePageJustify;