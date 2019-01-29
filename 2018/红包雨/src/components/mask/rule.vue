<template>
    <div class="rule">
        <p class="mask-p">12月3日-12月17日期间，用户每日首次进入活动页，可获得一次参与红包雨游戏的机会，分享后可再次获得一次。每次游戏时间8S，将根据用户击中红包的个数奖励相应的奖品份数。</p>
        <div class="table">
            <table>
                <tbody>
                    <tr>
                        <th>击中红包个数</th>
                        <th>可获奖品份数</th>
                    </tr>
                    <tr>
                        <td>0~14个</td>
                        <td>1</td>
                    </tr>
                    <tr>
                        <td>15个及以上</td>
                        <td>2</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <p class="mask-p">首次参加该游戏中会额外赠送一个1218网贷爱心日0.1%的加息特权的惊喜彩蛋。</p>
    </div>
</template>

<style lang="scss" scoped>
    .rule{
        @include wh(650,742);
        @include bg('../../assets/images/rule.png');
        padding: rem(160) rem(68) 0 rem(68);

    }
    .mask-p{
        color: #fff;
        line-height: rem(40);
        font-size: rem(24);
        text-align: justify;
    }
    .table{
        width: rem(494);
        margin: rem(30) auto;
        table{
            width: 100%;
        }
        tr{
            color: #fff;
        }
        th{
            font-size: rem(24);
            font-weight: bold;
            padding: rem(21) 0;
            text-align: center;
            border: 1px solid #fff;
            background: linear-gradient(to right,#ff9d68,#ff6f00);
        }
        td{
            font-size: rem(24);
            padding: rem(21) 0;
            text-align: center;
            border: 1px solid #fff;
        }
    }
</style>

