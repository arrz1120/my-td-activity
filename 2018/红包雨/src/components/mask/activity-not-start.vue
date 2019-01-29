<template>
    <div class="activity-not-start">
        <p class="mask-p">1218红包雨活动时间为2018年12月3日~<br />12月17日。活动尚未开始，敬请期待！</p>
    </div>
</template>

<style lang="scss" scoped>
    .activity-not-start{
        @include wh(650,455);
        @include bg('../../assets/images/activity-not-start.png');
        text-align: center;
        padding-top: rem(230);
    }
    .mask-p{
        color: #fff;
        line-height: rem(40);
        font-size: rem(24);
        text-align: center;
    }
</style>

