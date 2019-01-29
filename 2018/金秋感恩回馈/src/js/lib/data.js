let awardData = [{
    rank: "第1名",
    amo: '2888'
},{
    rank: "第2名",
    amo: '1688'
},{
    rank: "第3名",
    amo: '688'
},{
    rank: "第4-6名",
    amo: '258'
},{
    rank: "第7-10名",
    amo: '108'
}]

let awardLayout = ''
awardData.forEach(item => {
    awardLayout += `
    <div class="swiper-slide">
        <p class="rank">${item.rank}</p>
        <div class="hb">
            <p class="hb-p1">${item.amo}</p>
            <p class="hb-p2">现金红包</p>
        </div>
    </div>
    `
})

export default awardLayout