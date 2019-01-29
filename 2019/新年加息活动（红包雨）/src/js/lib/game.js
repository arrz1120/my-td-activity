import {
    Scene,
    Sprite,
    Group
} from '../lib/spritejs.2.19.min.js'
import {rem} from '../lib/util.js'

const WINDOW_WIDTH = document.documentElement.clientWidth
const WINDOW_HEIGHT = document.documentElement.clientHeight
const angle = 20

let hbSrc = __DEV__? require('../../assets/images/hb.png'): `//at.tuandai.com${window.webUrlPrefix}/redEnvelopeRain/images/hb.png`

export default class Game {
    constructor(vm) {
        this.vm = vm
        this.hb = {
            width: rem(132),
            height: rem(162),
            imgSrc: hbSrc
        }
        this.posStore = []
        this.arrX = []
        this.xIndex = 0
        this.init()
    }
    init() {
        this.scene = new Scene('#canvas', {
            viewport: [WINDOW_WIDTH, WINDOW_HEIGHT],
            resolution: [WINDOW_WIDTH, WINDOW_HEIGHT],
            displayRatio: 1,
        })
        this.layer = this.scene.layer()
        this.group = new Group()
        this.group.attr({
            size: [WINDOW_WIDTH, WINDOW_HEIGHT],
        })
        this.layer.append(this.group)
        this.setX()
        this.createSprite()
    }
    createSprite(){
        const {width, height, imgSrc} = this.hb
        for(var i=0;i<30;i++){
            var hb = new Sprite(imgSrc)
            var x0 = this.getX()
            // var y0 = -height - i * Math.max(height,Math.random()*height*2)
            var y0 = -height
            var d0 = i*350 + 100*Math.random()
            this.posStore.push({
                x: x0,
                y: y0,
                delay: d0
            })
            hb.attr({
                anchor: [0.5, 0.5],
                pos: [x0, y0],
                size: [width, height],
                rotate: angle,
            })
            this.group.append(hb)
        }
    }
    gamePlay(){
        const {width, height, imgSrc} = this.hb
        let hb = this.group.children
        hb.forEach((item,index) => {
            let store = this.posStore[index]
            let animation
            let y1 = WINDOW_HEIGHT + height
            let x1 = store.x - y1 * Math.tan(angle * Math.PI / 180)
            let isClick = false
            animation = item.animate([{
                x: store.x,
                y: store.y
            },
            {
                x: x1,
                y: y1
            }],{
                easing:'linear',
                delay: store.delay,
                duration: 2000,
                fill: 'forwards'
            })
            item.on('touchstart', (evt) => {
                if(isClick) return
                isClick = true
                if(animation) animation.cancel()
                this.vm.counter += 1
                animation = item.animate([{
                        opacity: 1,
                        x: evt.x,
                        y: evt.y
                    },
                    {
                        opacity: 0,
                        x: evt.x + 1,
                        y: evt.y - 1
                    },
                ], {
                    duration: 200,
                    fill: 'forwards',
                    easing: 'linear'
                })
            })
            animation.finished.then(() => {
                item.remove()
            })
        })
    }
    setX(){
        let {width} = this.hb
        let minX = WINDOW_WIDTH/2
        let maxX = WINDOW_WIDTH + this.hb.width
        const pad = width/3
        const length = Math.floor((maxX - minX) / pad)
        for(var i=0;i<=length;i++){
            this.arrX.push(Math.floor(minX + i*pad))
        }
    }
    getX() {
        let arr = []
        let length = this.arrX.length
        for(var i=0;i<length;i++){
            if(i !== this.xIndex){
                arr.push(i)
            }
        }
        let x = Math.floor(Math.random() * arr.length)
        return this.arrX[x]
    }
    end() {
        this.group.clear()
    }
}
