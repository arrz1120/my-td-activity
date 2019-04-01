(function () {
    var barrageComment = new Barrage('.comment-barrage', {
        data: [{
            key: 0,
            val: '156*****231获得 10.00 元投资红包'
        }, {
            key: 0,
            val: '156*****232获得 20.00 元投资红包'
        }],
        per: 1, //显示的行数
        styles: [],
        speed: 8, //速度系数
    });
    barrageComment.move();

    $(".bot-l").on('click', function () {
        $('body').scrollTop(2000);
    })
})();