<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>添加商品</title>
</head>
<body>
			<div class="top pl_20 pr_20">
				<span class="min-col f16">添加商品</span>
			</div>
			<div class="fanhui">
				<a href="javascript:window.history.go(-1);" class="min-col aButton">返回</a>
			</div>
		<form action="#" method="post" id="ProductsForm" enctype="multipart/form-data">
			<p>当前商品名称序号：<input type="text" name></p>
			<div class="group-box">
					<label class="fl">商品类别（一级分类）：</label>
					<select name="fristName_" id="fristName_">
					<option>请选择</option>
					</select>
			</div>
			<br>
			<div class="group-box">
					<label class="fl">二级分类：</label>
					<select name="twoName_" id="twoName_">
					<option>请选择</option>
					</select>
					<div class="group-box" id="sanjiImageBox">
					<div class="fileBox">
						<div class="upFileBox">
						<label class="fl">上传图片：</label>
							<img src="" class="img"> 
							<input type="file" onchange="getImgURL(this)" id="imgUrlFile" class="fileInput" 
							accept="pdf/gif/png" name="twoNamePic" multiple="multiple" > 
							<input type="hidden" name="twoNamePic" value="" class="urlImg"> 
							<span class="removeBut"></span>
						</div>
					</div>
				</div>
			</div>
			<br>
			<div class="group-box">
					<label class="fl">商品型号（三级分类）：</label>
					<select name="proModel_" id="proModel_">
					</select>
					<div class="fileBox">
						<div class="upFileBox">
							<img src="" class="img"> 
							<input type="file" onchange="getImgURL(this)" id="imgUrlFile" class="fileInput" 
							accept="pdf/gif/png" name="proModelPic_" multiple="multiple" > 
								<input type="hidden" name="proModelPic_" value="" class="urlImg"> 
								<span class="removeBut"></span>
						</div>
					</div>
			</div>
			<p><span>商品名称：</span><input type="text" name="proName_"></p>
			<p><span>日租金：</span><input type="text" name="dayRentMoney"></p>
			<p><span>押金：</span><input type="text" name="cashPledge_"></p>
			<p><span>进货价：</span><input type="text" name="proCostPrice_"></p>
			<p><span>折扣价：</span><input type="text" name="discountPrice_"></p>
			<p><span>售价：</span><input type="text" name="price_"></p>
			<p><span>商品数量：</span><input type="text" name="proCounts_"></p>
			<span>商品描述：</span>
			<textarea rows="" cols="" name="proDesc_"></textarea>
			
			<div class="group-box" id="component4">
					<button onclick="submit()" class="button" style="margin-left: 150px">保存</button>
			</div>
		</form>
<script type="text/javascript">
	function submit(){
		var proName_=$("input[name='proName_']").val();//商品名
		var cashPledge_=$("input[name='cashPledge_']").val();//押金
		var proCostPrice_=$("input[name='proCostPrice_']").val();//进货价
		var proCostPrice_=$("input[name='proCostPrice_']").val();//进货价
		var proCostPrice_=$("input[name='proCostPrice_']").val();//进货价
		var proCostPrice_=$("input[name='proCostPrice_']").val();//进货价
		if(proName_=""){
			alert("物品名称不能为空");
			return false;
		}
		var formData = new FormData($("#ProductsForm")[0]);
		console.log(formData);
		$.ajax({
			url: "FrmAdminPro.addProducts",
			type: "POST",
			dataType: "json",
			async: trues,
            cache: false,
			success: function(data) {
				if(data){
					alert("添加成功!");
				}else{
					alert("添加失败!");
				}
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	}
	
	
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
					str +="<option name='"+fristNameId_+"' value='"+fristNameId_+"'>"+fristName_+"</option>";
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
		$("#proModel_").empty();
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
					str +="<option name='"+twoNameId_+"' value='"+twoNameId_+"'>"+twoName_+"</option>";
					console.log(str);
				}
				$("#twoName_").append(str);
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	})
	//动态显示三级分类
	$("#twoName_").on("change",function(){
		$("#proModel_").empty();
		var fristNameId_=$('#fristName_ option:selected') .val();
		var twoNameId_=$(this).val();
		$.ajax({
			url: "FrmAdminProType.queryType",
			type: "POST",
			data:{fristNameId_:fristNameId_,twoNameId_:twoNameId_},
			dataType: "text",
			async: false,
            cache: false,
			success: function(data) {
				var vals = eval('(' +eval('(' + data + ')').va+ ')');
				console.log(vals);
				var str = '<option>请选择</option>'; 
				for(var i=0;i<vals.length;i++){
					var val = vals[i];
					var proModel_ = val.proModel_;
					var proModelId_ = val.proModelId_;
					str +="<option name='proModelId_' value='"+proModelId_+"'>"+proModel_+"</option>";
					console.log(str);
				}
				$("#proModel_").append(str);
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	})
	
</script>
</body>
</html>