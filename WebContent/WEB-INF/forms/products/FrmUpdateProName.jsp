<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${cdn}/css/style.css"/> 
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>变更商品</title>
<style type="text/css">
.img-block .remBut{
		
		
	} 
	.positon_re{
		position:relative;
		float: left;
    	width: 100px;
	}
	.upFileInputBox{
		border:none;
	}
	#component1 input{
    	width:100px;
    	height:100px;
    }
	.clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0} 
.clearfloat{zoom:1} 
</style>
</head>
<body>
 <div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">变更商品</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<div class="easyui-panel tc mt_20">
	




			<!-- <div class="top pl_20 pr_20">
				<span class="min-col f16">变更商品</span>
			</div>
			<div class="fanhui">
				<a href="javascript:window.history.go(-1);" class="min-col aButton">返回</a>
			</div> -->
		<form action="#" method="post" id="ProductsForm" enctype="multipart/form-data">
<!-- 			<p>当前商品名称序号：<input type="text" name="UID_" id="UID_"></p> -->
			<input type="hidden" value="${value.items.proId_ }" name="proId_">
			<div class="group-box">
				<label class="fl" style="width:200px">商品类别（一级分类）：</label>
<!-- 				<select name="fristNameId_" id="fristName_" style="width:300px"> -->
					<input type="hidden" name="fristNameId_" value="${value.items.fristNameId_ }">
					<span>${value.items.fristName_ }</span>
<%-- 					<option value="${value.items.fristNameId_ }" name="fristNameId_">${value.items.fristName_ }</option> --%>
<!-- 				</select> -->
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">二级分类：</label>
				<input type="hidden" name="twoNameId_" value="${value.items.twoNameId_ }">
					<span>${value.items.twoName_ }</span>
<!-- 				<select name="twoNameId_" id="twoName_" style="width:300px"> -->
<%-- 					<option value="${value.items.twoNameId_ }">${value.items.twoName_ }</option> --%>
<!-- 				</select> -->
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">物品名称：</label>
				<input name="proName_" type="text" value="${value.items.proName_ }">
			</div>
			
			<div class="group-box clearfloat" name="null" id="component1" visible="false">	
					<label class="fl" style="width:200px">商品图标：</label>
					 <div class="img-block IDcard-upload" >
					 		<div class="upFileInputBox bg" style="height:100px;float:left;width:100px;">
							  <img class="images"  style="width:100px;height:100px" alt="" src="${proZsImges_}"> 
							  <input class="file" type="file"  style="display: none;" name="proZsImges_" id="fileInputUrl" onchange="getImgURL(this)"> 
							  <input name="proZsImges_" type="text" style="display: none;"  class="images">
							  <span class="remBut" style="width:15px;height:15px;"></span>
							  </div>
			 	 	</div>
			 </div>
			<div class="group-box clearfloat" name="null" id="component1" visible="false">	
					<label class="fl" style="width:200px">商品轮播图：</label>
					 <div class="img-block IDcard-upload " style="height: 100px;">
					  
					  <c:if test="${empty value.items.proLbImges_}">
					  <div class="upFileInputBox bg" style="height:100px;float:left;width:100px;margin-right:20px;">
							  <img class="images"  style="width:100px;height:100px" alt="" src="${img}"> 
							  <input class="file" type="file" style="" name="proLbImges_" id="fileInputUrl1" onchange="getImgURL(this)"> 
							  <input name="proLbImges_" type="hidden" style="display: none;" class="images">
							   <span class="remBut" style="width:15px;height:15px;"></span>
							</div>
					  </c:if>
					   <c:if test="${not empty value.items.proLbImges_ }">
					   		 <c:forEach items="${value.items.proLbImges_ }" var="img">
						 	<div class="upFileInputBox bg" style="height:100px;float:left;width:100px;margin-right:20px;">
							  <img class="images"  style="width:100px;height:100px" alt="" src="${img}"> 
							  <input class="file" type="file" style="" name="proLbImges_" id="fileInputUrl1" onchange="getImgURL(this)"> 
							  <input name="proLbImges_" type="hidden" style="display: none;" class="images">
							   <span class="remBut" style="width:15px;height:15px;"></span>
							</div>
			 	 	</c:forEach>
					  </c:if>
					
			 	 	
			 	 	</div>
			 </div>
			
			
			
			<div class="group-box">
				<label class="fl" style="width:200px">售卖热推：</label>
				<c:if test="${value.items.salesHotPush_  == '0'}">
					<input type="radio" value="0" name="salesHotPush_" checked="checked">关
					<input type="radio" value="1" name="salesHotPush_">开
				</c:if>
				<c:if test="${value.items.salesHotPush_  == '1'}">
					<input type="radio" value="0" name="salesHotPush_" >关
					<input type="radio" value="1" name="salesHotPush_" checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">售卖分类菜单：</label>
				<c:if test="${value.items.salesTypeMenu_  == '0'}">
				<input type="radio" value="0" name="salesTypeMenu_" checked="checked">关
				<input type="radio" value="1" name="salesTypeMenu_">开
				</c:if>
				<c:if test="${value.items.salesTypeMenu_  == '1'}">
				<input type="radio" value="0" name="salesTypeMenu_">关
				<input type="radio" value="1" name="salesTypeMenu_" checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">售卖精品：</label>
				<c:if test="${value.items.salesFine_  == '0'}">
				<input type="radio" value="0" name="salesFine_" checked="checked">关
				<input type="radio" value="1" name="salesFine_">开
				</c:if>
				<c:if test="${value.items.salesFine_  == '1'}">
				<input type="radio" value="0" name="salesFine_">关
				<input type="radio" value="1" name="salesFine_" checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">售卖新品：</label>
				<c:if test="${value.items.salesNewPro_  == '0'}">
			    <input type="radio" value="0" name="salesNewPro_" checked="checked">关
				<input type="radio" value="1" name="salesNewPro_">开
				</c:if>
				<c:if test="${value.items.salesNewPro_  == '1'}">
			    <input type="radio" value="0" name="salesNewPro_">关
				<input type="radio" value="1" name="salesNewPro_" checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">租赁热推：</label>
				<c:if test="${value.items.rentHotPush_  == '0'}">
				<input type="radio" value="0" name="rentHotPush_"  checked="checked">关
				<input type="radio" value="1" name="rentHotPush_">开
				</c:if>
				<c:if test="${value.items.rentHotPush_  == '1'}">
				<input type="radio" value="0" name="rentHotPush_">关
				<input type="radio" value="1" name="rentHotPush_"  checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">租赁分类菜单：</label>
				<c:if test="${value.items.rentTypeMenu_  == '0'}">
				<input type="radio" value="0" name="rentTypeMenu_"  checked="checked">关
				<input type="radio" value="1" name="rentTypeMenu_">开
				</c:if>
				<c:if test="${value.items.rentTypeMenu_  == '1'}">
				<input type="radio" value="0" name="rentTypeMenu_">关
				<input type="radio" value="1" name="rentTypeMenu_"  checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">租赁精品：</label>
				<c:if test="${value.items.rentFine_  == '0'}">
				<input type="radio" value="0" name="rentFine_"  checked="checked">关
				<input type="radio" value="1" name="rentFine_">开
				</c:if>
				<c:if test="${value.items.rentFine_  == '1'}">
				<input type="radio" value="0" name="rentFine_">关
				<input type="radio" value="1" name="rentFine_"  checked="checked">开
				</c:if>
			</div>
			<div class="group-box">
				<label class="fl" style="width:200px">租赁新品：</label>
				<c:if test="${value.items.rentNewPro_  == '0'}">
				<input type="radio" value="0" name="rentNewPro_" checked="checked">关
				<input type="radio" value="1" name="rentNewPro_">开
				</c:if>
				<c:if test="${value.items.rentNewPro_  == '1'}">
				<input type="radio" value="0" name="rentNewPro_">关
				<input type="radio" value="1" name="rentNewPro_" checked="checked">开
				</c:if>
			</div>
			
		 
		</form>
			<div class="group-box" id="component4">
					<button onclick="submit()" class="button" style="margin-left: 150px;margin-top:10px;">提交</button>
			</div>
<script type="text/javascript">
	function submit(){
		var formData = new FormData($("#ProductsForm")[0]);
		console.log(formData);
		$.ajax({
			url: "FrmAdminPro.updateProductsName",
			data:formData,
			type: "POST",
			dataType: "json",
			async: true,
            cache: false,
            processData:false,
            contentType:false,
			success: function(data) {
				if(data){
					alert("修改成功!");
					window.location.href="FrmAdminPro";
				}else{
					alert("修改失败!");
				}
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	}
	
/* 	$().ready(function(){
		$.ajax({
			url: "FrmAdminProType.queryProTy",
			type: "POST",
			dataType: "text",
			async: false,
	        cache: false,
			success: function(data) {
				var vals = eval('(' +eval('(' + data + ')').va+ ')');
				var str = ''; 
				for(var i=0;i<vals.length;i++){
					var val = vals[i];
					var fristName_ = val.fristName_;
					var fristNameId_ = val.fristNameId_;
					str +="<option name='fristNameId_' value='"+fristNameId_+"'>"+fristName_+"</option>";
				}
				$("#fristName_").append(str);
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	} )
	
	//动态显示二级分类
	$("#fristName_").on("change",function(){
		$("#twoName_").empty();
		var fristNameId_=$(this).val();
		$.ajax({
			url: "FrmAdminProType.queryType",
			type: "POST",
			data:{fristNameId_:fristNameId_},
			dataType: "text",
			async: false,
	        cache: false,
			success: function(data) {
				var vals = eval('(' +eval('(' + data + ')').va+ ')');
				console.log(vals);
				var str = '<option>请选择</option>'; 
				for(var i=0;i<vals.length;i++){
					var val = vals[i];
					var twoName_ = val.twoName_;
					var twoNameId_ = val.twoNameId_;
					var fristNameId_ = val.fristNameId_;
					str +="<option name='twoNameId_' value='"+twoNameId_+"'>"+twoName_+"</option>";
					console.log(str);
				}
				$("#twoName_").append(str);
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	}) */

		
	var imgurl = "";
	var count = 20;
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
		var q1=$(node).attr("name");
		var q2=$(node).attr("name");
		/* var imglength=$(node).parent().parent().parent().find("img").length; */
		var imglength=$(".upFileInputBox").length; 
		var a2=$(node).parent().parent().find("img").length;
		if(imglength<6&&q2=="proLbImges_"){
			 $(node).parent().after("<div class='upFileInputBox bg' id='upFile' style='margin-right: 20px;background: url(/img/addimg.png);background-repeat: no-repeat; background-position: center; background-size: 100%;width: 100px;height: 100px;'>"+
			      		   "<img class='images' src='' style='display:none;width: 100px;height: 100px;'>"+
			      		   "<input class='file'  type='file' onchange='getImgURL(this)' name='proLbImges_' id='"+"fileInputUrl"+count+"'>"+
			      		   "<input type='hidden' name='proLbImges_' value='' class ='images' id='upload1'>"+
			      			"<span class='remBut' style='width:15px;height:15px;'></span>"+
			      		   "</div>");
				
		}
		imgurl = imgURL;
		wrap = $(node).attr('id');
		console.log(imgRUL);
		creatImg(imgRUL, wrap,node);
		return imgurl;
	};  
	function creatImg(imgRUL, wrap,node) { //根据指定URL创建一个Img对象  
		// $("#formfileUrl span").html(imgRUL); 
		$(node).siblings('.images').attr('src', imgRUL);
		/*  $("#"+wrap).val(imgRUL); */
		$(node).siblings('.images').val(imgRUL);
		$(node).siblings('.images').show();
		$(node).siblings('.remBut').show();
		$(node).hide();

		// alert(0);
	};
// 	function creatImg(imgRUL, wrap) { //根据指定URL创建一个Img对象  
// 		// $("#formfileUrl span").html(imgRUL); 
// 	//console.log(imgRUL)
// 		$("#" + wrap).siblings('.images').attr('src', imgRUL);
// 		$("#" + wrap).siblings('.images').show();
// 		$("#" + wrap).siblings('.remBut').show();
// 		$("#" + wrap).hide();
// 		// alert(0);
// 	};
 	$('body').on('click','.remBut',function() {
 		var imgLength=$(this).parent().parent().find("input[type='file']").length;
		if(imgLength>1){
		 $(this).parent().remove();  
		}
		$(this).siblings('.images').hide();
		$(this).siblings('.file').show();
		$(this).hide();
	}); 
 	
//  	$(function(){
//  		var url=$(".img-block .images").attr('src');
//  		if(url){
//  			$('.img-block').find('.file').show();
//  			$('.img-block').find('.remBut').show();
//  		}else{
//  			$('.img-block').find('.file').show();
//  			$('.img-block').find('.remBut').hide();
//  		}
//  	})
</script>
</body>
</html>