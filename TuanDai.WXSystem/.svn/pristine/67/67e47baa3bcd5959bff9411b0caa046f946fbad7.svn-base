var lottery = {
    index: -1,	//当前转动到哪个位置，起点位置
    count: 0,	//总共有多少个位置
    timer: 0,	//setTimeout的ID，用clearTimeout清除
    speed: 20,	//初始转动速度
    times: 0,	//转动次数
    cycle: 30,	//转动基本次数：即至少需要转动多少次再进入抽奖环节
    prize: -1,	//中奖位置
    init: function (id) {
        if ($("#" + id).find(".lottery-unit").length > 0) {
            $lottery = $("#" + id);
            $units = $lottery.find(".lottery-unit");
            this.obj = $lottery;
            this.count = $units.length;
            $lottery.find(".lottery-unit-" + this.index).addClass("active");
        };
    },
    roll: function () {
        var index = this.index;
        var count = this.count;
        var lottery = this.obj;
        $(lottery).find(".lottery-unit-" + index).removeClass("active");
        index += 1;
        if (index > count - 1) {
            index = 0;
        };
        $(lottery).find(".lottery-unit-" + index).addClass("active");
        this.index = index;
        return false;
    },
    stop: function (index) {
        this.prize = index;
        return false;
    }
};
function roll() {
    lottery.times += 1;
    lottery.roll();
    if (lottery.times > lottery.cycle + 10 && lottery.prize == lottery.index) {
        clearTimeout(lottery.timer);
        lottery.prize = -1;
        lottery.times = 0;
        click = false;

        //转盘停止显示内容
        if (_prizeName == "谢谢参与") {
            $("#btnchakanzhong").unbind("click");
            $("#btnchakanzhong").click(function () { $("#xiaochuangZhong").hide(); });
            $("#xiaochuangZhong").show();
            $(".chance").text("0");
        } else { 
            $("#xiaochuangZhong").show();
        }

        _currentDate = "";
        _userNick = "";
        _prizeName = "";
    } else {
        if (lottery.times > lottery.cycle) {
            lottery.speed += 5;
            if (lottery.speed > 200) {
                lottery.speed = 200;
            }
        } else {
            lottery.speed -= 10;
            if (lottery.speed < 40) {
                lottery.speed = 40;
            }
        }
        lottery.timer = setTimeout(roll, lottery.speed);
    }
    return false;
}
var click = false;
var _currentDate = "";
var _userNick = "";
var _prizeName = "";
var _count = "1次";
window.onload = function () {
    lottery.init('lottery');
    $("#lottery a").click(function () {
        if (!base_isCookieLogin()) {
            alert("您还未登录不能抽奖！");
            window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href;
            return;
        }

        if (click) {
            return false;
        } else {
            click = true; 
            //抽奖
            $.ajax({
                url: "Index.aspx?Action=GetFinanceDraw",
                type: "post",
                dataType: "json",
                async: true,
                data: {}
                , success: function (data) {
                    if (data != undefined && data.Status != undefined) {
                        if (data.Status.toString() == "-99") {
                            $(".popup-content").html("<p class='c-212121 f15px'>登录完成答卷才能抽奖哦！</p>");
                            $("#btnchakanzhong").unbind("click");
                            $("#btnchakanzhong").click(function () { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; });
                            $("#btnchakanzhong").html("马上登录");
                            $("#xiaochuangZhong").show(); 
                            //提示登录 
                            click = false;//置为未点击
                            return;
                        } else {
                            //-1活动未开始,-2活动结束,-3还没回答问题，-4已经抽过奖了 -5发送奖品失败 
                            switch (data.Status.toString()) {
                                case "1":
                                    lottery.speed = 100;
                                    roll(); 
                                    getprizeIndex(data.PrizeName);
                                    _prizeName = data.PrizeName;
                                    if (data.PrizeName == "谢谢参与") {
                                        $(".popup-content").html("<p class='c-212121 f15px'>谢谢参与！</p>");
                                        $("#btnchakanzhong").unbind("click");
                                        $("#btnchakanzhong").click(function () { window.location.href = "/pages/invest/invest_list.aspx"; });
                                        $("#btnchakanzhong").html("马上去投资");
                                        //$("#xiaochuangZhong").show();
                                    } else {
                                        $(".popup-content").html("<p class='c-212121 f15px'>恭喜" + data.NickName + "抽中了<br/>" + data.PrizeName + "</p>"); 
                                        $("#btnchakanzhong").unbind("click");
                                        $("#btnchakanzhong").click(function () { window.location.href = "/Member/UserPrize/Index.aspx"; });
                                        $("#btnchakanzhong").html("查看奖品");
                                       // $("#xiaochuangZhong").show();
                                        _currentDate = data.CurrentDate;
                                        _userNick = data.NickName;
                                    }
                                    _count = "0次";
                                    click = false;
                                    break;
                                case "-1": 
                                    $(".popup-content").html("<p class='c-212121 f15px'>活动还没开始，亲再等等！</p>");
                                    $("#btnchakanzhong").unbind("click");
                                    $("#btnchakanzhong").click(function () { window.location.href = "/pages/invest/invest_list.aspx"; });
                                    $("#btnchakanzhong").html("马上去投资");
                                    $("#xiaochuangZhong").show();
                                    click = false;
                                    break;
                                case "-2":                                   
                                    $(".popup-content").html("<p class='c-212121 f15px'>活动已结束了！</p>");
                                    $("#btnchakanzhong").unbind("click");
                                    $("#btnchakanzhong").click(function () { window.location.href = "/pages/invest/invest_list.aspx"; });
                                    $("#btnchakanzhong").html("马上去投资");
                                    $("#xiaochuangZhong").show();

                                    click = false;
                                    break;
                                case "-3":
                                    $(".popup-content").html("<p class='c-212121 f15px'>完成问卷才能抽奖哦！</p>");
                                    $("#btnchakanzhong").unbind("click");
                                    $("#btnchakanzhong").click(function () { window.location.href = "survey.aspx"; });
                                    $("#btnchakanzhong").html("马上完成");
                                    $("#xiaochuangZhong").show(); 
                                    click = false;
                                    break;
                                case "-4":                                   
                                    $(".popup-content").html("<p class='c-212121 f15px'>每人只有一次机会哦~~！</p>");
                                    $("#btnchakanzhong").unbind("click");
                                    $("#btnchakanzhong").click(function () { window.location.href = "/pages/invest/invest_list.aspx"; });
                                    $("#btnchakanzhong").html("马上去投资");
                                    $("#xiaochuangZhong").show();
                                    click = false;
                                    break;
                                case "-5": 
                                    $(".popup-content").html("<p class='c-212121 f15px'>抽奖出错了~~！</p>");
                                    $("#btnchakanzhong").unbind("click");
                                    $("#btnchakanzhong").click(function () { window.location.href = "/pages/invest/invest_list.aspx"; });
                                    $("#btnchakanzhong").html("马上去投资");
                                    $("#xiaochuangZhong").show();
                                    click = false;
                                    break;
                            }
                        }
                    }
                    else { 
                        $(".popup-content").html("<p class='c-212121 f15px'>抽奖出错了~~！</p>");
                        $("#btnchakanzhong").unbind("click");
                        $("#btnchakanzhong").click(function () { window.location.href =  "/pages/invest/invest_list.aspx"; });
                        $("#btnchakanzhong").html("马上去投资");
                        $("#xiaochuangZhong").show();
                        click = false;
                    }
                },
                error: function () {
                    click = false;//置为未点击
                }
            });
            return false;
        }
    });
}; 
 

function GoEnd() {
    $("#btnchakanzhong").hide();
}
function getprizeIndex(prizename) {
    switch (prizename) {
        case "π币1个":
            lottery.prize = 0;
            break;
        case "5元红包":
            lottery.prize = 1;
            break;
        case "π币3个":
            lottery.prize = 2;
            break;
        case "50元红包":
            lottery.prize = 3;
            break;
        case "谢谢参与":
            lottery.prize = 4;
            break;
        case "100元红包":
            lottery.prize = 5;
            break;
        case "π币5个":
            lottery.prize = 6;
            break;
        case "10元红包":
            lottery.prize = 7;
            break;
    }
}