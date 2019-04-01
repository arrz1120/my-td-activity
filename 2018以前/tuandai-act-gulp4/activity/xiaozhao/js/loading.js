/* Loading... */
var queue = new createjs.LoadQueue();


queue.on("progress", function(e) {
	//console.log(e.progress);
//	$('#loadBegin').text(parseInt(e.progress * 100) + '%');
}, this);
queue.on("complete", function(e) {
	$('#loadDiv').delay(300).fadeOut();
}, this);

queue.loadManifest([
	"../images/link.png",
	"../images/link_bg.png",
]);