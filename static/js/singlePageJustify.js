/**
 * 用于单屏页面内容高度大于屏幕高度是，缩小内容高度以适应屏幕高度
 * @param:
 *  dom: string dom className
 *  conHeightPercent: float类型 设置内容高度缩小后占屏幕高度的百分比
 *  
 */

export default class HeightJustify {
    constructor(dom,conHeightPercent) {
        this.conHeightPercent = conHeightPercent
        this.ele = dom
        this.render()
    }
    render() {
        const winH = window.innerHeight;
        const dom = document.querySelectorAll(this.ele)
        dom = [].slice.apply(dom)
        dom.forEach((item) => {
            let conHei = item.getBoundingClientRect().height
            let scale = Math.min(winH*this.conHeightPercent/conHei,1)
            item.style.webkitTransformOrigin = item.style.transformOrigin = 'center top'
            item.style.webkitTransform = item.style.transform = `scale(${scale},${scale})`
        })
    }
}
