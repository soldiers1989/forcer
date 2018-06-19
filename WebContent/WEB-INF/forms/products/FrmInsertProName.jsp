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
<title>添加商品</title>
<style>
	
</style>
</head>
<body>
 <div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加/变更物品属性</span>
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
		<form action="#" method="post" id="ProductsForm" enctype="multipart/form-data">
		<!--<p>当前商品名称序号：<input type="text" name="UID_" id="UID_"></p> -->
			<div class="group-box" name="null" id="component1" visible="false">
				<label style="width:200px">商品类别（一级分类）：</label>
				<select name="fristNameId_" id="fristName_" style="width:300px;">
					<option>请选择</option>
				</select>
			</div>			
			<div class="group-box">
				<label class="fl"  style="width:200px">二级分类：</label>
				<select name="twoNameId_" id="twoName_" style="width:300px;">
					<option>请选择</option>
				</select>					
			</div>
			<div class="group-box">
				<label style="width:200px">物品名称：</label><input name="proName_" type="text">
			</div>
			<div class="group-box clearfloat" name="null" id="component1" visible="false">	
					<label style="float:left;width:200px">分类小图标：</label>
					 <div class="img-block IDcard-upload" style="height:auto;">
					      <div class="upFileInputBox img" id="upFile" style="width:100px;height:100px;background-size:100px 100px;">
					        <img class="img"   src="" style="width:100px;height:100px" alt="" id="imgID_"/>
					        <input class="file fileInput" type="file" onchange="getImgURL(this)"  name="proZsImges_" id="fileInputUrl" style="height:100px;">
					        <input type="hidden" name="proZsImges_" value="" class="urlImg" id="upload3"> 
					        <span class="remBut" style="width:15px;height:15px;display:none"></span>
					      </div>
			 		 </div>
			 	 </div>
			<%-- <div class="group-box upFileBox">
				<label style="width:200px">商品小图标：</label>
					<img class="img" alt="" src="" style="width:50px;height:50px;"> 
					<input class="file" type="file" name="proZsImges_" id="fileInputUrl" onchange="getImgURL(this)" class="fileInput"> 
					<input type="hidden" name="proZsImges_" value="" class="urlImg" id="upload3"> 
					<span class="removeBut"  style="display: none;"><img src="${cdn }/img/remove-img.png" style="width:15px;height:15px;position:relative;left:5px;top:-35px"></span>
			</div> --%>
			<%-- <div class="group-box clearfloat" >
				<label class="fl " style="width:200px">商品展示轮播图：</label>
				<div class="fileBox" style="float:left">
					<div class="upFileBox" >
						<img style="width: 100px;height: 100px;display:none;border:1px solid #f5f5f5"  class="img"> 
						<input type="file" onchange="getImgURL(this)" id="imgUrlFile" class="fileInput"  name="proLbImges_"> 
						<input type="hidden" name="proLbImges_" value="" class="urlImg" id="upload1"> 
						<span class="removeBut"  style="display:none;"><img src="${cdn }/img/remove-img.png" style="width:20px;height:20px;position:relative;left:-10px;top:-80px"></span>
					</div>
				</div>
			</div> --%>
			<div class="group-box clearfloat" >	
					<label style="float:left;width:200px">商品展示轮播图：</label>
					 <div class="img-block IDcard-upload fileBox" style="height:100px;float:left;width:127px;padding-top:0px;">
					      <div class="upFileBox upFileInputBox" style="height:100px;float:left;width:100px;background-size:100px 100px">
					        <img class="img"   src="" style="width: 100px;height: 100px;display:none;border:1px solid #f5f5f5"/>
					        <input class="file fileInput" type="file" onchange="getImgURL(this)"  name="proLbImges_" id="imgUrlFile" style="height:100px;width:100px;">
					        <input type="hidden" name="proLbImges_" value="" class="urlImg" id="upload1"> 
					        <span class="remBut" style="width:15px;height:15px;display:none"></span>
					      </div>
			 		 </div>
			 	 </div>
			<div class="group-box">
				<label style="width:200px">售卖热推：</label>
				<input type="radio" value="0" name="salesHotPush_">关
				<input type="radio" value="1" name="salesHotPush_">开
			</div>
			<div class="group-box">
				<label style="width:200px">售卖分类菜单：</label>
				<input type="radio" value="0" name="salesTypeMenu_">关
				<input type="radio" value="1" name="salesTypeMenu_">开
			</div>
				<div class="group-box">
					<label style="width:200px">售卖精品：</label>
					<input type="radio" value="0" name="salesFine_">关
					<input type="radio" value="1" name="salesFine_">开
				</div>
				<div class="group-box">
					<label style="width:200px">售卖新品：</label>
				    <input type="radio" value="0" name="salesNewPro_">关
					<input type="radio" value="1" name="salesNewPro_">开
				</div>
				<div class="group-box">
					<label style="width:200px">租赁热推：</label>
					<input type="radio" value="0" name="rentHotPush_">关
					<input type="radio" value="1" name="rentHotPush_">开
				</div>
				<div class="group-box">
					<label style="width:200px">租赁分类菜单：</label>
					<input type="radio" value="0" name="rentTypeMenu_">关
					<input type="radio" value="1" name="rentTypeMenu_">开
				</div>
				<div class="group-box">
					<label style="width:200px">租赁精品：</label>
					<input type="radio" value="0" name="rentFine_">关
					<input type="radio" value="1" name="rentFine_">开
				</div>
				<div class="group-box">
					<label style="width:200px">租赁新品：</label>
					<input type="radio" value="0" name="rentNewPro_">关
					<input type="radio" value="1" name="rentNewPro_">开
				</div>
		</form>
		<div class="group-box" id="component4" style="margin-left:30%">
			<input type="submit" name="submit" value="提交" onclick="submit()" >				
		</div>
	</div>
	
</div>




<!-- 
			<div class="top pl_20 pr_20">
				<span class="min-col f16">添加/变更物品属性</span>
			</div>
			<div class="fanhui">
				<a href="javascript:window.history.go(-1);" class="min-col aButton">返回</a>
			</div>
		<form action="#" method="post" id="ProductsForm" enctype="multipart/form-data">
			<p>当前商品名称序号：<input type="text" name="UID_" id="UID_"></p>
			<div class="group-box">
					<label class="fl">商品类别（一级分类）：</label>
					<select name="fristNameId_" id="fristName_">
					<option>请选择</option>
					</select>
			</div>
			<div class="group-box">
					<label class="fl">二级分类：</label>
					<select name="twoNameId_" id="twoName_">
					<option>请选择</option>
					</select>
					
			</div>
			<div><span>物品名称：</span><input name="proName_"></div>
			<div class="upFileBox">
				<p>商品小图标：</p>
					<img class="img" alt="" src=""> 
					<input class="file" type="file" name="proZsImges_" id="fileInputUrl" onchange="getImgURL(this)" class="fileInput"> 
					<input type="hidden" name="proZsImges_" value="" class="urlImg" id="upload3"> 
					<span class="removeBut"  style="display: none;">X</span>
			</div>
			<div class="group-box">
				<label class="fl">商品展示轮播图：</label>
				<div class="fileBox">
					<div class="upFileBox">
						<img style="width: 50px;height: 50px;display:none;"  class="img"> 
						<input type="file" onchange="getImgURL(this)" id="imgUrlFile" class="fileInput"  name="proLbImges_"> 
						<input type="hidden" name="proLbImges_" value="" class="urlImg" id="upload1"> 
						<span class="removeBut"  style="display:none;">X</span>
					</div>
				</div>
			</div>
			<div>
				<div><span>售卖热推：</span>
					<input type="radio" value="0" name="salesHotPush_">关
					<input type="radio" value="1" name="salesHotPush_">开
				</div>
				<div><span>售卖分类菜单：</span>
					<input type="radio" value="0" name="salesTypeMenu_">关
					<input type="radio" value="1" name="salesTypeMenu_">开
				</div>
				<div><span>售卖精品：</span>
					<input type="radio" value="0" name="salesFine_">关
					<input type="radio" value="1" name="salesFine_">开
				</div>
				<div><span>售卖新品：</span>
				    <input type="radio" value="0" name="salesNewPro_">关
					<input type="radio" value="1" name="salesNewPro_">开
				</div>
				<div><span>租赁热推：</span>
					<input type="radio" value="0" name="rentHotPush_">关
					<input type="radio" value="1" name="rentHotPush_">开
				</div>
				<div><span>租赁分类菜单：</span>
					<input type="radio" value="0" name="rentTypeMenu_">关
					<input type="radio" value="1" name="rentTypeMenu_">开
				</div>
				<div><span>租赁精品：</span>
					<input type="radio" value="0" name="rentFine_">关
					<input type="radio" value="1" name="rentFine_">开
				</div>
				<div><span>租赁新品：</span>
					<input type="radio" value="0" name="rentNewPro_">关
					<input type="radio" value="1" name="rentNewPro_">开
				</div>
			</div>
		</form>
			
		 <div class="group-box" id="component4">
					<button onclick="submit()" class="button" style="margin-left: 150px">提交</button>
			</div> -->
			
	
<script type="text/javascript">
	function submit(){
		var proName_=$("input[name='proName_']").val();//售价
		if(proName_=""){
			alert("物品名称不能为空");
			return false;
		}
		var formData = new FormData($("#ProductsForm")[0]);
		console.log(formData);
		$.ajax({
			url: "FrmAdminPro.insertProductsName",
			data:formData,
			type: "POST",
			dataType: "json",
			async: true,
            cache: false,
            processData:false,
            contentType:false,
			success: function(data) {
				if(data){
					alert("添加成功!");
					window.location.href="FrmAdminPro";
				}else{
					alert("添加失败!已有相同名称的商品，请添加不同的商品！");
					window.location.href="FrmAdminPro.toInsertProductsName";
				}
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	}
	//显示一级分类
	$().ready(function(){
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
					if(twoName_!=""&&twoName_!=null){
						str +="<option name='twoNameId_' value='"+twoNameId_+"'>"+twoName_+"</option>";
						console.log(str);
					}
					
				}
				$("#twoName_").append(str);
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	})

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
	var q1=$(node).attr("name");
	var q2=$(node).attr("name");
	/* var imglength=$(node).parent().parent().parent().find("img").length; */
	var imglength=$(".self-fileBox").length; 
	var a2=$(node).parent().find("img").length;
	if(imglength<4&&q2=="proLbImges_"){
		 $(node).parent().parent().after("<div class='self-fileBox' style='float:left'>"+
		      		   "<div class='upFileInputBox bg' id='upFile' style='margin-right: 20px;'>"+
		      		   "<img class='img' src='' style='display:none;width: 100px;height: 100px;'>"+
		      		   "<input class='file'  type='file' onchange='getImgURL(this)' name='proLbImges_' id='"+"fileInputUrl"+count+"'>"+
		      		   "<input type='hidden' name='proLbImges_' value='' class ='urlImg' id='upload1'>"+
		      			"<div class='remBut' style='display:none;width:20px;height:20px;position:absolute;left:90px;top:0px;z-index:100'><img src='${cdn}/img/remove-img.png' style='width:100%;height:100;'></div>"+
		      		   "</div></div>");
			
	}
	imgurl = imgURL;
	wrap = $(node).attr('id');
	console.log(imgRUL);
	creatImg(imgRUL, wrap,node);
	return imgurl;
};
function creatImg(imgRUL, wrap,node) { //根据指定URL创建一个Img对象  
	// $("#formfileUrl span").html(imgRUL); 
	$(node).siblings('.remBut').show();
	$(node).siblings('.img').attr('src', imgRUL);
	/*  $("#"+wrap).val(imgRUL); */
	$(node).siblings('.urlImg').val(imgRUL);
	$(node).siblings('.img').show();
	
	
	$(node).hide();

	// alert(0);
};
$('body').on('click', '.remBut', function() {
	var name=$(this).siblings("input[type='hidden']").prop("name");
	if(name=="proLbImges_"){
		var imgLength=$(this).parent().parent().parent().find("input[type='file']").length;
		if(imgLength>1){
		 $(this).parent().parent().remove();  
		}
	}
	
	
	/* alert(); */
	$(this).siblings('.img').attr('src', '');
	$(this).siblings('.img').hide();
	$(this).siblings('.file').show();
	/* $(this).parent().remove();  */
	$(this).siblings("input[type='hidden']").remove();
	$(this).hide();
	
	
	
});
	
</script>
</body>
</html>