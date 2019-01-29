export default class HeightAdaptation {
    constructor(dom,conHeightPercent) {
        this.conHeightPercent = conHeightPercent
        this.ele = dom
        this.scale = 1
        return this
    }
    render() {
        let winH = window.innerHeight;
        let dom = document.querySelectorAll(this.ele)
        let conHei = dom[0].getBoundingClientRect().height
        let scale = window.innerHeight * this.conHeightPercent / conHei
        if (scale < 1) {
            this.scale = scale
            dom = [].slice.apply(dom)
            dom.forEach((item) => {
                item.style.webkitTransformOrigin = item.style.transformOrigin = 'center top'
                item.style.webkitTransform = item.style.transform = `scale(${scale},${scale})`
            })
        }
        return this
    }
}
