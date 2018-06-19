<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<style>
	.img-block .upFileInputBox{
		width: 1.6rem;
	    height: 1.15rem;
		background-color: #f9f9f9;
		border-radius: 0.128rem;
	}
	.img-block .upFileInputBox .file{
		width: 1.6rem;
	    height: 1.15rem;
	}
	.img-block .upFileInputBox img {
		width: 1.6rem;
   		height: 1.15rem;
	}
	.red{
		color:red;
		border:1px solid red;
	}
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">转赔付单</div>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
	 <form action="FrmMyCabinet.addIndemnity"  method="post" id="ProTypeForm" enctype="multipart/form-data">
	 <input type="hidden" value="${rent.items.orderId_ }"  name="orderId_">
 	<div class="toIndemnity_pf">
 		<div class="instructions">赔付说明</div>
 		<textarea rows="10" cols="15" name="payDesc_" placeholder="输入赔付说明"></textarea>	
 		<div class="instructions">上传图片凭证（1-3张）</div>
	 	<div>
	 		<!-- <span>上传图片凭证（1-3张）</span> -->
	 		 <div class="img-block IDcard-upload" >
			      <div class="upFileInputBox bg" id="upFile" style="margin:0 .2rem .2rem 0">
			        <img class="images"   src="" class="pf_upload" id="imgID_" alt=""/>
			        <input class="file " type="file" onchange="getImgURL(this)"  name="fristUrl_" id="fileInputUrl" >
			        <input type="hidden" name="" value="" class="images" id="upload3"> 
			        <span class="remBut" style="width:15px;height:15px;display:none"></span>
			      </div>
	 		 </div>
	 	</div>
		<div class="pf_submit">
	 	 	<input type="submit" name="submit" value="提交" onclick="submit()">
	     </div>
	 </div>
	 </form>
</div>
</body>

<script type="text/javascript">
/* 	function submit(){
		var formData = new FormData($("#ProTypeForm")[0]);
		console.log(formData);
		var imgID_=$("#imgID_").prop("src");
		if(imgID_==null||imgID_==""){
			alert("请上传图片！");
			return false;
		}
		$.ajax({
			url: "FrmMyCabinet.toIndemnity",
			type: "POST",
			data: formData,
			dataType: "json",
			async: true,
            cache: false,
            processData:false,
            contentType:false,
			success: function(data) {
				if(data){
					alert("提交成功");
					window.location.href="FrmMyCabinet.onRentingOrders";
				}
			},
			error: function(data) {
					alert("网络异常，请稍后再修改！");
			}
		});
	}
	 */
		
	//商品轮播图
	 var imgurl = "";
	 var count = 0;
	 function getImgURL(node) {
	 	var imgURL = "";
	 	try {
	 		var file = null;
	 		if (node.files && node.files[0]) {
	 			file = node.files[0];
	 			
	 		} else if (node.files && node.files.item(0)) {
	 			file = node.files.item(0);
	 		}
	 		//Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径  
	 		try {
	 			//Firefox7.0   
	 			imgURL = file.getAsDataURL();
	 			//alert("//Firefox7.0"+imgRUL);                           
	 		} catch (e) {
	 			//Firefox8.0以上                                
	 			imgRUL = window.URL.createObjectURL(file); //alert("//Firefox8.0以上"+imgRUL);  
	 		}
	 	} catch (e) {
	 		//支持html5的浏览器,比如高版本的firefox、chrome、ie10  
	 		if (node.files && node.files[0]) {
	 			var reader = new FileReader();
	 			reader.onload = function(e) {
	 				imgURL = e.target.result;
	 			};
	 			reader.readAsDataURL(node.files[0]);
	 		}
	 	}
	 	
	 	var formFile = new FormData();
	 	formFile.append("action", "UploadVMKImagePath");
	 	formFile.append("file", file); //加入文件对象
	 	var data = formFile;
	 	var nameValue=$(node).attr("name");
	 	count=count+1;
	 	/* var imglength=$(node).parent().parent().parent().find("img").length; */
	 	var imglength=$(".upFileInputBox").length; 
	 	var a2=$(node).parent().parent().find("img").length;
	 	if(imglength<3){
	 		 $(node).parent().after("<div class='upFileInputBox bg' id='upFile' style='margin:0 .2rem .2rem 0'>"+
		        "<img class='images'   src='' class='pf_upload' id='imgID_' alt=''/>"+
		        "<input class='file' type='file' onchange='getImgURL(this)'  name='fristUrl_' id='fileInputUrl"+count+"' >"+
		        "<input type='hidden' name='' value='' class='images' id='upload3'>"+
		        "<span class='remBut' style='width:15px;height:15px;display:none'></span></div>");

	 		/*  $(node).parent().parent().after("<div class='self-fileBox' style='float:left'>"+
	 		      		   "<div class='upFileInputBox bg' id='upFile' style='margin-right: 20px;'>"+
	 		      		   "<img class='img' src='' style='display:none;width: 100px;height: 100px;'>"+
	 		      		   "<input class='file'  type='file' onchange='getImgURL(this)' name='proLbImges_' id='"+"fileInputUrl"+count+"'>"+
	 		      		   "<input type='hidden' name='proLbImges_' value='' class ='urlImg' id='upload1'>"+
	 		      			"<div class='remBut' style='display:none;width:20px;height:20px;position:absolute;left:90px;top:0px;z-index:100'><img src='/img/remove-img.png' style='width:100%;height:100;'></div>"+
	 		      		   "</div></div>"); */
	 			
	 	}else{
	 		
	 	}
	 	imgurl = imgURL;
	 	wrap = $(node).attr('id');
	 	alert(wrap)
	 	console.log(imgRUL);
	 	creatImg(imgRUL, wrap,node);
	 	//node.addClass("red");
	 	return imgurl;
	 };

	 
	/*  -------------------------------- */
	
	/* function creatImg(imgRUL, wrap) { //根据指定URL创建一个Img对象  
		// $("#formfileUrl span").html(imgRUL); 
		$("#" + wrap).siblings('.images').attr('src', imgRUL);
		/*  $("#"+wrap).val(imgRUL); 
		$("#" + wrap).siblings('.images').val(imgRUL);
		$("#" + wrap).siblings('.images').show();
		$("#" + wrap).siblings('.removeBut').show();
		$("#" + wrap).hide();
 */
		// alert(0);
	/* }; */



	function creatImg(imgRUL, wrap) { //根据指定URL创建一个Img对象  
		// $("#formfileUrl span").html(imgRUL); 
		//console.log(imgRUL)
		$("#" + wrap).siblings('#imgID_').attr('src', imgRUL);
		$("#" + wrap).siblings('.images').show();
		/* $("#" + wrap).siblings('.remBut').show(); */
		$("#" + wrap).siblings('.remBut').show();
		$("#" + wrap).hide();
		// alert(0);
	};	
	$(function(){
 	$('body').on('click','.remBut',function() {
 		$(this).parent().remove();
 		
 		if($(".upFileInputBox").length == 0){
 			
 			 $(".IDcard-upload").append("<div class='upFileInputBox bg' id='upFile' style='margin:0 .2rem .2rem 0'>"+
 			        "<img class='images'   src='' class='pf_upload' id='imgID_' alt=''/>"+
 			        "<input class='file' type='file' onchange='getImgURL(this)'  name='fristUrl_' id='fileInputUrl"+count+"' >"+
 			        "<input type='hidden' name='' value='' class='images' id='upload3'>"+
 			        "<span class='remBut' style='width:15px;height:15px;display:none'></span></div>");
 		}
		/* var te=$(this).siblings('#imgID_').prop('src', '');
		$(this).siblings('.images').hide();
		$(this).siblings('.file').show();
		/* $(this).parent().remove();  */
		//$(this).siblings("#upload3").remove();
		//$(this).hide(); 
	}); 
	})
</script>
</html>