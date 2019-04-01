(function() {
    FastClick.attach(document.body);
    var interval = null;
    // 芝麻信用认证
    initPage(approveStatus);

    // step0 
    function initPage(status) {
        $('.step').addClass('hidden');
        switch (status) {
            case '0':
                $('.step0').removeClass('hidden');
                break;
            case '1':
                showZm(score, timestr);
                break;
        }
    }

    // 显示芝麻信用分  
    // score -- 芝麻信用分数， timestr -- 爬取时间 格式为2017.08.08
    function showZm(score, timestr) {
        $('.step').addClass('hidden');
        $('.step1').removeClass('hidden');
        showDial(score, timestr);
    }

    // 资料更新
    $('.az-content').on('click', '#btn_zm_update', function(e) {
        approveStatus = '0';
        initPage(approveStatus);
    });

    function showDial(score, timestr) {
        var $canvas = $("#canvas"),
            canvas = $canvas[0],
            context = canvas.getContext("2d"),
            cwidth = $('.az-content').width() * 2,
            cheight = Util.pxTopx(466) * 2,
            radian = Math.PI / 180,
            r = Util.pxTopx(462),
            arc_start = 150,
            arc_end = 390,
            arr_score = [350, 550, 600, 650, 700, 950];
        range = (arc_end - arc_start) / 5;
        canvas.style.width = cwidth / 2 + 'px';
        canvas.style.height = cheight / 2 + 'px';
        canvas.width = cwidth;
        canvas.height = cheight;

        // 规范分数
        if (score <= 350) {
            score = 350
        }
        if (score >= 950) {
            score = 950
        }

        // 画外圈圆环
        drawCircle(context, score);

        // 画圆点虚线圆环
        var arc_unit = 3;
        for (var i = 0; i < (360 / arc_unit); i++) {
            run(context, i, arc_unit);
        }

        // 画指针
        drawPoint(context, score, arc_unit);

        // 画文字
        var secTemp = getSection(score);
        drawTxt(context, '信用' + (secTemp ? secTemp[2] : '极差'), Util.pxTopx(34 * 2) + 'px', 130 * 2);
        drawTxt(context, score, Util.pxTopx(88 * 2) + 'px', 160 * 2);
        drawTxt(context, '评估时间：' + timestr, Util.pxTopx(24 * 2) + 'px', 260 * 2);

        // 画外圈
        function drawCircle(cxt, score) {
            // 计算度数
            var angle = getThreshold(score, arc_start, arc_end, 5) || 150;

            cxt.strokeStyle = 'rgba(255, 255, 255, 1)';
            cxt.lineWidth = 2;

            cxt.beginPath();
            cxt.arc(cwidth / 2, cheight / 2, r, radian * arc_start, radian * angle, false);
            cxt.stroke();
            cxt.closePath();

            cxt.beginPath();
            cxt.strokeStyle = 'rgba(255, 255, 255, .4)';
            cxt.arc(cwidth / 2, cheight / 2, r, radian * angle, radian * arc_end, false);
            cxt.stroke();
            cxt.closePath();
        }
        // 画文字
        function drawTxt(cxt, message, fontsize, y) {
            cxt.font = fontsize + '"Helvetica Neue", Helvetica, STHeiTi, sans-serif';
            cxt.fillStyle = 'white';
            var metrics = cxt.measureText(message),
                textWidth = metrics.width;
            cxt.textBaseline = 'top';
            cxt.fillText(message, cwidth / 2 - textWidth / 2, Util.pxTopx(y));
        }
        // 画圆点虚线圈 
        function run(cxt, t, arcUnit) {
            var rotate_arc = t * radian * arcUnit;
            if (rotate_arc + radian * 90 < radian * arc_start || rotate_arc + radian * 90 > radian * arc_end) return;
            // t 取值 21 ～ 100
            cxt.fillStyle = 'rgba(255, 255, 255, .4)';
            var threshold = getThreshold(score, 21, 100, 5) || 21;

            if (t < threshold) {
                cxt.fillStyle = 'rgba(255, 255, 255, 1)';
            }
            cxt.save(); //将当前以左上角坐标为(0,0)的上下文环境进行保存，这样是为了在接下来中要进行画布偏移后，可以进行还原当前的环境
            cxt.translate(cwidth / 2, cheight / 2);
            cxt.rotate(rotate_arc); //设定每次旋转的度数
            cxt.beginPath();
            cxt.arc(0, r - 12, 2, 0, 2 * Math.PI, false);
            cxt.closePath();
            cxt.fill();
            cxt.restore(); //将当前为(500,400)的点还原为（0,0）,其实在save中就是将上下文环境保存到栈中，在restore下面对其进行还原
        }

        // 指针
        function drawPoint(cxt, score, arcUnit) {
            var img = new Image();
            img.src = '../images/point.png';
            var threshold = getThreshold(score, -9, 70, 5) || -9 // // -9 ~70
            var rotate_arc = threshold * radian * arcUnit;
            img.onload = function(e) {
                cxt.save(); //将当前以左上角坐标为(0,0)的上下文环境进行保存，这样是为了在接下来中要进行画布偏移后，可以进行还原当前的环境
                cxt.translate(cwidth / 2, cheight / 2);
                cxt.rotate(rotate_arc); //设定每次旋转的度数
                cxt.beginPath();
                cxt.drawImage(img, -r - 16, 0 - img.height / 2);
                cxt.closePath();
                cxt.restore();

            }
        }
        // 获取区间
        function getSection(score) {
            if (score <= arr_score[0]) {
                return false;
            }
            if (score <= arr_score[1]) {
                return [0, 1, '较差'];
            }
            if (score <= arr_score[2]) {
                return [1, 2, '中等'];
            }
            if (score <= arr_score[3]) {
                return [2, 3, '良好'];
            }
            if (score <= arr_score[4]) {
                return [3, 4, '优秀'];
            }
            if (score <= arr_score[5]) {
                return [4, 5, '极好'];
            }
        }
        // 获取临界值
        function getThreshold(score, start, end, quantity) {
            var section = getSection(score);
            if (section) {
                var range = (end - start) / quantity;
                return (score - arr_score[section[0]]) / (arr_score[section[1]] - arr_score[section[0]]) * range + range * section[0] + start;
            }
            return section;
        }
    }

})();