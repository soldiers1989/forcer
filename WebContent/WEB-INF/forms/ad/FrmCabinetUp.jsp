<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${cdn }/css/style.css"/>
<title>修改柜子图片</title>
<style>
	.tableWidth{
		width:10%;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">修改柜子图片</span>
    </div>

	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	
	<form action="FrmCabinetAdImg.upCabinetAd" enctype="multipart/form-data" method="post">
	 <div class="group-box ">
	 <label>柜子编号：</label>${cabinetId_ }
	 </div>
	 <div class="group-box flexLayout">
		<label>轮播图片1：</label>
       <div class="img-block IDcard-upload " style="width:200px;height:150px;">
		      <div class="upFileInputBox bg" id="upFile" style="border-radius:6px;width:200px;height:150px;background-size:200px 150px;">
		        <img class="images"   src="" style="width:200px;height:150px" alt="" id="imgID_"/>
		        <input class="file " type="file" onchange="getImgURL(this)"  name="cabinetImg1_" id="cabinetImg1_" style="height:100px;width:100px">
		        <input type="hidden" name="" value="" class="images" id="upload3"> 
		        <span class="remBut" style="width:15px;height:15px;display:none"></span>
		      </div>
 		 </div>
      </div>
      <div class="group-box flexLayout">
		<label>轮播图片2：</label>
         <div class="img-block IDcard-upload " style="width:200px;height:150px;">
		      <div class="upFileInputBox bg" id="upFile" style="border-radius:6px;width:200px;height:150px;background-size:200px 150px;">
		        <img class="images"   src="" style="width:200px;height:150px" alt="" id="imgID_"/>
		        <input class="file " type="file" onchange="getImgURL(this)"  name="cabinetImg2_" id="cabinetImg2_" style="height:100px;width:100px">
		        <span class="remBut" style="width:15px;height:15px;display:none"></span>
		      </div>
 		 </div>
      </div>
       <div class="group-box flexLayout">
		<label>轮播图片3：</label>
        <div class="img-block IDcard-upload " style="width:200px;height:150px;">
		      <div class="upFileInputBox bg" id="upFile" style="border-radius:6px;width:200px;height:150px;background-size:200px 150px;">
		        <img class="images"   src="" style="width:200px;height:150px" alt="" id="imgID_"/>
		        <input class="file " type="file" onchange="getImgURL(this)"  name="cabinetImg3_" id="cabinetImg3_" style="height:100px;width:100px">
		        <span class="remBut" style="width:15px;height:15px;display:none"></span>
		      </div>
 		 </div>
      </div>
       <div class="group-box flexLayout">
		<label>轮播图片4：</label>
        <div class="img-block IDcard-upload " style="width:200px;height:150px;">
		      <div class="upFileInputBox bg" id="upFile" style="border-radius:6px;width:200px;height:150px;background-size:200px 150px;">
		        <img class="images"   src="" style="width:200px;height:150px" alt="" id="imgID_"/>
		        <input class="file " type="file" onchange="getImgURL(this)"  name="cabinetImg4_" id="cabinetImg4_" style="height:100px;width:100px">
		        <span class="remBut" style="width:15px;height:15px;display:none"></span>
		      </div>
 		 </div>
      </div>
       <div class="group-box mt_20">
         <input type="hidden" name="cabinetId_" id="cabinetId_" value="${cabinetId_ }">
      	 <input type="submit" value="提交" style="margin-left: 106px !important;">
       </div>
	       		<%-- <input type="hidden" name="cabinetId_" id="cabinetId_" value="${cabinetId_ }">
				柜子编号：${cabinetId_ }<br/><br/>
				轮播图片：<input type="file" name="cabinetImg1_" id="cabinetImg1_"><br/>
				轮播图片：<input type="file" name="cabinetImg2_" id="cabinetImg2_"><br/>
				轮播图片：<input type="file" name="cabinetImg3_" id="cabinetImg3_"><br/>
				轮播图片：<input type="file" name="cabinetImg4_" id="cabinetImg4_"><br/>
				<input type="submit" value="提交"> --%>
    </form>
 </div>
</body>
<script type="text/javascript">
	function getImgURL(node) {
		$.ajax({
			url : 'FrmSesameCredit.zhimaAuthInfoAuthorize',
			dataType : 'json',
			type : 'post',
			data : { 
				"name_" : name_,
				"card_" : card_
		    },
			cache : false,
			success : function(data) {
				alert("提交成功！");
				window.location.href = data;
			}
		});
	}
	
	var imgurl = "";
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
		
		imgurl = imgURL;
		wrap = $(node).attr('id');
		creatImg(imgRUL, wrap);

		return imgURL;
	}; 
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
		var te=$(this).siblings('#imgID_').prop('src', '');
		$(this).siblings('.images').hide();
		$(this).siblings('.file').show();
		/* $(this).parent().remove();  */
		$(this).siblings("#upload3").remove();
		$(this).hide();
	}); 
	})
</script>
</html>