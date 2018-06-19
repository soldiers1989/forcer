<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
 <%-- <%@include file="../jspf/head1.jspf"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
	.group-box label{
		width: 136px;
		margin-right: 9px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${cdn}/css/style.css"/> 
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>修改变更分类</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">编辑商品分类</span>
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
		
		<form action="#" method="post" id="ProTypeForm" enctype="multipart/form-data">
		<input type="hidden" value="${fristNameId_ }" name="fristNameId_">
				<c:if test="${twoname==null||twoname==''}">
				<div class="group-box" name="null" id="component1" visible="false">
					<label>一级分类名称：</label><input type="text" name="fristName_" value="${fristName_}">
				</div>
				<!-- <div class="group-box" name="null" id="component1" visible="false">
					<label>分类小图标：</label>
					<img class="images" alt="" src="" style="width:100px;height:100px"> 
					<input class="file" type="file" name="imgUrl_" id="fileInputUrl" onchange="getImgURL(this)"> 
					<input type="hidden" name="" value="" class="images" id="upload3"> 
				</div> -->
				<div class="group-box clearfloat" name="null" id="component1" visible="false">	
					<label style="float:left">一级分类小图标：</label>
					 <div class="img-block IDcard-upload" style="height:auto;">
					   	<div>
							  <img class="images" onclick="imgUrl_.click()" style="width:100px;height:100px" alt="" src="${fristImgUrl_}"> 
							  <input class="file" type="file" style="display: none;" name="imgUrl_" id="fileInputUrl" onchange="getImgURL(this)"> 
							  <input name="img_url" type="text" style="display: none;">
						</div>
			 		 </div>
			 	 </div>
				</c:if>
				
				<c:if test="${twoname!=null&&twoname!=''}">
				<div class="group-box" name="null" id="component1" visible="false">	
				<input type="hidden" value="${twoNameId_ }" name="twoNameId_">
					<label>二级分类名称：</label><input type="text" name="twoName_" value="${twoName_}">
					<input type="hidden" name="twoNameId_"  value="${twoNameId_}">
				</div>
				<div class="group-box" name="null" id="component1" visible="false" >	
					<!-- <label>选择上级分类：</label>
					<select name="fristName_" id="fristName_" style="width:300px;">
							<option>请选择</option>
					</select> -->
					<input type="hidden" name="fristName_" value="${fristName_ }">
					<label>一级分类名称：</label>
					<label style="width:64px;">${fristName_ }</label>
			    </div>
			   <!--  <div class="group-box" name="null" id="component1" visible="false" >	
					<label>分类小图标：</label>
					<img class="images" alt="" src="" style="width:100px;height:100px"> 
					<input class="file" type="file" name="imgUrl_" id="fileInputUrl" onchange="getImgURL(this)" style="text-indent: 0px;line-height:30px;"> 
					<input type="hidden" name="" value="" class="images" id="upload3"> 
				</div> -->
				<div class="group-box clearfloat" name="null" id="component1" visible="false">	
					<label style="float:left">二级分类小图标：</label>
					<!--  <div class="img-block IDcard-upload" style="height:auto;">
					      <div class="upFileInputBox bg" id="upFile" style="width:100px;height:100px;background-size:100px 100px;">
					        <img class="images"  src="" style="width:100px;height:100px" alt="" id="imgID_"/>
					        <input class="file " type="file" onchange="getImgURL(this)"  name="imgUrl_" id="fileInputUrl" style="height:100px;width:100px;">
					        <input type="hidden" name="" value="" class="images" id="upload3"> 
					        <span class="remBut" style="width:15px;height:15px;display:none"></span>
					      </div>
			 		 </div> -->
			 		 
			 		 <div>
					  <img class="images" onclick="imgUrl_.click()" style="width:100px;height:100px" alt="" src="${twoImgUrl_}"> 
					  <input class="file" type="file" style="display: none;" name="imgUrl_" id="fileInputUrl1" onchange="getImgURL(this)"> 
					  <input name="img_url" type="text" style="display: none;">
					</div>
	 	      </div>
				</c:if>	
		</form> 
		
		<div class="group-box" id="component4">
				<input type="submit" name="submit" value="保存并提交" onclick="submit()">	
				<!-- <div onclick="submit()" class="button" class="group-box">保存并提交</div> -->
		</div>
				
	</div>
</div>



		<%-- <div class="top pl_20 pr_20">
				<span class="min-col f16">编辑商品分类</span>
			</div>
			<hr>
		<form action="#" method="post" id="ProTypeForm" enctype="multipart/form-data">
				<c:if test="${sid==null||sid==''}">
				<p><span>分类名称：</span><input type="text" name="fristName_" value="${fristName_}">
					<input type="hidden" name="fristNameId_" value="${fristNameId_}">
					<p>分类小图标：</p>
					<img class="images" alt="" src=""> 
					<input class="file" type="file" name="imgUrl_" id="fileInputUrl" onchange="getImgURL(this)"> 
					<input type="hidden" name="" value="" class="images" id="upload3"> 
				</p>
				</c:if>
				
				<c:if test="${sid!=null&&sid!=''}">
				<p><span>分类名称：</span><input type="text" name="twoName_" value="${twoName_}">
					<input type="hidden" name="twoNameId_"  value="${twoNameId_}">
				</p>
					<span>选择上级分类：
						<select name="fristName_" id="fristName_">
								<option>请选择</option>
						</select>
					</span>
					<p>分类小图标：</p>
					<img class="images" alt="" src=""> 
					<input class="file" type="file" name="imgUrl_" id="fileInputUrl" onchange="getImgURL(this)"> 
					<input type="hidden" name="" value="" class="images" id="upload3"> 
				</c:if>
				
		</form>
			<div class="group-box" id="component4">
					<span onclick="submit()" class="button">保存并提交</span>
			</div> --%>
			
			
	<script type="text/javascript">
	$(document).ready(function(){
	  	$.ajax({
	  		url: "FrmAdminProType.queryProTypes",
			type: "POST",
			dataType: "text",
			async: true,
            cache: false,
			success: function(data) {
				var vals = eval('(' +eval('(' + data + ')').va+ ')');
				var str='';
				for(var i=0;i<vals.length;i++){
					var val = vals[i];
					var fristName_ = val.fristName_;
					var twoNameId_ = val.twoNameId_;
					var fristNameId_ = val.fristNameId_;
					var proModelId_ = val.proModelId_;
					str +="<option value='"+fristName_+"'>"+fristName_+"</option>";
					console.log(str);
				};
				$("#fristName_").append(str);
			},
	  	})
	});
	
	
	function submit(){
		var formData = new FormData($("#ProTypeForm")[0]);
		console.log(formData);
		$.ajax({
			url: "FrmAdminProType.updateType",
			type: "POST",
			data: formData,
			dataType: "json",
			async: true,
            cache: false,
            processData:false,
            contentType:false,
			success: function(data) {
				if(data){
					alert("修改成功");
					window.location.href="FrmAdminProType";
				}else{
					alert("已有相同的分类，请修改为不同种的分类！");
				}
			},
			error: function(data) {
					alert("网络异常，请稍后再添加！");
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
		$("#" + wrap).siblings('.images').attr('src', imgRUL);
		/*  $("#"+wrap).val(imgRUL); */
		$("#" + wrap).siblings('.images').val(imgRUL);
		$("#" + wrap).siblings('.images').show();
		$("#" + wrap).siblings('.remBut').show();
		$("#" + wrap).hide();

		// alert(0);
	};
	$(function(){
	 	$('body').on('click','.remBut',function() {
			
			$(this).siblings('.images').hide();
			$(this).siblings('.file').show();
			/* $(this).parent().remove();  */
			$(this).siblings("#upload3").remove();
			$(this).hide();
		}); 
		})
</script>
	
</body>
</html>