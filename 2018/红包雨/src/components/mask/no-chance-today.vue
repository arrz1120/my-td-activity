<template>
    <div class="no-chance-today">
        <p class="mask-p">活动期间，用户每天登录即可获得一次游戏<br />
           机会，分享活动可再获得一次游戏机会，每<br />
           个用户每天最多可获得两次游戏机会。请明<br />
           天继续哦~
        </p>
    </div>
</template>

<style lang="scss" scoped>
    .no-chance-today{
        @include wh(650,455);
        @include bg('../../assets/images/mask-no-chance-today.png');
        text-align: center;
        padding-top: rem(190);
    }
    .mask-p{
        color: #fff;
        line-height: rem(40);
        font-size: rem(24);
        text-align: center;
    }
</style>

