
/* 图片放大功能 */
$("body").on("click",".tableImg .enlargement_img",function(){
	var container=$('<div class="imgMars" style="width:100%;height:100%;position:absolute;top:0;left:0;z-index:1000;background-color:rgba(0,0,0,.6);"><div style="position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);"><img alt="" src="" class="enlargement"></div></div>');
	$("body").append(container);
	var src=$(this).prop("src");
	$(".enlargement").prop("src",src);
})
	$("body").on("click",".imgMars",function(){
		$(this).remove();
	})

	
