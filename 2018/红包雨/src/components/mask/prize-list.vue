<template>
    <div class="prize-list">
        <div class="list-container">
            <ul v-if="listData.length">
                <li v-for="(item,index) in listData" :class="{'active':item.jiaxi}" :key="index">
                    <div class="item">{{item.prizeName}}</div>
                    <div class="item">{{item.drawDate}}</div>
                </li>
            </ul>
            <div v-else class="no-data"></div>
        </div>
    </div>
</template>

<script>
export default {
    props: ['listData']
}
</script>


<style lang="scss" scoped>
    .prize-list{
        @include wh(650,698);
        @include bg('../../assets/images/prize-list.png');
        text-align: center;
        padding-top: rem(230);
        padding-left: rem(84);
        padding-right: rem(120);
    }
    .list-container{
        height: rem(345);
        overflow-y: auto;
        overflow-x: hidden;
        li{
            display: flex;
            align-items: center;
            height: rem(69);
            border-bottom: 1px dashed #f67eb9;
            .item{
                flex: 1;
                text-align: center;
                color: #fff;
                font-size: rem(22);
            }
        }
        .active{
            .item{
                color: #fde157;
            }
        }
    }
    .no-data{
        width: 100%;
        height: 100%;
        background: url('../../assets/images/no-data.png') center no-repeat;
        background-size: rem(224) rem(231);
        margin-left: rem(20);
    }
</style>

