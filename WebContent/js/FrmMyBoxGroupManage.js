$(function() {
	
	// 点击查看二维码
	$("body").on("click",".qrcode",function(){
		var container=$('<div class="imgMars" style="width:100%;height:100%;position:absolute;top:0;left:0;z-index:1000;background-color:rgba(0,0,0,.6);"><img alt="" src="" class="enlargement" style="position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);"></div>');
		$("body").append(container);
		var id=$(this).attr("data-id");
		$(".enlargement").prop("src", "QrcodeUtil?content=FrmMyBoxGroupLookDetail.qrcodeDetail?content=" + id);
	}).on("mousewheel", function() {
		var imgobj = $(".enlargement")[0];
		if (imgobj != undefined) {
			zoomImg(imgobj);
		}
		return false;
	});
	
	$("body").on("click",".imgMars",function(){
		$(this).remove();
	});
	
	function zoomImg(obj) {
		var zoom = parseInt(obj.style.zoom)||100;
		zoom += event.wheelDelta/2;
		if (zoom > 0) {
			obj.style.zoom = zoom + '%';
		}
	};
	
});
